pipeline {
    agent any  // Define agent here (only once)

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
                sh 'docker run -d -p 5050:80 frontend-app:latest'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo '🔵 Pushing Docker image to Docker Hub...'
                sh '''
                    docker login --username $DOCKER_USER --password $DOCKER_PASS
                    docker tag frontend-app:latest $DOCKER_USER/frontend-app:latest
                    docker push $DOCKER_USER/frontend-app:latest
                '''
            }
        }

        stage('Done') {
            steps {
                echo '✅ Build, Run, and Push Complete!'
            }
        }
    }
}
