provider "aws" {
  region = "us-east-1"
}

resource "null_resource" "install_docker" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = "34.229.141.58"  # Replace with your server's public IP
      user        = "ubuntu"                # Replace with your SSH username
      private_key = file("/home/ubuntu/.ssh/private_key.pem")  # Replace with the path to your private key
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
  value = "34.229.141.58"  # Replace with your server's public IP
}
