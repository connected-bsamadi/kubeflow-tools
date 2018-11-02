#!/bin/bash

# export CLIENT_ID=[CLIENT_ID]
# export CLIENT_SECRET=[CLIENT_SECRET]

export KFAPP=dashboard
export PROJECT=ontario-2018
export ZONE=us-central1-c

export KUBEFLOW_REPO=kubeflow_repo
export KUBEFLOW_REPO="`pwd`/${KUBEFLOW_REPO}"
export KUBEFLOW_TAG=master

if [[ ! -d "${KUBEFLOW_REPO}" ]]; then
  mkdir ${KUBEFLOW_REPO}
  cd ${KUBEFLOW_REPO}
  curl https://raw.githubusercontent.com/kubeflow/kubeflow/${KUBEFLOW_TAG}/scripts/download.sh | bash
  cd ..
fi

${KUBEFLOW_REPO}/scripts/kfctl.sh init ${KFAPP} --platform gcp --project ${PROJECT}

cd ${KFAPP}
${KUBEFLOW_REPO}/scripts/kfctl.sh generate platform
${KUBEFLOW_REPO}/scripts/kfctl.sh apply platform
${KUBEFLOW_REPO}/scripts/kfctl.sh generate k8s
${KUBEFLOW_REPO}/scripts/kfctl.sh apply k8s
cd ..

# Get all the services
kubectl -n ${KFAPP} get  all

# Look at all pods
kubectl get pod -n ${KFAPP}

# Look at the envoy pods
kubectl -n ${KFAPP} get pods -l service=envoy

# Check the central dashboard
kubectl get pods -l app=centraldashboard

# Check the endpoint
kubectl get ingress envoy-ingress

# Describe the ingress endpoint
kubectl describe ingress envoy-ingress

# Get secret
kubectl get secret
