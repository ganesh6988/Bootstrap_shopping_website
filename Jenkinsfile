pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/ganesh6988/Bootstrap_shopping_website'
        BRANCH = 'main'
        IMAGE_NAME = 'bootstrap_website_image'
        CONTAINER_NAME = 'bootstrap_container'
        HOST_PORT = '8087'
        CONTAINER_PORT = '80'
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning GitHub repo...'
                git branch: "${BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Stop Previous Container') {
            steps {
                echo 'Stopping existing container if running...'
                sh "docker rm -f ${CONTAINER_NAME} || true"
            }
        }

        stage('Run New Container') {
            steps {
                echo 'Running new container...'
                sh "docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}"
            }
        }

        stage('Verify Container') {
            steps {
                echo 'Verifying container is running...'
                sh 'docker ps'
            }
        }
    }

    post {
        success {
            echo '✅ Deployment complete. Site should be live at http://localhost:8087'
        }
        failure {
            echo '❌ Build or deployment failed.'
        }
    }
}
