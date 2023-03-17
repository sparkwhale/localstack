#!/usr/bin/env bash

awslocal s3api create-bucket --bucket crm --region eu-central-1 --create-bucket-configuration LocationConstraint=eu-central-1
awslocal sqs create-queue --queue-name crm-fetch
awslocal sqs create-queue --queue-name crm-events
awslocal sqs create-queue --queue-name crm-send

awslocal dynamodb create-table \
    --table-name crm \
    --attribute-definitions \
        AttributeName=external_id,AttributeType=S \
        AttributeName=category,AttributeType=S \
    --key-schema \
        AttributeName=external_id,KeyType=HASH \
        AttributeName=category,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=2,WriteCapacityUnits=2
