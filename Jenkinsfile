pipeline { 
    environment { 
        PROJECT_ID = 'clinic-to-cloud'
        LOCATION = 'us-central1'
        CREDENTIALS_ID = 'poc-searce'
        CLUSTER_NAME_TEST = 'poc-searce'
        registry = "docsearce/doc-application" 
        registryCredential = 'dockerhub' 
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
                script { 
                    app = docker.build(registry + ":$BUILD_NUMBER")
                }
            } 
        }
        stage('Deploy our image') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        app.push() 
                    }
                } 
            }
        } 
         stage('Deploy to GKE cluster') {
            steps{
                echo "Deployment started ..."
                sh "sed -i 's/doc-application:latest/doc-application:${BUILD_NUMBER}/g' deployment.yaml"
            }
        }
         
    }
}
