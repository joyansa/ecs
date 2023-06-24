variable "region" {
  description = "AWS region"
  type        = string
}
variable "project_name" {}
variable "environment" {}
variable "architecture" {}
variable "container_image" {}
variable "vpc_id" {
  type = string
}
variable "public_subnet_cidr_blocks" {
  type = list(string)
}
variable "private_subnet_cidr_blocks" {
  type = list(string)
}