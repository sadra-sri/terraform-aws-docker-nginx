provider "aws"{
	region = "us-east-1"

}

resource "aws_instance" "test" {

	ami = "ami-05cf1e9f73fbad2e2"

	instance_type = "t3.micro"

	key_name = "sadrasaririjavan"

	vpc_security_group_ids = [aws_security_group.ssh_sg.id]


	connection {
	
		type = "ssh"
		user = "ubuntu"
		private_key = file("/home/ubuntu/sadrasaririjavan.pem")
		host = self.public_ip


	}


	provisioner "remote-exec" {
	
		inline = [
			"sudo apt-get update -y",
			"sudo apt-get install -y docker.io",
			"sudo systemctl start docker",
			"sudo systemctl enable docker",
			"sudo docker run -d -p 8080:80 --name my-nginx nginx"	
		]
	}


	associate_public_ip_address = true

}

resource "aws_security_group" "ssh_sg" {
	
	name = "allow_ssh"
	ingress{
		
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	
	}

	ingress {
	
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	
	egress {

		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}


data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
