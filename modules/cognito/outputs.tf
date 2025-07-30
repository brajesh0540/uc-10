output "cognito_user_pool_id" {
  description = "The User Pool ID"
  value       = aws_cognito_user_pool.app_users.id
}

output "cognito_user_pool_client_id" {
  description = "The User Pool Client ID"
  value       = aws_cognito_user_pool_client.app_client.id
}

output "cognito_user_pool_domain" {
  description = "The Cognito User Pool Domain"
  value       = aws_cognito_user_pool_domain.app_domain.domain
}
