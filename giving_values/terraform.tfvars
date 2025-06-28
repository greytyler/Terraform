

filename = "name_via-tfvars"

#1 -var or -var-file are used to pass variables via CLI eg. tf plan -var="filename=name_via-cli"

#2 terraform.tfvars file. If filename is not terraform.tfvars, then implicitly tf plan -var-file="custom_name.tfvars"

#3 *.auto.tfvars file similar to .tfvars file but here its good when you want to seperate your variables like dev.auto.tfvars, staging.auto.tfvars, prod.auto.tfvars etc

#4 $env:TF_VAR_filename = "from-env-var"  Environment variable

#5 And lastly there's the default tf value in the variable.tf file