
variable "filename"{
    type = string
    default = "default-value"
}

variable "api_key" {
  type = string
  default = "default-api-key"}

#Different ways to give values to variables in Terraform

#tf plan -var="name-via_cli"

#terraform.tfvars file