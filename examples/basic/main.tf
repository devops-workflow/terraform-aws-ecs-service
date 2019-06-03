module "ecs-cluster" {
  source        = "git::https://github.com/devops-workflow/terraform-aws-ecs-cluster.git"
  name          = "ecs-1"
  environment   = "${var.environment}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"
  subnet_id     = ["${data.aws_subnet_ids.private_subnet_ids.ids}"]
  vpc_id        = "${data.aws_vpc.vpc.id}"
}

module "basic" {
  source                = "../../"
  name                  = "basic"
  ecs_cluster_arn       = "${module.ecs-cluster.cluster_id}"
  ecs_security_group_id = "${module.ecs-cluster.cluster_security_group_id}"
  environment           = "${var.environment}"
  organization          = "appzen"

  #docker_registry = "xxxxxxxxxx.dkr.ecr.us-west-2.amazonaws.com/account"
  docker_image = "rawmind/web-test:latest"

  app_port             = 8080
  dns_parent_zone_name = "test.appzen.com"
  lb_enable_http       = true
  lb_internal          = true
  lb_subnet_ids        = ["${data.aws_subnet_ids.private_subnet_ids.ids}"]
  region               = "${var.region}"
  vpc_id               = "${data.aws_vpc.vpc.id}"
  docker_port_mappings = "${list(
    map("containerPort", 8080, "protocol", "tcp")
    )}"
}
