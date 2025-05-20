#!/bin/bash

set -euo pipefail
sed -i -e 's/RESOURCE_GROUP_NAME/test/' backend.config
sed -i -e 's/STORAGE_ACCOUNT_NAME/test2/' backend.config
