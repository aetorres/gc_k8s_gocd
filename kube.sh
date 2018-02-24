#!/bin/bash

    gcloud container clusters get-credentials k8s-gocd-cluster --zone us-central1-a --project k8s-gocd3
    helm init
    sleep 120
    helm install --name my-release incubator/gocd
    kubectl expose deployment my-release-gocd-server --type=LoadBalancer --name=my-loadbalancer
    kubectl get services