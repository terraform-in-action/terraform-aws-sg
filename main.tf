locals {
    ingress_rules = concat([
    {
        protocol = -1
        from_port = 0
        to_port = 0
        cidr_blocks = null
        security_groups = null
        self = true
    },
    ],[for r in var.ingress_rules : {
        protocol = lookup(r,"protocol","tcp")
        from_port = lookup(r,"port",0)
        to_port = lookup(r,"port",0)
        cidr_blocks = lookup(r,"cidr_blocks",null)
        security_groups = lookup(r,"security_groups",null)
        self = false
    }])

    egress_rules = concat([
    {
        protocol    = -1
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
        security_groups = null
    }
    ],[for r in var.egress_rules : {
        protocol = lookup(r,"protocol","tcp")
        from_port = lookup(r,"port",0)
        to_port = lookup(r,"port",0)
        cidr_blocks = lookup(r,"cidr_blocks",null)
        security_groups = lookup(r,"security_groups",null)
    }])
}

resource "aws_security_group" "security_group" {
    name = var.name
    description = var.description
    vpc_id = var.vpc_id

    dynamic "ingress" {
        for_each = local.ingress_rules
        content {
            protocol = ingress.value.protocol
            from_port = ingress.value.from_port
            to_port = ingress.value.to_port
            cidr_blocks = ingress.value.cidr_blocks
            self = ingress.value.self
            security_groups = ingress.value.security_groups
        }
    }

    dynamic "egress" {
        for_each = local.egress_rules
        content {
            protocol = egress.value.protocol
            from_port = egress.value.from_port
            to_port = egress.value.to_port
            cidr_blocks = egress.value.cidr_blocks
            security_groups = egress.value.security_groups
        }
    }
 }