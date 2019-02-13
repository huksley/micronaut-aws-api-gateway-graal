# Micronaut + GraalVM Native + AWS Lambda Custom Runtime 

## Introduction

This app was generated using

```bash
mn create-app my-app --features aws-api-gateway-graal
```

## Building

This example demonstrates how to use Micronaut AWS API Gateway Proxy support and GraalVM to construct a custom runtime that runs native images or Lambda.

The `Dockerfile` contains the build to build the native image and it can be built with:

```bash
$ docker build . -t my-app
$ mkdir build
$ docker run --rm --entrypoint cat my-app  /home/application/function.zip > build/function.zip
```

## Running locally

Make sure you have [sam](https://github.com/awslabs/aws-sam-cli/) installed.
Run ./sam-local to start API from native function.
Open http://localhost:3000/

## Deploying

Which will add the function deployment ZIP file to `build/function.zip`. 
First, create S3 bucket for deployment, for example `my-bucket-for-function`.
You can then deploy via the AWS console or CLI:

```bash
aws cloudformation package --template-file sam.yaml --s3-bucket my-bucket-for-function --s3-prefix micronaut-my-app-graal --output-template-file build/sam-packaged.yaml

aws cloudformation deploy --template-file build/sam-packaged.yaml --stack-name MicronautGraalMyApp --capabilities CAPABILITY_IAM

aws cloudformation describe-stacks --stack-name MicronautGraalMyApp
```

The function can be invoked by sending an API Gateway Proxy request. For example:

```bash
aws lambda invoke --function-name MicronautGraalMyApp-MyServiceFunction-DEADBEEF --payload '{"resource": "/{proxy+}", "path": "/ping", "httpMethod": "GET"}' build/response.txt
cat build/response.txt
```

or using URL from `aws cloudformation describe-stacks --stack-name MicronautGraalMyApp` execute curl request:

```
curl https://deadbeef.execute-api.eu-west-1.amazonaws.com/Prod/ping
```

You should replace the `/ping` path entry with the URI the controller endpoint you wish to invoke.

## Errors during running function

```bash
START RequestId: 6ed53036-dc55-4c60-ae7a-ba91ad8f988c Version: $LATEST
io.micronaut.http.client.exceptions.ReadTimeoutException: Read Timeout
Request loop failed with: Read Timeout
END RequestId: 6ed53036-dc55-4c60-ae7a-ba91ad8f988c
REPORT RequestId: 6ed53036-dc55-4c60-ae7a-ba91ad8f988c  Duration: 15015.13 ms   Billed Duration: 15000 ms Memory Size: 128 MB   Max Memory Used: 95 MB  
2019-02-13T09:29:19.172Z 6ed53036-dc55-4c60-ae7a-ba91ad8f988c Task timed out after 15.02 seconds
```
