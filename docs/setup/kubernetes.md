# Setup on kubernetes
This assumes you have Kubernetes installed somewhere. If you don't, you can use [k3s](https://docs.k3s.io/quick-start)

or if you want to use a cloud, follow the instructions of your preferred platform
- [Google GKE](https://developer.hashicorp.com/terraform/tutorials/kubernetes/gke)
- [AWS EKS](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks)
- [Azure AKS](https://developer.hashicorp.com/terraform/tutorials/kubernetes/aks)


Install CloudNativePG
```
kubectl apply --server-side -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.25/releases/cnpg-1.25.0.yaml
```

Install Atlas for kubernetes-based database schema migrations
```
helm install atlas-operator oci://ghcr.io/ariga/charts/atlas-operator
```

Then install the kubernetes manifests
```
kubectl apply -f iac/kubernetes/.
```