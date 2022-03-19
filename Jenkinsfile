pipeline {
      environment {
            dockerimagename = "mehdijebali/crud-front"
            dockerImage = ""
      }
      agent any
      tools {nodejs "node12"}
      stages {
            stage('Initialization') {
                  steps {
                        echo '**** Starting Pipeline Job ****'
                        

                  }
            }
            stage('Code Quality Check via SonarQube') {
                  steps {
                        script {
                        def scannerHome = tool 'sonarqube';
                              withSonarQubeEnv("sonarqube") {
                              sh "${tool("sonarqube")}/bin/sonar-scanner \
                              -Dsonar.projectKey=Frontend \
                              -Dsonar.sources=. \
                              -Dsonar.login=admin \
                              -Dsonar.password=admin \
                              -Dsonar.host.url=https://sonarqube.projectcloud.click/"
                              }
                        }                  
                  }
            }
            stage('Install Dependencies') {
                  steps {
                        echo '**** Install Dependencies ****'
                        sh 'npm install'
                  }
            }
            stage('Build js file') {
                  steps {
                        echo '**** Build js file ****'
                        sh 'npm run build'
                  }
            }
            stage('Release Docker Image') {
                  environment {
                        registryCredential = 'docker_mehdi'
                  }
                  steps {
                        echo '**** Build Docker Image ****'
                        script{
                              dockerImage = docker.build dockerimagename
                              docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) 
                              {dockerImage.push("latest")}
                        }
                  }
            }
            stage('Deploy to k8s') {
                  steps {
                        echo '**** Deploy Application ****'
                        withCredentials([ string(credentialsId: 'k8s_mehdi', variable: 'api_token') ]) { sh 'kubectl --token $api_token --server https://192.168.49.2:8443/ --insecure-skip-tls-verify=true apply -f ./K8s '}
                  }
            }
      }
}