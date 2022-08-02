pipeline { 
    environment { 
        registry = "docsearce/poc" 
        registryCredential = 'docsearce' 
        dockerImage = '' 
        gitUrl =  'https://github.com/dc-searce/doc-application.git' 
    }
    agent any 
    stages { 
        stage('Cloning our Git') { 
            steps { 
                
                git branch: 'master', url:gitUrl
            }
        } 
        stage('Building our image') { 
            steps { 
                script { 
                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 
                }
            } 
        }
        stage('Deploy our image') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push() 
                    }
                } 
            }
        } 
        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        } 
    }
}