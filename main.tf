###
### Terraform AWS ECS Service
###

# https://www.terraform.io/docs/providers/aws/r/ecs_service.html
# https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html

# TODO: Add support for multiple containers
#   Need for sidecars: Datadog agent, service mesh,

module "enabled" {
  source  = "devops-workflow/boolean/local"
  version = "0.1.2"
  value   = "${var.enabled}"
}

module "enable_lb" {
  source  = "devops-workflow/boolean/local"
  version = "0.1.2"
  value   = "${var.enable_lb}"
}

/*
# Remove?
module "lb_target_group_only" {
  source  = "devops-workflow/boolean/local"
  version = "0.1.2"
  value   = "${var.target_group_only}"
}
/**/
# Define composite variables for resources
module "label" {
  source        = "devops-workflow/label/local"
  version       = "0.2.1"
  name          = "${var.name}"
  attributes    = "${var.attributes}"
  delimiter     = "${var.delimiter}"
  environment   = "${var.environment}"
  namespace-env = "${var.namespace-env}"
  namespace-org = "${var.namespace-org}"
  organization  = "${var.organization}"
  tags          = "${var.tags}"
}

locals {
  lb_protocols   = "${var.lb_enable_http ? "HTTP" : ""},${var.lb_enable_https ? "HTTPS" : ""}"
  log_group_name = "/ecs/${module.label.id}"
  sg_rules       = "${var.lb_enable_http ? "http-80-tcp" : ""},${var.lb_enable_https ? "https-443-tcp" : ""}"

  lb_existing = "${
    var.lb_listener_arn != "" &&
    var.lb_listener_rule_priority != "" &&
    var.lb_listener_rule_pattern != ""
    ? 1 : 0 }"
}

module "lb" {
  # Use master branch to test
  source = "github.com/appzen-oss/terraform-aws-lb?ref=master"

  #source           = "devops-workflow/lb/aws"
  #version          = "3.4.1"
  enabled = "${module.enabled.value && module.enable_lb.value && ! local.lb_existing ? 1 : 0}"

  target_group_only = "${local.lb_existing}"
  target_type       = "${var.target_type}"
  name              = "${module.label.name}"
  attributes        = "${var.attributes}"
  delimiter         = "${var.delimiter}"
  environment       = "${var.environment}"
  namespace-env     = "${var.namespace-env}"
  namespace-org     = "${var.namespace-org}"
  organization      = "${var.organization}"
  tags              = "${var.tags}"
  certificate_name  = "${var.acm_cert_domain}"
  lb_protocols      = "${compact(split(",", local.lb_protocols))}"
  internal          = "${var.lb_internal}"
  ports             = "${var.lb_ports}"
  lb_https_ports    = "${var.lb_https_ports}"
  subnets           = "${var.lb_subnet_ids}"

  /*
  subnets               = "${split(",",
    var.lb_internal ?
      join(",", module.aws_env.private_subnet_ids) :
      join(",", module.aws_env.public_subnet_ids))}"
  */

  vpc_id                           = "${var.vpc_id}"
  security_groups                  = ["${module.sg-lb.id}"]
  type                             = "${var.lb_type}"
  health_check_interval            = "${var.lb_healthcheck_interval}"
  health_check_path                = "${var.lb_healthcheck_path}"
  health_check_port                = "${var.lb_healthcheck_port}"
  health_check_protocol            = "${var.lb_healthcheck_protocol}"
  health_check_timeout             = "${var.lb_healthcheck_timeout}"
  health_check_healthy_threshold   = "${var.lb_healthcheck_healthy_threshold}"
  health_check_unhealthy_threshold = "${var.lb_healthcheck_unhealthy_threshold}"
  health_check_matcher             = "${var.lb_healthcheck_matcher}"
}

module "sg-lb" {
  source              = "devops-workflow/security-group/aws"
  version             = "2.1.0"
  enabled             = "${module.enabled.value && module.enable_lb.value ? 1 : 0}"
  name                = "${module.label.name}"
  attributes          = "${var.attributes}"
  delimiter           = "${var.delimiter}"
  environment         = "${var.environment}"
  namespace-env       = "${var.namespace-env}"
  namespace-org       = "${var.namespace-org}"
  organization        = "${var.organization}"
  tags                = "${var.tags}"
  description         = "LB for ECS service: ${module.label.name}"
  vpc_id              = "${var.vpc_id}"
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
  ingress_cidr_blocks = ["${var.lb_ingress_cidr_blocks}"]
  ingress_rules       = "${compact(split(",", local.sg_rules))}"
}

