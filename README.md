# SPE_Final_Project

This is a library management application

ssh into a k8s pod: 

```bash
kubectl exec --stdin --tty <pod-name> -- /bin/bash
```

Need to run the below after ansible runs

```bash
minikube tunnel
minikube addons enable ingress
kubectl port-forward service/loki-grafana 8081:80 -n monitoring
```

Monitoring done using Prometheus and Logging done using Grafana and Loki

Further details on the microservices can be found in the Readmes' of the respective directory
