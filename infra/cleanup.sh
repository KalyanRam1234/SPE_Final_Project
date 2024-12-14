# Scale each deployment to zero
kubectl scale deployment bookapp --replicas=0 || true
kubectl scale deployment studentapp --replicas=0 || true
kubectl scale deployment booklendingapp --replicas=0 || true
kubectl scale deployment library-frontend --replicas=0 || true
kubectl scale deployment prometheus-deployment -n monitoring --replicas=0 || true
kubectl scale deployment kube-state-metrics -n kube-system --replicas=0 || true

kubectl delete deployment bookapp || true
kubectl delete deployment studentapp || true
kubectl delete deployment booklendingapp || true
kubectl delete deployment library-frontend || true
kubectl delete deployment prometheus-deployment -n monitoring || true
kubectl delete deployment kube-state-metrics -n kube-system || true

kubectl delete svc bookapp-svc || true
kubectl delete svc studentapp-svc || true
kubectl delete svc booklendingapp-svc || true
kubectl delete svc library-frontend-svc || true
kubectl delete svc mysql || true
kubectl delete svc prometheus-service -n monitoring || true
kubectl delete svc kube-state-metrics -n kube-system || true