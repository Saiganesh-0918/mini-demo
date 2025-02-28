pipeline {
    agent any

    environment {
        IMAGE_NAME = "saiganesh0918/flask-app"
        K8S_NAMESPACE = "mini-demo1"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Saiganesh-0918/mini-demo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub', url: '']) {
                    sh 'docker push $IMAGE_NAME:latest'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml -n $K8S_NAMESPACE'
                sh 'kubectl apply -f k8s/service.yaml -n $K8S_NAMESPACE'
            }
        }
    }
}

