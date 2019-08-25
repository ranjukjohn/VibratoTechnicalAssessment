################################################################################
#
# Setup the AWS instance
#
provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_instance" "vta" {
  ami                    = "ami-0edcec072887c2caa"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-0ebbba47"
  vpc_security_group_ids = [ "${aws_security_group.allow_http.id}" ]
  key_name               = "vtaKey"

  root_block_device {
    delete_on_termination = true
  }

  tags =  {
    Name         = "vta"
  }

  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("vtaKey.pem")}"
    timeout     = "20"
  }

  provisioner "file" {
    source      = "./webapp/setup.sh"
    destination = "~/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = ["chmod +x ~/bootstrap.sh", "sudo ~/bootstrap.sh"]
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http, ssh, node inbound traffic"
  vpc_id      = "${aws_default_vpc.default.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    # SSH
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

################################################################################
#
# Outputs
#
output "instance_id" {
  value = "${aws_instance.vta.id}"
}

output "private_ip" {
  value = "${aws_instance.vta.public_ip}"
}
