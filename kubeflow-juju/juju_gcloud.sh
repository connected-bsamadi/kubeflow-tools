gcloud iam service-accounts create juju-ontario-2018 \
    --display-name "Compute Engine Juju service account"
gcloud projects add-iam-policy-binding ontario-2018 \
    --member serviceAccount:juju-ontario-2018@ontario-2018.iam.gserviceaccount.com \
    --role roles/compute.instanceAdmin.v1
gcloud projects add-iam-policy-binding ontario-2018 \
    --member serviceAccount:juju-ontario-2018@ontario-2018.iam.gserviceaccount.com \
    --role roles/compute.securityAdmin
gcloud iam service-accounts keys create juju-ontario-2018.json \
    --iam-account=juju-ontario-2018@ontario-2018.iam.gserviceaccount.com