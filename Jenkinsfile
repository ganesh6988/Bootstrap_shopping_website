pipeline {
    agent any

    environment {
        IMAGE_NAME = 'davincitones/bootstrap'
        CONTAINER_NAME = 'shopping-website'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/ganesh6988/Bootstrap_shopping_website.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Stop Existing Container') {
            steps {
                script {
                    sh '''
                    docker stop $CONTAINER_NAME || true
                    docker rm $CONTAINER_NAME || true
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh 'docker run -d -p 80:80 --name $CONTAINER_NAME $IMAGE_NAME'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment Successful'
        }
        failure {
            echo '❌ Build Failed'
        }
    }
}
