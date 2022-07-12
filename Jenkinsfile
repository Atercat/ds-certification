pipeline {
    parameters {
        string(name: "OS_USERNAME", trim: true, description: "OpenStack user name")
        string(name: "OS_PASSWORD", trim: true, description: "OpenStack password")
        string(name: "OS_PROJECT_ID", trim: true, description: "OpenStack project ID")
    }
    environment {
        HOME = '/var/lib/jenkins/workspace/ds-certification/files'
    }
    agent {
        dockerfile {
            filename 'Dockerfile.worker'
            dir 'files'
        }
    }
    stages {
        stage('Provision instances') {
            steps {
                sh 'echo ${WORKSPACE}' // debug line
                dir('terraform') {
                    sh 'terraform init && terraform plan && terraform apply -auto-approve'
                }
            }
        }
    }
}