# Deploying a PHP Application on Google Cloud Platform with Terraform

## 1. Project Overview

This project deploys a PHP web application on **Google Cloud Platform (GCP)**, using Terraform to provision the infrastructure and GitHub Actions to automate the deployment process.

The goal is to implement a reproducible, automated cloud infrastructure organized according to DevOps best practices.

### Objectives

- Provision GCP resources with Terraform.
- Containerize a PHP application with Docker.
- Deploy the application on Google Cloud Run.
- Use Cloud SQL to manage the MySQL database.
- Store sensitive information in Secret Manager.
- Host static assets on Cloud Storage.
- Automate deployment with GitHub Actions and Workload Identity Federation.
- Provide a Bash script to retrieve the IP addresses associated with the Cloud Run service.

## 2. Technical Architecture

### GCP Services Used

| Service | Role |
|---|---|
| Cloud Run | Hosting of the containerized PHP application |
| Cloud SQL | Hosting of the MySQL database |
| Secret Manager | Secure storage of the database password |
| Artifact Registry | Storage of Docker images |
| Cloud Storage | Hosting of static assets |
| IAM | Identity and permission management |
| Workload Identity Federation | Secure authentication of GitHub Actions to GCP |

### Technologies Used

- PHP 8.3
- Nginx
- PHP-FPM
- Docker
- Terraform
- Bash
- MySQL 8.0
- GitHub Actions
- Google Cloud CLI


## 3. Terraform Configuration

The Terraform files are located in the `terrform/` folder.

### 3.1 Terraform Variables

The variables required by the infrastructure are defined in `variables.tf`.

The main variables are:

| Variable | Description |
|---|---|
| `project_id` | GCP project identifier |
| `region` | Deployment region |
| `database_name` | Database name |
| `database_user` | MySQL user |
| `database_password` | MySQL password |
| `database_password_secret_id` | Secret identifier in Secret Manager |
| `cloud_run_service_name` | Cloud Run service name |

Environment-specific values can be defined in `terraform.tfvars`.

Example configuration:

```hcl
project_id                 = "the-program-22"
region                     = "us-central1"

database_name              = "php_application"
database_user              = "php_user"
database_password          = "the_database_password_here"
database_password_secret_id = "databse_password_secret_id"

cloud_run_service_name     = "php-service"
```

### 3.2 Initializing Terraform

From the repository root:

```bash
cd terrform
```

Initialize Terraform:

```bash
terraform init
```

### 3.3 Formatting and Validation

Format the files:

```bash
terraform fmt -recursive
```

Validate the configuration:

```bash
terraform validate
```

### 3.4 Previewing Changes

Generate the execution plan:

```bash
terraform plan
```

This command lets you see which resources will be created, modified, or deleted before they are deployed.

### 3.5 Deploying the Infrastructure

Apply the configuration:

```bash
terraform apply
```

Confirm the execution when Terraform prompts you.

Terraform notably provisions:

- The Cloud SQL instance and its database.
- The MySQL user.
- The Artifact Registry repository.
- The Cloud Run service.
- The database connection secret.
- The Cloud Storage bucket.
- The required service accounts and IAM permissions.

## 4. Automated Deployment with GitHub Actions

The repository uses GitHub Actions to automate building and deploying the application.

The workflow is defined in:

```text
.github/workflows/deploy.yml
```

### 4.1 How the Pipeline Works

The pipeline performs the following operations:

1. Checkout of the source code.
2. PHP syntax check.
3. Authentication to Google Cloud via Workload Identity Federation.
4. Docker configuration for Artifact Registry.
5. Docker image build.
6. Image push to Artifact Registry.
7. Image deployment to Cloud Run.

### 4.2 GitHub Configuration

The variables required for authentication must be configured in GitHub Actions secrets or variables, depending on how they are used in the workflow.

| Name | Description |
|---|---|
| `GCP_WORKLOAD_IDENTITY_PROVIDER` | Workload Identity Federation provider identifier |
| `GCP_SERVICE_ACCOUNT` | Address of the service account used by GitHub Actions |

The deployment service account must have the IAM permissions required to publish images and deploy the Cloud Run service.

Using Workload Identity Federation avoids storing a permanent service account JSON key in GitHub.

### 4.3 Triggering the Deployment

The workflow runs on a push to the `main` branch, as configured.

To trigger a deployment:

```bash
git add .
git commit -m "Update application"
git push origin main
```

Execution progress can be followed in the **Actions** tab of the GitHub repository.

