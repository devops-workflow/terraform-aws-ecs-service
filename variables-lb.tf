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

variable "lb_https_ports" {
  description = "HTTPS ports load balancer should listen on"
  default     = "443"
}

variable "lb_ingress_cidr_blocks" {
  description = "List of ingress CIDR blocks for load balancer"
  type        = "list"
  default     = ["10.0.0.0/8"]
}

variable "lb_listener_arn" {
  description = "Add to existing LB listener"
  default     = ""
}

variable "lb_listener_rule_pattern" {
  description = "Add to existing LB listener with rule pattern"
  default     = ""
}

variable "lb_listener_rule_priority" {
  description = "Add to existing LB listener as rule priority"
  default     = ""
}

variable "lb_ports" {
  description = "Ports load balancer should listen on"
  default     = "80"
}

variable "lb_stickiness_enabled" {
  description = "Enable LB session stickiness (default false)"
  default     = "false"
}

variable "lb_type" {
  description = "Type of LB to create: application, network"
  default     = "application"
}

# Remove?
variable "target_group_only" {
  description = "Only create target group without a load balancer. For when more advanced LB setups are required"
  default     = false
}

variable "target_type" {
  description = "Type for targets for target group. Can be: instance or ip"
  default     = "instance"
}
