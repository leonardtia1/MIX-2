
## Terraform Lynda

* [Advance Terraform Lynda](https://www.lynda.com/Terraform-tutorials/What-you-should-know/2823489/3129135-4.html)

* [advanced-terraform Github Code](https://github.com/LinkedInLearning/advanced-terraform-2823489)

### Variables
* Environment variables
* terraform.tfvars
* terraform.tfvars.json
* *.auto.tfvars
* -var or -var-file=variable file name (CLI option)

### Save a plan into a file
```
terraform plan -out=t1.tfplan
```

### Display the content of a plan
```
terraform show t1.tfplan
```

### Apply a plan
```
terraform apply t1.tfplan
```

### Convert a plan in to json
```
terraform show -json t1.tfplan
```

### Graph of the resources
```
terraform graph
http://webgraphviz.com/
```

### Overwrite the variable at the CLI
```
terraform plan -var deploy_environment=PROD -out=t2.tfplan
```