## 5. Accessing the Deployed Application

The deployed application can be accessed at the following link:
```
https://php-devops-service-tzd3u5b76q-uc.a.run.app/
```
or by performing the following step:


## 6. Bash Script: Retrieving the Public IP Address

The project includes a Bash script that retrieves the IPv4 addresses associated with the Cloud Run service hostname.

Planned file:

```text
scripts/get-cloud-run-public-ip.sh
```

### 7.1 Expected Behavior

The script should:

- Accept an argument corresponding to the environment, for example `dev` or `prod`.
- Adapt the project and service name based on that argument.
- Retrieve the Cloud Run service URL using the Google Cloud CLI.
- Extract the hostname from the URL.
- Resolve the IPv4 addresses associated with that hostname.
- Handle errors related to authentication, a missing service, or DNS resolution failure.

### 7.2 Execution

From the repository root:

```bash
chmod +x scripts/get-cloud-run-public-ip.sh
```

For the development environment:

```bash
./scripts/get-cloud-run-public-ip.sh dev
```

For another environment configured in the script:

```bash
./scripts/get-cloud-run-ip.sh prod
```

The script displays the public IP address obtained through DNS resolution.


## 8. Problems Encountered and Solutions

Several technical difficulties were encountered while setting up the infrastructure.

### 8.1 Terraform Backend Configuration

**Problem:**

An incorrect project ID or Terraform backend bucket configuration prevented initialization or access to the remote state.

**Solution:**

Verified the actual GCP project ID and corrected the backend configuration.

### 8.2 GitHub Actions Authentication to GCP

**Problem:**

The automated deployment failed because the Workload Identity Federation provider conditions did not exactly match the GitHub repository.

**Solution:**

Corrected the provider condition so that it matches the repository:

```text
RudelAv/DevOps_Test_GCP
```

The IAM permissions of the deployment service account were also verified.

The pipeline was then able to authenticate, build the Docker image, and deploy the application to Cloud Run.

### 8.3 Authorization Issue During Cloud Run Deployment

**Problem:**

The service account used by GitHub Actions did not have all the permissions required to use the Cloud Run runtime service account.

**Solution:**

Granted the role:

```text
roles/iam.serviceAccountUser
```

on the Cloud Run runtime service account.

### 8.4 Cloud SQL Authentication Issue

**Problem encountered:**

The application initially displayed an error when connecting to MySQL:

```text
SQLSTATE[HY000] [1045] Access denied for user 'php_devops_user'
```

The Cloud Run logs showed that the connection did reach the MySQL server, but that authentication was refused.

**Solutions applied:**

- Added the `google_secret_manager_secret_version` resource to manage secret versions with Terraform.
- Synchronized the Cloud SQL user's password with the one stored in Secret Manager.
- Created a new version of the secret.
- Updated the secret reference in the Cloud Run configuration to trigger a new revision.

**Result:**

The database connection was ultimately established successfully.
The application now displays:

```text
Database connection successful!

Database : php_devops_application

Connection : Cloud SQL / MySQL
```

Communication between the PHP application deployed on Cloud Run and the MySQL database hosted on Cloud SQL is therefore operational.


## 9. Possible Improvements for a Production Environment

The current configuration is a DevOps deployment baseline. Several improvements would be needed to reach a level of robustness suitable for production.

### 9.1 Monitoring and Observability

- Set up Google Cloud Monitoring to monitor resources.
- Configure Cloud Logging to centralize logs.
- Create alerts for service unavailability.
- Monitor response times, HTTP error rates, and resource consumption.
- Set up monitoring dashboards.

### 9.2 Security

- Apply the principle of least privilege to IAM service accounts.
- Avoid public access when the application does not require it.
- Use versioned secrets and control their rotation.
- Enable protections against unwanted public access on Cloud Storage.
- Implement security policies and regular IAM audits.

### 9.3 High Availability and Resilience

- Configure automatic Cloud SQL backups.
- Define a restore policy and test backups regularly.
- Configure Cloud Run resources according to load.
- Implement progressive deployment and rollback strategies.

### 9.4 CI/CD Pipeline Improvements

- Add automated tests before each deployment.
- Run vulnerability scans on Docker images.
- Add code quality checks.
- Separate development, test, and production environments.
- Set up automated Terraform validations before applying changes.

### 9.5 Cost Management

- Configure budgets and billing alerts.
- Monitor Cloud Run, Cloud SQL, and Cloud Storage consumption.
- Adjust resources to the application's actual needs.