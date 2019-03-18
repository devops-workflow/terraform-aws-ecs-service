output "lb_dns_name" {
  description = "FQDN of ALB provisioned for service (if present)"
  value       = "${module.basic.lb_dns_name}"
}

output "lb_zone_id" {
  description = "Route 53 zone ID of ALB provisioned for service (if present)"
  value       = "${module.basic.lb_zone_id}"
}
//
// LB Target Group attributes
//
output "target_group_http_arns" {
  description = "ARNs of the HTTP target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.basic.target_group_http_arns}"
}

output "target_group_https_arns" {
  description = "ARNs of the HTTPS target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.basic.target_group_https_arns}"
}

output "target_group_tcp_arns" {
  description = "ARNs of the TCP target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.basic.target_group_tcp_arns}"
}

output "target_group_arns" {
  description = "ARNs of all the target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.basic.target_group_arns}"
}

output "target_group_arns_suffix" {
  description = "ARNs suffix of all the target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.basic.target_group_arns_suffix}"
}

//
output "task_iam_role_arn" {
  description = "ARN of the IAM Role for the ECS Task"
  value       = "${module.basic.task_iam_role_arn}"
}

output "task_iam_role_name" {
  description = "Name of the IAM Role for the ECS Task"
  value       = "${module.basic.task_iam_role_name}"
}

output "service_iam_role_arn" {
  description = "ARN of the IAM Role for the ECS Service"
  value       = "${module.basic.service_iam_role_arn}"
}

output "service_iam_role_name" {
  description = "Name of the IAM Role for the ECS Task"
  value       = "${module.basic.service_iam_role_name}"
}

output "cluster_arn" {
  description = "ECS cluster ARN"
  value       = "${module.basic.cluster_arn}"
}

output "service_arn" {
  description = "ECS service ARN"
  value       = "${module.basic.service_arn}"
}

output "service_name" {
  description = "ECS service name"
  value       = "${module.basic.service_name}"
}

output "container_json" {
  description = ""
  value       = "${module.basic.container_json}"
}
