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

### Configuring the AWS CLI tool
Using profiles is a requirement for this script.  Use them...  
https://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html


### Usage
1) clone this repo:  

```
git clone git@github.com:rch317/aws_mfa.git
```

2) Copy the mfa.sh script to a directory in your PATH  

```
cp aws_mfa/mfa.sh ~/bin
```

3) Execute the mfa.sh script, you need to pass your MFA token to the script

```
$ ./mfa.sh 123456
export AWS_ACCESS_KEY_ID="XXXXXXXXXXXXXXXXXXXXXXxx"
export AWS_SECRET_ACCESS_KEY="XXXXiiiiXXXXXXXXXXXXXiiiiXX+XXXXXXX"
export AWS_SESSION_TOKEN="FQoGZXIvYXdzEIH//////////wEaDIJHn2mOY0WMZmBcSiKwAdWgxig7uCZlyb4U8vw2pfJygbdIvnwvdUJ0YxGYWeVh9EY9iUAzBeCWQQjSqirABCXyoW7FyA5YSqeo/hnkEtjiEowqvMgXOzDLmgfcinCAA55trb+V/L8wl6j27X4rdy0Q9o4TfhZjksSlptI6T3YRfFvTxhB7HQUnDTB+AJ0c++3+DrcYqRloq4e/qLcLT8p/4L1WD0rfF6W5Zo+vcq/eKOPYlt8F"
export AWS_SECURITY_TOKEN="FQoGZXIvYXdzEIH//////////wEaDIJHn2mOY0WMZmBcSiKwAdWgxig7uCZlyb4U8vw2pfJygbdIvnwvdUJ0YxGYWeVh9EY9iUAzBeCWQQjSqirABCXyoW7FyA5YSqeo/hnkEtjiEowqvMgXOzDLmgfcinCAA55trb+V/L8wl6j27X4rdy0Q9o4TfhZjksSlptI6T3YRfFvTxhB7HQUnDTB+AJ0c++3+DrcYqRloq4e/qLcLT8p/4L1WD0rfF6W5Zo+vcq/eKOPYlt8F"

```

4) Do awesome things with AWS CLI:

```
aws s3 ls --profile aws-is-rad --region us-east-2
2017-07-21 15:55:00 our-really-cool-s3-bucket-us-east-2
```


## NOTICE

**This script will make changes to your credentials file, use at your own risk!**
