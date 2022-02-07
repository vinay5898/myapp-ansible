pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID = credentials('aws-account-id')
        AWS_DEFAULT_REGION = "ap-south-1" 
        IMAGE_REPO_NAME = "nodejsapp"
        IMAGE_TAG = "latest"
        PUB_IP = 
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
        NOTIFY_EVENT_TOKEN = credentials('notify-token')
    }
   


        stage('Skype Notification') {
            steps{
                script {
                    //sh "echo Notification Sent"
                    notifyEvents message: '$BUILD_TAG | Built successfully', token: "$NOTIFY_EVENT_TOKEN"
                }
            }
        }

        stage('Deploy to Machine') {
            agent { label "${env.node_name}" }
            steps {
                script {
                    sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                    sh "docker pull ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:version${env.BUILD_NUMBER}"
                    sh 'docker ps -q --filter "name=nodejsapp" | grep -q . && docker kill nodejsapp || echo No running nodejsapp containers'
                    sh "sleep 10"
                    sh "docker run --rm --name nodejsapp -d -p 1111:8080 ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:version${env.BUILD_NUMBER}"
                }
            }
        }

      
    }
}
