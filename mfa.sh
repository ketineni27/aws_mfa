#!/bin/sh

### You can set this in your .bash_profile as a environment var... or edit this script
AWS_MFA_DEVICE="${AWS_MFA_DEVICE:-arn:aws:iam::0123456789:mfa/iam.username}"
TOKEN_FILE="${HOME}/.vars/aws_token_file"
CREDENTIALS="${HOME}/.aws/credentials"
AWS_CACHE="${HOME}/.aws/cli/cache"


### You should not need to change anything below this line...
#---------------------------------------------------------------------------------------------

### Validate the aws cli is installed
if ! [ -x "$(command -v aws)" ]; then
  echo 'Error: aws is not installed.' >&2
  exit 1
fi

### Validate that jq is installed
if ! [ -x "$(command -v jq)" ]; then
  echo 'Error: jq is not installed.' >&2
  exit 1
fi

AWSCMD="aws sts get-session-token --output json"

### Remove any stale ${TOKEN_FILE} and clear our cache
rm -rf ${TOKEN_FILE} ${AWS_CACHE}

### Create a backup of our credentials file
#cp ${CREDENTIALS}{,.$(date +%s)}
cp ${CREDENTIALS} ${CREDENTIALS}.$(date +%s)


### Clear previous credentials
unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SECURITY_TOKEN AWS_SESSION_TOKEN

### Get a new token
CREDENTIALS_OUTPUT=$(${AWSCMD} --serial-number ${AWS_MFA_DEVICE} --token-code $1)

AWS_ACCESS_KEY=$(echo ${CREDENTIALS_OUTPUT}|jq -r '.Credentials.AccessKeyId')
AWS_SECRET_ACCESS_KEY=$(echo ${CREDENTIALS_OUTPUT}|jq -r '.Credentials.SecretAccessKey')
AWS_SESSION_TOKEN=$(echo ${CREDENTIALS_OUTPUT}|jq -r '.Credentials.SessionToken')
AWS_SECURITY_TOKEN=${AWS_SESSION_TOKEN}

### Create the token_file
cat << EOF >> ${TOKEN_FILE}
export AWS_ACCESS_KEY=${AWS_ACCESS_KEY}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
export AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}
export AWS_SECURITY_TOKEN=${AWS_SECURITY_TOKEN}
EOF

# ### Clear out old MFA data - yes - this creates a backup too
sed -i .bak '1,/\[mfa.*/!d' ${CREDENTIALS}

# ### Spit out something we can cut & paste
cat << EOF >> ${CREDENTIALS}
output=json
region=us-east-2
aws_access_key_id=${AWS_ACCESS_KEY}
aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}
aws_session_token=${AWS_SESSION_TOKEN}
EOF

# ### Clean up old stuff
find ${HOME}/.aws -type f -name credentials.\* -mtime +7 -exec rm {} \;