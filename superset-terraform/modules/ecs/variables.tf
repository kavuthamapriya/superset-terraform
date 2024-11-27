variable "ecs_cluster_name" {
  description = "The ECS Cluster Name"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "task_arn" {
  description = "The ARN of the ECS task"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}
