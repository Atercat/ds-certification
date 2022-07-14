pipeline {
    parameters {
        string(
			name: 'OS_USERNAME',
            trim: true,
            description: 'OpenStack user name',
		)
        password(
			name: 'OS_PASSWORD',
			description: 'OpenStack password',
		)
        string(
			name: 'OS_PROJECT_ID',
			trim: true,
			description: 'OpenStack project ID',
		)
        string(
			name: 'KEY_NAME',
			trim: true,
			description: 'Cloud SSH-key name',
		)
        credentials(
            name: 'KEY_PAIR',
            defaultValue: '',
            credentialType: 'com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey',
			description: 'Key pair credential corresponding to the KEY_NAME parameter',
            required: true
        )
        string(
			name: 'DOCKER_REGISTRY',
			defaultValue: 'https://index.docker.io/v1/',
			trim: true,
			description: 'Docker registry URL'
		)
        credentials(
            name: 'REGISTRY_CRED',
            defaultValue: '',
            credentialType: 'com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl',
			description: 'Docker registry credentials',
            required: true
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
                        terraform plan -var "key_name=${KEY_NAME}" -out=slyplan &&
                        terraform apply -auto-approve slyplan 
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
            steps {
                script {
                    withCredentials([
                        usernamePassword(
                            credentialsId: params.REGISTRY_CRED,
                            usernameVariable: 'REPO_CRED_USR',
                            passwordVariable: 'REPO_CRED_PSW'
                        )
                    ])
                    {
                        sshagent([params.KEY_PAIR]) {
                            ansiblePlaybook playbook: 'ansible/main.yaml',
                                disableHostKeyChecking: true,
                                extras: '''
                                    -e BUILDER_IP=${BUILDER_IP}
                                    -e RUNNER_IP=${RUNNER_IP}
                                    -e DOCKER_REGISTRY=${DOCKER_REGISTRY}
                                    -e DOCKER_USER=${REPO_CRED_USR}
                                    -e DOCKER_PASSWORD=${REPO_CRED_PSW}
                                '''
                        }
                    }
                }
            }
        }
    }
}