pipeline {
    agent any

    environment {
        IMAGE_NAME = 'shopping-website'
        CONTAINER_NAME = 'shopping-website-container'
        HOST_PORT = '8089'
        CONTAINER_PORT = '80'
    }

    stages {
        stage('Docker Cleanup') {
            steps {
                bat '''
                docker stop %CONTAINER_NAME% || echo Container not running
                docker rm %CONTAINER_NAME% || echo No container to remove
                docker rmi -f %IMAGE_NAME% || echo No image to remove
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Run Docker Container') {
            steps {
                bat '''
                timeout /t 3 /nobreak
                docker run -d -p %HOST_PORT%:%CONTAINER_PORT% --name %CONTAINER_NAME% %IMAGE_NAME%
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'Dockerhub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat '''
                        docker login -u %DOCKER_USER% -p %DOCKER_PASS%
                        docker tag %IMAGE_NAME% %DOCKER_USER%/%IMAGE_NAME%
                        docker push %DOCKER_USER%/%IMAGE_NAME%
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Website updated and deployed via Docker.'
        }
        failure {
            echo '❌ Deployment failed. Check logs.'
        }
    }
}
