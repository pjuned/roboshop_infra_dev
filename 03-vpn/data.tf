## CentOS

# data "aws_ami" "centos8"{
#     owners = ["973714476881"]
#     most_recent      = true

#     filter {
#         name   = "name"
#         values = ["Centos-8-DevOps-Practice"]
#     }

#     filter {
#         name   = "root-device-type"
#         values = ["ebs"]
#     }

#     filter {
#         name   = "virtualization-type"
#         values = ["hvm"]
#     }
# }

# data "aws_vpc" "default" {
#   default = true
# }

# data "aws_subnet" "selected" {
#   vpc_id = data.aws_vpc.default.id
#   availability_zone = "us-east-1a"
# }


## OPen VPN

data "aws_ami" "openvpn"{
    owners = ["679593333241"]
    most_recent      = true

    filter {
        name   = "name"
        values = ["OpenVPN Access Server Community Image-fe8020db-5343-4c43-9e65-5ed4a825c931"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "vpn_sg_id" {
  name = "/${var.project_name}/${var.environment}/vpn_sg_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}


# output "vpc_info" {
#   value = data.aws_subnet.selected.id
# }


data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "selected" {
  vpc_id = data.aws_vpc.default.id
  availability_zone = "us-east-1a"
}