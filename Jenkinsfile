pipeline {
    agent {
        node {
            label 'maven'
        }
    }

environment {
    PATH = "/opt/apache-maven-3.9.11/bin:$PATH"
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

        stage('Docker Build & publish'){
            steps{
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}"){
                    sh '''
                    aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 882961642803.dkr.ecr.ap-south-1.amazonaws.com
                    docker build -t ttrend .
                    docker tag ttrend:latest 882961642803.dkr.ecr.ap-south-1.amazonaws.com/ttrend:latest
                    docker push 882961642803.dkr.ecr.ap-south-1.amazonaws.com/ttrend:latest
                    '''
                }
            }
        }



    }
}
