#!/bin/bash
set -eo pipefail
ARTIFACT_BUCKET=$(cat output-bucket-name.txt)
cd function
pwsh package.ps1
cd ../
aws cloudformation package --template-file template.yml --s3-bucket $ARTIFACT_BUCKET --output-template-file out.yml
aws cloudformation deploy --template-file out.yml --stack-name blank-powershell-lambda-with-api-gateway --capabilities CAPABILITY_NAMED_IAM
