
## Terraform for AWS

### There are various types of tools that can allows you to deploy infrastructure as code
* Terraform
* CloudFormation
* Head
* Ansible
* SaltSack
* Chef, Puppet and other


### Which tools to choose for infrastructure as code?
* If your infrastructure is going to be vendor specific in longer term? Example AWS: you can choose Cloudformation.
* If you are planning to use multiple cloud providers, Terraform will be the best choice.


### Pros of Terraform
* Terraform support multiple platform. It has 100 of providers
* Easy to intergrate with configuration management like Ansible
* Easily extensible with the help of plugins
* It free

### Lists of Terraform Providers
* [Terraform supported platforms](https://www.terraform.io/docs/providers/index.html)

* [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)



### Delete all resources create by terraform with `terraform destroy`
* This will destroy all the resource this the Terraform state fiel
* if you want to destroy a particular resource, you can either command that resource in the state file and run Terraform apply or you can use `terraform destroy --target <resource name>` to do that.
* This command `terraform destroy --target <resource name>` will remove the resource in the state file and if your `terraform apply again`, it will create the resource again.
* The best way to destroy the resource is to remove it in `.tf` file or to command it in `.tf` file and run terraform apply command.


 ### Understanding Terraform State files
 * How does Terraform know if the resources were created or deleted? It uses the state file
 * Terraform will store all the resources that you created in the `terraform.tfstate` file.
* When we delete a resource, Terraform will remove that resource in the state file
This state file do not have any resource.
```tf
{
  "version": 4,
  "terraform_version": "0.13.5",
  "serial": 21,
  "lineage": "f52b6086-afa2-62cb-21d5-853af2b067b1",
  "outputs": {},
  "resources": []
}
```

### Terraform plan command 
* When your run `Terraform plan` command, always check this line: `Plan: 1 to add, 0 to change, 0 to destroy.`
* This is because if terraform wany to destroy something, it will be listed on this line.
* Avoid deleting resource manual through AWS console while using Terraform because this will create a challenge. When you will run `terraform apply` command it will always try to create resources that were deleted manually through the console.


### Understanding Desired & Current States
* Let say you have deploy a `t2.micro` EC2 using terraform and latter on, someone manually change the instance type through AWS console to `m4.large`.
* The `m4.large` that is currenty running is the di=esired state and the `t2.micro` in the terraform state file is the current state of your insfrastructure.
* The manual changes are called desired state and the details store in the terraform file are called current state
* When you run the `terraform plan`, it always try to match the desired state to current state
* A lot of time working in the production environment, tou will realize that the desired and current state are different.
* NB: The desired state is what is actually runing in AWS console and the current state is what we have in Terraform state file because they will be manual changes that will be done to you insfrastructure. You need to decide what to do if the cuurent is different from the desired state.

  * Desired and Current State
  * i) Desired State: EC2 = instance_type = "t2.micro"
  * ii) Current State: EC2 = "instance_state": "stopped" && "instance_type" = "t2.nano"
  * Desired State == Current State

### Refresh Command
When we run terraform apply command, it refreshes the state file first to match the disered state to the current state. We can also run the `terraform refresh` command to refresh the state file.
```
terraform refresh
```
```tf
# current state 
"instance_state": "running",
"instance_type": "t2.micro",

# Stop EC2 on aws console
"instance_state": "stopped",
"instance_type": "t2.micro",

# change the instance type from t2.micro to "t2.nano"
"instance_state": "running",
"instance_type": "t2.micro", >>>> "t2.nano"

# run terraform apply. This will always change the desired state to the current state.
"instance_state": "running",
"instance_type": "t2.micro"
```

### Challenges with the current state on computed values
* If will create and Ec2 instance with terraform without a security and latter create a SG and change the default SG, terraform will not manage that because they is no information about the SG in the state file.
* The default SG in not part of the current state
* if you make a manual change that is not defined in the state file, terraform will not do anything with that resource.

### Provider and Resources
* Terraform supports multiple providers. 
* We have to specify the provider details for which we want to launch the infrastructure 
* With the provider, we also have to add the tokens which will be used for authentication.
* On adding a provider, terraform init will download plugins associated with the provider.

### Terraform State File
* Terraform stores the state of the infrastructure that is being created from the TF files.
* his state allows terraform to map real-world resource to your existing configuration.
* Multiple resources in Terraform will have a separate block with the state file.


### Current State vs Desired State
* When running a terraform plan, Terraform must know the current state of resources in order to effectively determine the changes that it needs to make to reach your desired configuration.
* Current State = Current Infrastructure Resource & Configuration
* Desired State = Infrastructure Configuration defined within the Terraform TF Files.
* Terraform will plan to match the desired state to the current state. If there is a difference between both, the desired state will take the preference.


### Destroying Infrastructure With Terraform
* The terraform destroy command is used to destroy the Terraform-managed infrastructure.
* This will ask for confirmation before destroying it
* If -auto-approve is set, then the destroy confirmation will not be shown.


### Terraform Provider Versioning
* The provide add as a middle or interface between terraform and the service provider
* Provider have multiple versioning. For instance, Windows have a lot of version such Windows 10, 7, XP, server and so on.
* Provider plugins are released separately from Terraform itself.
* They have a different set of version numbers. 

### Explicitly Setting Provider Version
* During terraform init, if version argument is not specified, the most recent provider will be downloaded during initialization.
* For production use, you should constrain the acceptable provider versions via configuration, to ensure that new versions with breaking changes will not be automatically installed.
* AWS latter version is `hashicorp/aws: version = "~> 3.10.0"`. Type terraform init to see the version.
* This is because new version most be tested in the test enveronement before deploy to production.

```tf
provider "aws" {
  region  = "us-east-1"
  version = "2.7"
}
```

```tf
provider "aws" {
  # ... other configuration ...

  version = "~> 2.70"
}


provider "aws" {
  # ... other configuration ...

  version = "~> 3.0"
}
```

### Arguments for Specifying the provider
* There are multiple ways of specifying the version of a provider.
  * `>=1.0`: Download plogins that are greater than or equal to one
  * `<=1.0`: Download plogins that are less than or equal to one
  * `~>2.0`: Download plogins in the 2.X range
  * `>=2.10,<=2.30`: Download any plogins version between 2.10 and 2.30

```tf
version    = "2.7"
version    = ">= 2.8"
version    = "<= 2.8"
version    = ">=2.10,<=2.30"
```

```tf
provider "aws" {
    region = "us-east-1"
    version = ">=2.8,<=2.30"   
}
resource "aws_s3_bucket" "terraform_s3" {
    bucket = "terraform-bucket-232"
    acl = "private"
}
```

### Module 5 Types of Terraform Providers
There are two major categories for terraform providers
* HashiCorp Distributed provider 
* 3rd party provider
  * HashiCorp Distributed providers can be downloaded automatically during terraform init.
  * terraform init cannot automatically download providers that are not distributed by HashiCorp

### Overview of 3rd Party Providers
* It can happen that the official provider does not support specific functionality.
* Some organizations might have their proprietary platform for which they want to use Terraform.
* For such cases, individuals can decide to develop/use 3rd party providers.

### Configuring 3rd Party Provider
* Third-party providers must be manually installed, since terraform init cannot automatically download them.
* Install third-party providers by placing their plugin executables in the user plugins directory.
* Windows: `%APPDA%\terraform.d/plugins`
* All other system: `~/.terraform.d/plugins`

### Understanding Attributes and Output Values
* Terraform has the capability to output the attribute of a resource with the output values.
* An outputed attributes can not only be used for the user reference but it can also act as an input to other resources being created via terraform

