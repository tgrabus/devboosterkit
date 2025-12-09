resource "azuredevops_git_repository" "alz" {
  depends_on     = [azuredevops_environment.alz]
  project_id     = local.project_id
  name           = var.repository_name
  default_branch = local.default_branch
  initialization {
    init_type = "Clean"
  }
}

resource "azuredevops_git_repository_file" "alz" {
  for_each            = var.repository_files
  repository_id       = azuredevops_git_repository.alz.id
  file                = each.key
  content             = each.value.content
  branch              = local.default_branch
  commit_message      = "[skip ci]"
  overwrite_on_create = true
}

resource "azuredevops_branch_policy_merge_types" "alz" {
  depends_on = [azuredevops_git_repository_file.alz]
  project_id = local.project_id

  enabled  = var.create_branch_policies
  blocking = true

  settings {
    allow_squash                  = true
    allow_rebase_and_fast_forward = false
    allow_basic_no_fast_forward   = false
    allow_rebase_with_merge       = false

    scope {
      repository_id  = azuredevops_git_repository.alz.id
      repository_ref = azuredevops_git_repository.alz.default_branch
      match_type     = "Exact"
    }
  }
}

locals {
  build_validation_pipelines = { for key, pipeline in local.pipelines : key => pipeline if lookup(pipeline, "build_validation", false) }
  
  build_validation_pipeline_key = one(keys(local.build_validation_pipelines))
}

resource "azuredevops_branch_policy_build_validation" "alz" {
  count = length(local.build_validation_pipelines) > 0 ? 1 : 0
  depends_on = [azuredevops_git_repository_file.alz]
  project_id = local.project_id

  enabled  = var.create_branch_policies
  blocking = true

  settings {
    display_name        = "Terraform Validation"
    build_definition_id = azuredevops_build_definition.pipeline[local.build_validation_pipeline_key].id
    valid_duration      = 720

    scope {
      repository_id  = azuredevops_git_repository.alz.id
      repository_ref = azuredevops_git_repository.alz.default_branch
      match_type     = "Exact"
    }
  }
}
