# Author - Ashay Maheshwari
# Date - February 12, 2023
# Overview - Script authors Rego policy to enforce tag rules and guidlines for EC2 creation process


# Defined a namespace to contain polcies
package terraform.ec2.policies

# Import all keywords available in Rego
import future.keywords
import input.planned_values.root_module.resources
#import input.planned_values.root_module.resources.values


# Policies defined by Organization 

# ALLOW CONDITION - Allow creation of EC2 instance if all of the below rules are true in the Terraform plan 
#   1. Any EC2 instance to be created must have atleast 2 tags 
#   2. Tags must be "department" and "environment"

# REJECT CONDITION - Reject creation of EC2 instance if above conditions are evaluated to false 

default allow_ec2_tag_rule := false

allow_ec2_tag_rule if {
    
	# Set allow tags and values 
    compliant_tags_and_values = {
            	"department" : ["finance", "engineering", "research"],
            	"environment" : ["development", "test", "production"]
    }
           
    # Condition 1 - Check tags for EC2 "aws-instance" only
    # Loop through all the planned values in terraform plan and check the one which is for aws-instance
    # save the value of index in ec2_planned_value_index
    some index, item in resources 
    	  item.type == "aws_instance"
          ec2_planned_value_index = index
    
    ec2_planned_value_index == 0
    # Condition  - Check if there are atleast 2 tags in the plan
    tags = resources[index]["values"]["tags"]
    count(tags) > 0  
    
    # Condition 2 - Check if tags found in tfplan and tags allowed for compliance exists 
    # Get the keys in tags found in tfplan.json
    # Get the keys found in compliant tags set
	found_keys = object.keys(tags)
    compliant_tags_keys = object.keys(compliant_tags_and_values)
    found_keys == compliant_tags_keys
    
}


