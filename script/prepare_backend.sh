#!/bin/bash

set -uo pipefail

RG=react-test-backend
location="East US"
SA=$(echo "${RG}"|tr - ' '|tr -d ' ')
az group list --query "[?location=='$location']"|grep "${RG}"

if [ $? -ne 0 ]; then
  az group create --resource-group "${RG}" -l "${location}"
fi

az storage account list --resource-group "${RG}"|grep "${SA}"
if [ $? -ne 0 ]; then
  az storage account create --name "${SA}" --resource-group "${RG}" -l "${location}" --encryption-services blob
fi

az storage container exists -n tfstate --account-name "${SA}"|grep true

if [ $? -ne 0 ]; then
az storage container create -n tfstate --account-name "${SA}"
fi


sed -i -e "s/RESOURCE_GROUP_NAME/${RG}/" ../../template/backend.config
sed -i -e "s/STORAGE_ACCOUNT_NAME/${SA}/" ../../template/backend.config
cat ../../template/backend.config
