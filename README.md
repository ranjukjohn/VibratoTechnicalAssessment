# VibratoTechnicalAssessment
## The environment
The tiers are: client application, web server and database tiers
Language: nodejs for client and server application
Web server: nodes http server
database: mySQL
The virtualization platform: AWS 
The virtual server: Ubuntu Server 18.04 LTS (HVM), SSD Volume Type. t2.micro (free tier eligible)
The OS: Linux Ubuntu
Scripting: bash
IaC: Terraform
Repo: github

## Pre-requisites
1. An AWS account with the 'Default VPC' available. All AWS account come with a Default VPC in every region
2. A linux bash shell, with Terrafom on it

# Deploy the project
The project is deployed using terraform, and it uses varfile.tfvars to configure the deployment
From the CLI run:

```bash
$ terraform apply -var-file=./varfile.tfvars
```
When the deployment finishes, the last line return the aws instance id and ip-address of the deployed server

### Viewing the result
Use the ip-address, returned at the end of the deployment, in a web browser. The browser will use http and port 80 with the ip-address by default, to return the contents of the database (The database has a table called chat with a single column and record, "textline" and "Hello World" respectively). Alternatively the url http://<ip-address>:80 can be provided in the browser, where <ip-address> is the ip-address of the instance.

### Destroying the instance
When completed, please destroy the aws instance with
```bash
$ terraform destroy -var-file=./varfile.tfvars
```

## Known Limitations and Issues
Due to the nature of the project and time consideration the following are some of the limiations and issues:

### Limitations
- Upon reboot the node http server has not been implemented to start up on its own
- error checking, recovery and exit conditions
- resilience and redundancy considerations

### Known Issues
- permission issue running npm and express packages

## Improvements
