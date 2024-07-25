<!-- BEGIN_TF_DOCS -->
# Terraform Sandbox Project Factory

Simple use of the [Cloud Foundations Fabric](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric/blob/master/modules/project/main.tf) project module.

Creates projects based on template and sets up state bucket for these projects and automation account, so that the project contents can later on be managed separately.

Inputs are yaml files stired under `inputs_location`. The factory outputs under `outputs_location` rendered backend, provider and tfvars.json files with data that can be used by a separate instances of terraform to manage the resources under the created projects.

Prerequisites:
- manually created `tfstate_bucket_name`, where the factory stores the state.

Usage:
```
./generate_provider.py
terraform init
terraform apply
```

#### Requirements

No requirements.

#### Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider_google) | 5.38.0 |
| <a name="provider_local"></a> [local](#provider_local) | 2.5.1 |

#### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_automation_service_account"></a> [automation_service_account](#module_automation_service_account) | github.com/GoogleCloudPlatform/cloud-foundation-fabric/modules/iam-service-account | n/a |
| <a name="module_project"></a> [project](#module_project) | github.com/GoogleCloudPlatform/cloud-foundation-fabric/modules/project | n/a |
| <a name="module_service-accounts"></a> [service-accounts](#module_service-accounts) | github.com/GoogleCloudPlatform/cloud-foundation-fabric/modules/iam-service-account | n/a |
| <a name="module_tfbucket"></a> [tfbucket](#module_tfbucket) | github.com/GoogleCloudPlatform/cloud-foundation-fabric/modules/gcs | n/a |

#### Resources

| Name | Type |
|------|------|
| [google_folder.parent](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder) | resource |
| [local_file.backends](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.providers](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.tfvars](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

#### Inputs

| Name | Description | Type |
|------|-------------|------|
| <a name="input_billing_account"></a> [billing_account](#input_billing_account) | The ID of the billing account to associate projects with. | `string` |
| <a name="input_inputs_location"></a> [inputs_location](#input_inputs_location) | Inputs location | `string` |
| <a name="input_org_id"></a> [org_id](#input_org_id) | GCP Organization ID | `string` |
| <a name="input_outputs_location"></a> [outputs_location](#input_outputs_location) | Outputs location | `string` |
| <a name="input_parent_folder_name"></a> [parent_folder_name](#input_parent_folder_name) | Organization's parent folder name | `string` |
| <a name="input_terraform_sa"></a> [terraform_sa](#input_terraform_sa) | Service account used by terraform | `string` |
| <a name="input_tfbucket_location"></a> [tfbucket_location](#input_tfbucket_location) | Terraform state buckets location | `string` |
| <a name="input_tfstate_bucket_name"></a> [tfstate_bucket_name](#input_tfstate_bucket_name) | Bucket for storing terraform state | `string` |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_backends"></a> [backends](#output_backends) | n/a |
| <a name="output_providers"></a> [providers](#output_providers) | n/a |
| <a name="output_tfvars"></a> [tfvars](#output_tfvars) | n/a |
<!-- END_TF_DOCS -->