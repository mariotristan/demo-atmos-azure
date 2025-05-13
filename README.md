# Azure VM & Load Balancer Deployment with Terraform & Atmos

## 📌 Overview
This project uses **Terraform** and **Atmos** to deploy a **Virtual Machine (VM)** hosting a "Hello World" website, behind an **Azure Load Balancer** for traffic distribution.

## ⚙️ Architecture
This setup includes:

- **Networking**
  - Virtual Network (`demo-vnet`)
  - Subnet (`demo-subnet`)
  - Network Interface (`demo-nic`)
  - Public IP (`demo_vm_pip`)
- **Compute**
  - Linux Virtual Machine (`HelloWorldVM`)
  - Nginx Web Server (`Hello World` page)
- **Load Balancing**
  - Azure Load Balancer (`demo-lb`)
  - Frontend IP (`lb-public-ip`)
  - Backend Pool (`vm-backend-pool`)

# How to Use Atmos for This Demo

This guide explains how to use Atmos to deploy, test, and clean up the resources for this demo.

## 🚀 Deploying the Demo

1. **Install Prerequisites**
   - Install [Terraform](https://www.terraform.io/downloads.html).
   - Install [Atmos](https://atmos.tools/).
   - Ensure you have the Azure CLI installed and authenticated.

2. **Set Up Configuration**
   - Navigate to the `stacks/deploy/` directory.
   - Update the `dev.yaml` or `staging.yaml` files with your desired configuration.

3. **Run Atmos Commands**
   - **Initialize Terraform**
     ```bash
     atmos terraform init -s <environment>
     ```
     Replace `<environment>` with `dev` or `staging`.

   - **Plan Deployment**
     ```bash
     atmos terraform plan -s <environment>
     ```

   - **Apply Deployment**
     ```bash
     atmos terraform apply -s <environment>
     ```

4. **Verify Deployment**
   - Access the public IP of the Load Balancer to verify the `Hello World` website is running.

## 🧪 Testing the Demo

1. **Access the Application**
   - Use the public IP address of the Load Balancer to access the deployed `Hello World` application in your browser.

2. **Perform Functional Tests**
   - Verify that the application responds correctly to HTTP requests.
   - Test the load balancer by simulating traffic to ensure proper distribution.

3. **Monitor Resources**
   - Use the Azure portal or CLI to monitor the deployed resources and ensure they are functioning as expected.

## 🧹 Cleaning Up the Environment

To clean up the deployed resources and remove the environment, follow these steps:

1. **Run Atmos Destroy Command**
   Use the following command to destroy the resources for a specific environment:
   ```bash
   atmos terraform destroy -s <environment>
   ```
   Replace `<environment>` with `dev` or `staging` depending on the environment you want to clean up.

2. **Verify Resource Deletion**
   - Check the Azure portal to ensure all resources have been deleted.
   - Verify that no residual resources are left in the resource group.

3. **Remove State Files (Optional)**
   If you want to completely clean up the local state files, you can delete the `terraform.tfstate.d/` directory for the respective environment:
   ```bash
   rm -rf components/terraform/demo-app/terraform.tfstate.d/<environment>/
   ```
   Replace `<environment>` with `staging` or `dev`.

   **Note:** Be cautious when deleting state files as they are critical for tracking resource states.
