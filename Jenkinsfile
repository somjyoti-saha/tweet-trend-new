pipeline {
    agent {
        node {
            label 'maven'
        }
    }

environment {
    JAVA_HOME = "/usr/lib/jvm/java-17-openjdk-amd64"
    PATH = "${JAVA_HOME}/bin:/opt/apache-maven-3.9.11/bin:${PATH}"
}

    stages {
        stage('build') {
            steps {
                sh 'mvn clean deploy'
            }
        }
    }

    stage('SonarQube analysis') {
    environment{
        scannerHome = tool 'SonarQube-Scanner01'
    }
    steps{
    withSonarQubeEnv('SonarQube-Server01') { 
      sh "${scannerHome}/bin/sonar-scanner"
    }
    }

  }

}
