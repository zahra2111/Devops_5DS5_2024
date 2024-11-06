pipeline {
    agent any  
    
    //environment {
      //  DOCKER_HUB_CREDENTIALS = credentials('dockerhub-credentials')  // Identifiants DOCKER_HUB 
     //   NEXUS_CREDENTIALS = credentials('nexus-credentials')  // Identifiants Nexus
     // SONARQUBE_CREDENTIALS = credentials('sonarqube-credentials') // Identifiants SonarQube
    //}

    stages {
        
        stage('GIT') {
            steps {
                // Clonage du projet depuis le dépôt Git
                echo 'Récupération du code depuis Git...'
                git branch: 'Mariem_Djelassi_5DS5', url: 'https://github.com/zahra2111/Devops_5DS5_2024.git'
            }
        }
        
        stage('Maven Build') {
            steps {
                // Exécution de Maven pour nettoyer et compiler le projet
                echo 'Compilation du projet...'
                script {
                    sh 'mvn clean compile'
                }
            }
        }
        
        stage('SonarQube') {
            steps {
                echo 'Analyse de qualité du code avec SonarQube...'
                script {
                    withSonarQubeEnv('SonarQube') {  
                        sh 'mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=SonarQube.5DS5'
                    }
                }
            }
        }
        
        stage('JUNIT/MOCKITO') {
            steps {
                echo 'Exécution des tests unitaires avec JUnit...'
                script {
                    sh 'mvn test'
                    sh 'mvn clean package'
                }
            }
        }
        
        stage('Nexus') {
            steps {
                echo 'build: '
                sh 'mvn clean deploy -Dusername=admin -Dpassword=nexus -DskipTests'
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline exécuté avec succès!'
        }
        failure {
            echo 'Le pipeline a échoué, analysez les logs pour plus de détails.'
        }
    }
}
