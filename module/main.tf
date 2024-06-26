resource "aws_instance" "instance"{
    ami             = data.aws_ami.image.id
    instance_type   = var.instance_type
    vpc_security_group_ids = [data.aws_security_group.sg.id]
    iam_instance_profile = aws_iam_instance_profile.test_profile.name


    instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "stop"
      spot_instance_type             = "persistent"
    }
  }
  tags = {
    Name = var.tool_name
  }
}

resource "aws_route53_record" "record" {
  zone_id = var.zone_id
  name    = var.tool_name
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.public_ip]
}


resource "aws_route53_record" "pvt-record" {
  zone_id = var.zone_id
  name    = "${var.tool_name}-private"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}
resource "aws_iam_role" "role" {
  name = "${var.tool_name}-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  
   inline_policy {
    name = "${var.tool_name}-inline-policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = concat(var.dummy_policy, var.policy_resource_list)
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }


  tags = {
    Name = "${var.tool_name}-role"
  }
}

resource "aws_iam_instance_profile" "test_profile" {
  name = "${var.tool_name}_profile"
  role = aws_iam_role.role.name
}