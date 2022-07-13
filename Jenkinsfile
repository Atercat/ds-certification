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
                            script: 'terraform output ip',
                            returnStdout: true
                        ).trim()
                    }
                    sh 'echo ${BUILDER_IP}'
                    sh 'terraform output ip'
                    sh 'terraform output -raw ip'
                }
            }
        }
        stage('The Builder instance setting') {
            steps {
                sh 'echo ${BUILDER_IP}'
                sshagent(['wsl']) {
                    sh 'echo ${BUILDER_IP}'
                    ansiblePlaybook disableHostKeyChecking: true, extras: '-vvv -e BUILDER_IP=${BUILDER_IP}', playbook: 'ansible/main.yaml'
                }
            }
        }
    }
}