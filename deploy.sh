docker build . -t my-app
mkdir build
docker run --rm --entrypoint cat my-app  /home/application/function.zip > build/function.zip

aws cloudformation package --template-file sam.yaml --s3-bucket sam-test-deploy-vi6vah6oom --s3-prefix micronaut-my-app-graal --output-template-file build/sam-packaged.yaml

aws cloudformation deploy --template-file build/sam-packaged.yaml --stack-name MicronautGraalMyApp --capabilities CAPABILITY_IAM

aws cloudformation describe-stacks --stack-name MicronautGraalMyApp

