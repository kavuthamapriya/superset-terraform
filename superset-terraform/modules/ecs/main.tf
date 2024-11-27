resource "aws_ecs_cluster" "superset_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "superset_task" {
  family                   = "superset-task-family"
  container_definitions    = <<DEFINITION
[
  {
    "name": "superset-task",
    "image": "${aws_ecr_repository.my_superset_repo.repository_url}",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 8088,
        "hostPort": 8088
      }
    ],
    "memory": 512,
    "cpu": 256
  }
]
DEFINITION
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  memory                   = 512
  cpu                      = 256
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
