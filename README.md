# jenkins-setup

Setting up the jenkins using IAC in AWS

## Steps

1. Create a VPC
2. Create a Subnet
3. Attach an Internet gateway
4. Attach the route table
5. Launch the jenkins instance

## Project Structure

- [jenkins-setup](./)

  - [modules](./modules/)

    - [iam](./modules/iam/)

      - [main.tf](./modules/iam/main.tf)
      - [outputs.tf](./modules/iam/outputs.tf)
      - [variables.tf](./modules/iam/variables.tf)
      - [README.md](./modules/iam/README.md)

  - [scripts](./scripts/)

    - [jenkins_setup.sh](./scripts/jenkins_setup.sh)

  - [terraform-backend-setup](./terraform-backend-setup/)

    - [main.tf](./terraform-backend-setup/main.tf)
    - [outputs.tf](./terraform-backend-setup/outputs.tf)
    - [terraform.tfvars](./terraform-backend-setup/terraform.tfvars)
    - [variables.tf](./terraform-backend-setup/variables.tf)
    - [README.md](./terraform-backend-setup/README.md)

  - [main.tf](./main.tf)

  - [outputs.tf](./outputs.tf)

  - [README.md](./README.md)

  - [terraform.tfvars](./terraform.tfvars)

  - [variables.tf](./variables.tf)

## How to Run

1. Clone the repository.
2. Navigate to the `terraform-backend-setup` folder.
3. Run the project, for example:

   ```bash
   terraform plan
   ```

   ```bash
   terraform apply
   ```

4. Now once you have setup the backend, move towards setting up the jenkins instance
5. ```bash
   terraform plan
   ```

   ```bash
   terraform apply
   ```
