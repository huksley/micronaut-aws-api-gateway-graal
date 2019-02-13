docker build . -t my-app
mkdir build
docker run --rm --entrypoint cat my-app  /home/application/function.zip > build/function.zip
aws lambda create-function --function-name my-app \
--zip-file fileb://build/function.zip --handler function.handler --runtime provided \
--role arn:aws:iam::881337894647:role/lambda_basic_execution