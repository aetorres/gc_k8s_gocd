#!/bin/bash

    gcloud container clusters get-credentials k8s-gocd-cluster --zone us-central1-a --project k8s-gocd3
    kubectl create secret generic user-pass --from-file=./username.txt --from-file=./password.txt
    helm init
    sleep 80
    helm install --name my-release -f values.yaml incubator/gocd 
    kubectl expose deployment my-release-gocd-server --type=LoadBalancer --name=my-loadbalancer
    kubectl get services
    sleep 100
    echo "Copying entrypoint.sh to Agent Pod"
    agente=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | sed -n 1p)
    kubectl cp scripts/entrypoint.sh default/$agente:/home/go/entrypoint.sh
    echo "Changing permissions to entrypoint.sh"
    kubectl --namespace=default exec $agente chmod +x /home/go/entrypoint.sh
    echo "Executing entrypoint.sh"
    kubectl --namespace=default exec $agente /home/go/entrypoint.sh
    echo "copying GoCD config file to Server Pod"
    