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
                    git branch: 'dev', url: 'https://github.com/Atercat/ds-certification.git'
                }
                sh 'ls -halR /git'
            }
        }
    }
}