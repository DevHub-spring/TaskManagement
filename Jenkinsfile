pipeline {
    agent any
    tools {
        jdk 'jdk21'
        maven 'maven3'
    }
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', credentialsId: 'jenkins pipeline authentication', url: 'https://github.com/DevHub-spring/TaskManagement.git'
            }
        }
        stage('Maven Compile') {
            steps {
                sh 'mvn clean compile'
            }
        }
        stage('OWASP Scan Dependency Check') {
            steps {
                dependencyCheck additionalArguments: ' --scan ./', odcInstallation: 'DP'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage('Build Application') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
        }
        stage('Test Docker'){
        steps{
            sh 'docker --version'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t saikrishna2320/task-management:latest .'
                }
            }
        }
        stage('Docker Images'){
            steps{
                script{
                    sh 'docker images'
                }
            }
        }
        stage('Push Docker Image To Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerCreds')]) {
                        sh 'echo $dockerCreds | docker login -u saikrishna2320 --password-stdin'
                        sh 'docker tag saikrishna2320/task-management saikrishna2320/task-management:v1'
                        sh 'docker push saikrishna2320/task-management:latest'
                    }
                }
            }
        }
    }
}
