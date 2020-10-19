#!/usr/bin/env sh
set -euxo pipefail
echo "Applying terraform"
echo "Using project $1"
echo "Using zone $2"
terraform validate
terraform plan -var="project_name=$1" -var="geo_zone=$2"
terraform apply -var="project_name=$1" -var="geo_zone=$2"