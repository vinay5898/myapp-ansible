provider "aws" {
access_key = "AKIARKUYWJX3I3SV5B4F"
secret_key = "1+9LcGUc50sjB+ba1FVaUA8OFSnEH6oNECP9k0Dj"
region = "ap-south-1"
}
resource "aws_instance" "ec2_example" {
    ami = "ami-03fa4afc89e4a8a09"
    instance_type = "t2.micro"
    key_name= "terraform-ansible"
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}
