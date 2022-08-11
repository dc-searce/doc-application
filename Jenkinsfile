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
                    sh "docker build -t ${registry}:${env.BUILD_ID} ."
                }
            } 
        }
        stage('Deploy our image') { 
            steps { 
                script { 
                     withCredentials( \
                                 [string(credentialsId: 'dockerhub',\
                                 variable: 'dockerhub')]) {
                        sh "docker login -u docsearce -p ${registryCredential}"
                    }
                    app.push("${env.BUILD_ID}")
                    // docker.withRegistry( '', registryCredential ) { 
                    //     dockerImage.push() 
                    // }
                } 
            }
        } 
         stage('Deploy to GKE cluster') {
            steps{
                sh "sed -i 's/doc-application:latest/doc-application:${BUILD_NUMBER}/g' deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', 
                    projectId: env.PROJECT_ID, 
                    clusterName: env.CLUSTER_NAME_TEST, 
                    location: env.LOCATION, 
                    manifestPattern: 'deployment.yaml', 
                    credentialsId: env.CREDENTIALS_ID, 
                    verifyDeployments: true
                ])
            }
        }
         
    }
}
