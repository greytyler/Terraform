# simple file resource
resource "local_file" "tf_example" {
    filename = "${path.module}/example.txt" 
}
