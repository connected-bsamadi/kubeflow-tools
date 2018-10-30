#!/bin/bash

ZONE=us-central1-c
gcloud container clusters delete kubeflow-codelab --zone $ZONE