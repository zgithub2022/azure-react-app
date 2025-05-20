#!/bin/bash

set -uo pipefail

RG=react-test-"${short_sha}"
# RG=react-test-20may
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

sed -i -e "s/RESOURCE_GROUP_NAME/${RG}/" ../../template/backend.config
sed -i -e "s/STORAGE_ACCOUNT_NAME/${SA}/" ../../template/backend.config
cat ../../template/backend.config
