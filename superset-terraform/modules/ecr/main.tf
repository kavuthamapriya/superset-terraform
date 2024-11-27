resource "aws_ecr_repository" "my_repo" {
  name  = var.repository_name
  
  lifecycle {
    prevent_destroy = false
  }
}
