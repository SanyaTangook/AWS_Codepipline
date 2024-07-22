# Terraform Config AWS API Gateway

This is **IaC** Copy API Gateway Prod for Build API Gateway Staging

## Structures File

```bash
|__config
|    |__main.tf
|    |__provider.tf
|    |__*.tfvars
|    |__var.tf
|__modules
    |__api_gateway
    |__ECS 
    |__ECR
    |__namespace
```

- How To Config variables
  New File terraform.tfvars
  - Structures variabls look in var.tf
    example variables

```terrafrom
data_api ={
    "name_api" = {
        Id_original = "xx78xx"
        domain_name = "test.78.co" 
    }
}

name_certificate = "name_certificate" 

ECS = {
    "Cluster_name" = [ "name_task" ]
}

role_ecs = "Role_ECS"

url_ecr  = "xxxxxxx.xx.xx.ap-southeast-1.amazonaws.com"
```

- **certificate look in tap VPC links**

## **Go to build** 🛠️🤯

```bash
terraform apply -var-file="terraform.tfvars"
```

# Modules ECS not work
