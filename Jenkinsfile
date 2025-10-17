pipeline {
  agent any
  environment {
    REPO = "<DOCKERHUB_REPO>" // replace in job or set via env
    K8S_NAMESPACE = "demo-microservices"
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Build images') {
      steps {
        sh '''
          docker --version || true
          docker build -t ${REPO}/service-a:latest ./service-a
          docker build -t ${REPO}/service-b:latest ./service-b
        '''
      }
    }
    stage('Push images') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker push ${REPO}/service-a:latest
            docker push ${REPO}/service-b:latest
          '''
        }
      }
    }
    stage('Deploy to Kubernetes') {
      steps {
        // assumes kubectl configured on agent (or provide kubeconfig credential)
        sh '''
          kubectl apply -f k8s/namespace.yaml
          kubectl apply -f k8s/service-b-deployment.yaml
          kubectl apply -f k8s/service-a-deployment.yaml
          # update images
          kubectl -n ${K8S_NAMESPACE} set image deployment/service-a service-a=${REPO}/service-a:latest
          kubectl -n ${K8S_NAMESPACE} set image deployment/service-b service-b=${REPO}/service-b:latest
        '''
      }
    }
  }
  post {
    success { echo "Deployment completed." }
    failure { echo "Pipeline failed." }
  }
}
