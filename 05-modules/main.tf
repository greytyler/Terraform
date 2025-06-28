
# module
module "create_files" {
    source = "./file_creator"

    filename1 = "my_first_file.txt"
    file1_content = "from file1"

    filename2 = "my_second_file.txt"
    file2_content = "from file2"
}

output "file_path" {
    value = [
        module.create_files.file1_path,
        module.create_files.file2_path
    ] 
}

#You tell Terraform to create two files with specific names and contents.
#Terraform will show you where those files are saved.