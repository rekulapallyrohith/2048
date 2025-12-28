variable "aws_region" {
  default = "ap-south-1"
}
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"

}
variable "public_subnet" {
  type = list(object({
    cidr_block = string
    az         = string
    tags       = map(string)
  }))
  default = [{
    cidr_block = "10.0.0.0/24"
    az         = "ap-south-1a"
    tags = {
      Name = "web1"
    }
    }, {
    cidr_block = "10.0.1.0/24"
    az         = "ap-south-1b"
    tags = {
      Name = "web2"
    }
  }]
}
variable "private_subnet" {
  type = list(object({
    cidr_block = string
    az         = string
    tags       = map(string)

  }))
  default = [{
    cidr_block = "10.0.2.0/24"
    az         = "ap-south-1a"
    tags = {
      Name = "app1"
    }
    }, {
    cidr_block = "10.0.3.0/24"
    az         = "ap-south-1b"
    tags = {
      Name = "app2"
    }
  }]
}

variable "cluster_name" {
  default = "my-eks-2048"
}