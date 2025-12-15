module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  ami = data.aws_ami.centos.id

  name = "${local.ec2-name}-vpn"
  instance_type = "t2.micro"

  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]

  subnet_id = data.aws_subnet.selected.id

  user_data = file("openvpn.sh")

  tags = merge(
    var.common_tags,
    {
        component = "vpn"
    },
    {
        Name = "${local.ec2-name}-vpn"
    }
  )
}

# resource "aws_key_pair" "openvpn" {
#   key_name   = "openvpn"
#   public_key = file("~/.ssh/github2.pub") # for mac use /
# }

# resource "aws_instance" "vpn" {
#   ami           = data.aws_ami.openvpn.id
#   instance_type = "t2.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
#   subnet_id = data.aws_subnet.selected.id
#   #key_name = "daws-84s" # make sure this key exist in AWS
#   key_name = aws_key_pair.openvpn.key_name
#   user_data = file("openvpn.sh")

#   tags = merge(
#     var.common_tags,
#     {
#         Name = "${var.project_name}-${var.environment}-vpn"
#     }
#   )
# }

# resource "aws_route53_record" "vpn" {
#   zone_id = var.zone_id
#   name    = "vpn-${var.environment}.${var.zone_name}"
#   type    = "A"
#   ttl     = 1
#   records = [aws_instance.vpn.public_ip]
#   allow_overwrite = true
# }