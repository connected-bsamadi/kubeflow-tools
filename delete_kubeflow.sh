#!/bin/bash

export KFAPP=kubeflow
export KUBEFLOW_REPO=kubeflow_repo
export KUBEFLOW_REPO="`pwd`/${KUBEFLOW_REPO}"

cd ${KFAPP}
${KUBEFLOW_REPO}/scripts/kfctl.sh delete all
cd ..
