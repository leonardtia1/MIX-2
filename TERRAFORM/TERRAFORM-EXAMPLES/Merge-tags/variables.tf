variable "vpc_cidr" {
  type = string
  default = "192.168.0.0/16"
}
variable "vpc_name" {
  type = string
  default = "man-dev-vpc"
}
variable "default_tags" {
  type = map(string)
  default = {
      owner         = "norm.nadeau@pearson.com" 
      project       = "mam" 
      stack         = "dev" 
      application   = "mam-dev" 
      t_dcl         = "2" 
      t_cost_centre = "9516.9130.251166.773000.00000.0000.0000.0000" 
      t_environment = "DEV"
      t_AppID       = "SVC02573"
  }
}