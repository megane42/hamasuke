resource "aws_elasticache_subnet_group" "redis" {
  name        = "elasticache-subnet-group-${local.service}-${local.env}"
  description = "elasticache-subnet-group-${local.service}-${local.env}"
  subnet_ids  = module.vpc.private_subnets
}

resource "aws_elasticache_replication_group" "redis_for_session" {
  replication_group_id = "sidekiq-backend-${local.service}-${local.env}"
  description          = "sidekiq-backend-${local.service}-${local.env}"

  engine_version             = "7.0"
  node_type                  = "cache.t3.micro"
  automatic_failover_enabled = false
  multi_az_enabled           = false
  num_cache_clusters         = 1
  port                       = 6379
  security_group_ids         = [aws_security_group.redis.id]
  subnet_group_name          = aws_elasticache_subnet_group.redis.name
}

resource "aws_security_group" "redis" {
  name        = "security_group_elasticache_${local.service}_${local.env}"
  description = "Allow Redis traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 6379
    to_port   = 6379
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security_group_elasticache_${local.service}_${local.env}"
  }
}
