variable "aws_region" {
  description = "aws region name"
  type        = string
}

variable "aws_profile" {
  description = "aws profile name"
  type        = string
}

variable "cidr_block" {
  description = "Cidr block"
  type        = string
}
variable "vpc_tag_name" {
  description = "tag Name of Vpc"
  type        = string
}

variable "aws_account_id" {
  description = "Account Id"
  type        = string
}

# EKS Cluster Variables

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "cluster_version" {
  description = "EKS Cluster Version"
  type        = string
}

variable "aws_first_user" {
  description = "AWS First Username"
  type        = string
}

variable "aws_second_user" {
  description = "AWS Second Username"
  type        = string
}

