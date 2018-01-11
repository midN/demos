#!/bin/bash

aws --profile awtf cloudformation delete-stack --stack-name iam
aws --profile awtf cloudformation delete-stack --stack-name ecs
aws --profile awtf cloudformation wait stack-delete-complete --stack-name ecs
aws --profile awtf cloudformation delete-stack --stack-name vpc
