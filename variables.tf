//
// Variables specific to DNS Aliases module
//
variable "dns_aliases" {
  description = "Additional DNS names"
  type        = "list"
  default     = []
}

variable "dns_full_name" {
  description = "Use full name (id from label module) instead of short name for DNS host"
  default     = false
}

variable "dns_parent_zone_name" {
  description = "DNS name of the parent zone to put this in"
  default     = ""
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

variable "enable_ecs_managed_tags" {
  description = "Enable ECS managed task tagging"
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

variable "assign_public_ip" {
  description = "Assign a public IP address to the ENI (Fargate launch type only)"
  default     = false
}

variable "awsvpc_security_group_ids" {
  description = "Security ID's to assign to awsvpc network mode tasks"
  type        = "list"
  default     = []
}

variable "awsvpc_subnet_ids" {
  description = "Subnet IDs to put awsvpc network tasks in"
  type        = "list"
  default     = []
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

variable "ecs_launch_type" {
  description = "The launch type on which to run your service. The valid values are EC2 and FARGATE"
  default     = "EC2"
}

variable "docker_command" {
  description = "String to override CMD in Docker container (default \"\")"
  default     = ""
}

variable "docker_cpu" {
  description = "CPU units for task"
  default     = "512"
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

variable "docker_registry" {
  description = "Docker register for image"
  default     = ""
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

variable "platform_version" {
  description = "The platform version on which to run your service. Only applicable for launch_type set to FARGATE"
  default     = ""
}

variable "propagate_tags_method" {
  description = "Propagate tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION"
  default     = "SERVICE"
}

variable "requires_compatibilities" {
  description = "A set of launch types required by the task. The valid values are EC2 and FARGATE"
  type        = "list"
  default     = ["EC2"]
}

variable "security_group_ids" {
  description = "The security groups associated with the task or service"
  type        = "list"
  default     = []
}

variable "service_full_name" {
  description = "Use full name (id from label module) instead of short name for service name"
  default     = false
}

variable "service_identifier" {
  description = "Unique identifier for this pganalyze service (used in log prefix, service name etc.)"
  default     = "service"
}

variable "subnet_ids" {
  description = "The subnets associated with the task or service. For awsvpc"
  type        = "list"
  default     = []
}

variable "task_definition_arn" {
  description = "Task definition ARN to use instead of module generated one"
  default     = ""
}

variable "task_execution_role_arn" {
  description = "Execution role arn for tasks. Required got Fargate"
  default     = ""
}

variable "task_identifier" {
  description = "Unique identifier for this pganalyze task (used in log prefix, service name etc.)"
  default     = "task"
}

variable "task_role_arn" {
  description = "Task role ARN to use instead of module generated one"
  default     = ""
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

variable "ecs_health_check_grace_period_seconds" {
  description = "Health check grace period (seconds) before LB health checks start"
  default     = "30"
}

variable "ecs_placement_constraints" {
  description = "Placement contraints to use when distributing tasks"
  type        = "list"
  default     = []
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
