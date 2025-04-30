pipeline {
    agent any

    environment {
        IMAGE_NAME = 'shopping:latest'
        DOCKER_PORTS = '5050:80'
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
            sh '''
                if [ -f Dockerfile ]; then
                    docker build -t $IMAGE_NAME .
                else
                    echo "🔴 Dockerfile not found in workspace root."
                    exit 1
                fi
            '''
        }
    }
}

        stage('Run Container') {
            steps {
                script {
                    echo '🔵 Running Docker container...'
                    sh '''
                        docker stop shopping || echo 🔵 No existing container to stop.
                        docker rm shopping || echo 🔵 No existing container to remove.
                        docker run -d -p %DOCKER_PORTS% --name shopping %IMAGE_NAME%
                    '''
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        echo '🔵 Logging into Docker Hub and pushing image...'
                        sh '''
                            echo %DOCKER_PASS% | docker login --username %DOCKER_USER% --password-stdin
                            docker tag %IMAGE_NAME% %DOCKER_USER%/shopping:latest
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
