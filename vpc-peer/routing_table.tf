resource "aws_route_table" "primary_rt" {
    provider = aws.primary
    vpc_id = aws_vpc.vpc_a.id

    tags = {
        Name = "primary_rt"
        Environment = "Demo"
    }
}

resource "aws_route_table" "secondary_rt" {
    provider = aws.secondary
    vpc_id = aws_vpc.vpc_b.id
    tags = {
        Name = "secondary_rt"
        Environment = "Demo"
    }
}

resource "aws_route_table_association" "primary_rt_assoc" {
  provider = aws.primary
  subnet_id = aws_subnet.vpc_a_pub_subnet.id
  route_table_id = aws_route_table.primary_rt.id

}

resource "aws_route_table_association" "secondary_rt_assoc" {
  provider = aws.secondary
  subnet_id = aws_subnet.vpc_b_pub_subnet.id
  route_table_id = aws_route_table.secondary_rt.id
  
}

resource "aws_route" "rt_a_default" {
  route_table_id = aws_route_table.primary_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.primary_igw.id
  provider = aws.primary
}

resource "aws_route" "rt_b_default" {
  route_table_id = aws_route_table.secondary_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.secondary_igw.id
  provider = aws.secondary
}

resource "aws_route" "vpc_peer_a_to_b" {
    route_table_id = aws_route_table.primary_rt.id
    destination_cidr_block = aws_vpc.vpc_b.cidr_block
    provider = aws.primary
    vpc_peering_connection_id = aws_vpc_peering_connection.primary_peer_conn.id
    depends_on = [ aws_vpc_peering_connection_accepter.secondary_peer_acceptor ]
}

resource "aws_route" "vpc_peer_b_to_a" {
    route_table_id = aws_route_table.secondary_rt.id
    destination_cidr_block = aws_vpc.vpc_a.cidr_block
    provider = aws.secondary
    vpc_peering_connection_id = aws_vpc_peering_connection.primary_peer_conn.id
    depends_on = [ aws_vpc_peering_connection_accepter.secondary_peer_acceptor ]
}