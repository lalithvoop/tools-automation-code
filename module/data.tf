data "aws_ami" "image" {
    most_recent = True
    name_regex = "RHEL-9-DevOps-Practice"
    owners = ["973714476881"]
}

data "security_group" "sg" {
    name = "allow-all"
}

data "aws_route53_zone" "zone" {
  name         = "vlsdo.online"
  private_zone = false
}