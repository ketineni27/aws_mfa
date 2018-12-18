#!/bin/sh
AWS_DEVICE="arn:aws:iam::075520607603:mfa/rob.hough"
AWSCMD="aws sts get-session-token --output text"
TOKEN_FILE="${HOME}/.token_file"
CREDENTIALS="${HOME}/.aws/credentials"
AWS_CACHE="${HOME}/.aws/cli/cache"

### Remove any stale ${TOKEN_FILE}
rm -rf ${TOKEN_FILE}

### Clear our CLI cache
rm -rf ${AWS_CACHE}

### Create a backup of our credentials file
cp ${CREDENTIALS}{,.$(date +%s)}

### Get a new token
${AWSCMD} --serial-number ${AWS_DEVICE} --token-code $1 | \
 awk '{printf("export AWS_ACCESS_KEY_ID=\"%s\"\nexport AWS_SECRET_ACCESS_KEY=\"%s\"\nexport AWS_SESSION_TOKEN=\"%s\"\nexport AWS_SECURITY_TOKEN=\"%s\"\n",$2,$4,$5,$5)}' | tee ${TOKEN_FILE}

### Clear out old MFA data - yes - this creates a backup too
sed -i .bak '1,/\[mfa.*/!d' ${CREDENTIALS}

### grab data from token file to populate some vars
aws_access_id=$(grep AWS_ACCESS_KEY_ID ${TOKEN_FILE} |cut -d= -f 2 | sed -e 's/^"//' -e 's/"$//')
aws_secret_access_key=$(grep AWS_SECRET_ACCESS_KEY ${TOKEN_FILE} |cut -d= -f 2 | sed -e 's/^"//' -e 's/"$//')
aws_session_token=$(grep AWS_SESSION_TOKEN ${TOKEN_FILE} |cut -d= -f 2 | sed -e 's/^"//' -e 's/"$//')

### Spit out something we can cut & paste
cat <<EOF>>${CREDENTIALS}
output=json
region=us-east-2
aws_access_key_id=${aws_access_id}
aws_secret_access_key=${aws_secret_access_key}
aws_session_token=${aws_session_token}
EOF

source ${TOKEN_FILE}
