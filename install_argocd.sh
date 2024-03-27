#!/bin/bash

# Install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for ArgoCD components to be ready
kubectl wait --for=condition=Available deployment -l 'app.kubernetes.io/name=argocd-server' -n argocd --timeout=300s

# Print ArgoCD server URL and credentials
echo "ArgoCD is installed and running."
echo "You can access the ArgoCD web UI using the following URL:"
echo "http://$(kubectl get svc argocd-server -n argocd -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')"

echo "Login credentials:"
echo "Username: admin"
echo "Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o=jsonpath='{.data.password}' | base64 -d)"
