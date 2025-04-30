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

        stage('Run Docker Container') {
            steps {
                echo '🔵 Running Docker container...'
                sh 'docker stop frontend-container || true'
                sh 'docker rm frontend-container || true'
                sh 'docker run -d --name frontend-container -p 5050:80 frontend-app:latest'
            }
        }

        stage('Done') {
            steps {
                echo '✅ Website should be available at http://localhost:5050'
            }
        }
    }
}
