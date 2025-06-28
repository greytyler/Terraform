esource "local_file" "example1" {
    filename = "${path.module}/example1.txt" 
    content = "This is demo content"
}
resource "local_file" "example2" {
    filename = "${path.module}/example2.txt" 
    content = "This is demo content"
}
resource "local_sensitive_file" "example3" {
    filename = "${path.module}/example3.md" 
    content = "#%Pas#%6;9-0"
}