#!/bin/bash

echo -e "\nValidating the template\n"
echo -e "\nValidating the template:\n" > /tmp/StackUsers.log
aws --profile $1 cloudformation validate-template --template-body file://user_policy.yaml --region eu-west-1 >> /tmp/StackUsers.log

echo -e "\nCreating the Stack\n"
echo -e "Creating the Stack:\n" >> /tmp/StackUsers.log
aws --profile $1 cloudformation create-stack --stack-name StackUsers --template-body file://user_policy.yaml --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region eu-west-1 --parameters ParameterKey=CreateUsername,ParameterValue=$2 ParameterKey=CreatePassword,ParameterValue=$3 >> /tmp/StackUsers.log

echo -e "\nPlease, wait for the Stack creation\n"
echo -e "\nWaiting for the Stack creation:\n" >> /tmp/StackUsers.log
aws --profile $1 cloudformation wait stack-create-complete --stack-name StackUsers >> /tmp/StackUsers.log

echo -e "\nThe stack has been created\n"
