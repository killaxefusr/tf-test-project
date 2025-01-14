variable "aws_key_name" {
  type        = string
  default     = "my-key-tf"
  description = "AWS key pair name"
}

variable "ssh_pkey_file" {
  type        = string
  default     = "/home/user/.ssh/my-key-tf.pem"
  description = "SSH key pair path"
}
 
variable "allowed_ports" {
  type        = list(number)
  default     = [22]
  description = "List of allowed ports for the security group"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "ami" {
  type        = string
  default     = "ami-005fc0f236362e99f"
  description = "EC2 instance AMI"
}

variable "vpc_id" {
  type        = string
  default     = "vpc-005fc0f236362e99f"
  description = "AWS VPC ID"
}

variable "iam_role_name" {
  type        = string
  default     = "iam_role_tf_01"
  description = "AWS IAM role"
}

variable "subnet_id" {
  type        = string
  default     = "subnet-005fc0f236362e99f"
  description = "AWS VPC Subnet ID"
}

variable "ec2_sgroup" {
  type        = string
  default     = "test-tf-sg-01"
  description = "AWS EC2 security group"
}

variable "ec2_vol_type" {
  type        = string
  default     = "gp2"
  description = "AWS EC2 EBS volume type"
}

variable "ec2_vol_size" {
  type        = number
  default     = 8
  description = "AWS EC2 EBS volume size"
}

variable "ec2_inst_name" {
  type        = string
  default     = "ec2-test-terraform"
  description = "AWS EC2 instance name tag"
}
