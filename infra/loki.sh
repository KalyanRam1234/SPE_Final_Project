#!/bin/bash

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm install grafana grafana/grafana --namespace grafana --create-namespace
helm show values grafana/loki-distributed > loki-distributed-overrides.yaml
helm upgrade --install --values loki-distributed-overrides.yaml loki grafana/loki-distributed -n grafana-loki --create-namespace
helm show values grafana/promtail > promtail-overrides.yaml

helm upgrade --install --values promtail-overrides.yaml promtail grafana/promtail -n grafana-loki

# Namespace and service variables
NAMESPACE="grafana"
SERVICE_NAME="grafana"

# Function to check if the service is running
function is_service_ready() {
    kubectl get service "$SERVICE_NAME" -n "$NAMESPACE" &> /dev/null
    if [ $? -ne 0 ]; then
        return 1
    fi

    # Check if the service has a valid ClusterIP
    IP_STATUS=$(kubectl get service "$SERVICE_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.clusterIP}')
    if [ -z "$IP_STATUS" ] || [ "$IP_STATUS" == "<pending>" ]; then
        return 1
    fi

    return 0
}

echo "Waiting for service $SERVICE_NAME in namespace $NAMESPACE to be ready..."

# Wait until the service is ready
while ! is_service_ready; do
    sleep 2
done

echo "Service is ready. Starting port forwarding in a new tmux session..."

# Start port forwarding in a new tmux session
tmux new-session -d -s "port_forwarding" "kubectl port-forward service/$SERVICE_NAME 8081:80 -n $NAMESPACE"

echo "Port forwarding started in tmux session 'port_forwarding'."

# Wait for a short time to ensure the port-forwarding session is running
sleep 5

echo "Fetching Grafana admin password..."
kubectl get secret grafana -n "$NAMESPACE" -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
