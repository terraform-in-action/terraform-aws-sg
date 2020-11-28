# terraform-aws-sg
This is a module that makes it easy to create security groups in AWS. Built for 0.12

Example Usage:
```
module "sg" {
    name = var.name
    description = var.description
    vpc_id = var.vpc_id

    ingress_rules = [
        {
            protocol = "tcp"
            port = 80
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]    
}

```
outputs:
the created security group accesible via: `module.sg.security_group`