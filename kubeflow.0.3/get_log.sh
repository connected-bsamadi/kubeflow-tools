#!/bin/bash
export KFAPP=dashboard
export CLUSTER=$KFAPP
export POD=jupyterhub-0

mkdir -p logs
cd logs

# kubectl get pod -n ${KFAPP}

gcloud --project=${PROJECT} logging read \
       --format="table(timestamp, resource.labels.container_name, textPayload)" \
       --freshness=24h \
       --order asc "resource.type=\"container\" \
                   resource.labels.cluster_name=\"${CLUSTER}\"  \
                   resource.labels.pod_id=\"${POD}\"  " > ${POD}.log

export POD=envoy-79ff8d86b-4flnc

gcloud --project=${PROJECT} logging read \
       --format="table(timestamp, resource.labels.container_name, textPayload)" \
       --freshness=24h \
       --order asc "resource.type=\"container\" \
                   resource.labels.cluster_name=\"${CLUSTER}\"  \
                   resource.labels.pod_id=\"${POD}\"  " > ${POD}.log


cd ..