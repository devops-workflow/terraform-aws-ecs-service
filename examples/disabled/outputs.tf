output "lb_dns_name" {
  description = "FQDN of ALB provisioned for service (if present)"
  value       = "${module.disabled.lb_dns_name}"
}

output "lb_zone_id" {
  description = "Route 53 zone ID of ALB provisioned for service (if present)"
  value       = "${module.disabled.lb_zone_id}"
}

output "task_iam_role_arn" {
  description = "ARN of the IAM Role for the ECS Task"
  value       = "${module.disabled.task_iam_role_arn}"
}

output "task_iam_role_name" {
  description = "Name of the IAM Role for the ECS Task"
  value       = "${module.disabled.task_iam_role_name}"
}

output "service_iam_role_arn" {
  description = "ARN of the IAM Role for the ECS Service"
  value       = "${module.disabled.service_iam_role_arn}"
}

output "service_iam_role_name" {
  description = "Name of the IAM Role for the ECS Task"
  value       = "${module.disabled.service_iam_role_name}"
}

output "container_json" {
  description = ""
  value       = "${module.disabled.container_json}"
}
