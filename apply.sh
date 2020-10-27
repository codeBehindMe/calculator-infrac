#!/usr/bin/env sh
set -euxo pipefail
echo "Applying terraform"
echo "Using project $1"
echo "Using zone $2"
echo "Using master auth ip cidr as $3"
terraform validate
terraform plan -var="project_name=$1" -var="geo_zone=$2" -var="master_auth_ip_cidr=$3"
terraform apply -var="project_name=$1" -var="geo_zone=$2" -var="master_auth_ip_cidr=$3" -auto-approve