resource "aws_lb_listener_rule" "static" {
  count        = "${local.lb_existing}"
  listener_arn = "${var.lb_listener_arn}"
  priority     = "${var.lb_listener_rule_priority}"

  action {
    type             = "forward"
    target_group_arn = "${element(module.lb.target_group_arns, 0)}"
  }

  condition {
    field  = "path-pattern"
    values = ["${var.lb_listener_rule_pattern}"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

# TODO: separate service name & container name. Make different to improve logging, etc

# DNS for LB
module "route53-aliases" {
  #source = "git::https://github.com/devops-workflow/terraform-aws-route53-alias.git"
  source  = "devops-workflow/route53-alias/aws"
  version = "0.2.4"
  enabled = "${module.enabled.value && module.enable_lb.value ? 1 : 0}"
  aliases = "${compact(concat(list(module.label.name), var.dns_aliases))}"

  parent_zone_name = "${var.dns_parent_zone_name != "" ?
    "${var.dns_parent_zone_name}" :
    "${module.label.environment}.${module.label.organization}.com."
    }"

  target_dns_name        = "${module.lb.dns_name}"
  target_zone_id         = "${module.lb.zone_id}"
  evaluate_target_health = true
}

# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#container_definitions
data "template_file" "container_definition" {
  count    = "${module.enabled.value}"
  template = "${file("${path.module}/files/container_definition.json")}"

  # ADD: networkMode, cpu
  vars {
    name               = "${module.label.name}"
    image              = "${var.docker_registry != "" ? "${var.docker_registry}/${var.docker_image}" : var.docker_image}"
    memory             = "${var.docker_memory}"
    memory_reservation = "${var.docker_memory_reservation}"

    #app_port              = "${var.app_port}"
    port_mappings         = "${replace(jsonencode(var.docker_port_mappings), "/\"([0-9]+)\"/", "$1")}"
    command_override      = "${length(var.docker_command) > 0 ? "\"command\": [\"${var.docker_command}\"]," : ""}"
    environment           = "${jsonencode(var.docker_environment)}"
    mount_points          = "${replace(jsonencode(var.docker_mount_points), "\"true\"", true)}"
    awslogs_group         = "${local.log_group_name}"
    awslogs_region        = "${var.region}"
    awslogs_stream_prefix = "${module.label.environment}"
    additional_config     = "${var.container_definition_additional == "" ? "" :
      ",${var.container_definition_additional}"}"
  }
}

# FIX: resource cannot be found if it fails
#   when passing in container_definition, if def bad, wrong format, invalid arg, etc.
# Look into support for sidecars, proxy, (AppMesh)
resource "aws_ecs_task_definition" "task" {
  #count                 = "${module.enabled.value}"
  count                 = "${module.enabled.value && var.task_definition_arn == "" ? 1 : 0}"
  family                = "${module.label.id}"
  container_definitions = "${var.container_definition == "" ? element(concat(data.template_file.container_definition.*.rendered, list("")), 0) : var.container_definition }"
  network_mode          = "${var.network_mode}"
  task_role_arn         = "${aws_iam_role.task.arn}"
  volume                = "${var.docker_volumes}"

  /*
  execution_role_arn =
  cpu                      = "${var.cpu_units}"
  memory                   = "${var.memory}" # greater of mem and mem_res ?
  requires_compatibilities = "${var.requires_compatibilities}"
  tags                     = "${module.label.tags}"
  /**/
}

# TODO: add service registry support
resource "aws_ecs_service" "service-no-lb" {
  count                              = "${module.enabled.value && ! module.enable_lb.value && ! local.lb_existing ? 1 : 0}"
  name                               = "${module.label.name}"
  cluster                            = "${var.ecs_cluster_arn}"
  task_definition                    = "${var.task_definition_arn == "" ? aws_ecs_task_definition.task.arn : var.task_definition_arn}"
  desired_count                      = "${var.ecs_desired_count}"
  deployment_maximum_percent         = "${var.ecs_deployment_maximum_percent}"
  deployment_minimum_healthy_percent = "${var.ecs_deployment_minimum_healthy_percent}"
  placement_constraints              = "${var.ecs_placement_constraints}"

  /* Make these optional
  enable_ecs_managed_tags = "${var.enable_ecs_managed_tags}"
  propagate_tags          = "${var.ecs_propagate_tags}"
  tags                    = "${module.label.tags}"
  // Fargate
  launch_type     = "${var.ecs_launch_type}"
  // ONLY if network mode is awsvpc
  network_configuration {
     security_groups  = ["${aws_security_group.ecs_service_sg.id}"]
     subnets          = ["${split(",", var.private_subnet_ids)}"]
  }
  /**/

  # FIX: look at deprecate msg
  #ordered_placement_strategy {}
  #placement_contraints {}
  placement_strategy {
    type  = "${var.ecs_placement_strategy_type}"
    field = "${var.ecs_placement_strategy_field}"
  }
  lifecycle {
    ignore_changes = ["desired_count"]
  }
  depends_on = [
    "aws_cloudwatch_log_group.task",
    "aws_ecs_task_definition.task",
    "aws_iam_role.service",
  ]
}

resource "aws_ecs_service" "service" {
  count                              = "${(module.enabled.value && module.enable_lb.value) || local.lb_existing ? 1 : 0}"
  name                               = "${module.label.name}"
  cluster                            = "${var.ecs_cluster_arn}"
  task_definition                    = "${var.task_definition_arn == "" ? aws_ecs_task_definition.task.arn : var.task_definition_arn}"
  desired_count                      = "${var.ecs_desired_count}"
  iam_role                           = "${aws_iam_role.service.arn}"
  deployment_maximum_percent         = "${var.ecs_deployment_maximum_percent}"
  deployment_minimum_healthy_percent = "${var.ecs_deployment_minimum_healthy_percent}"
  placement_constraints              = "${var.ecs_placement_constraints}"
  health_check_grace_period_seconds  = "${var.ecs_health_check_grace_period_seconds}"

  placement_strategy {
    type  = "${var.ecs_placement_strategy_type}"
    field = "${var.ecs_placement_strategy_field}"
  }

  # TODO: Change for fargate?
  load_balancer = {
    target_group_arn = "${element(module.lb.target_group_arns, 0)}"
    container_name   = "${module.label.name}"
    container_port   = "${var.app_port}"
  }

  lifecycle {
    ignore_changes = ["desired_count"]
  }

  depends_on = [
    "aws_cloudwatch_log_group.task",
    "aws_ecs_task_definition.task",
    "aws_iam_role.service",
    "module.lb",
  ]
}

resource "aws_cloudwatch_log_group" "task" {
  count             = "${module.enabled.value}"
  name              = "${local.log_group_name}"
  retention_in_days = "${var.ecs_log_retention}"
  tags              = "${module.label.tags}"
}
