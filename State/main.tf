resource "local_file" "tf_file1" {
    filename = "${path.module}/fileum.txt" 
    content = "This is demo content"
}
resource "local_file" "tf_file2" {
    filename = "${path.module}/fileum2.txt" 
    content = "This is demo content"
}
resource "local_sensitive_file" "tf_sensitive" {
    filename = "${path.module}/sensitive.md" 
    content = "#%Pass32427^-0"
}

#terraform destroy -target=local_sensitive_file.tf_sensitive 
# terraform state -h .......see tf advenced state management commands
#terraform refresh to check for state drift, if change done on console was intentional tf will update the state file instead of updating the resources