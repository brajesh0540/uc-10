resource "aws_cognito_user_pool" "app_users" {
  name = "hackprepare-user-pool"

  username_attributes    = ["email"]
  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  schema {
    attribute_data_type      = "String"
    name                     = "email"
    required                 = true
    mutable                  = true

    string_attribute_constraints {
      min_length = 7
      max_length = 50
    }
  }

  tags = {
    Environment = "production"
    Application = "HackPrepareRepo"
  }
}

resource "aws_cognito_user_pool_client" "app_client" {
  name         = "hackprepare-web-client"
  user_pool_id = aws_cognito_user_pool.app_users.id

  generate_secret                = false # Use "true" for confidential clients
  explicit_auth_flows            = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_CUSTOM_AUTH",
  ]
  allowed_oauth_flows            = ["code", "implicit"]
  allowed_oauth_scopes           = ["email", "openid", "profile"]
  supported_identity_providers   = ["COGNITO"]

  callback_urls         = ["https://your-frontend.com/callback"]
  logout_urls           = ["https://your-frontend.com/logout"]

  prevent_user_existence_errors = "ENABLED"

  # Optionally, set access token validity, id token validity, etc
}

resource "aws_cognito_user_pool_domain" "app_domain" {
  domain       = "hackprepare-auth-example" # Must be unique globally
  user_pool_id = aws_cognito_user_pool.app_users.id
}
