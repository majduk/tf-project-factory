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
