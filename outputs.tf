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
  tfvars = {
    for k, v in module.project:
    "${k}" => {
      project_id = module.project[k].project_id
      #network_self_link
      #subnetwork_self_link
    }
  }
  providers = {
    for k, v in module.project:
      "${k}" => {
        terraform_sa = module.automation_service_account[k].email
    }
  }
  backends = {
    for k, v in module.project:
      "${k}" => {
        tfstate_bucket_name = module.tfbucket[k].name
        terraform_sa = module.automation_service_account[k].email
    }
  }
}


output "backends" {
  value = local.backends
} 

output "providers" {
  value = local.providers
} 

output "tfvars" {
  value = local.tfvars
} 

resource "local_file" "tfvars" {
  for_each = local.tfvars
  file_permission = "0644"
  filename        = "${try(pathexpand(var.outputs_location), "")}/${each.key}.tfvars.json"
  content         = jsonencode(each.value)
}

resource "local_file" "backends" {
  for_each = local.backends
  file_permission = "0644"
  filename        = "${try(pathexpand(var.outputs_location), "")}/${each.key}.backend.tf"
  content         = templatefile("${path.module}/backend.tftpl", each.value)
}

resource "local_file" "providers" {
  for_each = local.providers
  file_permission = "0644"
  filename        = "${try(pathexpand(var.outputs_location), "")}/${each.key}.provider.tf"
  content         = templatefile("${path.module}/provider.tftpl", each.value)
}