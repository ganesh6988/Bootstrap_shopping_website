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
                bat 'docker build -t frontend-app:latest .'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo '🔵 Running Docker container...'
                bat 'docker stop frontend-container || exit 0'
                bat 'docker rm frontend-container || exit 0'
                bat 'docker run -d --name frontend-container -p 5050:80 frontend-app:latest'
            }
        }

        stage('Done') {
            steps {
                echo '✅ Website should be available at http://localhost:5050'
            }
        }
    }
}
