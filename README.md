# Academic Project: two-tier-web-application-automation-shadowy-inspiration

## Architecture

![image](https://github.com/Ranjith-2022/Two-Tier-web-application-automation-with-Terraform-Ansible/assets/114111480/9c344462-01ef-42bf-949b-51aa972003a4)


- The application will serve a static website with the images downloaded from S3 bucket.
- The application will be deployed on an Auto-Scaling Group (ASG) of EC2 instances with a minimum of 3 and a maximum of 4 instances across 3 availability zones.
- The solution will have a scaling policy to scale out if the load is above 10% of the CPU and scale in if the load is below 5% of the CPU.
- The solution will deploy two environments with the following specifications.


<img width="800" alt="image" src="https://github.com/Ranjith-2022/Two-Tier-web-application-automation-with-Terraform-Ansible/assets/114111480/2de66017-ea73-41c4-823c-4c9795cba596">

## Traffic Flows

![image](https://github.com/Ranjith-2022/Two-Tier-web-application-automation-with-Terraform-Ansible/assets/114111480/397aeba8-a447-4fa5-812f-eed106044ccd)


## Table Of Contents
- [Final Project: two-tier-web-application-automation-shadowy-inspiration](#acs730-final-project-two-tier-web-application-automation-shadowy-inspiration)
  - [Pre-Requisites](#pre-requisites)
  - [Deployment Instructions](#deployment-instructions)
    - [Step 1: Clone the project at a path accessible in your IDE](#step-1-clone-the-project-at-a-path-accessible-in-your-ide)
    - [Step 2: Create S3 buckets to store state and images](#step-2-create-s3-buckets-to-store-state-and-images)
    - [Step 3: Select deployment environment](#step-3-select-deployment-environment)
    - [Step 4: Generate SSH keys and deploy the environment infrastructure using Terraform](#step-4-generate-ssh-keys-and-deploy-the-environment-infrastructure-using-terraform)
    - [Step 5: Run the ansible playbook using the dynamic AWS inventory for the terraform environment(s) deployed](#step-5-run-the-ansible-playbook-using-the-dynamic-aws-inventory-for-the-terraform-environments-deployed)
    - [Step 6: Test access to webservers using the load balancer DNS noted in Step 4](#step-6-test-access-to-webservers-using-the-load-balancer-dns-noted-in-step-4)
    - [Step 7: Destroy deployed infrastructure](#step-7-destroy-deployed-infrastructure)
  - [License](#license)
  - [Author Information](#author-information)

## Pre-Requisites
- Terraform is installed in your IDE. Run the following code if Terraform has not yet been installed:
  
```bash
   sudo yum install -y yum-utils
   sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
   sudo yum -y install terraform
```

-  Ansible has to be installed. Run the following code if Ansible has not yet been installed:
  
```bash
   yum remove ansible
   pip3 install ansible
   pip3 install boto3 botocore
   ansible-galaxy collection install amazon.aws
```
 
- Please check if Python and Ansible version are the latests versions (At least **Python 3.8.16** and **Ansible [core 2.13.13]** above)
  
  You can check your Python version with the following:
  
```bash
   python --version
```

  You can check your Ansible version with the following:
  
```bash
   ansible --version
```


## Deployment Instructions

### Step 1: Clone the project at a path accessible in your IDE

```bash
   git clone git@github.com:NCC-0514/two-tier-web-application-automation-shadowy-inspiration.git
```

### Step 2: Create S3 buckets to store state and images

The buckets use `${var.env[count.index]}-images-acs730-shadowy-inspiration` for their name by default. Since AWS S3 buckets in the same region need to have unique names, if you face an issue with them at the time of deployment, update variable `env` in variables.tf to deploy buckets and the full bucket name in the config.tf file along with the `s3_address` ansible var (used for referencing the image for the webserver) in the environment you are deploying. 

```bash
   cd two-tier-web-application-automation-shadowy-inspiration/terraform/buckets
   terraform init
   terraform apply -auto-approve
```

### Step 3: Select deployment environment

Run the following command to select the `staging` environment

```bash 
   cd ../environments/staging
```  

or the following command to select the `production` environment

```bash
   cd ../environments/production
```

### Step 4: Generate SSH keys and deploy the environment infrastructure using Terraform

Run the command given below to generate the ssh keys

```bash 
   ssh-keygen -t rsa -f bastion_key
   ssh-keygen -t rsa -f vm_key
```
  
Deploy the infrastructure

```bash   
   terraform init
   terraform apply -auto-approve
```
  
Note the DNS address from the terraform output "load_balancer_dns_name" (similar to (http://production-alb-12345678.us-east-1.elb.amazonaws.com/) for accessing the webservers through the loadbalancer and wait for all the EC2 instances to be running successfully before proceeding to the next step.

### Step 5: Run the ansible playbook using the dynamic AWS inventory for the terraform environment(s) deployed 

For staging

```bash  
   cd ../../../ansible/staging
   ansible-playbook -i aws_ec2.yaml finalproj.yaml
```

For production

```bash  
   cd ../../../ansible/production
   ansible-playbook -i aws_ec2.yaml finalproj.yaml
```

If the run errors or times out due to a connectivity issue, please rerun the playbook and you should see a successful run.

### Step 6: Test access to webservers using the load balancer DNS noted in Step 4

Verify that the target group has healthy targets and use the load balancer URL noted earlier/from AWS Management console to access the webservers

```
Terraform load_balancer_dns_name output similar to http://production-alb-12345678.us-east-1.elb.amazonaws.com/
```

Refresh your browser a few times to observe the change in the webserver receving traffic from the load balancer.

### Step 7: Destroy deployed infrastructure

For staging

```bash
   cd ../../terraform/environments/staging
   terraform destroy -auto-approve
```

For production

```bash
   cd ../../terraform/environments/production
   terraform destroy -auto-approve
```

For S3 buckets
```bash  
   cd ../../buckets
   terraform destroy -auto-approve
```  

## License

ACS-NUMBAH-WAN-LICENSE

## Author Information

GROUP 8 SHADOWY INSPIRATION IS MY ACADEMIC GROUP PROJECT, HERE IS THE LINK - https://github.com/NCC-0514/two-tier-web-application-automation-shadowy-inspiration
