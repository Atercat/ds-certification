pipeline {
    parameters {
        string(
			name: 'OS_USERNAME',
            trim: true,
            description: 'OpenStack user name'
		)
        string(
			name: 'OS_PASSWORD',
			trim: true,
			description: 'OpenStack password'
		)
        string(
			name: 'OS_PROJECT_ID',
			trim: true,
			description: 'OpenStack project ID'
		)
        string(
			name: 'DOCKER_REGISTRY',
			defaultValue: 'https://index.docker.io/v1/',
			trim: true,
			description: 'Docker registry URL'
		)
    }
    agent {
        dockerfile {
            filename 'Dockerfile.agent'
            dir 'files'
            // Using a terraform repository mirror instead of the blocked Hashicorp
            args '-v ${WORKSPACE}/files/.terraformrc:/home/jenkins/.terraformrc'
        }
    }
    stages {
        stage('Provision instances') {
            steps {
                dir('terraform') {
                    sh '''
                        terraform init &&
                        terraform plan &&
                        terraform apply -auto-approve
                    '''
                    script {
                        env.BUILDER_IP = sh returnStdout: true,
                            script: 'terraform output -raw builder_ip'
                        env.RUNNER_IP = sh returnStdout: true,
                            script: 'terraform output -raw runner_ip'
                    }
                }
            }
        }
        stage('Instances setting') {
            environment {
                REPO_CREDS = credentials('docker')
            }
            steps {
                sshagent(['wsl']) {
                    ansiblePlaybook playbook: 'ansible/main.yaml',
                        disableHostKeyChecking: true,
                        extras: '-vvv -e BUILDER_IP=${BUILDER_IP} -e RUNNER_IP=${RUNNER_IP} -e DOCKER_REGISTRY=${DOCKER_REGISTRY} -e DOCKER_USER=${REPO_CREDS_USR} -e DOCKER_PASSWORD=${REPO_CREDS_PSW}'
                }
            }
        }
    }
}