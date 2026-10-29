# allocate elastic ip for the nat-gateway in the public subnet 1 (PUB_SUB1)
resource "aws_eip" "nat_gw1_eip" {
    tags = {
      Name = "${var.PROJECT_NAME}-nat_gw1_eip"
    }
 
}

# allocate elastic ip for the nat-gateway in the public subnet 2 (PUB_SUB2)
resource "aws_eip" "nat_gw2_eip" {
    tags = {
      Name = "${var.PROJECT_NAME}-nat_gw2_eip"
    }
 
}

#create nat-gateway nat_gw1 in pub_sub1
resource "aws_nat_gateway" "nat_gw1" {
    allocation_id = aws_eip.nat_gw1_eip.id
    subnet_id = var.PUB_SUB1_ID

    tags = {
      Name = "${var.PROJECT_NAME}-nat_gw1"
    }


  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.IGW_ID]
}


# create private route table pri-rt-1 and add route through nat_gw1
resource "aws_route_table" "pri-rt-1" {
    vpc_id = var.VPC_ID

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gw1.id

    }
  
}


# associate private subnet pri-sub3 with private route table pri-rt-1
resource "aws_route_table_association" "pri-route-1" {
  route_table_id = aws_route_table.pri-rt-1.id
  subnet_id = var.PRI_SUB3_ID

}




#create nat-gateway nat_gw2 in pub_sub2
resource "aws_nat_gateway" "nat_gw2" {
    allocation_id = aws_eip.nat_gw2_eip.id
    subnet_id = var.PUB_SUB2_ID

    tags = {
      Name = "${var.PROJECT_NAME}-nat_gw2"
    }


  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.IGW_ID]
}


# create private route table pri-rt-2 and add route through nat_gw2
resource "aws_route_table" "pri-rt-2" {
    vpc_id = var.VPC_ID

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gw2.id

    }
  
}


# associate private subnet pri-sub4 with private route table pri-rt-2
resource "aws_route_table_association" "pri-route-2" {
  route_table_id = aws_route_table.pri-rt-2.id
  subnet_id = var.PRI_SUB4_ID

}


