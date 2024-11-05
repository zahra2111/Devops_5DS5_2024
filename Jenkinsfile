pipeline {
    agent any

      environment {
            SONARQUBE_ENV = 'SonarQube'  // SonarQube environment name
            NEXUS_CREDENTIALS_ID = 'deploymentRepo'  // Nexus credentials ID in Jenkins

        }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                git branch: 'farah', url: 'https://github.com/zahra2111/Devops_5DS5_2024.git'
            }
        }
         stage('Clean') {
                    steps {
                        echo 'Cleaning the workspace...'
                        sh 'mvn clean'
                    }
                }
         stage('Test') {
                             steps {
                                 echo 'Running unit tests...'
                                 sh 'mvn test'
                             }
                         }


                stage('Package') {
                            steps {
                                echo 'Packaging the application...'
                                sh 'mvn package'
                            }
                        }

                stage('Build') {
                    steps {
                        echo 'Building the project...'
                        sh 'mvn install -Dmaven.test.skip=true'
                    }
                }


                stage('SonarQube Analysis') {
                    steps {
                        withSonarQubeEnv(SONARQUBE_ENV) {
                            sh 'mvn sonar:sonar -Dsonar.projectKey=sonar'
                        }
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
