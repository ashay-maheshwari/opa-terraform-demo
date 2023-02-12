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
    resources[1]["values"]["versioning_configuration"][0]["status"] == "Enabled"
}


