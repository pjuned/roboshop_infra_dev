module "mongodb" {
    source = "../../terraform_aws_sg"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for mongodb"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "mongodb"
    #sg_ingress_rules = var.mongodb_sg_ingress_rules
  }

  
  module "catalogue" {
    source = "../../terraform_aws_sg"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for catalogue"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "catalogue"
  }


  module "redis" {
    source = "../../terraform_aws_sg"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for redis"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "redis"
  }


 module "cart" {
    source = "../../terraform_aws_sg"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for cart"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "cart"
  }


 module "user" {
    source = "../../terraform_aws_sg"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for user"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "user"
  }

  module "mysql" {
    source = "../../terraform_aws_sg"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for mysql"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "mysql"
  }



  module "shipping" {
    source = "../../terraform_aws_sg"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for shipping"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "shipping"
  }

  module "rabbitmq" {
    source = "../../terraform_aws_sg"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for rabbitmq"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "rabbitmq"
  }


module "payment" {
    source = "../../terraform_aws_sg"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for payment"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "payment"
  }

  

  module "web" {
    source = "../../terraform_aws_sg"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for web"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "web"
  }

  # creating new vpn_sg_id for openvpn instance as I am putting it into same VPC i.e roboshop VPC
resource "aws_security_group" "vpn" {
  name        = "roboshop-dev-vpn"
  description = "VPN SG"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["43.249.227.74/32"] #My internet public IP 
  }



  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 943
    to_port     = 943
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-dev-vpn"
  }
}

  module "app_alb" {
    source = "../../terraform_aws_sg"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for app_alb"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "app_alb"
  }

module "web_alb" {
    source = "../../terraform_aws_sg"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for web_alb"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "web_alb"
  }


  #app_alb accepting connections from all components

resource "aws_security_group_rule" "app_alb-vpn" {
  source_security_group_id = aws_security_group.vpn.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.app_alb.sg_id
}

resource "aws_security_group_rule" "app_alb-web" {
  source_security_group_id = module.web.sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.app_alb.sg_id
}


resource "aws_security_group_rule" "catalogue-app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "app_alb-shipping" {
  source_security_group_id = module.app_alb.sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.shipping.sg_id
}

resource "aws_security_group_rule" "app_alb-cart" {
  source_security_group_id = module.app_alb.sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.cart.sg_id
}

resource "aws_security_group_rule" "app_alb-user" {
  source_security_group_id = module.app_alb.sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.user.sg_id
}


resource "aws_security_group_rule" "app_alb-payment-" {
  source_security_group_id = module.app_alb.sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.payment.sg_id
}

# resource "aws_security_group_rule" "app_alb-dispatch" {
#   source_security_group_id = module.app_alb.sg_id
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   security_group_id = module.dispatch.sg_id
# }


#web_alb accepting connections from internet

resource "aws_security_group_rule" "web_alb-internet" {
  cidr_blocks = ["0.0.0.0/0"]  
  type = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = module.web_alb.sg_id
}




#mongodb accepting connections:


resource "aws_security_group_rule" "mongodb_vpn" {
  source_security_group_id = aws_security_group.vpn.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id
}

#mongodb accepting connections from catalogue instance
resource "aws_security_group_rule" "mongodb_catalogue" {
  source_security_group_id = module.catalogue.sg_id
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id
}

# mongodb accepting from user
resource "aws_security_group_rule" "mongodb_user" {
  source_security_group_id = module.user.sg_id
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id
}


# redis accepting from vpn
resource "aws_security_group_rule" "redis_vpn" {
  source_security_group_id = aws_security_group.vpn.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}

# redis accepting from user
resource "aws_security_group_rule" "redis_user" {
  source_security_group_id = module.user.sg_id
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}

# redis accepting from cart
resource "aws_security_group_rule" "redis_cart" {
  source_security_group_id = module.cart.sg_id
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}

# mysql accepting from vpn
resource "aws_security_group_rule" "mysql_vpn" {
  source_security_group_id = aws_security_group.vpn.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.mysql.sg_id
}

# mysql accepting from shipping
resource "aws_security_group_rule" "mysql_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = module.mysql.sg_id
}

# rabbitmq accepting from vpn
resource "aws_security_group_rule" "rabbitmq_vpn" {
  source_security_group_id = aws_security_group.vpn.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.sg_id
}

# rabbitmq accepting from payment
resource "aws_security_group_rule" "rabbitmq_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.sg_id
}

# catalogue accepting from vpn
resource "aws_security_group_rule" "catalogue_vpn" {
  source_security_group_id = aws_security_group.vpn.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

#catalogue accepting from vpn_http
resource "aws_security_group_rule" "catalogue_vpn_http" {
  source_security_group_id = aws_security_group.vpn.id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

# resource "aws_security_group_rule" "catalogue_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.catalogue.sg_id
# }

resource "aws_security_group_rule" "catalogue_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

# resource "aws_security_group_rule" "catalogue_cart" {
#   source_security_group_id = module.cart.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.catalogue.sg_id
# }

# user accepting from vpn
resource "aws_security_group_rule" "user_vpn" {
  source_security_group_id = aws_security_group.vpn.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "user_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}

# resource "aws_security_group_rule" "user_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.user.sg_id
# }

# resource "aws_security_group_rule" "user_payment" {
#   source_security_group_id = module.payment.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.user.sg_id
# }

resource "aws_security_group_rule" "cart_vpn" {
  source_security_group_id = aws_security_group.vpn.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

# resource "aws_security_group_rule" "cart_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.cart.sg_id
# }

resource "aws_security_group_rule" "cart_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "shipping_vpn" {
  source_security_group_id = aws_security_group.vpn.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.shipping.sg_id
}

# resource "aws_security_group_rule" "shipping_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.shipping.sg_id
# }

resource "aws_security_group_rule" "shipping_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.shipping.sg_id
}

resource "aws_security_group_rule" "payment_vpn" {
  source_security_group_id = aws_security_group.vpn.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.payment.sg_id
}

# resource "aws_security_group_rule" "payment_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.payment.sg_id
# }

resource "aws_security_group_rule" "payment_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.payment.sg_id
}

resource "aws_security_group_rule" "web_vpn" {
  source_security_group_id = aws_security_group.vpn.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.web.sg_id
}

resource "aws_security_group_rule" "web_internet" {
  cidr_blocks = ["0.0.0.0/0"]
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = module.web.sg_id
}