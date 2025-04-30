pipeline {
    agent any

    environment {
        IMAGE_NAME = 'frontend-app'
        CONTAINER_NAME = 'frontend-app-container'
        DOCKERHUB_REPO = 'frontend-app' // Your repo name on Docker Hub
    }
     agent any

    stages {
        stage('Check Docker') {
            steps {
                script {
                    sh 'docker --version'
                }
            }
        }
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
                script {
                    echo '🔵 Building Docker image...'
                    sh "docker build -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Stop Previous Container') {
            steps {
                script {
                    echo '🛑 Stopping existing container if running...'
                    sh """
                        docker ps -q --filter "name=${CONTAINER_NAME}" | grep -q . && \
                        docker stop ${CONTAINER_NAME} && docker rm ${CONTAINER_NAME} || echo 'No container to stop'
                    """
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    echo '🚀 Running new Docker container...'
                    sh "docker run -d -p 5050:80 --name ${CONTAINER_NAME} ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        echo '📤 Logging into Docker Hub and pushing image...'
                        sh '''
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker tag frontend-app:latest $DOCKER_USER/${DOCKERHUB_REPO}:latest
                            docker push $DOCKER_USER/${DOCKERHUB_REPO}:latest
                        '''
                    }
                }
            }
        }

        stage('Done') {
            steps {
                echo '✅ Build, Run, and Push Complete!'
            }
        }
    }
}
