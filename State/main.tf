resource "local_file" "tf_file1" {
    filename = "${path.module}/fileum.txt" 
    content = "This is demo content"
}
resource "local_file" "tf_file2" {
    filename = "${path.module}/fileum.txt" 
    content = "This is demo content"
}
resource "local_sensitive_file" "tf_sensitive" {
    filename = "${path.module}/sensitive.md" 
    content = "#%Pas#%6;=09-0"
}

#terraform destroy -target=local_sensitive_file.tf_sensitive 
# terraform state -h .......see tf advenced state management commands
#terraform refresh to check for state drift, if change done on console was intentional tf will update the state file instead of updating the resources
# it is recommended to keep the state file in a remote backend like s3, azurerm, gcs, or in a seperate folder if local etc.