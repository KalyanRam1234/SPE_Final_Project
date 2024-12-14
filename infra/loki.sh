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
  --set promtail.resources.requests.memory="1Gi" \
  --set promtail.resources.limits.cpu="800m" \
  --set promtail.resources.limits.memory="1.5Gi"

kubectl get secret loki-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
