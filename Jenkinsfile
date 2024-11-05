pipeline {
    agent any

      environment {
            SONARQUBE_ENV = 'SonarQube'  // SonarQube environment name
            NEXUS_CREDENTIALS_ID = 'deploymentRepo'  // Nexus credentials ID in Jenkins




        DOCKER_CREDENTIALS = credentials ('docker-hub-credentials')
                RELEASE_VERSION = "1.0"
                registry = "farahw/gestion-station-ski"
                registryCredential = 'docker-hub-credentials'
                dockerImage = ''
                IMAGE_TAG = "${RELEASE_VERSION}-${env.BUILD_NUMBER}"


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

                 stage('Deploy to Nexus') {
                          steps {
                              sh "mvn deploy -Dmaven.test.skip=true -DaltDeploymentRepository=deploymentRepo::default::http://192.168.33.10:8081/repository/maven-releases/"
                          }
                      }
             stage('Build Image') {
                   steps {
                       script {
                           dockerImage = docker.build "${registry}:${IMAGE_TAG}"

                               }
                           }
                       }
               stage('Login To Docker') {
                   steps {
                       script {
                           withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                           sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                                             }
                                         }
                          }
                   }
               stage('Push to DockerHub') {
                  steps {
                      script {
                          sh "docker push ${dockerImage.imageName()}"
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
