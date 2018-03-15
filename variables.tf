//
// Variables specific to module label
//
variable "attributes" {
  description = "Suffix name with additional attributes (policy, role, etc.)"
  type        = "list"
  default     = []
}

variable "delimiter" {
  description = "Delimiter to be used between `name`, `namespaces`, `attributes`, etc."
  default     = "-"
}

variable "environment" {
  description = "Environment (ex: `dev`, `qa`, `stage`, `prod`). (Second or top level namespace. Depending on namespacing options)"
}

variable "name" {
  description = "Base name for resources"
}

variable "namespace-env" {
  description = "Prefix name with the environment. If true, format is: <env>-<name>"
  default     = true
}

variable "namespace-org" {
  description = "Prefix name with the organization. If true, format is: <org>-<env namespaced name>. If both env and org namespaces are used, format will be <org>-<env>-<name>"
  default     = false
}

variable "organization" {
  description = "Organization name (Top level namespace)."
  default     = ""
}

variable "tags" {
  description = "A map of additional tags"
  type        = "map"
  default     = {}
}

//
// Variables specific to DNS Aliases module
//
variable "dns_aliases" {
  description = "Additional DNS names"
  type        = "list"
  default     = []
}

//
// Variables specific to LB module
//
variable "lb_enable_https" {
  description = "Enable HTTPS listener in LB (http or https MUST be enabled)"
  default     = "false"
}

variable "lb_enable_http" {
  description = "Enable HTTP listener in LB (http or https MUST be enabled)"
  default     = true
}

variable "lb_internal" {
  description = "Configure LB as internal-only"
  default     = true
}

variable "lb_subnet_ids" {
  description = "VPC subnet IDs in which to create the LB (unnecessary if neither lb_enable_https or lb_enable_http are true)"
  type        = "list"
  default     = []
}

variable "acm_cert_domain" {
  description = "Domain name of ACM-managed certificate"
  type        = "string"
  default     = ""
}

variable "lb_healthcheck_interval" {
  description = "Time in seconds between LB health checks (default 30)"
  default     = 30
}

variable "lb_healthcheck_path" {
  description = "URI path for LB health checks (default /)"
  default     = "/"
}

variable "lb_healthcheck_port" {
  description = "Port for LB to use when connecting health checks (default same as application traffic)"
  default     = "traffic-port"
}

variable "lb_healthcheck_protocol" {
  description = "Protocol for LB to use when connecting health checks (default HTTP)"
  default     = "HTTP"
}

variable "lb_healthcheck_timeout" {
  description = "Timeout in seconds for LB to use when connecting health checks (default 5)"
  default     = 5
}

variable "lb_healthcheck_healthy_threshold" {
  description = "Number of consecutive successful health checks before marking service as healthy (default 5)"
  default     = 5
}

variable "lb_healthcheck_unhealthy_threshold" {
  description = "Number of consecutive failed health checks before marking service as unhealthy (default 2)"
  default     = 5
}

variable "lb_healthcheck_matcher" {
  description = "HTTP response codes to accept as healthy (default 200)"
  default     = "200-399"
}

variable "lb_cookie_duration" {
  description = "Duration of LB session stickiness cookie in seconds (default 86400)"
  default     = "86400"
}

variable "lb_stickiness_enabled" {
  description = "Enable LB session stickiness (default false)"
  default     = "false"
}

variable "lb_type" {
  description = "Type of LB to create: application, network"
  default     = "application"
}

// Variables specific to Security Group module

//
// Variables for container definition template
//

//
// Variables specific to this module
//
variable "enabled" {
  description = "Set to false to prevent the module from creating anything"
  default     = true
}

variable "enable_lb" {
  description = "Set to false to prevent the module from creating a Load Balancer"
  default     = true
}

variable "region" {
  description = "AWS region in which ECS cluster is located (default is 'us-east-1')"
  type        = "string"
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "ID of VPC in which ECS cluster is located"
  type        = "string"
}

variable "ecs_cluster_arn" {
  description = "ARN of ECS cluster in which the service will be deployed"
  type        = "string"
}

variable "ecs_security_group_id" {
  description = "Security group ID of ECS cluster in which the service will be deployed"
  type        = "string"
}

variable "ecs_desired_count" {
  description = "Desired number of containers in the task (default 1)"
  type        = "string"
  default     = 1
}

variable "docker_command" {
  description = "String to override CMD in Docker container (default \"\")"
  default     = ""
}

variable "docker_environment" {
  description = "List of environment maps of format { \"name\" = \"var_name\", \"value\" = \"var_value\" }"
  type        = "list"
  default     = []
}

variable "docker_image" {
  description = "Docker image to use for task"
  type        = "string"
  default     = ""
}

variable "docker_memory" {
  description = "Hard limit on memory use for task container (default 256)"
  default     = 256
}

variable "docker_memory_reservation" {
  description = "Soft limit on memory use for task container (default 128)"
  default     = 128
}

variable "docker_port_mappings" {
  description = "List of port mapping maps of format { \"containerPort\" = integer, [ \"hostPort\" = integer, \"protocol\" = \"tcp or udp\" ] }"
  type        = "list"
  default     = []
}

variable "docker_mount_points" {
  description = "List of mount point maps of format { \"sourceVolume\" = \"vol_name\", \"containerPath\" = \"path\", [\"readOnly\" = \"true or false\" ] }"
  type        = "list"
  default     = []
}

variable "docker_volumes" {
  description = "List of volume maps of format { \"name\" = \"var_name\", \"host_path\" = \"var_value\" }"
  type        = "list"
  default     = []
}

variable "ecs_data_volume_path" {
  description = "Path to volume on ECS node to be defined as a \"data\" volume (default \"/opt/data\")"
  default     = "/opt/data"
}

variable "network_mode" {
  description = "Docker network mode for task (default \"bridge\")"
  default     = "bridge"
}

variable "service_identifier" {
  description = "Unique identifier for this pganalyze service (used in log prefix, service name etc.)"
  default     = "service"
}

variable "task_identifier" {
  description = "Unique identifier for this pganalyze task (used in log prefix, service name etc.)"
  default     = "task"
}

variable "log_group_name" {
  description = "Name for CloudWatch Log Group that will receive collector logs (must be unique, default is created from service_identifier and task_identifier)"
  type        = "string"
  default     = ""
}

variable "extra_task_policy_arns" {
  description = "List of ARNs of IAM policies to be attached to the ECS task role (in addition to the default policy, so cannot be more than 9 ARNs)"
  type        = "list"
  default     = []
}

variable "app_port" {
  description = "Numeric port on which application listens (unnecessary if neither lb_enable_https or lb_enable_http are true)"
  type        = "string"
  default     = ""
}

variable "ecs_deployment_maximum_percent" {
  description = "Upper limit in percentage of tasks that can be running during a deployment (default 200)"
  default     = "200"
}

variable "ecs_deployment_minimum_healthy_percent" {
  description = "Lower limit in percentage of tasks that must remain healthy during a deployment (default 100)"
  default     = "100"
}

variable "ecs_placement_strategy_type" {
  description = "Placement strategy to use when distributing tasks (default binpack)"
  default     = "binpack"
}

variable "ecs_placement_strategy_field" {
  description = "Container metadata field to use when distributing tasks (default memory)"
  default     = "memory"
}

variable "ecs_log_retention" {
  description = "Number of days of ECS task logs to retain (default 3)"
  default     = 3
}

variable "container_definition" {
  description = "Container definition when not using module default definition"
  default     = ""
}

variable "container_definition_additional" {
  description = "Additional parameters to add to container definition. This is a json substring"
  default     = ""
}
