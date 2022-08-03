pipeline { 
    environment { 
        registry = "docsearce/poc" 
        registryCredential = 'docsearce' 
        dockerImage = '' 
    }
    agent any 
    stages { 
        stage('Cloning our Git') { 
            steps { 
                git branch: 'master', url:'https://github.com/dc-searce/doc-application.git' 
            }
        } 
        stage('Building our image') { 
            steps { 
                sh '''
                docker version
                docker info
                docker compose info
                curl --version
                jq --version
                '''
            } 
        }
         
    }
}
