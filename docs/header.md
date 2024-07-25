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
