locals {
  env_vars     = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  project_vars = read_terragrunt_config(find_in_parent_folders("project.hcl"))

  project    = local.project_vars.locals.project
  account_id = local.account_vars.locals.account_id
  env        = local.account_vars.locals.account
  region     = local.env_vars.locals.region

  s3_state_region       = "us-east-1"
}

remote_state {
  backend     = "s3"
  generate    = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "${local.project}-${local.env}-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.s3_state_region}"
    encrypt         = true
    dynamodb_table  = "${local.project}-${local.env}-terraform-state-lock"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
  region  = "${local.region}"
  assume_role {
      role_arn     = "arn:aws:iam::${local.account_id}:role/terragrunt-execution-role"
    }
}
EOF
}
