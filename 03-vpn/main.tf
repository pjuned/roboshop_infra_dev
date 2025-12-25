  resource "aws_key_pair" "openvpn" {
    key_name   = "openvpn"
    public_key = file("C:\\Users\\junaid\\.ssh\\github2.pub") # for mac use /
  }

  resource "aws_instance" "openvpn" {
      ami = data.aws_ami.openvpn.id
      instance_type = "t2.micro"
      vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
      subnet_id = local.public_subnet_id
      key_name = aws_key_pair.openvpn.key_name

      associate_public_ip_address = true
      source_dest_check           = false

      user_data = file("openvpn.sh")
      
      tags = merge (
          local.common_tags,
          {
              Name = "${var.project_name}-${var.environment}-openvpn"
          }
      )
  }

  resource "aws_route53_record" "openvpn" {
    zone_id = var.zone_id
    name    = "openvpn.${var.domain_name}" # openvpn.daws86s.fun  
    type    = "A"
    ttl     = 1
    records = [aws_instance.openvpn.public_ip]
    allow_overwrite = true
  }

# module "vpn" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   ami = data.aws_ami.centos8.id
#   name                   = "${local.ec2_name}-vpn"
#   instance_type          = "t3.small"
#   vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
#   subnet_id              = data.aws_subnet.selected.id
#   user_data = file("openvpn.sh")
#   tags = merge(
#     var.common_tags,
#     {
#       Component = "vpn"
#     },
#     {
#       Name = "${local.ec2_name}-vpn"
#     }
#   )
# }

