In order to run the Terraform code and deploy the Azure App Service, you need to do the following:

1. Run ``terraform init`` to download the azurerm provider and configure the runtime environment

2. Run ``terraform plan`` to check your code and output what the code will do

3. Run ``terraform apply`` to run the code and deploy the App Service

4. Once the app is deployed, go to the Azure Portal. Under the App Service, go to "Deployment Center". Connect ot GitHub and select the "javascript-sdk-demo-app" respository to deploy the Web App
