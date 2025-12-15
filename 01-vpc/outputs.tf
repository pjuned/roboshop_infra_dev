
  
# output "azs" {
#     value = module.roboshop.azs
  
# }

# output "vpc_id" {
#   value = aws_vpc.main.id
# }

# output "public_subnets_ids" {
#   value = aws_subnet.public[*].id
# }

# output "private_subnets_ids" {
#   value = aws_subnet.private[*].id
# }

# output "database_subnets_ids" {
#   value = aws_subnet.database[*].id
# }

output "vpc_id" {
  value = module.roboshop.vpc_id
}

output "public_subnet_ids" {
  value = module.roboshop.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.roboshop.private_subnet_ids
}

output "database_subnet_ids" {
  value = module.roboshop.database_subnet_ids
}
