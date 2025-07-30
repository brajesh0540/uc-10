resource "aws_ecs_cluster" "hackprepare" {
  name = "hackprepare-ecs-cluster"
}

resource "aws_ecs_task_definition" "hackprepare_task" {
  family                   = "hackprepare-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "hackprepare-backend"
      image     = "YOUR_DOCKER_IMAGE_URI"
      essential = true
      portMappings = [
        {
          containerPort = 5000
          protocol      = "tcp"
        }
      ]
      environment = [
        # Add necessary env vars here, e.g. DB endpoints, secrets
      ]
    }
  ])
}


resource "aws_ecs_service" "hackprepare_service" {
  name            = "hackprepare-service"
  cluster         = aws_ecs_cluster.hackprepare.id
  task_definition = aws_ecs_task_definition.hackprepare_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = aws_subnet.private[*].id
    security_groups = [aws_security_group.hackprepare_sg.id]
    assign_public_ip = false
  }

  depends_on = [aws_lb_target_group.hackprepare_tg]
}


