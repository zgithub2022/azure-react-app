#!/bin/bash

# RG=react-"${{ steps.var.outputs.sha_short }}"
RG=react-test
az storage account delete --name $RG --resource-group $RG -l TF_VAR_location --encryption-services blob --no-wait
az group delete $RG -l TF_VAR_location --no-wait
