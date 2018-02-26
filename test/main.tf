provider "aws" {
  region = "${var.region}"

  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

data "aws_vpc" "vpc" {
  tags {
    Env = "${var.environment}"
  }
}

data "aws_subnet_ids" "private_subnet_ids" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags {
    Network = "Private"
  }
}

data "aws_subnet" "private_subnets" {
  count = "${length(data.aws_subnet_ids.private_subnet_ids.ids)}"
  id    = "${data.aws_subnet_ids.private_subnet_ids.ids[count.index]}"
}

module "ecs-cluster" {
  source        = "git::https://github.com/devops-workflow/terraform-aws-ecs-cluster.git"
  name          = "ecs-1"
  environment   = "one"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"
  subnet_id     = ["${data.aws_subnet_ids.private_subnet_ids.ids}"]
  vpc_id        = "${data.aws_vpc.vpc.id}"
}

/*
module "disabled" {
  source  = "../"
  enabled = false
  name    = "disabled"
  environment   = "one"
  key_name      = ""
  subnet_id     = []
  vpc_id        = "${data.aws_vpc.vpc.id}"
}
*/

module "service-1" {
  source                = "../"
  name                  = "service-1"
  environment           = "one"
  organization          = "wiser"
  ecs_cluster_arn       = "${module.ecs-cluster.cluster_id}"
  ecs_security_group_id = "${module.ecs-cluster.cluster_security_group_id}"

  #docker_image          = "105667981759.dkr.ecr.us-west-2.amazonaws.com/wiser/map-application:latest"
  docker_image   = "infrastructureascode/hello-world:latest"
  vpc_id         = "${data.aws_vpc.vpc.id}"
  app_port       = 8080                                              # target group & container port
  alb_subnet_ids = ["${data.aws_subnet_ids.private_subnet_ids.ids}"]
  region         = "${var.region}"

  alb_enable_http = true
  lb_internal     = true
}
