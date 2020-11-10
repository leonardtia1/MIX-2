
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