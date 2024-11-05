pipeline {
    agent any
    stages {
             stages {
                    stage('Checkout') {
                        steps {
                            echo 'Checking out code...'
                            git branch: 'farah',
                            url: 'https://github.com/zahra2111/Devops_5DS5_2024.git'
                        }
                    }
             stage('Build') {
                  steps {
                      sh 'mvn install -Dmaven.test.skip=true'
                  }
             }
      


                 }

                 post {
                     success {
                         echo 'Build finished successfully!'
                     }
                     failure {
                         echo 'Build failed!'
                     }
                 }


}