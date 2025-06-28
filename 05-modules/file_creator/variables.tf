
variable "file1_content" {
    description = "Content for the first file"
    type        = string
    default     = "This is the content of the first file."
  
}

variable "file2_content" {
    description = "Content for the second file"
    type        = string
    default     = "This is the content of the second file."
  
}

variable "filename1" {
    description = "Name of the file 1"
    type        = string 
    default     = "file1.txt"
}
 
variable "filename2" {
    description = "Name of the file 2"
    type        = string 
    default     = "file2.txt"
  
}