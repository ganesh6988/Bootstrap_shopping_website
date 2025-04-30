pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                echo '🔵 Cloning repository...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🔵 Building Docker image...'
                sh 'docker build -t frontend-app:latest .'
            }
        }

        stage('Run Container') {
            steps {
                echo '🔵 Running Docker container...'
                sh '''
                    docker rm -f frontend-container || true
                    docker run -d --name frontend-container -p 5050:80 frontend-app:latest
                '''
            }
        }

        stage('Done') {
            steps {
                echo '✅ Deployment Complete. Visit http://localhost:5050'
            }
        }
    }
}
