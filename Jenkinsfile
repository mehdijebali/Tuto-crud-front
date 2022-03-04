pipeline {
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
            // stage('Build Docker Image') {
                  // steps {
                        // echo '**** Build Docker Image ****'
                  // }
            // }
      }
}