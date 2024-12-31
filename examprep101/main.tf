resource "aws_s3_bucket" "test_aws_s3_bucket" {
  bucket = "dayo777-bucket"
  tags = {
    Name      = "s3-bucket"
    CreatedBy = "Dru"
  }
}

resource "aws_s3_bucket_versioning" "enable_bucket_versioning" {
  bucket = aws_s3_bucket.test_aws_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_vpc" "dru_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "dru_subnet" {
  vpc_id                  = aws_vpc.dru_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "dev-public-subnet"
  }
}

resource "aws_internet_gateway" "dru_internet_gateway" {
  vpc_id = aws_vpc.dru_vpc.id

  tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "dru_public_rt" {
  vpc_id = aws_vpc.dru_vpc.id

  tags = {
    Name = "dev-public-rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.dru_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dru_internet_gateway.id
}

resource "aws_route_table_association" "dru_public_rt_assoc" {
  subnet_id      = aws_subnet.dru_subnet.id
  route_table_id = aws_route_table.dru_public_rt.id
}

resource "aws_vpc" "mainvpc" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_security_group" "dru_sg" {
  vpc_id      = aws_vpc.dru_vpc.id
  name        = "dev-sg"
  description = "dummy security group for learning"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_key_pair" "dru_auth" {
#   key_name = "devkey"
#   public_key = file("~/.ssh/testkeypair.pem")
# }