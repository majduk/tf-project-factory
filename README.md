# Terraform Sandbox Project Factory

Simple use of the [Cloud Foundations Fabric](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric/blob/master/modules/project/main.tf) project module.

Creates projects based on template and sets up state bucket for these projects and automation account, so that the project contents can later on be managed separately.

Prerequisites:
- manually created `tfstate_bucket_name`, where the factory stores the state.

Usage:
```
./generate_provider.py
terraform init
terraform apply
```
Copyright 2023 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.38.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_project"></a> [project](#module\_project) | github.com/GoogleCloudPlatform/cloud-foundation-fabric/modules/project | n/a |
| <a name="module_tfbucket"></a> [tfbucket](#module\_tfbucket) | github.com/GoogleCloudPlatform/cloud-foundation-fabric/modules/gcs | n/a |

## Resources

| Name | Type |
|------|------|
| [google_folder.parent](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder) | resource |
| [local_file.tfvars](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | The ID of the billing account to associate projects with. | `string` | n/a | yes |
| <a name="input_inputs_location"></a> [inputs\_location](#input\_inputs\_location) | Inputs location | `string` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | GCP Organization ID | `string` | n/a | yes |
| <a name="input_outputs_location"></a> [outputs\_location](#input\_outputs\_location) | Outputs location | `string` | n/a | yes |
| <a name="input_parent_folder_name"></a> [parent\_folder\_name](#input\_parent\_folder\_name) | Organization's parent folder name | `string` | n/a | yes |
| <a name="input_terraform_sa"></a> [terraform\_sa](#input\_terraform\_sa) | Service account used by terraform | `string` | n/a | yes |
| <a name="input_tfbucket_location"></a> [tfbucket\_location](#input\_tfbucket\_location) | Terraform state buckets location | `string` | n/a | yes |
| <a name="input_tfstate_bucket_name"></a> [tfstate\_bucket\_name](#input\_tfstate\_bucket\_name) | Bucket for storing terraform state | `string` | n/a | yes |

## Outputs

No outputs.
