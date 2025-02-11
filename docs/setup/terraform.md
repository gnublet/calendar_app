# Setup with OpenTofu (or Terraform)
Install [OpenTofu](https://opentofu.org/docs/intro/install/) or [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli). For the below, we'll assume you chose Opentofu, but if you chose Terraform, just replace `tofu` with `terraform`.

Change directory to `iac/tf`:
```
cd iac/tf
```

Initialize a working directory in `iac/tf`:
```
tofu init
```

Create execution plan with a preview of the changes OpenTofu will make to your infrastructure:
```
tofu plan
```

Validate the plan, referring only to the configuration and not accessing any remote services:
```
tofu validate
```

Apply the changes, executing the proposed actions:
```
tofu apply
```

If you're done and want to clear everything:
```
tofu destroy
```