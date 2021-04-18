# This readme details the instructions for creating your Lambda function

1. Run ``npm install -g serverless``. This will install the "Serverless Framework" 
2. Confirm you are in the correct directory where your code is going to be stored
3. Run ``serverless create --template aws-python3``. This creates the Lambda function template with boto3. It creates 2 files in our directory, the ``handler.py`` file and ``serverless.yml``
4. Once you have modified the files for your use and authenticated yourself to AWS from the Console or VSCode, run ``serverless deploy``.   

