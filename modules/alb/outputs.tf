output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.ecs_alb.dns_name
  
}

output "appointments_target_group_arn" {
  description = "The ARN of the ALBb"
  value       = aws_lb_target_group.appointments.arn
}

output "patients_target_group_arn" {
  value = aws_lb_target_group.patients.arn
}