resource "aws_lb" "ecs_alb" {
    name               = var.name
    internal           = false
    load_balancer_type = "application"
    security_groups    = [var.alb_sg_id]
    subnets            = var.public_subnets
    
    tags = {
        Name = var.name
    }
}

# === Listener Rule: Cognito Authentication ===
resource "aws_lb_listener_rule" "auth_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 1

  action {
    type = "authenticate-cognito"

    authenticate_cognito {
      user_pool_arn       = var.cognito_user_pool_arn
      user_pool_client_id = var.cognito_user_pool_client_id
      user_pool_domain    = var.cognito_user_pool_domain

      on_unauthenticated_request = "authenticate"
      scope                      = "openid email"
      session_cookie_name        = "AWSELBAuthSessionCookie"
      # Optional session expiration time (seconds)
      # session_timeout            = 86400
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.patients.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}




resource "aws_lb_target_group" "patients" {
    name     = "${var.name}-tg-patients"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
    target_type = "ip"

    health_check {
        path                = "/health"
        protocol            = "HTTP"
        matcher            = "200"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
    }
}

resource "aws_lb_target_group" "appointments" {
    name     = "${var.name}-tg-appointments"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
    target_type = "ip"

    health_check {
        path                = "/health"
        protocol            = "HTTP"
        matcher            = "200"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
    }
  
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.ecs_alb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "fixed-response"
        fixed_response {
            content_type = "text/plain"
            message_body = "not found"
            status_code  = "404"
        }
        
    }
}

resource "aws_lb_listener_rule" "patients" {
    listener_arn = aws_lb_listener.http.arn
    priority     = 10

    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.patients.arn
    }

    condition {
        path_pattern {
            values = ["/patients"]
        }
    }
}

resource "aws_lb_listener_rule" "appointments" {
    listener_arn = aws_lb_listener.http.arn
    priority     = 11

    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.appointments.arn
    }

    condition {
        path_pattern {
            values = ["/appointments"]
        }
    }
}
