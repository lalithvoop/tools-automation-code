resource "aws_instance" "instance"{
    ami             = data.aws_ami.image.id
    instance_type   = var.instance_type
    vpc_security_group_ids = [data.aws_security_group.sg.id]


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