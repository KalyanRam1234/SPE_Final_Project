# SPE_Final_Project

This is a library management application

ssh into a k8s pod: 

```bash
kubectl exec --stdin --tty <pod-name> -- /bin/bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
minikube tunnel
```