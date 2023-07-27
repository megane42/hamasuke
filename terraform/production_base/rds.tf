module "aurora_mysql" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "7.7.0"

  name              = "aurora-${local.service}-${local.env}"
  engine            = "aurora-mysql"
  engine_mode       = "serverless"
  storage_encrypted = true

  vpc_id                 = module.vpc.vpc_id
  subnets                = module.vpc.private_subnets
  create_security_group  = false
  vpc_security_group_ids = [aws_security_group.rds.id]

  monitoring_interval = 60

  apply_immediately   = true
  skip_final_snapshot = false

  db_parameter_group_name         = aws_db_parameter_group.this.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.this.id
  # enabled_cloudwatch_logs_exports = # NOT SUPPORTED

  scaling_configuration = {
    auto_pause               = true
    min_capacity             = 1
    max_capacity             = 8
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}

resource "aws_db_parameter_group" "this" {
  name        = "aurora-mysql-db-parameter-group-${local.service}-${local.env}"
  description = "aurora-mysql-db-parameter-group-${local.service}-${local.env}"
  family      = "aurora-mysql5.7"
}

resource "aws_rds_cluster_parameter_group" "this" {
  name        = "aurora-mysql-cluster-parameter-group-${local.service}-${local.env}"
  description = "aurora-mysql-cluster-parameter-group-${local.service}-${local.env}"
  family      = "aurora-mysql5.7"
}

resource "aws_security_group" "rds" {
  name        = "security_group_rds_${local.service}_${local.env}"
  description = "Allow MySQL traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 3306
    to_port   = 3306
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
    Name = "security_group_rds_${local.service}_${local.env}"
  }
}

output "cluster_master_password" {
  value     = module.aurora_mysql.cluster_master_password
  sensitive = true
}
