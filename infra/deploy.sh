kubectl apply -f app-secrets.yaml
kubectl apply -f bookapp-infra
kubectl apply -f studentapp-infra
kubectl apply -f booklendingapp-infra
kubectl apply -f frontend-infra
kubectl apply -f db-infra
kubectl apply -f ingress-infra

kubectl create namespace monitoring
kubectl apply -f prometheus
kubectl apply -f kube-state-metrics-configs
