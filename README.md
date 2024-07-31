# Terraform Config AWS API Gateway

This is **IaC** Copy API Gateway Prod for Build API Gateway Staging

## Structures File

```bash
├───config
│   ├───api_geteway
│   ├───ECR
│   ├───ECS_Service
│   └───Pipeline
└───modules
    ├───api_geteway
    ├───ECR
    ├───ECS
    │   └───service
    └───Pipeline
```

- **certificate look in tap VPC links**

## **Go to build** 🛠️🤯

```bash
terraform apply -var-file="terraform.tfvars"
```

### Modules in Plan

- ecs service
- pipeline