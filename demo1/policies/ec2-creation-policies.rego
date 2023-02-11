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




