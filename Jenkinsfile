pipeline {
    agent any

    environment {
        IMAGE_NAME = 'saiganesh0918/flask-app'  // Docker Hub image name
        IMAGE_TAG = 'v1'  // Image version tag
        K8S_NAMESPACE = 'mini-demo-1'  // Kubernetes namespace
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Saiganesh-0918/mini-demo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '/bin/bash -c "docker build -t ${IMAGE_NAME}:latest -t ${IMAGE_NAME}:${IMAGE_TAG} -f app/Dockerfile app/"'
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub', url: '']) {
                    sh '/bin/bash -c "docker push ${IMAGE_NAME}:latest"'
                    sh '/bin/bash -c "docker push ${IMAGE_NAME}:${IMAGE_TAG}"'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '/bin/bash -c "kubectl apply -f k8s/deployment.yaml -n ${K8S_NAMESPACE}"'
                sh '/bin/bash -c "kubectl apply -f k8s/service.yaml -n ${K8S_NAMESPACE}"'
            }
        }
    }
}

