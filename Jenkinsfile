pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('b93a9ca9-18e7-4cdc-b3ed-ab1eeca5e21f')
        IMAGE_NAME = 'ganesh6988/shoppingwebsite'
        CONTAINER_NAME = 'shopping_container'
        HOST_PORT = '8082'
        CONTAINER_PORT = '80'
    }

    stages {
        stage('Clone Repository') {
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

        stage('Stop & Remove Old Container') {
            steps {
                echo '🧹 Stopping and removing old container (if any)...'
                sh '''
                    docker stop $CONTAINER_NAME || true
                    docker rm $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run New Container') {
            steps {
                echo '🚀 Running new container...'
                sh 'docker run -d -p $HOST_PORT:$CONTAINER_PORT --name $CONTAINER_NAME $IMAGE_NAME:latest'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo '📤 Pushing Docker image to Docker Hub...'
                sh '''
                    echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
                    docker push $IMAGE_NAME:latest
                '''
            }
        }

        stage('Completed') {
            steps {
                echo '✅ Deployment completed successfully!'
            }
        }
    }

    post {
        failure {
            echo '❌ Build failed. Please check the error logs above.'
        }
        always {
            echo '🧼 Final cleanup check (only if container exists)...'
        }
    }
}
