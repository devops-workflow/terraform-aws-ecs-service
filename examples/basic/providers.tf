provider "aws" {
  profile = "appzen-admin"
  region  = "${var.region}"

  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true

  assume_role {
    role_arn = "arn:aws:iam::242413444216:role/OrganizationAccountAccessRole"
  }
}
