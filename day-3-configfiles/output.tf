 output "ip" {
     value = aws_instance.name.public_ip
  
 }
 output "vpc_security_group_ids" {
    value = aws_instance.name.vpc_security_group_ids
   
 }
# output "privateip" {
#   value = aws_instance.day-4.private_ip
# }