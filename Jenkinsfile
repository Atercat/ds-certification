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
                sh 'echo "test"'
                sh 'touch testfile'
            }
        }
    }
}