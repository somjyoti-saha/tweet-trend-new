
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

        stage('SonarQube Analysis') {
            environment {
            scannerHome = tool 'SonarQube-Scanner01'
            }
            steps {
                withSonarQubeEnv('SonarQube-Server01') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
    }
}

