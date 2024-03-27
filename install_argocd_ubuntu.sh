#!/bin/bash

# Download ArgoCD manifests
mkdir argocd
cd argocd
wget https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Apply the ArgoCD manifests
kubectl apply -f install.yaml

# Wait for ArgoCD to be ready
kubectl wait --for=condition=Available deployment -l "app.kubernetes.io/name=argocd-server" --timeout=300s

# Get ArgoCD server URL
ARGOCD_SERVER_URL=$(kubectl get svc argocd-server -n argocd -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo "ArgoCD is now installed and running."
echo "You can access the ArgoCD web UI at: http://${ARGOCD_SERVER_URL}"
echo "Login credentials are typically username: admin, and password: the password is auto-generated, you can retrieve it using kubectl"
