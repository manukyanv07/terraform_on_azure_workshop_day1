#   Challenge 1: Deploying an Azure App Service using Terraform CLI and the Azure CLI

In this first challenge, you will have to deploy our sample ASP.NET Core application to Azure App Service. You will have to provision all required Azure resources using HashiCorp's Terraform.

We will be running the web application in frontend-only mode. This means that you will be hosting the ASP.NET Core application without a database. As a result, only the home page will be operational. In the following coding challenges you will fix this. Check the paragraph on running the application in frontend-only mode below on how to achieve this.

There are multiple ways to deploy a web application to Azure App Service. In this coding challenge you will use the Azure CLI to configure the Azure App Service Deployment Center continuous deployment. This will configure the App Service to pull the sample application code from a GitHub repo.

Make sure to first fork the sample application to your GitHub account, after which you can then configure continuous deployment from GitHub on your App Service.

TIP: the GitHub deployment setting for an App Service cannot be configured through Terraform. You will need to use another automated way to configure this.

##  Success criteria 🏆
To successfully complete this challenge, you will

- Use the Terraform CLI to provision the Azure resources to host 1) an Azure SQL database, 2) a MongoDB database on Azure Container Instances.
- Use the Azure CLI to deploy the sample application from a GitHub repo, using Azure App Service Deployment Center Continuous Deployment (not using GitHub Actions at this time!).


## Create Infrastructure
### Run locally
1. Install Terraform CLI
2. Install Azure CLI
3. Login to Azure CLI
    ```bash
    az login
    ```
4. Create a Service Principal for Terraform

    ```bash
    az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscription_id>"
    ```
5. Create a `terraform.tfvars` file with the following content:

    ```bash
    subscription_id = "<subscription_id>"
    client_id = "<client_id>"
    client_secret = "<client_secret>"
    tenant_id = "<tenant_id>"
    ```
   
6. Run the following commands:

    ```bash
    terraform init
    terraform plan
    terraform apply
    ```
7. Login to Azure Portal and check the created resources
