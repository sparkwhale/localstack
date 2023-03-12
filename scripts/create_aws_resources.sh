#!/usr/bin/env bash

aws --endpoint-url=http://localhost:4566 s3api create-bucket --bucket hey --region eu-central-1 --create-bucket-configuration LocationConstraint=eu-central-1

aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name hey-fetch

aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name hey-events

aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name hey-send

aws --endpoint-url=http://localhost:4566 dynamodb create-table \
    --table-name hey \
    --attribute-definitions \
        AttributeName=external_id,AttributeType=S \
        AttributeName=category,AttributeType=S \
    --key-schema \
        AttributeName=external_id,KeyType=HASH \
        AttributeName=category,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=2,WriteCapacityUnits=2
