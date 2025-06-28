

resource "local_file" "example1" {
  filename = "${path.module}/${var.filename1}.txt"
  content  = "This is demo content"
  count = var.count_num
}

locals {
    base_path = "${path.module}/files"


    environment = "dev" #dev, staging,  prod
    upper_case = upper(local.environment)
    base_path2 = "${path.module}/configs/${local.upper_case}"
}

resource "local_file" "example2" {
  filename = "${local.base_path}/example2.md"
  content  = "foo"
}

resource "local_file" "example3" {
  filename = "${local.base_path}/example3.md"
  content  = "foo"
}

resource "local_file" "example4" {
  filename = "${local.base_path}/example4.md"
  content  = "foo"
}

resource "local_file" "service_configs" {
  filename = "${local.base_path2}/server.sh"
  content  = <<EOF
    environment=${local.environment}
    port=3000
EOF

}















# resource "local_file" "example1" {
#     filename = "${path.module}/${var.filename1}.txt" 
#     content = "This is demo content"
# }
# resource "local_file" "example2" {
#     filename = "${path.module}/${var.filename2}.txt" 
#     content = "This is demo content"
#     count = var.count_num
# }
# resource "local_sensitive_file" "example3" {
#     filename = "${path.module}/${var.filename3}.md" 
#     content = "#%Pas#%6;9-0"
# }