
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



        stage('Docker Build & publish'){
            steps{
                withAWS(credentials: 'aws-creds', region: 'ap-south-1') {
                    sh 'aws sts get-caller-identity'
                }

            }
        }
    }
}
