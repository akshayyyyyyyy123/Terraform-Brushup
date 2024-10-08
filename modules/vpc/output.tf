output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "public-subnet-id" {
  value = aws_subnet.public_subnet.id
}

output "private-subnet-id" {
  value = aws_subnet.private_subnet.id
}