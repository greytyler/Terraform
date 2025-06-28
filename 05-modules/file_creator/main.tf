terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.5.3"
    }
  }
}

resource "local_file" "file1" {
  filename = "${path.module}/${var.filename1}.txt"
  content  = var.file1_content
}

resource "local_file" "file2" {
  filename = "${path.module}/${var.filename2}.txt"
  content  = var.file2_content
}