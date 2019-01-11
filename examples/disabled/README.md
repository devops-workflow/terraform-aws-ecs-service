# ECS Service: Disabled

Configuration in this directory run with the module disabled.

The module should create nothing and not error on any of the outputs

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
| environment | - | string | `MGMT` | no |
| instance\_type | AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types | string | `m5.large` | no |
| key\_name | SSH key name to use | string | `devops20170606` | no |
| region | - | string | `us-west-2` | no |

## Outputs

| Name | Description |
|------|-------------|
| container\_json | - |
| lb\_dns\_name | FQDN of ALB provisioned for service (if present) |
| lb\_zone\_id | Route 53 zone ID of ALB provisioned for service (if present) |
| service\_iam\_role\_arn | ARN of the IAM Role for the ECS Service |
| service\_iam\_role\_name | Name of the IAM Role for the ECS Task |
| task\_iam\_role\_arn | ARN of the IAM Role for the ECS Task |
| task\_iam\_role\_name | Name of the IAM Role for the ECS Task |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
