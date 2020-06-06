#!/bin/bash

# Pass argument of Airflow ECR repository URI
REGION=$(echo $1 | awk -F '.' '{print $4}')

# Build the base image for all containers
docker build -t apache/airflow:1.10.9 .

# Setup docker login
dockerRegister=$(aws ecr get-login --no-include-email --region $REGION)
$dockerRegister

# Publish the image to ECR
docker rmi $1:latest
docker tag apache/airflow:1.10.9 $1:latest
docker push $1:latest