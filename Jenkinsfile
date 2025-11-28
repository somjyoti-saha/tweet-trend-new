
pipeline {
    agent { label 'maven' }

    environment {
        PATH = "/opt/apache-maven-3.9.11/bin:$PATH"
    }

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean deploy'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn surefire-report:report'
            }
        }

    }
}

