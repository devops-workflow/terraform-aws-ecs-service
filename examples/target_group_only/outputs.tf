//
// LB
//
output "lb_arn" {
  description = "ARN of the LB"
  value       = "${module.example.lb_arn}"
}

output "lb_dns_aliases" {
  description = "List of DNS aliases add for ALB"
  value       = "${module.example.lb_dns_aliases}"
}

output "lb_dns_name" {
  description = "FQDN of ALB provisioned for service (if present)"
  value       = "${module.example.lb_dns_name}"
}

output "lb_zone_id" {
  description = "Route 53 zone ID of ALB provisioned for service (if present)"
  value       = "${module.example.lb_zone_id}"
}

//
// LB Listener attributes
//
output "lb_listener_http_arns" {
  description = "The ARNs of the HTTP LB Listeners"
  value       = "${module.example.lb_listener_http_arns}"
}

output "lb_listener_https_arns" {
  description = "The ARNs of the HTTPS LB Listeners"
  value       = "${module.example.lb_listener_https_arns}"
}

output "lb_listener_tcp_arns" {
  description = "The ARNs of the network TCP LB Listeners"
  value       = "${module.example.lb_listener_tcp_arns}"
}

output "lb_listener_arns" {
  description = "ARNs of all the LB Listeners"
  value       = "${module.example.lb_listener_arns}"
}

//
// LB Target Group attributes
//
output "lb_target_group_http_arns" {
  description = "ARNs of the HTTP target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.example.lb_target_group_http_arns}"
}

output "lb_target_group_https_arns" {
  description = "ARNs of the HTTPS target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.example.lb_target_group_https_arns}"
}

output "lb_target_group_tcp_arns" {
  description = "ARNs of the TCP target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.example.lb_target_group_tcp_arns}"
}

output "lb_target_group_arns" {
  description = "ARNs of all the target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.example.lb_target_group_arns}"
}

output "lb_target_group_arns_suffix" {
  description = "ARNs suffix of all the target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.example.lb_target_group_arns_suffix}"
}

//
output "task_iam_role_arn" {
  description = "ARN of the IAM Role for the ECS Task"
  value       = "${module.example.task_iam_role_arn}"
}

output "task_iam_role_name" {
  description = "Name of the IAM Role for the ECS Task"
  value       = "${module.example.task_iam_role_name}"
}

output "service_iam_role_arn" {
  description = "ARN of the IAM Role for the ECS Service"
  value       = "${module.example.service_iam_role_arn}"
}

output "service_iam_role_name" {
  description = "Name of the IAM Role for the ECS Task"
  value       = "${module.example.service_iam_role_name}"
}

output "cluster_arn" {
  description = "ECS cluster ARN"
  value       = "${module.example.cluster_arn}"
}

output "service_arn" {
  description = "ECS service ARN"
  value       = "${module.example.service_arn}"
}

output "service_name" {
  description = "ECS service name"
  value       = "${module.example.service_name}"
}

output "container_json" {
  description = ""
  value       = "${module.example.container_json}"
}
