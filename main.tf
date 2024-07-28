provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
}

variable "server_public_ip" {
  description = "The public IP address of the server"
  type        = string
}

variable "private_key" {
  description = "The path to the private key for SSH"
  type        = string
}

resource "null_resource" "install_docker" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = var.server_public_ip  # Using the variable
      user        = "ubuntu"  # Replace with your SSH username
      private_key = file(var.private_key)  # Using the variable
    }

    inline = [
      "sudo apt-get update -y",  # Use apt-get for Ubuntu
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo usermod -aG docker ubuntu"  # Add the user to the docker group
    ]
  }
}

output "public_ip" {
  value = var.server_public_ip  # Using the variable
}
