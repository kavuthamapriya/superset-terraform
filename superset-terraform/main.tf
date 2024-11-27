
module "ecs" {
  source            = "./modules/ecs"
  ecs_cluster_name  = var.ecs_cluster_name
  subnet_id         = "subnet-79d0d010"
  task_arn          = var.task_arn
  vpc_id            = "vpc-b76c54de"
}

module "service" {
  source     = "./modules/service"
  cluster_id = module.ecs.cluster_id
  subnet_id  = "subnet-79d0d010"
  task_arn   = module.ecs.superset_task_arn
  vpc_id     = "vpc-b76c54de"
}

variable "ecs_cluster_name" {
  description = "The ECS Cluster Name"
  type        = string
}

variable "task_arn" {
  description = "The ARN of the ECS task"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_id" {
  value = module.vpc.subnet_id
}
output "load_balancer_dns" {
  value = module.service.load_balancer_dns
}
