
pipeline {
    agent {
        node {
            label 'maven'
        }
    }

environment {
    PATH = "/opt/apache-maven-3.9.11/bin:$PATH"
    AWS_REGION = "ap-south-1"
    ECR_ACCOUNT = "882961642803"
    ECR_REPO = "ttrend"
}

    stages {
        stage('build') {
            steps {
                sh 'mvn clean deploy'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn surefire-report:report'
            }
        }


        stage('Checking AWS Crde'){
            steps{
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh '''
                        echo "Checking AWS credentials..."
                        aws sts get-caller-identity
                    '''
                }
            }
        }


        stage('Docker Build & publish'){
            steps{
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}"){
                    sh '''
                        echo "Logging into AWS ECR..."
                        aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com
                        
                        echo 'Building Docker image...'
                        docker build -t ${ECR_REPO} .

                        echo 'Tagging Docker image...'
                        docker tag ${ECR_REPO}:latest ${ECR_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:latest
                        
                        echo 'Pushing Docker image...'
                        docker push ${ECR_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:latest
                    '''
                }
            }
        }



    }
}
