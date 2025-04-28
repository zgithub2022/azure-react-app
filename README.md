# Pre-requisites
- Create a resource group react-rg having storage account name of reactapptwentyfourapr with a container name tfstate of Azure blob storage type. For Redundancy, select it as Locally-redundant storage. This will be used to store the statefile for all three environment.
- Create an Azure Container Registry using below commands after supplying same resource group as previous step and provide a new name for container registry.

>ACR=webapptwentyfourapr
<!-- markdownlint-disable -->

<!-- markdownlint-restore -->
>RG=react-rg
<!-- markdownlint-disable -->

<!-- markdownlint-restore -->
>az acr create --name $ACR --resource-group $RG --sku Basic --admin-enabled true

Additionally save the Container Registry webapptwentyfourapr.azurecr.io as ACR_LOGIN_SERVER, credentials to interact with Registry as ACR_USERNAME and ACR_PASSWORD as GitHub Action secret variables (Fetch it from Container Registry you created in portal via settings and Access Keys)

- Create an app registration, name it webapp and assign a secret, this will be used for GitHub action and stored in secret as AZURE_CREDENTIALS with below value. Also attach this to subscription with role of owner so that a new role assignment could be created with access to AcrPull and ensure that you add a condition to only assign AcrPull role.

>{
>"clientId": "TBD",
>"clientSecret": "TBD",
>"subscriptionId": "TBD",
>"tenantId": "TBD"
>}
- Assign this service principle webapp as a contributor to subscriptionId TBD
- Create a PAT Token with necessary permission to create a semantic release tag after creating an environment and save this as GH_TOKEN
- create tfvars file for specific environment e.g. development/development.tfvars, uat/uat.tfvars, production/production.tfvars
1. azurerm_rg -> This is a prefix for resource group which contains web app e.g. react-rg
2. location -> This is location of azure where web app is hosted  e.g. "West Europe"
3. environment -> This has been used to name the price plan and web app e.g. dev, uat and prod
4. ip_address_list -> list of whitelisted ip address from where app can be accessed e.g. if anywhere then ["0.0.0.0/0"]
5. container_port -> port where container is exposing the web app e.g. 3000 in dev and 80 in uat and prod
- Please make a note that **docker build through az acr is not supported in as a free customer** hence while building the image, docker credentials have been used from azure container registry. Also if app has been deployed initially with docker credentials, to redeploy with a role identity would need to be manually generated otherwise plan will fail.
## Automation
- Pipeline will fail if your commit message doesn't use below format e.g. "feat: new feature", "fix: fix of the code", "chore: generic change", "BREAKING CHANGE: new non backward compatible change" etc so first part allowed are build, chore, ci, docs, feat, perf, refactor, revert, style, test, BREAKING CHANGE and there must be ':' after that.
- commit your code from branch feature/azure-test which should kick off a GitHub action and should create a docker image and push into azure container registry and deploy this as a webapp exposing your application on port 3000 from container whiwh is equivalent to Dev
- Once Pull Request is merged into main, this should kick off a GitHub action from main and should create a docker image and push into azure container registry and deploy this as a webapp exposing your application on port 80 which will be treated as UAT
- Once a release version is created on merge to main, create the next tag by incrementing the minor version using command below on branch main
>git tag <next minor version> e.g. if current version is refs/tags/v1.2.1 then use git tag v1.2.2
>Push this tag to remote repository e.g. git push origin v1.2.2
- Docker Image for Dev, UAT & Production will be different. 
- Link for Web App is provided from terraform output which are as below:
[Dev](https://react-container-app-59b2a58c9381f0f8-dev.azurewebsites.net)
[UAT](https://react-container-app-2591d109a443d2c3-uat.azurewebsites.net)
[PROD](https://react-container-app-599bfb95f76fa8b8-prod.azurewebsites.net)
- As part of each pipeline, a new resource group, a web price plan and a web app is created.
- There is a workflow to destroy as well which will only destroy web app and associated resource group and price plan and is currently in disabled state and tied to branch feature/azure-test-destroy for dev.
## Release to Production
- Checkout the tag you want to use for production release and then create a new branch from that with syntax production/<descriptivetext>. Change README.md file to state that production URL will be available after this commit. Once this is commited, production endpoint is made available.
## Known Issues
1. Creation of tag is not resulting in kick off for production deployment
2. Follow the manual process for production deployment
3. To destroy the envrionment, please ensure you name your branch as feature/destroy, main/destroy and production/destroy respectively for dev, uat and production
4. There are linting issues which needs looking.
