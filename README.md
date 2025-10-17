# containerized-microservices-local-k8s
# Local Kubernetes Microservices (sample)

This sample demonstrates:
- Two simple Python microservices (`service-a`, `service-b`)
- Containerized with Docker
- Deployed to a local Kubernetes cluster (kind / minikube / local k8s)
- Jenkins pipeline to build, push/load images and deploy to kubernetes

## Options to run locally

### Using kind (recommended for CI)
1. Install `kind` and `kubectl`.
2. Create a cluster:
   ```bash
   kind create cluster --name demo
