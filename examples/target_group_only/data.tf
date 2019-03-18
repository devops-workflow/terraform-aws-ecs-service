data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.account_name}-${var.environment}"]
  }
}

data "aws_subnet_ids" "private_subnet_ids" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags {
    Network = "Private"
  }
}

data "aws_subnet" "private_subnets" {
  count = "${length(data.aws_subnet_ids.private_subnet_ids.ids)}"
  id    = "${data.aws_subnet_ids.private_subnet_ids.ids[count.index]}"
}
