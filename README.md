# grafana-terraform-aws-lc-autoscale #

This repository use for **Grafana Stack** provisioning.

The component contains 2 components that are

- *Terraform Files Configuration* (*.tf) -- The set of files used to describe infrastructure in Terraform.

- *Variables File* (*.tfvar) -- This file parameterize the configurations.

### How to run the component ###

Setup the AWS Credentials which has sufficient permission

    aws configure
    AWS Access Key ID [None]: *********
    AWS Secret Access Key [None]: **********
    Default region name [None]: ap-southeast-2
    Default output format [None]:

Go to the specific environment folder and run the terrafoAfter Setup the Credentials, Initialize the terraform and execute the planrm

    terraform init -var-file=grafana.tfvar ../deployment/

    terraform plan -var-file=grafana.tfvar ../deployment/

    terraform apply -var-file=grafana.tfvar ../deployment/

### Modules ##

- **aws_lc**: Module use to create ws launch configuration.

- **aws_sg**: Module use to create security group with the existing vpc. as "test-vpc".

- **aws_asg**: Module use to create autoscaling group using aws launch configuration.

- **aws_elb** : Module for any type of the load balancer with listerner and target group and also set the ssl certification.

- **aws_dns**: Module to create a domain name in "route 53" with the load balance endpoint as above.