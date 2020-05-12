# ECS Service: Basic

Configuration in this directory sets up an ECS cluster and 1 service with a load balancer

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_name |  | string | `"appzen-dev"` | no |
| environment |  | string | `"mgmt"` | no |
| instance\_type | AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types | string | `"m5.large"` | no |
| key\_name | SSH key name to use | string | `"devops-2018-12-19"` | no |
| region |  | string | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_arn | ECS cluster ARN |
| container\_json |  |
| lb\_arn | ARN of the LB |
| lb\_dns\_aliases | List of DNS aliases add for ALB |
| lb\_dns\_name | FQDN of ALB provisioned for service (if present) |
| lb\_listener\_arns | ARNs of all the LB Listeners |
| lb\_listener\_http\_arns | The ARNs of the HTTP LB Listeners |
| lb\_listener\_https\_arns | The ARNs of the HTTPS LB Listeners |
| lb\_listener\_tcp\_arns | The ARNs of the network TCP LB Listeners |
| lb\_target\_group\_arns | ARNs of all the target groups. Useful for passing to your Auto Scaling group module. |
| lb\_target\_group\_arns\_suffix | ARNs suffix of all the target groups. Useful for passing to your Auto Scaling group module. |
| lb\_target\_group\_http\_arns | ARNs of the HTTP target groups. Useful for passing to your Auto Scaling group module. |
| lb\_target\_group\_https\_arns | ARNs of the HTTPS target groups. Useful for passing to your Auto Scaling group module. |
| lb\_target\_group\_tcp\_arns | ARNs of the TCP target groups. Useful for passing to your Auto Scaling group module. |
| lb\_zone\_id | Route 53 zone ID of ALB provisioned for service (if present) |
| service\_arn | ECS service ARN |
| service\_iam\_role\_arn | ARN of the IAM Role for the ECS Service |
| service\_iam\_role\_name | Name of the IAM Role for the ECS Task |
| service\_name | ECS service name |
| task\_iam\_role\_arn | ARN of the IAM Role for the ECS Task |
| task\_iam\_role\_name | Name of the IAM Role for the ECS Task |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
