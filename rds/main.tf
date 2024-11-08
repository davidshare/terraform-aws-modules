resource "aws_db_subnet_group" "this" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = var.tags
}

resource "aws_db_parameter_group" "this" {
  count = var.family != null ? 1 : 0

  name   = "${var.identifier}-parameter-group"
  family = var.family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = var.tags
}

resource "aws_db_instance" "this" {
  identifier             = var.identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  max_allocated_storage  = var.max_allocated_storage
  storage_type           = var.storage_type
  storage_encrypted      = var.storage_encrypted
  kms_key_id             = var.kms_key_id
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  port                   = var.port
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.this.name
  parameter_group_name   = var.family != null ? aws_db_parameter_group.this[0].name : null
  availability_zone      = var.availability_zone
  multi_az               = var.multi_az
  iops                   = var.iops
  publicly_accessible    = var.publicly_accessible
  monitoring_interval    = var.monitoring_interval
  monitoring_role_arn    = var.monitoring_role_arn

  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately
  maintenance_window          = var.maintenance_window

  skip_final_snapshot       = var.skip_final_snapshot
  copy_tags_to_snapshot     = var.copy_tags_to_snapshot
  backup_retention_period   = var.backup_retention_period
  backup_window             = var.backup_window

  tags = var.tags
}