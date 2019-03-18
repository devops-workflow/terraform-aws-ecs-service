# terraform-aws-ecs-service

[![CircleCI](https://circleci.com/gh/devops-workflow/terraform-aws-ecs-service/tree/master.svg?style=svg)](https://circleci.com/gh/devops-workflow/terraform-aws-ecs-service/tree/master)
[![Github release](https://img.shields.io/github/release/devops-workflow/terraform-aws-ecs-service.svg)](https://github.com/devops-workflow/terraform-aws-ecs-service/releases)

Terraform module for deploying and managing a generic [ECS](https://aws.amazon.com/ecs/) service onto an existing cluster.

## Required

- `region` - AWS region in which the EC2 Container Service cluster is located
- `ecs_cluster` - EC2 Container Service cluster in which the service will be deployed (must already exist, the module will not create it).
- `service_identifier` - Unique identifier for the service, used in naming resources.
- `task_identifier` - Unique identifier for the task, used in naming resources.
- `docker_image` - Docker image specification.

## Usage

```hcl

module "pganalyze_testdb" {
  source             = "github.com/terraform-community-modules/tf_aws_ecs_service?ref = v1.0.0"
  region             = "${data.aws_region.current.name}"
  ecs_cluster        = "my-ecs-cluster"
  service_identifier = "pganalyze"
  task_identifier    = "testdb"
  docker_image       = "quay.io/pganalyze:stable"

  docker_environment = [
    {
      "name"  = "DB_URL",
      "value" = "postgres://user:password@host:port/database",
    },
  ]
}
```

### Authors

[Steve Huff](https://github.com/hakamadare)
[Tim Hartmann](https://github.com/tfhartmann)

### Changelog

2.1.0 - IAM role outputs.

1.0.0 - Initial release.

### License

This software is released under the MIT License (see `LICENSE`).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| acm\_cert\_domain | Domain name of ACM-managed certificate | string | `""` | no |
| app\_port | Numeric port on which application listens (unnecessary if neither lb_enable_https or lb_enable_http are true) | string | `""` | no |
| attributes | Suffix name with additional attributes (policy, role, etc.) | list | `<list>` | no |
| container\_definition | Container definition when not using module default definition | string | `""` | no |
| container\_definition\_additional | Additional parameters to add to container definition. This is a json substring | string | `""` | no |
| delimiter | Delimiter to be used between `name`, `namespaces`, `attributes`, etc. | string | `"-"` | no |
| dns\_aliases | Additional DNS names | list | `<list>` | no |
| dns\_parent\_zone\_name | DNS name of the parent zone to put this in | string | `""` | no |
| docker\_command | String to override CMD in Docker container (default "") | string | `""` | no |
| docker\_environment | List of environment maps of format { "name" = "var_name", "value" = "var_value" } | list | `<list>` | no |
| docker\_image | Docker image to use for task | string | `""` | no |
| docker\_memory | Hard limit on memory use for task container (default 256) | string | `"256"` | no |
| docker\_memory\_reservation | Soft limit on memory use for task container (default 128) | string | `"128"` | no |
| docker\_mount\_points | List of mount point maps of format { "sourceVolume" = "vol_name", "containerPath" = "path", ["readOnly" = "true or false" ] } | list | `<list>` | no |
| docker\_port\_mappings | List of port mapping maps of format { "containerPort" = integer, [ "hostPort" = integer, "protocol" = "tcp or udp" ] } | list | `<list>` | no |
| docker\_registry | Docker register for image | string | `""` | no |
| docker\_volumes | List of volume maps of format { "name" = "var_name", "host_path" = "var_value" } | list | `<list>` | no |
| ecs\_cluster\_arn | ARN of ECS cluster in which the service will be deployed | string | n/a | yes |
| ecs\_data\_volume\_path | Path to volume on ECS node to be defined as a "data" volume (default "/opt/data") | string | `"/opt/data"` | no |
| ecs\_deployment\_maximum\_percent | Upper limit in percentage of tasks that can be running during a deployment (default 200) | string | `"200"` | no |
| ecs\_deployment\_minimum\_healthy\_percent | Lower limit in percentage of tasks that must remain healthy during a deployment (default 100) | string | `"100"` | no |
| ecs\_desired\_count | Desired number of containers in the task (default 1) | string | `"1"` | no |
| ecs\_log\_retention | Number of days of ECS task logs to retain (default 3) | string | `"3"` | no |
| ecs\_placement\_constraints | Placement contraints to use when distributing tasks | list | `<list>` | no |
| ecs\_placement\_strategy\_field | Container metadata field to use when distributing tasks (default memory) | string | `"memory"` | no |
| ecs\_placement\_strategy\_type | Placement strategy to use when distributing tasks (default binpack) | string | `"binpack"` | no |
| ecs\_security\_group\_id | Security group ID of ECS cluster in which the service will be deployed | string | n/a | yes |
| enable\_lb | Set to false to prevent the module from creating a Load Balancer | string | `"true"` | no |
| enabled | Set to false to prevent the module from creating anything | string | `"true"` | no |
| environment | Environment (ex: `dev`, `qa`, `stage`, `prod`). (Second or top level namespace. Depending on namespacing options) | string | n/a | yes |
| extra\_task\_policy\_arns | List of ARNs of IAM policies to be attached to the ECS task role (in addition to the default policy, so cannot be more than 9 ARNs) | list | `<list>` | no |
| lb\_cookie\_duration | Duration of LB session stickiness cookie in seconds (default 86400) | string | `"86400"` | no |
| lb\_enable\_http | Enable HTTP listener in LB (http or https MUST be enabled) | string | `"true"` | no |
| lb\_enable\_https | Enable HTTPS listener in LB (http or https MUST be enabled) | string | `"false"` | no |
| lb\_healthcheck\_healthy\_threshold | Number of consecutive successful health checks before marking service as healthy (default 5) | string | `"5"` | no |
| lb\_healthcheck\_interval | Time in seconds between LB health checks (default 30) | string | `"30"` | no |
| lb\_healthcheck\_matcher | HTTP response codes to accept as healthy (default 200) | string | `"200-399"` | no |
| lb\_healthcheck\_path | URI path for LB health checks (default /) | string | `"/"` | no |
| lb\_healthcheck\_port | Port for LB to use when connecting health checks (default same as application traffic) | string | `"traffic-port"` | no |
| lb\_healthcheck\_protocol | Protocol for LB to use when connecting health checks (default HTTP) | string | `"HTTP"` | no |
| lb\_healthcheck\_timeout | Timeout in seconds for LB to use when connecting health checks (default 5) | string | `"5"` | no |
| lb\_healthcheck\_unhealthy\_threshold | Number of consecutive failed health checks before marking service as unhealthy (default 2) | string | `"5"` | no |
| lb\_https\_ports | HTTPS ports load balancer should listen on | string | `"443"` | no |
| lb\_ingress\_cidr\_blocks | List of ingress CIDR blocks for load balancer | list | `<list>` | no |
| lb\_internal | Configure LB as internal-only | string | `"true"` | no |
| lb\_ports | Ports load balancer should listen on | string | `"80"` | no |
| lb\_stickiness\_enabled | Enable LB session stickiness (default false) | string | `"false"` | no |
| lb\_subnet\_ids | VPC subnet IDs in which to create the LB (unnecessary if neither lb_enable_https or lb_enable_http are true) | list | `<list>` | no |
| lb\_type | Type of LB to create: application, network | string | `"application"` | no |
| log\_group\_name | Name for CloudWatch Log Group that will receive collector logs (must be unique, default is created from service_identifier and task_identifier) | string | `""` | no |
| name | Base name for resources | string | n/a | yes |
| namespace-env | Prefix name with the environment. If true, format is: <env>-<name> | string | `"true"` | no |
| namespace-org | Prefix name with the organization. If true, format is: <org>-<env namespaced name>. If both env and org namespaces are used, format will be <org>-<env>-<name> | string | `"false"` | no |
| network\_mode | Docker network mode for task (default "bridge") | string | `"bridge"` | no |
| organization | Organization name (Top level namespace). | string | `""` | no |
| region | AWS region in which ECS cluster is located (default is 'us-east-1') | string | `"us-east-1"` | no |
| service\_identifier | Unique identifier for this pganalyze service (used in log prefix, service name etc.) | string | `"service"` | no |
| tags | A map of additional tags | map | `<map>` | no |
| target\_group\_only | Only create target group without a load balancer. For when more advanced LB setups are required | string | `"false"` | no |
| target\_type | Type for targets for target group. Can be: instance or ip | string | `"instance"` | no |
| task\_identifier | Unique identifier for this pganalyze task (used in log prefix, service name etc.) | string | `"task"` | no |
| vpc\_id | ID of VPC in which ECS cluster is located | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_arn | ECS cluster ARN |
| container\_json |  |
| lb\_dns\_aliases | List of DNS aliases add for ALB |
| lb\_dns\_name | FQDN of ALB provisioned for service (if present) |
| lb\_zone\_id | Route 53 zone ID of ALB provisioned for service (if present) |
| log\_group\_name | Cloudwatch log group name for service |
| service\_arn | ECS service ARN |
| service\_iam\_role\_arn | ARN of the IAM Role for the ECS Service |
| service\_iam\_role\_name | Name of the IAM Role for the ECS Task |
| service\_name | ECS service name |
| task\_iam\_role\_arn | ARN of the IAM Role for the ECS Task |
| task\_iam\_role\_name | Name of the IAM Role for the ECS Task |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM GRAPH HOOK -->

### Resource Graph of plan

![Terraform Graph](resource-plan-graph.png)
<!-- END OF PRE-COMMIT-TERRAFORM GRAPH HOOK -->
