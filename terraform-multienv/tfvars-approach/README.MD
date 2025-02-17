terraform init -backend-config=dev/backend.tf
terraform plan -var-file=dev/backend.tf
terraform apply -var-file=dev/backend.tf
terraform init -reconfigure -backend-config=prod/prod.tf
terraform plan -var-file=prod/backend.tf
terraform apply -var-file=prod/backend.tf
