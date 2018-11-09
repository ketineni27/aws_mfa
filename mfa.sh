#!/bin/sh
AWS_DEVICE="arn:aws:iam::075520607603:mfa/rob.hough"
AWSCMD="aws sts get-session-token --output text"

${AWSCMD} --serial-number ${AWS_DEVICE} --token-code $1 | \
 awk '{printf("export AWS_ACCESS_KEY_ID=\"%s\"\nexport AWS_SECRET_ACCESS_KEY=\"%s\"\nexport AWS_SESSION_TOKEN=\"%s\"\nexport AWS_SECURITY_TOKEN=\"%s\"\n",$2,$4,$5,$5)}' | tee ~/.token_file

source ~/.token_file
