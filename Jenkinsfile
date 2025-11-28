
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

        stage('Jar Published') {
            steps {
                script{
                    echo '<--------------- Jar Publish Started --------------->'
                    // 1. Get AWS CodeArtifact Auth Token
                    def token = sh(
                    script: """
                    aws codeartifact get-authorization-token \
                    --domain test \
                    --domain-owner 882961642803 \
                    --region ap-south-1 \
                    --query authorizationToken \
                    --output text
                    """,
                    returnStdout: true
                    ).trim()

                    // 2. Generate Maven settings.xml dynamically
                    writeFile file: 'settings.xml', text: """
                    <settings>
                        <servers>
                            <server>
                                <id>codeartifact</id>
                                <username>aws</username>
                                <password>${token}</password>
                            </server>
                        </servers>
                    </settings>
                    """
                    
                    // 3. Deploy JAR to AWS CodeArtifact
                    sh """
                    mvn deploy \
                    -DaltDeploymentRepository=codeartifact::default::https://882961642803.d.codeartifact.ap-south-1.amazonaws.com/maven/devops-artifacts/ \
                    --settings settings.xml
                    """
                }
            } 
        }   

    }
}

