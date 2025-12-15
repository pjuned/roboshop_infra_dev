# data "aws_ami" "rhel"{
#     owners = ["973714476881"]
#     most_recent = true

#     filter {
#     name   = "name"
#     values = ["RHEL-9-*"]
#   }

#   filter {
#     name = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name = "virtualization-type"
#     values = ["hvm"]
#   }
# }

data "aws_ami" "centos"{
    owners = ["973714476881"]
    most_recent = true

    filter {
    name   = "name"
    values = ["Centos-*"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpc" "default" {
    default = true
}


data "aws_subnet" "selected" {
    vpc_id = data.aws_vpc.default.id
    availability_zone = "us-east-1b"
  
}

output "vpc_info" {
    value = data.aws_subnet.selected.id
  
}

data "aws_ssm_parameter" "vpn_sg_id" {
    name = "/${var.project_name}/${var.environment}/vpn_sg_id"

}


data "aws_ssm_parameter" "public_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/public_subnet_ids"

}
