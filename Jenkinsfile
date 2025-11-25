
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

        stage("Quality Gate"){
            steps{
                script{
                    timeout(time: 1, unit: 'HOURS') { // Just in case something goes wrong, pipeline will be killed after a timeout
                        def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }
        }
    }
}

