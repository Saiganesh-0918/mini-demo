#!/bin/bash
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}===== KUBERNETES MINI DEMO DEPLOYMENT =====${NC}"
echo -e "${GREEN}Checking if Minikube is running...${NC}"
if ! minikube status | grep -q "host: Running"; then
    echo "Starting Minikube..."
    minikube start
else
    echo "Minikube is already running"
fi
echo -e "${GREEN}Configuring Docker to use Minikube's Docker daemon...${NC}"
eval $(minikube docker-env)
cd ~/mini-demo/app
docker build -t mini-demo:latest .
echo -e "${GREEN}Applying Kubernetes manifests...${NC}"
cd ~/mini-demo
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
echo -e "${GREEN}Waiting for deployment to be ready...${NC}"
kubectl -n mini-demo rollout status deployment/flask-app
echo -e "${GREEN}Getting application URL...${NC}"
minikube service flask-app -n mini-demo --url
