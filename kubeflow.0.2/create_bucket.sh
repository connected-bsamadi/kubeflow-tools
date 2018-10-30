#!/bin/bash

# project id
PROJECT_ID=ontario-2018

# choose a unique name for your model's bucket
BUCKET_NAME=ontario-2018-kubeflow

# get the user email
IAM_EMAIL=$(gcloud config get-value account)

# create the GCS bucket
gsutil mb gs://$BUCKET_NAME/

# create service account
gcloud iam service-accounts create kubeflow-codelab --display-name kubeflow-codelab

# get the email associated with the new service account
IAM_EMAIL=kubeflow-codelab@$PROJECT_ID.iam.gserviceaccount.com

# allow the service account to upload data to the bucket
gsutil acl ch -u $IAM_EMAIL:O gs://$BUCKET_NAME

gcloud iam service-accounts keys create ./tensorflow-model/key.json --iam-account=$IAM_EMAIL