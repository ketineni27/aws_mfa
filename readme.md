# AWS MFA


This script is meant to be used from a bash shell. This works from my Macbook Pro,  YMMV...


### Requirements
1) You will need a bash shell:
  - Windows:  WSL
  - Windows: Git-Bash (not tested)
  - Mac: Terminal
  - Linux: Terminal

2) You will need a validate AWS account
3) You will need the AWS CLI tools installed:
  - https://docs.aws.amazon.com/cli/latest/userguide/installing.html  
4) You will need the arn for your MFA:
![alt text](https://github.com/rch317/aws_mfa/blob/master/images/virtual_device.png)


1) clone this repo:  

```
git clone git@github.com:rch317/aws_mfa.git
```

2) Copy the mfa.sh script to a directory in your PATH  

```
cp aws_mfa/mfa.sh ~/bin
```

3) Execut
