The deployment uses a CloudFormation YAML template which is based off the [AWS::Serverless Transform](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/transform-aws-serverless.html)

The included Lambda function (`function/Handler.ps1`) will simply output the number of Lambda functions in the AWS account/region based on https://docs.aws.amazon.com/powershell/latest/reference/items/Get-LMAccountSetting.html

# Requirements
- [PowerShell 7.0](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell#powershell-core)
- [.NET Core 3.1](https://www.microsoft.com/net/download)
- [AWSLambdaPSCore module 2.0](https://www.powershellgallery.com/packages/AWSLambdaPSCore/2.0.0.0)
- The Bash shell. For Linux and macOS, this is included by default. In Windows 10, you can install the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) to get a Windows-integrated version of Ubuntu and Bash.
- [The AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) v1.17 or newer.

# Setup
Download or clone this repository.
To create a new bucket for deployment artifacts, run `1-create-s3-bucket.sh`.

    $ ./1-create-bucket.sh
    Will output something like:
    make_bucket: lambda-artifacts-a5e491dbb5b22e0d

# Deploy
To deploy the application, run `2-deploy.sh`.

    $ ./2-deploy.sh
    Restoring .NET Lambda deployment tool
    Initiate packaging
    Uploading to e678bc216e6a0d510d661ca9ae2fd941  28800329 / 28800329.0  (100.00%)
    Successfully packaged artifacts and wrote output template to file out.yml.
    Waiting for changeset to be created..
    Waiting for stack create/update to complete
    Successfully created/updated stack - blank-powershell-lambda-with-api-gateway

This script uses AWS CloudFormation to deploy the Lambda functions and an IAM role. If the AWS CloudFormation stack that contains the resources already exists, the script updates it with any changes to the template or function code.

# Test
To invoke the function, first edit `3-invoke.sh` with the API endpoint and then run it. This URL can be found under the Lambda function -> Configuration -> Triggers

    $ ./3-invoke.sh
    {
      "AccountUsage": {
        "FunctionCount": 1,
        "TotalCodeSize": 31112884
      }
    }
