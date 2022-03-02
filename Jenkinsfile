pipeline {
      agent any
      tools {nodejs "node12"}
      stages {
            stage('Initialization') {
                  steps {
                        echo '**** Starting Pipeline Job ****'
                        

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