resource "aws_vpc_peering_connection" "primary_peer_conn" {
  provider = aws.primary
  vpc_id = aws_vpc.vpc_a.id
  peer_vpc_id = aws_vpc.vpc_b.id
  peer_region = "us-west-1"
  auto_accept = false

  tags = {
      Name = "Primary to Secondary Peer Connection"
      Environment = "Demo"
  }
}

resource "aws_vpc_peering_connection_accepter" "secondary_peer_acceptor" {
    provider = aws.secondary
    vpc_peering_connection_id = aws_vpc_peering_connection.primary_peer_conn.id
    auto_accept = true

    tags = {
        Name = "Secondary to Primary Peer Connection"
        Environment = "Demo"
    }
}