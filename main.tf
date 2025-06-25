# simple file resource
resource "local_file" "tf_example" {
    filename = "${path.module}/example.txt" 
    content = "Hey this is updated content to write to the file"
}

resource "local_sensitive_file" "tf_example2" {
    filename = "${path.module}/sensitive.txt"
    content = "This is a sensitive file created by Terraform"
}
