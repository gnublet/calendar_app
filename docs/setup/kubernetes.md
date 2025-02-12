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


Then you can check the external-ip of the fastapi-service (using `kubectl get svc fastapi-service`). For example, if it's `192.168.0.170`, to see the app, go to `192.168.0.170:8000/docs`

If you're done, you can delete everything
```
kubectl delete -f iac/kubernetes/.
```