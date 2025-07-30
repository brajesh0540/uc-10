resource "aws_lb" "hackprepare_alb" {
  name               = "hackprepare-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.public[*].id
}

resource "aws_lb_target_group" "hackprepare_tg" {
  name     = "hackprepare-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

resource "aws_lb_listener" "hackprepare_listener" {
  load_balancer_arn = aws_lb.hackprepare_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hackprepare_tg.arn
  }
}
