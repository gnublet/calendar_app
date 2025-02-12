# Calendar App
<!-- ![logo](./assets/cal_logo_small.jpeg) -->
<img src="./assets/cal_logo_small.jpeg" height="200">

A simple crud app for a calendar api.

![CI](https://github.com/gnublet/calendar_app/actions/workflows/test.yaml/badge.svg)

## Setup
Copy `.env.test` as `.env` and customize your environment variables as desired, then choose your preferred method:

- [From scratch](./docs/setup/scratch.md)
- [Docker-compose](./docs/setup/docker-compose.md)
- [Kubernetes](./docs/setup/kubernetes.md)
- [Terraform/OpenTofu](./docs/setup/terraform.md) 


### If you're using Kubernetes
Assuming you have Kubernetes installed

Install CloudNativePG which supports the full lifecycle of a highly available PostgreSQL database cluster with a primary/standby architecture:
```
kubectl apply --server-side -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.25/releases/cnpg-1.25.0.yaml
```

Install Atlas for kubernetes based database migrations
```
helm install atlas-operator oci://ghcr.io/ariga/charts/atlas-operator
```