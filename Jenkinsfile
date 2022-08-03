pipeline { 
    environment { 
        registry = "docsearce/doc-application" 
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
                  sh 'docker build -t doc-application + ":$BUILD_NUMBER" + ./' 
            } 
        }
         
    }
}
