#!/bin/bash

set -euo pipefail

sudo apt-get update 
sudo apt-get install -y nginx"
echo 'Hello, World!' | sudo tee /var/www/html/index.html

if [ $? -ne 0 ]; then
  echo "nginx installation may not have worked"
else
  echo "nginx installation has worked"
fi

