module "disabled" {
  source                = "../../"
  enabled               = false
  name                  = "disabled"
  ecs_cluster_arn       = ""
  ecs_security_group_id = ""
  environment           = "MGMT"
  vpc_id                = ""

  #vpc_id      = "${data.aws_vpc.vpc.id}"
}
