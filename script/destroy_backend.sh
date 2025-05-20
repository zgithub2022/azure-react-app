#!/bin/bash

RG=react-test-"${short_sha}"
location="East US"
SA=$(echo "${RG}"|tr - ' '|tr -d ' ')
az storage account delete --name "${SA}" --resource-group "${RG}" -y
az group delete --resource-group "${RG}" -y
