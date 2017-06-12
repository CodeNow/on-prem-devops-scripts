#!/bin/bash
aws configure set aws_access_key_id {{ aws_ecr_access_key }}
aws configure set aws_secret_access_key {{ aws_ecr_secret_key }}
aws configure set region {{ aws_region }}
eval $(aws ecr get-login)
