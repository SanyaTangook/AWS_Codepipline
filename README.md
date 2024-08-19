# Plan Next Day
 CND,api gateway,ALB,

# NOTE
 ECS Clusters สร้างมือ
 ECS Service สร้างมือ
 VPC สร้างมือ

# Terraform Config Pipeline and ECS

## Structures File

```bash
MODULES
├───api_geteway
├───CodeBuile
│   └───role_policy
├───ECR
├───ECS
│   └───role_policy
└───Pipe
    └───role_policy
```

- **certificate look in tap VPC links**

## **Go to build** 🛠️🤯

```bash
terraform apply --var-file="terraform.tfvars"
```

| Modules      | status   |
|--------------|----------|
| API_gatetway | Not pass |
| ALB          | Not pass |
| ECR          | pass     |
| ECS          | pass     |
| pipeline     | pass     |
| codebuile    | pass     |
