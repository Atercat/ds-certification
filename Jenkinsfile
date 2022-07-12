pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            dir 'build'
        }
    }
    stages {
        stage('Provision instances') {
            steps {
                dir('/git') {
                    checkout scm
                }
                sh 'ls -halR /git'
            }
        }
    }
}