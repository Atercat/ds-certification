pipeline {
    parameters {
        string(name: "OS_USERNAME", trim: true, description: "OpenStack user name")
        string(name: "OS_PASSWORD", trim: true, description: "OpenStack password")
        string(name: "OS_PROJECT_ID", trim: true, description: "OpenStack project ID")
    }
    agent {
        dockerfile {
            filename 'Dockerfile.worker'
            dir 'files'
            args '-e "HOME=${WORKSPACE}/files"'
        }
    }
    stages {
        stage('Provision a builder instance') {
            steps {
                dir('terraform') {
                    sh 'terraform init && terraform plan && terraform apply -auto-approve'
                    script {
                        BUILDER_IP = sh(
                            script: 'terraform output -raw ip',
                            returnStdout: true
                        )
                    }
                }
            }
        }
        stage('The Builder instance setting') {
            steps {
                sshagent(['wsl']) {
                    ansiblePlaybook disableHostKeyChecking: true, extras: '-vvv -e BUILDER_IP=${BUILDER_IP}', playbook: 'ansible/main.yaml'
                }
            }
        }
    }
}