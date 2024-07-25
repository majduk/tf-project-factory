/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
    input_files = fileset("${var.inputs_location}/", "*.yaml")
    projects  = {
        for f in local.input_files:
            trimsuffix(f, ".yaml") => yamldecode(file("${var.inputs_location}/${f}"))
    }
    tfbuckets = { 
        for p in keys(local.projects): 
            p => "${p}-iac"
    }
    service_account_roles = flatten([
      for pk, pv in local.projects: [
        for sak, sav in pv.service_accounts:  {
          name = sak
          project = pk
          roles = sav
        }
      ]
    ])
}


resource "google_folder" "parent" {
  display_name = var.parent_folder_name
  parent       = "organizations/${var.org_id}"
}

module "project" {
  for_each = local.projects
  source                      = "github.com/GoogleCloudPlatform/cloud-foundation-fabric/modules/project"
  name                        = each.key
  parent                      = google_folder.parent.id
  billing_account             = var.billing_account
  default_service_account     = "disable"
  skip_delete                 = false
  services                    = each.value.services
}

module "automation_service_account" {
  source                      = "github.com/GoogleCloudPlatform/cloud-foundation-fabric/modules/iam-service-account"
  for_each = local.projects
  project_id = module.project[each.key].project_id
  name       = each.value.automation_service_account_name
  iam_project_roles = {
      "${module.project[each.key].project_id}" = each.value.automation_service_account_roles
    }
}

module "service-accounts" {
  source                      = "github.com/GoogleCloudPlatform/cloud-foundation-fabric/modules/iam-service-account"
  for_each = tomap({
    for sa in local.service_account_roles: "${sa.project}.${sa.name}" => sa
  })
  project_id = each.value.project
  name       = each.value.name
  iam_project_roles = {
      "${each.value.project}" = each.value.roles
    }
}

module "tfbucket" {
  for_each = local.tfbuckets
  source      = "github.com/GoogleCloudPlatform/cloud-foundation-fabric/modules/gcs"
  project_id  = each.key
  name        = each.value
  location   = var.tfbucket_location
}