resource "aws_ecs_service" "Superset_Service" {
  name              = "Superset-Service"
  cluster           = var.cluster_id
  task_definition   = var.task_arn
  desired_count     = 1
  launch_type       = "FARGATE"

  network_configuration {
    subnets          = [var.subnet_id]
    security_groups  = [aws_security_group.lb_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.superset_tg.arn
    container_name   = "superset-task"
    container_port   = 8088
  }

  tags = {
    Name = "superset-service"
  }
}
