pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile.worker'
            dir 'files'
        }
    }
    stages {
        stage('Provision instances') {
            steps {
                sh 'ls -hal'
            }
        }
    }
}