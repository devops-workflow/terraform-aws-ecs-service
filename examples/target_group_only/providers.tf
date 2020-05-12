provider "aws" {
  profile = "appzen-dev"
  region  = "${var.region}"
  version = "1.60.0"

  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}
