# AWS MFA


This script is meant to be used from a bash shell. This works from my Macbook Pro,  YMMV...


### Requirements
1) You will need a bash shell:
  - Windows:  WSL
  - Windows: Git-Bash (not tested)
  - Mac: Terminal
  - Linux: Terminal  

2) You will need a validate AWS account  

3) You will need the AWS CLI tools installed and configured:
  - https://docs.aws.amazon.com/cli/latest/userguide/installing.html   

4) You will need an MFA device assigned to your IAM account  

5) You will need the arn for your MFA (Assigned MFA Device, below):
![Assigned MFA Device](https://github.com/rch317/aws_mfa/blob/master/images/virtual_device.png)  

6) You will need the 'jq' tool installed:  
[Download jq](https://stedolan.github.io/jq/download/)


### Configuring the AWS CLI tool
Using profiles is a requirement for this script.  Use them...  
https://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html

Update your ``` $HOME/.aws/credentials ``` file to also include:

```
[mfa]

```

### Usage
1) Set your AWS_MFA_DEVICE variable according to your system. This is the
"Assigned MFA device" ARN pictured above. 

2) clone this repo:  

```
git clone git@github.com:rch317/aws_mfa.git
```

3) Copy the mfa.sh script to a directory in your PATH  

```
cp aws_mfa/mfa.sh ~/bin
```

4) Edit the mfa.sh script and update the locations if needed. Create the
.vars directory if you don't already have one:

```
mkdir -p ~/.vars
```

5) Execute the mfa.sh script, you need to pass your MFA token to the script

```
$ ./mfa.sh 123456
```

6) Do awesome things with AWS CLI:

```
aws s3 ls --profile aws-is-rad --region us-east-2
2017-07-21 15:55:00 our-really-cool-s3-bucket-us-east-2
```

### NOTES
The aws_token_file is configured for bash style environment variables.  You can add
the following code to your .bash_profile to auto-load these variables any time you
open a new terminal window.  This will work for the duration of the token (12hrs).

```
### Load various environment vars
myVars="${HOME}/.vars"
for file in $(ls ${myVars}/)
  do
    file="${myVars}/${file}"

    if [[ -r "${file}" ]] && [[ -f "${file}" ]]; then
      source "${file}"
    fi
  done
unset file
```
