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
                    dockerImage = docker.build("${registry}:${env.BUILD_ID}")
                }
            } 
        }
        stage('Deploy our image') { 
            steps { 
                script { 
                      docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                            dockerImage.push("${env.BUILD_ID}")
                    }
                } 
            }
        } 
         stage('Deploy to GKE test cluster') {
             
            steps{
                echo "Deployment started ..."
                sh 'ls -ltr'
                sh 'pwd'
                sh "sed -i 's/doc-application:latest/doc-application:${env.BUILD_ID}/g' deployment.yaml"
                sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl'  
                sh './kubectl --help'
                
                echo "KubernetesEngineBuilder started ... ${PATH}"
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
        
        stage('List pods') {
    withKubeConfig([credentialsId: '<credential-id>',
                    caCertificate: '<ca-certificate>',
                    serverUrl: '<api-server-address>',
                    contextName: '<context-name>',
                    clusterName: '<cluster-name>',
                    namespace: '<namespace>'
                    ]) {
      sh 'kubectl get pods'
    }
  }
         
    }
}
