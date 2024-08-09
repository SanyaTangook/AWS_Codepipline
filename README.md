# Plan Next Day
 Modules pipe,CND,api gateway,Edit Modulesca
 

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
| API_gatetway | pass     |
| ECR          | pass     |
| ECS          | pass     |
| service      | pass     |
| Policies     | pass     |
| pipeline     | Not pass |
| codebuile    | pass     |
