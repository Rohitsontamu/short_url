pipeline {
    agent any

    environment {
        AWS_REGION     = "ap-southeast-2"
        AWS_ACCOUNT_ID = "859867727599"
        ECR_REPO       = "short-url-app"
        IMAGE_URI      = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}"
        IMAGE_TAG      = "${BUILD_NUMBER}"
        APP_EC2_IP     = "54.66.56.201"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_URI}:${IMAGE_TAG} -t ${IMAGE_URI}:latest ."
            }
        }

        stage('Smoke Test Container') {
            steps {
                sh """
                    docker run -d --name test-app -p 5001:5000 ${IMAGE_URI}:${IMAGE_TAG}
                    sleep 5
                    curl -f http://localhost:5001/ || (docker logs test-app && exit 1)
                """
            }
            post {
                always {
                    sh "docker rm -f test-app || true"
                }
            }
        }

        stage('Push to AWS ECR') {
            steps {
                sh """
                    aws ecr get-login-password --region ${AWS_REGION} | \
                    docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                    docker push ${IMAGE_URI}:${IMAGE_TAG}
                    docker push ${IMAGE_URI}:latest
                """
            }
        }

        stage('Deploy to App EC2') {
            steps {
                sshagent(['app-ec2-ssh-key']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ubuntu@${APP_EC2_IP} '
                            aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                            docker pull ${IMAGE_URI}:${IMAGE_TAG}
                            docker stop short-url-app || true
                            docker rm short-url-app || true
                            docker run -d --name short-url-app --restart unless-stopped -p 5000:5000 -v /home/ubuntu/data:/app/data ${IMAGE_URI}:${IMAGE_TAG}
                        '
                    """
                }
            }
        }
    }

    post {
        always {
            sh "docker image prune -f || true"
        }
    }
}



