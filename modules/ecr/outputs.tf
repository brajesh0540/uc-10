output "repositories" {
  value = {
    for repo in var.ecr_repo_name : repo => aws_ecr_repository.ecr[repo].repository_url
  }
  
}