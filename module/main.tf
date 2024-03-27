resource "aws_instance" "instance"{
    ami             = data.aws_ami.image.id
    instance_type   = var.instance_type
    vpc_security_group_ids = [data.security_group.sg.ids]


    tags = {
        Name = var.tool_name
    }
}

resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = var.tool_name
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.public_ip]
}