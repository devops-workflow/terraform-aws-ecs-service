# ECS Service: EFS

Configuration in this directory sets up multiple EFS, mounts them on ECS' EC2 instances, and configures service to mount.

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.
