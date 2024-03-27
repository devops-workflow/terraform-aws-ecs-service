resource "aws_ecs_cluster" "cluster" {
  name = "${var.environment}-ecs-1"
}

# define execution role w/ logs:PutLogEvents,
#                "logs:CreateLogGroup",
#                "ecs:DiscoverPollEndpoint",

resource "aws_iam_policy" "task_execution" {
  name = "fargate_task_execution"

  policy = <<EXEC
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:GetAuthorizationToken",
        "ecr:GetDownloadUrlForLayer",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EXEC
}

resource "aws_iam_role" "task_execution" {
  name = "fargate_task_execution"

  assume_role_policy = <<ROLE
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
ROLE
}

resource "aws_iam_role_policy_attachment" "task_execution" {
  role       = "${aws_iam_role.task_execution.name}"
  policy_arn = "${aws_iam_policy.task_execution.arn}"
}

module "basic" {
  source                = "../../"
  name                  = "basic"
  ecs_cluster_arn       = "${aws_ecs_cluster.cluster.arn}"
  ecs_security_group_id = ""
  environment           = "${var.environment}"
  organization          = "appzen"
  docker_image          = "rawmind/web-test:latest"

  app_port             = 8080
  dns_parent_zone_name = "test.appzen.com"
  lb_enable_http       = true
  lb_internal          = true
  lb_subnet_ids        = ["${data.aws_subnet_ids.private_subnet_ids.ids}"]
  region               = "${var.region}"
  vpc_id               = "${data.aws_vpc.vpc.id}"

  # Fargate settings
  awsvpc_security_group_ids = []
  awsvpc_subnet_ids         = ["${data.aws_subnet_ids.private_subnet_ids.ids}"]
  docker_cpu                = "256"
  docker_memory             = "512"
  ecs_launch_type           = "FARGATE"
  network_mode              = "awsvpc"
  requires_compatibilities  = ["FARGATE"]
  target_type               = "ip"
  task_execution_role_arn   = "${aws_iam_role.task_execution.arn}"

  docker_port_mappings = "${list(
    map("containerPort", 8080, "protocol", "tcp")
    )}"
}
