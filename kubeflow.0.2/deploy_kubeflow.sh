#!/bin/bash

export GITHUB_TOKEN=9aa39fbf29100e1cf8965a0397c038597dd07191

# list all projects for your Google Cloud Platform account
gcloud projects list

# set your active GCP project
PROJECT_ID=ontario-2018
ZONE=us-central1-c

gcloud config set project $PROJECT_ID

# create a cluster
gcloud container clusters create kubeflow-codelab \
      --zone $ZONE --machine-type n1-standard-2

gcloud container clusters get-credentials kubeflow-codelab --zone $ZONE

kubectl create clusterrolebinding default-admin \
      --clusterrole=cluster-admin --user=$(gcloud config get-value account)

ks init ksonnet-kubeflow
cd ksonnet-kubeflow

ks env add cloud

VERSION=v0.2.7
ks registry add kubeflow github.com/kubeflow/kubeflow/tree/${VERSION}/kubeflow
ks pkg install kubeflow/core@${VERSION}
ks pkg install kubeflow/tf-serving@${VERSION}
ks pkg install kubeflow/tf-job@${VERSION}
ks pkg install kubeflow/seldon@${VERSION}

# generate the kubeflow-core component from its prototype
ks generate core kubeflow-core --name=kubeflow-core --cloud=gke

# apply component to our cluster
ks apply cloud -c kubeflow-core

kubectl get all 
