#!/usr/bin/env bash

awslocal s3api create-bucket --bucket hey --region eu-central-1 --create-bucket-configuration LocationConstraint=eu-central-1

awslocal sqs create-queue --queue-name hey-fetch

awslocal sqs create-queue --queue-name hey-events

awslocal sqs create-queue --queue-name hey-send

awslocal dynamodb create-table \
--table-name hey \
--attribute-definitions \
    AttributeName=external_id,AttributeType=S \
    AttributeName=category,AttributeType=S \
--key-schema \
    AttributeName=external_id,KeyType=HASH \
    AttributeName=category,KeyType=RANGE \
--provisioned-throughput ReadCapacityUnits=2,WriteCapacityUnits=2
