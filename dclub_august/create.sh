#!/bin/bash

aws --profile awtf cloudformation create-stack --stack-name iam --template-body file://iam.yaml --parameters file://iam_params.json --capabilities CAPABILITY_NAMED_IAM
aws --profile awtf cloudformation create-stack --stack-name vpc --template-body file://vpc.yaml
aws --profile awtf cloudformation wait stack-create-complete --stack-name vpc
aws --profile awtf cloudformation create-stack --stack-name ecs --template-body file://ecs.yaml --capabilities CAPABILITY_IAM