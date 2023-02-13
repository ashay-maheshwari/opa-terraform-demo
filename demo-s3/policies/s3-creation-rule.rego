# Author - Ashay Maheshwari
# Date - February 12, 2023
# Overview - Script authors Rego policy to enforce rules in creation of S3 bucket on AWS

# Defined a namespace to contain polcies
package terraform.s3.policies

# Import all keywords available in Rego
import future.keywords
import input.planned_values.root_module.resources
#import input.planned_values.root_module.resources.values

# Policies defined by Organization 

# ALLOW CONDITION - Allow creation of S3 bucket if the following conditions meet 
#   1. S3 ACL must be private
#   2. S3 versioning must be enabled 

# REJECT CONDITION - Reject creation of EC2 instance if above conditions are evaluated to false 

default allow_s3_creation := false

allow_s3_creation if {
    
	# Condition 1 - S3 ACL must be private
    resources[0]["values"]["acl"] == "private"
    
    # Condition 2  - S3 versioning must be enabled 
    # check for the index of the resource with s3 bucket versioning details 
    # provide that index and look for the status 

    some index, item in resources 
    	item.type == "aws_s3_bucket_versioning"
        ec2_planned_value_index = index
    resources[index]["values"]["versioning_configuration"][0]["status"] == "Enabled"  
}


