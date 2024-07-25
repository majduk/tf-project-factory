# Terraform Sandbox Project Factory

This Terraform module provides a simple way to create and manage Google Cloud Platform (GCP) projects using the [Cloud Foundations Fabric](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric/blob/master/modules/project/main.tf) project module.

## Overview

The factory creates projects based on a template and sets up a state bucket for each project, along with an automation account. This allows you to manage the resources within each project separately.

The factory uses YAML files stored in the `inputs_location` directory to define the project configurations. Projects are named after the definition files, with the `.yaml` extension removed. [Example input file](example.yaml)

The factory outputs the following files to the `outputs_location` directory:

* **Backend configuration:** A `backend.tf` file containing the configuration for the Terraform backend, which is used to store the state of the project.
* **Provider configuration:** A `providers.tf` file containing the configuration for the Google Cloud provider.
* **Terraform variables:** A `tfvars.json` file containing the variables that are used to configure the project.

## Usage

1. **Prerequisites:**
   * Create a Google Cloud Storage bucket to store the Terraform state. This bucket should be manually created and its name should be specified in the `tfstate_bucket_name` input variable.

2. **Run the factory:**
   * Copy the [terraform.tfvars.sample](terraform.tfvars.sample) file to `terraform.tfvars` and edit it with your project's details.
   * Execute the `generate_provider.py` script to generate the Terraform configuration files.
   * Initialize Terraform using the command `terraform init`.
   * Apply the Terraform configuration using the command `terraform apply`.