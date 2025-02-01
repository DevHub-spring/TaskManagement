pipeline {
    agent any
    tools{
        jdk 'jdk21'
        maven 'maven3'
    }

    stages {
        stage('Git Checkout') {
            steps {
              git branch: 'main', credentialsId: 'jenkins pipeline authentication ', url: 'https://github.com/DevHub-spring/TaskManagement.git'
            }
        }
         stage('Maven Compile') {
            steps {
                bat 'mvn clean compile'
            }
        }
        stage('OWASP Scan Dependency Check') {
            steps {
                dependencyCheck additionalArguments: ' --scan ./',odcInstallation: 'DP'
                    dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage('Build Application'){
            steps{
                bat 'mvn clean install -DskipTests'
            }
        }
        stage('Build Docker Image')
        {
            steps{
                script{
                    bat 'docker build -t saikrishna2320/task-management:latest .'
                }
            }
        }
        stage('Push Docker Image To Hub')
        {
            steps{
                 script {
                     withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerCreds')]) {
                        bat 'docker login -u saikrishna2320 -p %dockerCreds%'
                        bat 'docker tag saikrishna2320/task-management saikrishna2320/task-management:v1'
                        bat 'docker push saikrishna2320/task-management:latest'
                    }
                }
            }
        }
    }
}
