pipeline {
    agent any

    tools {
        maven 'Maven Apache'
        jdk 'Java17'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Herson2310/CapaKarateTCS1.git'
            }
        }

        stage('Build & Test') {
            steps {
                script {

                     bat 'mvn clean test -Dkarate.env=cert "-Dkarate.options=--tags @products"'

                }

            }
        }



        stage('Publish Report') {
            steps {
                publishHTML(target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'target/karate-reports',
                    reportFiles: 'karate-summary.html',
                    reportName: 'Karate Test Report'
                ])
            }
        }
    }

    post {
        always {
            // Publica resultados JUnit para verlos en Jenkins
            junit '**/target/surefire-reports/*.xml'
        }
        success {
            echo 'Todas las pruebas pasaron con éxito.'
        }
        failure {
            echo 'Hubo fallas en las pruebas. Revisar reportes.'
        }
    }
}