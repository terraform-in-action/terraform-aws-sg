provider "aws" {
    region = "us-west-2"
}

variable "vpc_id" {
  type = string
}

module "lb_sg" {
  source      = "./.."
  name = "test-lb"
  vpc_id      = var.vpc_id
  ingress_rules = [{
    port        = 80
    cidr_blocks = ["0.0.0.0/0"]
  }]
}

module "websvr_sg" {
  source      = "./.."
   name = "test-websvr"
  vpc_id      = var.vpc_id
  ingress_rules = [{
    port            = 8080
    security_groups = [module.lb_sg.security_group.id]
  }]
}

module "db_sg" {
  source      = "./.."
   name = "test-db"
  vpc_id      = var.vpc_id
  ingress_rules = [{
    port            = 3306
    security_groups = [module.websvr_sg.security_group.id]
  }]
}