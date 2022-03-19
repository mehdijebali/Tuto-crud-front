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
                              -Dsonar.host.url=http://localhost:9000"
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
                        registryCredential = 'dockerhub'
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
                        sh 'git clone https://github.com/mehdijebali/Infrastructure-Tuto-crud.git'
                        script {
                              kubernetesDeploy (configs: "database-configmap.yml", kubeconfigId: "k8s")
                        }
                  }
            }
      }
}