# Plan Next Day
 Modules pipe,CND,api gateway,Edit Modulesca
 

# Terraform Config AWS API Gateway

This is **IaC** Copy API Gateway Prod for Build API Gateway Staging

## Structures File

```bash
├───config
│   ├───api_geteway
│   ├───ECR
│   ├───ECS_Service
│   └───IAM
└───modules
    ├───api_geteway
    ├───CodeBuile
    ├───ECR
    ├───ECS
    │   └───service
    ├───Pipe
    └───Policies
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
