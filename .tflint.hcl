config {
terraform_version = "0.11.11"
deep_check = true
ignore_module = {
"devops-workflow/boolean/local" = true
"devops-workflow/label/local" = true
"devops-workflow/lb/aws" = true
"devops-workflow/route53-alias/aws" = true
"devops-workflow/security-group/aws" = true
"git::https://github.com/devops-workflow/terraform-aws-route53-alias.git" = true
}
}

