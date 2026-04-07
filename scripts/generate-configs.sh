#!/bin/bash

set -e

echo "Generating configs..."

# Prometheus
envsubst < prometheus/prometheus.yml.template > prometheus/prometheus.yml

# Alertmanager
envsubst < alertmanager/alertmanager.yml.template > alertmanager/alertmanager.yml

# Grafana datasource
envsubst < grafana/provisioning/datasources/datasource.yml.template > grafana/provisioning/datasources/datasource.yml

echo "Configs generated"