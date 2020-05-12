## Contents

- [Purpose](#purpose)
- [Usage](#usage)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Purpose

AWS ECS task definitions allow for multiple containers to be defined. Due to some known limitations with the [HashiCorp Configuration Language](https://github.com/hashicorp/hcl) (HCL), the `merge` module allows for combining multiple container definitions. 

To see an example of the `merge` module in use, see the [usage](#usage) section.

## Usage

The task definition defined in the purpose section can be created using a combination of the [`terraform-aws-ecs-task-definition`](https://github.com/mongodb/terraform-aws-ecs-task-definition) module and the `merge` module like so:

```hcl
module "merged" {
  source = "./modules/merge"

  container_definitions = [
    "${var.container_definitions}",
    "${var.container_definitions_sidecar}",
  ]
}

resource "aws_ecs_task_definition" "hello_world" {
  container_definitions = "${module.merged.container_definitions}"
  family                = "hello_world"
}
```

**Note:** The `register_task_definition` flag for both task definitions is required; otherwise a task definition containing a single container definition is registered created for both the `app1` and `mysql` services.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| container\_definitions | A list of container definitions in JSON format that describe the different containers that make up your task | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| container\_definitions | A list of container definitions in JSON format that describe the different containers that make up your task |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
