output "user_pool_arn" {
  value = aws_cognito_user_pool.app_users.arn
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.app_client.id
}

output "user_pool_domain" {
  value = aws_cognito_user_pool_domain.app_domain.domain
}

output "client_secret" {
  value     = aws_cognito_user_pool_client.this.client_secret
  sensitive = true
}
