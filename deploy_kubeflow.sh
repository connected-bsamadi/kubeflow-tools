#!/bin/bash

# export CLIENT_ID=[CLIENT_ID]
# export CLIENT_SECRET=[CLIENT_SECRET]

export KFAPP=kubeflow
export PROJECT=ontario-2018
export ZONE=us-central1-c

export KUBEFLOW_REPO=kubeflow_repo
export KUBEFLOW_TAG=master

if [[ ! -d "${KUBEFLOW_REPO}" ]]; then
  mkdir ${KUBEFLOW_REPO}
  cd ${KUBEFLOW_REPO}
  curl https://raw.githubusercontent.com/kubeflow/kubeflow/${KUBEFLOW_TAG}/scripts/download.sh | bash
  cd ..
fi

export KUBEFLOW_REPO="`pwd`/${KUBEFLOW_REPO}"

# export CONFIG_FILE="cluster-kubeflow.yaml"
# gcloud deployment-manager --project=${PROJECT} deployments create ${KFAPP} --config=${CONFIG_FILE}
${KUBEFLOW_REPO}/scripts/kfctl.sh init ${KFAPP} --platform gcp --project ${PROJECT}

cd ${KFAPP}
${KUBEFLOW_REPO}/scripts/kfctl.sh generate platform
${KUBEFLOW_REPO}/scripts/kfctl.sh apply platform
${KUBEFLOW_REPO}/scripts/kfctl.sh generate k8s
${KUBEFLOW_REPO}/scripts/kfctl.sh apply k8s
cd ..

kubectl -n kubeflow get  all
kubectl get pod -n ${KFAPP}
# https://kubeflow.endpoints.ontario-2018.cloud.goog/hub
