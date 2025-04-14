# modles/vpc/vpc.tf

# VPC Creation
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-vpc-${var.environment}"
    }
  )
}


# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-igw-${var.environment}"
    }
  )
}

# Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets_cidr)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-public-subnet-${count.index + 1}-${var.environment}"
      Type = "Public"
    }
  )
}


# Private Subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)
  
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-subnet-${count.index + 1}-${var.environment}"
      Type = "Private"
    }
  )
}


# Elastic IPs for NAT Gateways
# resource "aws_eip" "nat" {
#   count  = var.create_nat_gateway ? (var.single_nat_gateway ? 1 : length(var.public_subnets_cidr)) : 0
#   domain = "vpc"
  
#   tags = merge(
#     var.tags,
#     {
#       Name = "${var.project_name}-eip-${count.index + 1}-${var.environment}"
#     }
#   )
# }


# # NAT Gateways
# resource "aws_nat_gateway" "main" {
#   count         = var.create_nat_gateway ? (var.single_nat_gateway ? 1 : length(var.public_subnets_cidr)) : 0
#   allocation_id = aws_eip.nat[count.index].id
#   subnet_id     = aws_subnet.public[count.index].id
  
#   tags = merge(
#     var.tags,
#     {
#       Name = "${var.project_name}-nat-gw-${count.index + 1}-${var.environment}"
#     }
#   )
  
#   depends_on = [aws_internet_gateway.main]
# }

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-public-rt-${var.environment}"
    }
  )
}

# Add route to Internet Gateway
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

# Private Route Tables
resource "aws_route_table" "private" {
  count  = var.create_nat_gateway ? (var.single_nat_gateway ? 1 : length(var.private_subnets_cidr)) : length(var.private_subnets_cidr)
  vpc_id = aws_vpc.main.id
  
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-rt-${count.index + 1}-${var.environment}"
    }
  )
}

# Route from private subnet to NAT Gateway for internet access
# resource "aws_route" "private_nat" {
#   count                  = var.create_nat_gateway ? (var.single_nat_gateway ? length(var.private_subnets_cidr) : length(var.private_subnets_cidr)) : 0
#   route_table_id         = element(aws_route_table.private[*].id, var.single_nat_gateway ? 0 : count.index)
#  destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = element(aws_nat_gateway.main[*].id, var.single_nat_gateway ? 0 : count.index)
# }

# Associate private subnets with private route tables
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = element(aws_route_table.private[*].id, var.single_nat_gateway ? 0 : count.index)
}