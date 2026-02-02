resource "aws_instance" "name" {
    ami = "ami-0532be01f26a3de55"
    instance_type = "t3.micro"
    tags = {
      Name = "import"
    }
  
}

#create empty resource block
# run terraform init
#run terraform import aws_instance instaceid
# add dependencies in manual
# appply only after no changes
 
   
 