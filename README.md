# Plan Next Day
 CND,api gateway

# NOTE
 ECS Clusters สร้างมือ
 VPC สร้างมือ

# Terraform Config AWS API Gateway

This is **IaC** Copy API Gateway Prod for Build API Gateway Staging

## Structures File

```bash
MODULES
├───api_geteway
├───CodeBuile
│   └───role_policy
├───ECR
├───ECS
│   └───service
└───Pipe
    └───role_policy
```

- **certificate look in tap VPC links**

## **Go to build** 🛠️🤯

```bash
terraform apply -var-file="terraform.tfvars"
```

| Modules      | status   |
|--------------|----------|
| API_gatetway | Not pass |
| ECR          | pass     |
| ECS          | pass     |
| service      | pass     |
| Policies     | pass     |
| pipeline     | pass     |
| codebuile    | pass     |
