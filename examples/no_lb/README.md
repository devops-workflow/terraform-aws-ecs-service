# ECS Service: no_lb

Configuration in this directory sets up an ECS cluster and 1 service without a load balancer

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
| account\_name |  | string | `"appzen-test"` | no |
| environment |  | string | `"mgmt"` | no |
| instance\_type | AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types | string | `"m5.large"` | no |
| key\_name | SSH key name to use | string | `"devops-2018-12-19"` | no |
| region |  | string | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_arn | ECS cluster ARN |
| container\_json |  |
| service\_arn | ECS service ARN |
| service\_iam\_role\_arn | ARN of the IAM Role for the ECS Service |
| service\_iam\_role\_name | Name of the IAM Role for the ECS Task |
| service\_name | ECS service name |
| task\_iam\_role\_arn | ARN of the IAM Role for the ECS Task |
| task\_iam\_role\_name | Name of the IAM Role for the ECS Task |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
