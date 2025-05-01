pipeline {
    agent any

    environment {
        IMAGE_NAME = 'shoppingwebsite'
    }

    stages {
        stage('Check Docker Version') {
            steps {
                sh 'docker --version'
            }
        }

        stage('Clone') {
            steps {
                echo '🔵 Cloning repository...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🔨 Building Docker image...'
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Run Container') {
            steps {
                echo '🚀 Running Docker container...'
                sh '''
                    docker stop shopping_container || true
                    docker rm shopping_container || true
                    docker run -d -p 8082:80 --name shopping_container $IMAGE_NAME:latest
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo '📤 Pushing Docker image to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh '''
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker push $IMAGE_NAME:latest
                    '''
                }
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
            echo '🧹 Cleaning up Docker container (if running)...'
            sh '''
                docker stop shopping_container || true
                docker rm shopping_container || true
            '''
        }
    }
}
