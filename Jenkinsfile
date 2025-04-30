pipeline {
    agent any
    stages {
        stage('Detect OS') {
            steps {
                
                bat 'ver' // Works only on Windows
            }
        }
    }
}

        stage('Build Docker Image') {
            steps {
                script {
                    echo '🔵 Building Docker image...'
                    bat 'docker build -t frontend-app:latest .'
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    echo '🔵 Running Docker container...'
                    bat 'docker run -d -p 5050:80 frontend-app:latest'
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
                            docker tag frontend-app:latest %DOCKER_USER%/frontend-app:latest
                            docker push %DOCKER_USER%/frontend-app:latest
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
