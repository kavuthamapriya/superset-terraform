output "cluster_id" {
  value = aws_ecs_cluster.superset_cluster.id
}

output "superset_task_arn" {
  value = aws_ecs_task_definition.superset_task.arn
}
