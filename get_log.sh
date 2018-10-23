#!/bin/bash
export KFAPP=kubeflow
export CLUSTER=$KFAPP
export POD=jupyterhub-0

# kubectl get pod -n ${KFAPP}

gcloud --project=${PROJECT} logging read \
       --format="table(timestamp, resource.labels.container_name, textPayload)" \
       --freshness=24h \
       --order asc "resource.type=\"container\" \
                   resource.labels.cluster_name=\"${CLUSTER}\"  \
                   resource.labels.pod_id=\"${POD}\"  " > ${POD}.log

export POD=envoy-79ff8d86b-8jv5z

gcloud --project=${PROJECT} logging read \
       --format="table(timestamp, resource.labels.container_name, textPayload)" \
       --freshness=24h \
       --order asc "resource.type=\"container\" \
                   resource.labels.cluster_name=\"${CLUSTER}\"  \
                   resource.labels.pod_id=\"${POD}\"  " > ${POD}.log
