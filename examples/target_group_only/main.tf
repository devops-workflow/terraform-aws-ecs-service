module "ecs-cluster" {
  source        = "git::https://github.com/devops-workflow/terraform-aws-ecs-cluster.git"
  name          = "ecs-1"
  environment   = "${var.environment}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"
  subnet_id     = ["${data.aws_subnet_ids.private_subnet_ids.ids}"]
  vpc_id        = "${data.aws_vpc.vpc.id}"
}

module "example" {
  source                = "../../"
  name                  = "basic"
  ecs_cluster_arn       = "${module.ecs-cluster.cluster_id}"
  ecs_security_group_id = "${module.ecs-cluster.cluster_security_group_id}"
  environment           = "${var.environment}"
  organization          = "appzen"

  #enable_lb               = false
  #target_group_only     = true

  #docker_registry = "111111.dkr.ecr.us-west-2.amazonaws.com/repo"
  docker_image         = "crccheck/hello-world:latest"
  app_port             = 8000
  dns_parent_zone_name = "dev.appzen.com"
  lb_enable_http       = true
  lb_internal          = true
  lb_subnet_ids        = ["${data.aws_subnet_ids.private_subnet_ids.ids}"]
  region               = "${var.region}"
  vpc_id               = "${data.aws_vpc.vpc.id}"
  docker_port_mappings = "${list(
    map("containerPort", 8000, "hostPort", 8000, "protocol", "tcp")
  )}"
}

/**/
# Not happening after example module ?? Yep
module "add_listener" {
  source                = "../../"
  name                  = "example2"
  ecs_cluster_arn       = "${module.ecs-cluster.cluster_id}"
  ecs_security_group_id = "${module.ecs-cluster.cluster_security_group_id}"
  environment           = "${var.environment}"
  organization          = "appzen"
  enable_lb             = false

  #target_group_only     = true
  # Getting empty list?
  lb_listener_arn = "arn:aws:elasticloadbalancing:us-east-1:186266557194:listener/app/mgmt-basic/d4bfaa41f117780d/5bdb624579ca11fa" # "${element(module.example.lb_listener_arns, 0)}"

  lb_listener_rule_priority = "210"
  lb_listener_rule_pattern  = "/existing/*"

  #docker_registry = "111111.dkr.ecr.us-west-2.amazonaws.com/repo"
  docker_image = "yeasy/simple-web"

  app_port             = 80
  dns_parent_zone_name = "dev.appzen.com"
  lb_enable_http       = true
  lb_internal          = true
  lb_subnet_ids        = ["${data.aws_subnet_ids.private_subnet_ids.ids}"]
  region               = "${var.region}"
  vpc_id               = "${data.aws_vpc.vpc.id}"

  docker_port_mappings = "${list(
    map("containerPort", 80, "hostPort", 8001, "protocol", "tcp")
  )}"
}

/**/

resource "aws_lb_listener_rule" "basic" {
  listener_arn = "${element(module.example.lb_listener_arns, 0)}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${element(module.example.lb_target_group_arns, 0)}"
  }

  condition {
    field  = "path-pattern"
    values = ["/basic/*"]
  }
}

/**/
# Can data lookup for other service be done?
# Create target group & listening rule for instances
data "aws_instance" "Jenkins" {
  filter {
    name   = "tag:Name"
    values = ["Jenkins"]
  }
}

data "aws_instance" "mgmt-infra" {
  filter {
    name   = "tag:Name"
    values = ["mgmt-infra"]
  }
}

resource "aws_lb_target_group" "static" {
  name     = "testing-static"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${data.aws_vpc.vpc.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "jenkins" {
  target_group_arn = "${aws_lb_target_group.static.arn}"
  target_id        = "${data.aws_instance.Jenkins.id}"
  port             = 9090
}

resource "aws_lb_target_group_attachment" "mgmt-infra" {
  target_group_arn = "${aws_lb_target_group.static.arn}"
  target_id        = "${data.aws_instance.mgmt-infra.id}"
  port             = 3000
}

/*
resource "aws_lb_target_group" "dup" {
  name     = "testing-dup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${data.aws_vpc.vpc.id}"
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_lb_target_group_attachment" "dup" {
  target_group_arn = "${aws_lb_target_group.dup.arn}"
  target_id        = "${data.aws_instance.Jenkins.id}"
  port             = 9090
}
/**/
resource "aws_lb_listener_rule" "static" {
  listener_arn = "${element(module.example.lb_listener_arns, 0)}"
  priority     = 110

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.static.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/static/*"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener_rule" "defaultish" {
  listener_arn = "${element(module.example.lb_listener_arns, 0)}"
  priority     = 50000

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.static.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/*"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

/**/
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${module.example.lb_arn}"
  port              = "11"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

/**/

