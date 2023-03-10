# Author - Ashay Maheshwari
# Date - February 11, 2023
# Overview - Script to automate process of terraform initiation, plan creation and OPA evaluation 

PROJECT_DIR="/home/osboxes/practice-goes-live/demonstrations/opa-terraform-demo/demo-ec2/"
TFPLAN_JSON_DIR="/home/osboxes/practice-goes-live/demonstrations/opa-terraform-demo/demo-ec2/ec2-tf/"
POLICIES_DIR="/home/osboxes/practice-goes-live/demonstrations/opa-terraform-demo/demo-ec2/policies/"

#Pass the name of policy as first command line argument 
REGO_POLICY_FILENAME=$1

# Step 1 - Terraform init 
cd $TFPLAN_JSON_DIR
terraform init

# Step 2 - Terraform validate 
terraform validate 

# Step 3 - Terraform plan 
terraform plan -out=tfplan.binary

# Step 4 - Terraform plan to JSON
terraform show -json tfplan.binary | jq '.' > tfplan.json

# Step 5 - Execute OPA Evaluation
echo "\n\n-----------------Executing OPA Evaluation-----------"
#opa eval --format raw -i ${TFPLAN_JSON_DIR}tfplan.json -d ${POLICIES_DIR}ec2-creation-policies-v1.rego 'data.terraform.ec2.policies' | jq '.'
opa eval --format raw -i ${TFPLAN_JSON_DIR}tfplan.json -d $POLICIES_DIR$REGO_POLICY_FILENAME 'data.terraform.ec2.policies' | jq '.'