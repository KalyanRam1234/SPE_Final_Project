# #!/bin/bash

# helm repo add grafana https://grafana.github.io/helm-charts
# helm repo update

# helm install grafana grafana/grafana --namespace grafana --create-namespace
# helm show values grafana/loki-distributed > loki-distributed-overrides.yaml
# helm upgrade --install --values loki-distributed-overrides.yaml loki grafana/loki-distributed -n grafana-loki --create-namespace
# helm show values grafana/promtail > promtail-overrides.yaml

# helm upgrade --install --values promtail-overrides.yaml promtail grafana/promtail -n grafana-loki

# # Namespace and service variables
# NAMESPACE="grafana"
# SERVICE_NAME="grafana"

# # Function to check if the service is running
# function is_service_ready() {
#     kubectl get service "$SERVICE_NAME" -n "$NAMESPACE" &> /dev/null
#     if [ $? -ne 0 ]; then
#         return 1
#     fi

#     # Check if the service has a valid ClusterIP
#     IP_STATUS=$(kubectl get service "$SERVICE_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.clusterIP}')
#     if [ -z "$IP_STATUS" ] || [ "$IP_STATUS" == "<pending>" ]; then
#         return 1
#     fi

#     return 0
# }

# echo "Waiting for service $SERVICE_NAME in namespace $NAMESPACE to be ready..."

# # Wait until the service is ready
# while ! is_service_ready; do
#     sleep 2
# done

# echo "Service is ready. Starting port forwarding in a new tmux session..."

# # Start port forwarding in a new tmux session
# tmux new-session -d -s "port_forwarding" "kubectl port-forward service/$SERVICE_NAME 8081:80 -n $NAMESPACE"

# echo "Port forwarding started in tmux session 'port_forwarding'."

# # Wait for a short time to ensure the port-forwarding session is running
# sleep 5

# echo "Fetching Grafana admin password..."
# kubectl get secret grafana -n "$NAMESPACE" -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# helm install loki grafana/loki-stack   --namespace monitoring   --create-namespace   --set loki.image.tag=2.9.3   --set promtail.enabled=true   --set promtail.config.server.http_listen_port=3101   --set promtail.config.clients[0].url=http://loki:3100/loki/api/v1/push   --set promtail.config.positions.filename=/run/promtail/positions.yaml   --set promtail.config.scrape_configs[0].job_name="kubernetes-pods"   --set promtail.config.scrape_configs[0].kubernetes_sd_configs[0].role="pod"   --set promtail.config.scrape_configs[0].relabel_configs[0].action="keep"   --set promtail.config.scrape_configs[0].relabel_configs[0].source_labels="[_meta_kubernetes_namespace]"   --set promtail.config.scrape_configs[0].relabel_configs[0].regex=".*"   --set promtail.config.scrape_configs[0].relabel_configs[1].source_labels="[meta_kubernetes_pod_name]"   --set promtail.config.scrape_configs[0].relabel_configs[1].target_label="job"   --set promtail.config.scrape_configs[0].relabel_configs[2].source_labels="[meta_kubernetes_namespace]"   --set promtail.config.scrape_configs[0].relabel_configs[2].target_label="namespace"   --set promtail.config.scrape_configs[0].relabel_configs[3].source_labels="[_meta_kubernetes_pod_name]"   --set promtail.config.scrape_configs[0].relabel_configs[3].target_label="pod"   --set grafana.enabled=true   --set prometheus.enabled=true

helm install loki grafana/loki-stack \
  --namespace monitoring \
  --create-namespace \
  --set loki.image.tag=2.9.3 \
  --set promtail.enabled=true \
  --set promtail.config.server.http_listen_port=3101 \
  --set promtail.config.clients[0].url=http://loki:3100/loki/api/v1/push \
  --set promtail.config.positions.filename=/run/promtail/positions.yaml \
  --set promtail.config.scrape_configs[0].job_name="kubernetes-pods" \
  --set promtail.config.scrape_configs[0].kubernetes_sd_configs[0].role="pod" \
  --set promtail.config.scrape_configs[0].relabel_configs[0].action="keep" \
  --set promtail.config.scrape_configs[0].relabel_configs[0].source_labels="[_meta_kubernetes_namespace]" \
  --set promtail.config.scrape_configs[0].relabel_configs[0].regex=".*" \
  --set promtail.config.scrape_configs[0].relabel_configs[1].source_labels="[meta_kubernetes_pod_name]" \
  --set promtail.config.scrape_configs[0].relabel_configs[1].target_label="job" \
  --set promtail.config.scrape_configs[0].relabel_configs[2].source_labels="[meta_kubernetes_namespace]" \
  --set promtail.config.scrape_configs[0].relabel_configs[2].target_label="namespace" \
  --set promtail.config.scrape_configs[0].relabel_configs[3].source_labels="[_meta_kubernetes_pod_name]" \
  --set promtail.config.scrape_configs[0].relabel_configs[3].target_label="pod" \
  --set grafana.enabled=true \
  --set prometheus.enabled=true \
  --set loki.resources.requests.cpu="600m" \
  --set loki.resources.requests.memory="1Gi" \
  --set loki.resources.limits.cpu="1" \
  --set loki.resources.limits.memory="2Gi" \
  --set promtail.resources.requests.cpu="400m" \
  --set promtail.resources.requests.memory="512Mi" \
  --set promtail.resources.limits.cpu="800m" \
  --set promtail.resources.limits.memory="1Gi"

kubectl get secret loki-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
