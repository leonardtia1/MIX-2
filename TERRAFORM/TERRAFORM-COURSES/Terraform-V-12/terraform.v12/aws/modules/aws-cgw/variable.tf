variable "namespace" {
 type        = string
 description = "Namespace (e.g. `eg` or `cp`)"
 default     = ""
}

variable "stage" {
 type        = string
 description = "Stage (e.g. `prod`, `dev`, `staging`)"
 default     = ""
}

variable "delimiter" {
 type        = string
 default     = "-"
 description = "Delimiter to be used between `name`, `namespace`, `stage` and `attributes`"
}

variable "enabled" {
 description = "Controls if VPC should be created (it affects almost all resources)"
 type        = bool
 default     = true
}

variable "attributes" {
 type        = list(string)
 default     = []
 description = "Additional attributes (e.g. `1`)"
}

variable "name" {
 description = "Name to be used on all the resources as identifier"
 default     = ""
}


variable "tags" {
 description = "A map of tags to add to all resources"
 type        = map(string)
 default     = {}
}

#OFFICE STATIC PUBLIC IP
variable "customer-gateway-static-public-ip" {
 default = ""
}


data "aws_availability_zones" "azs" {}