variable "REGION" {
  default = "ca-central-1"
}

# Define the path to the file containing your container definitions
variable "container_definitions_file" {
  default = "../theyemihostspaceTaskDefinition.json"
}
