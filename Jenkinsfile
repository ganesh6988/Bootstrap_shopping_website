pipeline {
    agent any

    environment {
        IMAGE_NAME = 'shoppingwebsite'
        CONTAINER_NAME = 'shopping_container'
        DOCKERHUB_USER = credentials('b93a9ca9-18e7-4cdc-b3ed-ab1eeca5e21f') // Replace with your actual Jenkins credentials ID
    }

    stages {
        stage('Check Docker Installation') {
            steps {
                echo '🔍 Checking Docker installation...'
                bat 'docker --version'
            }
        }

        stage('Clone Repository') {
            steps {
                echo '📥 Cloning source code from GitHub...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🔨 Building Docker image...'
                bat "docker build -t %IMAGE_NAME% ."
            }
        }

        stage('Stop & Remove Existing Container') {
            steps {
                echo '🧹 Cleaning up old Docker container (if exists)...'
                bat """
                docker stop %CONTAINER_NAME% || exit 0
                docker rm %CONTAINER_NAME% || exit 0
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                echo '🚀 Running Docker container...'
                bat "docker run -d -p 8082:80 --name %CONTAINER_NAME% %IMAGE_NAME%"
            }
        }

        stage('Push to Docker Hub (Optional)') {
            when {
                expression { return env.DOCKERHUB_USER != null }
            }
            steps {
                echo '📤 Pushing image to Docker Hub...'
                bat """
                echo %DOCKERHUB_USER_PSW% | docker login -u %DOCKERHUB_USER_USR% --password-stdin
                docker tag %IMAGE_NAME% %DOCKERHUB_USER_USR%/%IMAGE_NAME%
                docker push %DOCKERHUB_USER_USR%/%IMAGE_NAME%
                """
            }
        }

        stage('Done') {
            steps {
                echo '✅ Pipeline completed successfully!'
            }
        }
    }

    post {
        always {
            echo '📌 Post-build cleanup...'
        }
    }
}
