
## Terraform Commannd

### Download provider plugins to interact with the API
```
terraform init
```

### To see all the changes before applying with terraform apply command
```
terraform plan
```

### Create resources
```
terraform apply
```

### To skip yes while running terraform appply command
```
terraform apply --auto-approve
```

### To skip yes while running terraform destroy command
```
terraform destroy --auto-approve
```

### To see all Common commands in terraform
```
terraform
```
### Check all state Subcommands
```
terraform state
```

### List resources in the state
```
terraform state list
```

### List all resources in the state file or see the contents of your tfstate files
```
terraform state show 
```

### List a specific resource in the state
```
terraform state show <resource name>
terraform state show aws_internet_gateway.igw
```

### Delete all resources create by terraform
* This will destroy all the resource this the Terraform state fiel
* if you want to destroy a particular resource, you can either command that resource in the state file and run Terraform apply or you can use `terraform destroy --target <resource name>` to do that.
* This command `terraform destroy --target <resource name>` will remove the resource in the state file and if your `terraform apply again`, it will create the resource again.
* The best way to destroy the resource is to remove it in `.tf` file or to command it in `.tf` file and run terraform apply command.

```
terraform destroy
```

### To destroy a particular resource
```
terraform destroy --target <resource name>
terraform destroy --target aws_security_group.allow-web
```

### To deploy a particular resource
```
terraform apply --target <resource name>
terraform apply --target aws_security_group.allow-web
```

### Comment in terraform
We use /* and */ to comment in terrform

```
/*
This is a comment in terraform
*/
```

```tf
provider "aws" {
    profile = "default"
    region = "us-east-1"
}
/*
resource "aws_s3_bucket" "terraform_s3" {
    bucket = "terraform-bucket-232"
    acl = "private"
}
*/
```

### Refresh Command (to refresh the current state)
When we run terraform apply command, it refreshes the state file first to match the disered state to the current state. We can also run the `terraform refresh` command to refresh the state file.
```
terraform refresh
```


a. terraform init
b. terraform plan
c terraform apply


1. terraform destroy -target resource_type.resource_logical_name

2. terraform get -update=true

3. terraform output -module=module-name

4.terraform plan -target=module.cloudgeeks.ca-vpc ---> only plan specific modules

5.terraform apply -target=module.cloudgeeks.ca-vpc ---> only apply specific modules

6.terraform state pull----> ok

7.terraform state push---->danger

8.terraform state rm module.cloudgeeks.ca-rds-app1  ----> https://stackoverflow.com/questions/43950097/how-to-import-manual-changes-into-terraform-remote-state

9.terraform show ---> see after deployment

10. terraform state list

#Note: Pull directly from git hub

#https://www.terraform.io/docs/modules/sources.html

11. source = "github.com/quickbooks2018/Terraform-Classic-Modules/modules/vpc"

# ssh generate public key from a private key

12. ssh-keygen -y -f terraform.pem > terraform.pub

13. terraform apply -var-file=dmz.tfvars

14. terraform destroy -var-file=dmz.tfvars

15. terraform import -var-file=dmz.tfvars module.sg7.aws_security_group.security_group sg-00afc6e255cc55387 

16. terraform plan -var-file=secrets.tfvars -var-file=dmz.tfvars -target=module.directory-service -out plan



#############################################################################################################

List the Terraform commands:

terraform
Common commands:
apply: Builds or changes infrastructure
console: Interactive console for Terraform interpolations
destroy: Destroys Terraform-managed infrastructure
fmt: Rewrites configuration files to canonical format
get: Downloads and installs modules for the configuration
graph: Creates a visual graph of Terraform resources
import: Imports existing infrastructure into Terraform
init: Initializes a new or existing Terraform configuration
output: Reads an output from a state file
plan: Generates and shows an execution plan
providers: Prints a tree of the providers used in the configuration
push: Uploads this Terraform module to Terraform Enterprise to run
refresh: Updates local state file against real resources
show: Inspects Terraform state or plan
taint: Manually marks a resource for recreation
untaint: Manually unmarks a resource as tainted
validate: Validates the Terraform files
version: Prints the Terraform version
workspace: Workspace management

Set up the environment:

mkdir -p terraform/basics
cd terraform/basics
Create a Terraform script:

vi main.tf
main.tf contents:

# Download the latest Ghost image
resource "docker_image" "image_id" {
  name = "ghost:latest"
}
Initialize Terraform:

terraform init
Validate the Terraform file:

terraform validate
List providers in the folder:

ls .terraform/plugins/linux_amd64/
List providers used in the configuration:

terraform providers
Terraform Plan:

terraform plan
Useful flags for plan:
-out=path: Writes a plan file to the given path. This can be used as input to the "apply" command.
-var 'foo=bar': Set a variable in the Terraform configuration. This flag can be set multiple times.

Terraform Apply:

terraform apply
Useful flags for apply:
-auto-approve: This skips interactive approval of plan before applying.
-var 'foo=bar': This sets a variable in the Terraform configuration. It can be set multiple times.

Confirm your apply by typing yes. The apply will take a bit to complete.

List the Docker images:

docker image ls
Terraform Show:

terraform show
Terraform Destroy:

terraform destroy
Confirm your destroy by typing yes.

Useful flags for destroys:
-auto-approve: Skip interactive approval of plan before applying.

Re-list the Docker images:

docker image ls
Using a plan:

terraform plan -out=tfplan
Applying a plan:

terraform apply tfplan
Show the Docker Image resource:

terraform show
Destroy the resource once again:

terraform destroy