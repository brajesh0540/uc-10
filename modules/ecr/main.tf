resource "aws_ecr_repository" "ecr" {
  for_each = toset(var.ecr_repo_name)
  name                 = each.value
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }
}