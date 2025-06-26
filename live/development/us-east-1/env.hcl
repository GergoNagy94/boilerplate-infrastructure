locals {
    project_vars  = read_terragrunt_config(find_in_parent_folders("project.hcl"))
    account_vars  = read_terragrunt_config(find_in_parent_folders("account.hcl"))

    project         = local.project_vars.locals.project
    project_version = local.project_vars.locals.project_version
    default_region  = local.project_vars.locals.default_region

    account_id = local.account_vars.locals.account_id
    env        = local.account_vars.locals.account
      
    region                   = "us-east-1"

    skip_module = {}

    tags = {
      createdBy       = "Terragrunt" 
      environment     = "${local.env}" 
      project         = "${local.project}"
      project-version = "${local.project_version}"  
    }
}