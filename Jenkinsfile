pipeline {
    agent any

    environment {
        IMAGE_NAME = 'ganesh6988/shoppingwebsite'
    }

    stages {
        stage('Clone') {
            steps {
                echo "🔵 Cloning repository..."
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "🔵 Building Docker image..."
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    echo "🔵 Running Docker container..."
                    sh 'docker run -d -p 8080:80 $IMAGE_NAME'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "🔵 Logging into Docker Hub..."
                    sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
                    echo "🔵 Pushing image to Docker Hub..."
                    sh 'docker push $IMAGE_NAME'
                }
            }
        }

        stage('Done') {
            steps {
                echo "✅ Pipeline completed successfully!"
            }
        }
    }
}
