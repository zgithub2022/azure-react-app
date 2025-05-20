#!/bin/bash

RG=react-test-backend
location="East US"
SA=$(echo "${RG}"|tr - ' '|tr -d ' ')
az storage account delete --name "${SA}" --resource-group "${RG}" -y
az group delete --resource-group "${RG}" -y
