variable "tools" {
  default = {
    prometheus = {
      instance_type = "t3.small"
      policy_resource_list = ["ec2:DescribeInstances"]
    }
  }
}

variable "zone_id" {
  default = "Z05808672PDIFFA0T7K1O"
}
