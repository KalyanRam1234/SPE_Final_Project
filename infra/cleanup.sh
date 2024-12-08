kubectl delete deployment bookapp || true
kubectl delete deployment studentapp || true
kubectl delete deployment booklendingapp || true
kubectl delete deployment library-frontend || true

kubectl delete svc bookapp-svc || true
kubectl delete svc studentapp-svc || true
kubectl delete svc booklendingapp-svc || true
kubectl delete svc library-frontend-svc || true