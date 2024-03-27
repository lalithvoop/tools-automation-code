module "tool_vm_creation" {
    source = "./module"
    tool_name = var.tool_name
    instance_type = var.instance_type
}