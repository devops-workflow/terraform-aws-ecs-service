module "ecs-cluster" {
  source        = "git::https://github.com/devops-workflow/terraform-aws-ecs-cluster.git"
  name          = "ecs-2"
  environment   = "one"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"
  subnet_id     = ["${data.aws_subnet_ids.private_subnet_ids.ids}"]
  vpc_id        = "${data.aws_vpc.vpc.id}"
}

module "no_lb" {
  source                = "../"
  name                  = "no_lb"
  ecs_cluster_arn       = "${module.ecs-cluster.cluster_id}"
  ecs_security_group_id = "${module.ecs-cluster.cluster_security_group_id}"
  environment           = "one"
  organization          = "wiser"

  #docker_registry = "105667981759.dkr.ecr.us-west-2.amazonaws.com/wiser"
  #docker_image    = "map-application:latest"
  docker_image = "infrastructureascode/hello-world:latest"

  app_port  = 8080                     # target group & container port
  enable_lb = false
  region    = "${var.region}"
  vpc_id    = "${data.aws_vpc.vpc.id}"
}
