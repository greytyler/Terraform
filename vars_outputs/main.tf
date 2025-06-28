
resource "local_file" "example1" {
    filename = "${path.module}/${var.filename1}.txt" 
    content = "This is demo content"
}
resource "local_file" "example2" {
    filename = "${path.module}/${var.filename2}.txt" 
    content = "This is demo content"
}
resource "local_sensitive_file" "example3" {
    filename = "${path.module}/${var.filename3}.md" 
    content = "#%Pas#%6;9-0"
}