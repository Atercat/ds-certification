pipeline {
    parameters {
        string(name: "OS_USERNAME", trim: true, description: "OpenStack user name")
        string(name: "OS_PASSWORD", trim: true, description: "OpenStack password")
        string(name: "OS_PROJECT_ID", trim: true, description: "OpenStack project ID")
    }
    agent {
        dockerfile {
            filename 'Dockerfile.agent'
            dir 'files'
            args '-v ./files/.terraformrc:/home/jenkins/.terraformrc'
        }
    }
    stages {
        stage('Provision a builder instance') {
            steps {
                dir('terraform') {
                    sh '''
                        terraform init &&
                        terraform plan &&
                        terraform apply -auto-approve
                    '''
                    script {
                        env.BUILDER_IP = sh returnStdout: true,
                            script: 'terraform output -raw ip'
                    }
                }
            }
        }
        stage('The Builder instance setting') {
            steps {
                sshagent(['wsl-work']) {
                    ansiblePlaybook playbook: 'ansible/main.yaml',
                        disableHostKeyChecking: true,
                        extras: '-e BUILDER_IP=${BUILDER_IP}'
                }
            }
        }
    }
}