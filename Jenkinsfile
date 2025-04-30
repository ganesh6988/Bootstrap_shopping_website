pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('b93a9ca9-18e7-4cdc-b3ed-ab1eeca5e21f') // Replace with your Jenkins credentials ID
        IMAGE_NAME = 'ganesh6988/shoppingwebsite'
    }

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
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Run Container') {
            steps {
                echo '🟢 Running Docker container...'
                sh 'docker run -d -p 8085:80 --name shopping_container $IMAGE_NAME:latest'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo '🟡 Pushing Docker image to Docker Hub...'
                sh '''
                    echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
                    docker push $IMAGE_NAME:latest
                '''
            }
        }

        stage('Done') {
            steps {
                echo '✅ Pipeline completed!'
            }
        }
    }

    post {
        always {
            echo '🧹 Cleaning up...'
            sh '''
                docker stop shopping_container || true
                docker rm shopping_container || true
            '''
        }
    }
}
pipeline {
    agent any
    stages {
        stage('Test Docker') {
            steps {
                sh 'docker --version'
            }
        }
    }
}
