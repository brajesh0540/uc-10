resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_ecs_task_definition" "task" {
  for_each = var.services
  family = "${var.cluster_name}-${each.key}"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = each.value.cpu
  memory = each.value.memory
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = null

  container_definitions = jsonencode([
    {
      name      = each.key
      image     = "${each.value.image}:cicd"
      portMappings = [
        {
          containerPort = each.value.container_port
          hostPort      = each.value.container_port
          protocol      = "tcp"
        }
      ]
      essential = true
      logconfiguration = {
        logdriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/appointment-service"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
resource "aws_cloudwatch_log_group" "ecs_appointment_logs" {
  name              = "/ecs/appointment-service"
  retention_in_days = 7
}

  resource "aws_ecs_service" "ecs_service" {
  for_each = var.services
  name            = each.key
  cluster         = aws_ecs_cluster.ecs_cluster.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.task[each.key].arn
  desired_count   = 1
network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_groups
    assign_public_ip = true
  }

load_balancer {
    target_group_arn = var.ecs_target_group_arn
    container_name   = each.key
    container_port   = each.value.container_port

  }
depends_on = [ aws_ecs_task_definition.task ]

}
