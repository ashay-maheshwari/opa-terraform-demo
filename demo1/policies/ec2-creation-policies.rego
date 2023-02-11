# Author - Ashay Maheshwari
# Date - February 11, 2023
# Overview - Script authors Rego policies for creation of Ec2 instance on a dummy AWS Account


# Defined a namespace to contain polcies
package terraform.ec2.policies

# Import all keywords available in Rego
import future.keywords

# Policies defined by Organization 

# ALLOW CONDITION - Allow creation of EC2 instance if all of the below rules are true in the Terraform plan 
#   1. Any EC2 instance to be created must have tags - department and environment 
#   2. Must use verified terraform registry, i.e. - registry.terraform.io/hashicorp/aws
#   3. Instance must belong to t2 instance family 
#   4. EC2 instance must have a public IP Address allocated after creation 
# REJECT CONDITION - Reject creation of EC2 instance if above conditions are evaluated to false 

# Set variables 
defualt allow_ec2_creation := false

# save planned_values from terraform plan
tfplan_planned_values = input.planned_values

# save resource_changes from terraform plan 
tfplan_resource_changes = input.tfplan_resource_changes

# set variable with approved registry or provider
tfplan_approved_provider = "registry.terraform.io/hashicorp/aws"

# set variable with allowed aws instance type 
tfplan_approved_instance_familiy = "t2"

tag_exists if {
    # Check if tags exists in the Terraform plan JSON Input 
    # if tag exists, set this condition to true
}

registry_verified if {
    # Check if the terraform registry used is from verified hashicorp registry 
    # if yes, set this condition to true 

}

instance_family if {
    # Check if instance belongs to T2 familiy which is allowed 
    # If yes, set this condition to true 
}

public_ip if {
    # Check if instance is assigned with a public ip address 
    # If yes, set this condition to true 
}

allow_ec2_creation if {
    # checks if all the conditions are true and performs an AND operation 
    # as we need all conditions to be true 
    tag_exists              # if true AND
    registry_verified       # if true AND
    instance_family         # if true AND   
    public_ip               # if true AND 
}



