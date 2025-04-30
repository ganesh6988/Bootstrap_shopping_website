pipeline {
    agent any

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
                    bat 'docker build -t shopping:latest .'
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    echo '🔵 Running Docker container...'
                    bat 'docker run -d -p 5050:80 shopping:latest'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        echo '🔵 Logging into Docker Hub and pushing image...'
                        bat '''
                            echo %DOCKER_PASS% | docker login --username %DOCKER_USER% --password-stdin
                            docker tag shopping:latest %DOCKER_USER%/shopping:latest
                            docker push %DOCKER_USER%/shopping:latest
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