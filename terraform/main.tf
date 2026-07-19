data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "goldenowl_sg" {

  name        = "goldenowl-sg"
  description = "Allow SSH, HTTP and HTTPS"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    description = "HTTPS"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "goldenowl_key_pair" {

  key_name   = var.key_name
  public_key = var.public_key
}


resource "aws_iam_instance_profile" "ec2_profile" {

  name = "ec2-profile"

  role = "EC2-CONNECT-ECR"
}

resource "aws_ecr_repository" "goldenowl_ecr" {

  name = "goldenowl-app"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {

    scan_on_push = true
  }

  encryption_configuration {

    encryption_type = "AES256"
  }

}

resource "aws_instance" "goldenowl_instance" {

  ami           = var.ami_id
  instance_type = var.instance_type

  key_name = aws_key_pair.goldenowl_key_pair.key_name

  vpc_security_group_ids = [
    aws_security_group.goldenowl_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = var.private_key
    timeout = "4m"
  }
}
