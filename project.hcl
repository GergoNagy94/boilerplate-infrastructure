locals {
    project         = "terragrunt"
    project_version = "v1.0.0"

    organization_id        = "o-00000000000"
    organization_root_id   = "r-0000"

    management_account_id  = "000000000000"
    monitoring_account_id  = "000000000000"
    production_account_id  = "000000000000"
    development_account_id = "000000000000"

    management_account_email  = "aws+management@terragrunt.com"
    monitoring_account_email  = "aws+monitoring@terragrunt.com"
    production_account_email  = "aws+production@terragrunt.com"
    development_account_email = "aws+development@terragrunt.com"
}