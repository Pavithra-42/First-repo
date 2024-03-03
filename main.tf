# main.tf

provider "aws" {
  region = "us-east-1" # Change this to your desired AWS region
}

# Use the existing VPC ID
variable "vpc_id" {
  description = "vpc-0a3bad2458cbcc67e"
  type        = string
}

# Generate a new key pair
resource "aws_key_pair" "example_key_pair" {
  key_name   = "example-key-pair"
  public_key = file("C:/Users/Hi/.ssh/id_rsa.pub")
# Replace with the path to your public key
}

# Create an EC2 instance within the existing VPC
resource "aws_instance" "example_instance" {
  ami           = "ami-07d9b9ddc6cd8dd30"  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example_key_pair.key_name
  vpc_security_group_ids = ["sg-0a9fc10324fe8e760"]  # Replace with the ID of your existing security group
  subnet_id     = "subnet-071e013c3e6aebd3e"  # Replace with the ID of your existing subnet

  tags = {
    Name = "example-instance"
  }
}
