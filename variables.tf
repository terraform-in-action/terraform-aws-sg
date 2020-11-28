variable "name" {
    default = null
    type = string
}

variable "description" {
    default = null
    type = string
}

variable "vpc_id" {
    type = string
}

variable "ingress_rules" {
    default = []
    description = "A list of custom ingress rules to apply"
    type = any
}

variable "egress_rules" {
    default = []
    description = "A list of custom egress rules to apply"
    type = any
}