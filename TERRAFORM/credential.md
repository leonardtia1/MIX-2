### Default configuration (deploy in 1 region and  1 account)
* config 
```t
[default]
output = json
region = us-east-1
```
* credentials
```tf
i
```

### Resources
```t
provider "aws" {
  region     =  "us-east-1"
}

resource "aws_eip" "myeip" {
  vpc = "true"
}
```

### Deploy resources in 2 region
```t
provider "aws" {
  region     =  "us-east-1"
}

provider "aws" {
  alias      = "ohio"
  region     =  "us-east-2"
}



resource "aws_eip" "myeip" {
  vpc = "true"
}

resource "aws_eip" "myeip1" {
  vpc = "true"
  provider = aws.ohio
}
```

### Deploy in multiple accounts

* config file 
[default]
output = json
region = us-east-1

[account02]
output = json
region = us-east-1


* credentials file
[default]
aws_access_key_id = AKIA3PBICDDCCEANXB56
aws_secret_access_key = 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

[account02]
aws_access_key_id = AKIA3PBICDDCCEANXB56
aws_secret_access_key = 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

* Test 
aws s3 ls
aws s3 ls --profile default
aws s3 ls --profile account02

* Default
```t
provider "aws" {
  region     =  "us-east-1"
  profile    = "default"
}

resource "aws_eip" "myeip" {
  vpc = "true"
}
```

* Accont 02
```t
provider "aws" {
  region     =  "us-east-1"
  profile    = "accont02"
}

resource "aws_eip" "myeip" {
  vpc = "true"
}
```

### Deploy in multiple accounts at the same time
```t
provider "aws" {
  region     =  "us-east-1"
  profile    = "default"
}


provider "aws" {
  alias      = "aws_aws02"
  region     = "us-east-1"
  profile    = "account02"
}


resource "aws_eip" "myeip01" {
  vpc = "true"
}

resource "aws_eip" "myeip02" {
  vpc = "true"
  provider = aws.aws_aws02
}
```

```t
provider "aws" {
  alias      = "aws_default"
  region     =  "us-east-1"
  profile    = "default"
}


provider "aws" {
  alias      = "aws_aws02"
  region     = "us-east-1"
  profile    = "account02"
}


resource "aws_eip" "myeip01" {
  vpc = "true"
  provider = aws.aws_aws02
}

resource "aws_eip" "myeip02" {
  vpc = "true"
  provider = aws.aws_default
}
```


### backend
```tf
terraform {
  backend "s3" {
  }
}
```
```t
terraform init \
    -backend-config="bucket=terraform-tia-backend" \
    -backend-config="key=remotedemo.tfstate" \
    -backend-config="region=us-east-1" \
    -backend-config="dynamodb_table=terraform-s3-state-lock" \
    -backend-config="access_key=AKIA3PBICDDCCEANXB56" \
    -backend-config="secret_key=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"
```

```t
terraform init \
    -backend-config="bucket=terraform-tia-backend" \
    -backend-config="key=dev/app1/remotedemo.tfstate" \
    -backend-config="region=us-east-1" \
    -backend-config="dynamodb_table=terraform-s3-state-lock" \
    -backend-config="access_key=AKIA3PBICDDCCEANXB56" \
    -backend-config="secret_key=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"
```


### Provider
```t
provider "aws" {
  region = "us-east-1"
  access_key = "AKIA3PBICDDCCEANXB56"
  secret_key = "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"
}
```