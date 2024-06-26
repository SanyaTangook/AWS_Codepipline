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
        |__main.tf
        |__output.tf
        |__var.tf
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
```

- **certificate look in tap VPC links**

## **Go to build** 🛠️🤯

```bash
terraform apply -var-file="terraform.tfvars"
```