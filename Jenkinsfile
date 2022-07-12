pipeline {
    parameters {
        string(name: "OS_USERNAME", trim: true, description: "OpenStack user name")
        string(name: "OS_PASSWORD", trim: true, description: "OpenStack password")
        string(name: "OS_PROJECT_ID", trim: true, description: "OpenStack project ID")
    }
    environment {
        TF_CLI_CONFIG_FILE = 'files/terraform-mirror.tfrc'
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
                dir('terraform') {
                    sh 'terraform init && terraform plan && terraform apply -auto-approve'
                }
            }
        }
    }
}