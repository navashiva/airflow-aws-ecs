# Apache Airflow on AWS ECS

A guide to setup Apache Airflow on AWS ECS service using Fargate.

> Follow the below steps sequentially

## Deployment Architecture
![Alt text](docs/images/DeploymentArchitecture.jpeg?raw=true "Airflow on AWS ECS")

## Prerequisites
- AWS CLI access to account with permissions to ECR, ParameterStore and KMS.
- Docker

## Deployment Guide

1. Create PostgreSQL database and ECR repository for Airflow docker image

    Launch AWS Aurora PostgreSQL database and AWS ECR repository using AWS CloudFormation stack cloudformation/airflow-resources.yaml

2. Build the image and pulish it to ECR repository

    Build the base docker image for Airflow and publish it to AWS ECR repository. Pass the URI of
    ECR repository as first argument to following command (Get the URI from AWS ECR console)
    `sh build-publish.sh 594602835978.dkr.ecr.us-west-1.amazonaws.com/apache/airflow`
    
3. Create a parameter store for securly storing PostgreSQL password
    
    Store the password of PostgreSQL database at AWS Parameter Store by executing follow awscli command
    `aws ssm put-parameter --name airflow-db-password --value lokyataAirflow --type SecureString --overwrite`

4. Create ECS cluster and Airflow service
    
    Launch AWS ECS cluster with Airflow service by using cloudformation/airflow-cluster.yaml. Get the ALB 
    endpoint from output variables of CloudFormation
    
> Airflow is accessible over port 8080 and Flower over port 5555


