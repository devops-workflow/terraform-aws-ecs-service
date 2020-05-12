//
// LB
//
output "lb_arn" {
  description = "ARN of the LB"
  value       = "${module.lb.arn}"
}

output "lb_dns_aliases" {
  description = "List of DNS aliases add for ALB"
  value       = "${module.route53-aliases.hostnames}"
}

output "lb_dns_name" {
  description = "FQDN of ALB provisioned for service (if present)"
  value       = "${module.lb.dns_name}"
}

output "lb_zone_id" {
  description = "Route 53 zone ID of ALB provisioned for service (if present)"
  value       = "${module.lb.zone_id}"
}

//
// LB Listener attributes
//
output "lb_listener_http_arns" {
  description = "The ARNs of the HTTP LB Listeners"
  value       = "${module.lb.listener_http_arns}"
}

output "lb_listener_https_arns" {
  description = "The ARNs of the HTTPS LB Listeners"
  value       = "${module.lb.listener_https_arns}"
}

output "lb_listener_tcp_arns" {
  description = "The ARNs of the network TCP LB Listeners"
  value       = "${module.lb.listener_tcp_arns}"
}

output "lb_listener_arns" {
  description = "ARNs of all the LB Listeners"
  value       = "${module.lb.listener_arns}"
}

//
// LB Target Group attributes
//
output "lb_target_group_http_arns" {
  description = "ARNs of the HTTP target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.lb.target_group_http_arns}"
}

output "lb_target_group_https_arns" {
  description = "ARNs of the HTTPS target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.lb.target_group_https_arns}"
}

output "lb_target_group_tcp_arns" {
  description = "ARNs of the TCP target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.lb.target_group_tcp_arns}"
}

output "lb_target_group_arns" {
  description = "ARNs of all the target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.lb.target_group_arns}"
}

output "lb_target_group_arns_suffix" {
  description = "ARNs suffix of all the target groups. Useful for passing to your Auto Scaling group module."
  value       = "${module.lb.target_group_arns_suffix}"
}

//
output "log_group_name" {
  description = "Cloudwatch log group name for service"
  value       = "${local.log_group_name}"
}

output "task_iam_role_arn" {
  description = "ARN of the IAM Role for the ECS Task"
  value       = "${element(concat(aws_iam_role.task.*.arn, list("")), 0)}"
}

output "task_iam_role_name" {
  description = "Name of the IAM Role for the ECS Task"
  value       = "${element(concat(aws_iam_role.task.*.name, list("")), 0)}"
}

output "service_iam_role_arn" {
  description = "ARN of the IAM Role for the ECS Service"
  value       = "${element(concat(aws_iam_role.service.*.arn, list("")), 0)}"
}

output "service_iam_role_name" {
  description = "Name of the IAM Role for the ECS Task"
  value       = "${element(concat(aws_iam_role.service.*.name, list("")), 0)}"
}

output "cluster_arn" {
  description = "ECS cluster ARN"

  value = "${element(concat(
    aws_ecs_service.service-no-lb.*.cluster,
    aws_ecs_service.service.*.cluster,
    aws_ecs_service.service-no-lb-net.*.cluster,
    aws_ecs_service.service-lb-net.*.cluster,
    list("")), 0)}"
}

output "service_arn" {
  description = "ECS service ARN"

  value = "${element(concat(
    aws_ecs_service.service-no-lb.*.id,
    aws_ecs_service.service.*.id,
    aws_ecs_service.service-no-lb-net.*.id,
    aws_ecs_service.service-lb-net.*.id,
    list("")), 0)}"
}

output "service_name" {
  description = "ECS service name"

  value = "${element(concat(
    aws_ecs_service.service-no-lb.*.name,
    aws_ecs_service.service.*.name,
    aws_ecs_service.service-no-lb-net.*.name,
    aws_ecs_service.service-lb-net.*.name,
    list("")), 0)}"
}

output "container_json" {
  description = ""
  #value       = "${element(concat(data.template_file.container_definition.*.rendered, list("")), 0)}"
  value       = "${module.merged.container_definitions}"
}
