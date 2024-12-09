kubectl delete deployment bookapp || true
kubectl delete deployment studentapp || true
kubectl delete deployment booklendingapp || true
kubectl delete deployment library-frontend || true
kubectl delete deployment prometheus-deployment -n monitoring || true
kubectl delete deployment kube-state-metrics -n monitoring || true

kubectl delete svc bookapp-svc || true
kubectl delete svc studentapp-svc || true
kubectl delete svc booklendingapp-svc || true
kubectl delete svc library-frontend-svc || true
kubectl delete svc mysql || true
kubectl delete svc prometheus-service -n monitoring || true
kubectl delete svc kube-state-metrics -n monitoring || true