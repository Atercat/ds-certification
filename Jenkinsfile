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
                git branch: 'dev', url: 'https://github.com/Atercat/ds-certification.git'
                sh 'ls -hal'
            }
        }
    }
}