locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Retrieve the latest Amazon Linux 2023 AMI ID from AWS SSM.
data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# IAM role assumed by EC2 instances.
resource "aws_iam_role" "ec2" {
  name = "${var.environment}-portfolio-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = local.common_tags
}

# Allows secure management through AWS Systems Manager.
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.environment}-portfolio-ec2-profile"
  role = aws_iam_role.ec2.name

  tags = local.common_tags
}

# Defines the configuration for EC2 application instances.
resource "aws_launch_template" "app" {
  name_prefix   = "${var.environment}-portfolio-app-"
  image_id      = data.aws_ssm_parameter.al2023_ami.value
  instance_type = var.instance_type

  vpc_security_group_ids = [var.app_security_group_id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2.name
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    set -euxo pipefail

    dnf install -y httpd
    systemctl enable --now httpd

    cat > /var/www/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
      <head>
        <title>Terraform DevOps Portfolio</title>
      </head>
      <body>
        <h1>Application is running!</h1>
        <p>Deployed using Terraform on AWS.</p>
      </body>
    </html>
    HTML
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = merge(local.common_tags, {
      Name = "${var.environment}-portfolio-app"
      Tier = "private-app"
    })
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(local.common_tags, {
      Name = "${var.environment}-portfolio-app-volume"
    })
  }

  tags = local.common_tags

  depends_on = [
    aws_iam_role_policy_attachment.ssm
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# Maintains the desired number of EC2 instances across the two private subnets.
resource "aws_autoscaling_group" "app" {
  name                = "${var.environment}-portfolio-asg"
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  vpc_zone_identifier = values(var.app_subnet_ids)

  target_group_arns = [var.target_group_arn]

  health_check_type         = "ELB"
  health_check_grace_period = 180

  launch_template {
    id      = aws_launch_template.app.id
    version = aws_launch_template.app.latest_version
  }

  dynamic "tag" {
    for_each = merge(local.common_tags, {
      Name = "${var.environment}-portfolio-app"
      Tier = "private-app"
    })

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }
}
