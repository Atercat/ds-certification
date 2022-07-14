pipeline {
    parameters {
        choice(
            name: "PROVIDER",
            choices: ["vk", "yandex"],
            description: "The cloud provider to build an infrastructure on"
        )
        string(
			name: 'APP_GIT',
			defaultValue: 'https://github.com/boxfuse/boxfuse-sample-java-war-hello.git',
			trim: true,
			description: 'Application source code Git repository'
		)
        string(
			name: 'OS_USERNAME',
            trim: true,
            description: 'OpenStack user name (for VK)',
		)
        password(
			name: 'OS_PASSWORD',
			description: 'OpenStack password (for VK)',
		)
        string(
			name: 'OS_PROJECT_ID',
			trim: true,
			description: 'OpenStack project ID (for VK)',
		)
        string(
			name: 'YC_CLOUD_ID',
            trim: true,
            description: 'Yandex cloud ID (yc config list)',
		)
        string(
			name: 'YC_FOLDER_ID',
			trim: true,
            description: 'Yandex folder ID',
		)
        password(
			name: 'YC_TOKEN',
            description: 'Yandex OAuth token',
		)
        string(
			name: 'KEY_NAME',
            defaultValue: 'my_key',
			trim: true,
			description: 'Existent cloud SSH-key name (for VK)',
		)
        credentials(
            name: 'KEY_PRIV',
            defaultValue: '',
            credentialType: 'com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey',
			description: 'Private SSH-key credential corresponding to the KEY_NAME parameter',
            required: true
        )
        string(
			name: 'KEY_PUB',
			defaultValue: 'ssh-rsa AAAA/ChangeMe',
			trim: true,
			description: 'Public SSH-key corresponding to the KEY_PRIV (for Yandex)'
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
        string(
			name: 'APP_IMAGE',
			defaultValue: 'atercat/myboxfuse',
			trim: true,
			description: 'App Docker image name: [registry/][username/]imagename[:tag]'
		)
        string(
			name: 'TERRAFORM_IMAGE',
			defaultValue: 'hashicorp/terraform:1.2.4',
			trim: true,
			description: 'Terraform Docker image name'
		)
        string(
			name: 'MAVEN_IMAGE',
			defaultValue: 'maven:3.6-openjdk-8',
			trim: true,
			description: 'Maven Docker image name'
		)
        string(
			name: 'TOMCAT_IMAGE',
			defaultValue: 'tomcat:9.0.63-jre8-openjdk-slim-buster',
			trim: true,
			description: 'Tomcat Docker image name'
		)
    }
    agent {
        dockerfile {
            filename 'Dockerfile.agent'
            dir 'files'
            // Using a terraform repository mirror instead of the blocked Hashicorp
            args '-v ${WORKSPACE}/files/.terraformrc:/home/jenkins/.terraformrc'
            additionalBuildArgs  '--build-arg IMAGE_NAME=${TERRAFORM_IMAGE}'
        }
    }
    stages {
        stage('Provision instances') {
            steps {
                dir('terraform') {
                    // As long as variables are not allowed in module source
                    // select particular module with a symbolic link
                    sh 'rm -f modules/provider && ln -s modules/${PROVIDER} provider'
                    sh '''
                        terraform init &&
                        terraform plan \
                            -var "key_name=${KEY_NAME}" \
                            -var "pub_key=${KEY_PUB}" \
                            -out=slyplan &&
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
                        sshagent([params.KEY_PRIV]) {
                            ansiblePlaybook playbook: 'ansible/main.yaml',
                                disableHostKeyChecking: true,
                                extras: '''
                                    -e BUILDER_IP=${BUILDER_IP}
                                    -e RUNNER_IP=${RUNNER_IP}
                                    -e DOCKER_REGISTRY=${DOCKER_REGISTRY}
                                    -e DOCKER_USER=${REPO_CRED_USR}
                                    -e DOCKER_PASSWORD=${REPO_CRED_PSW}
                                    -e MAVEN_IMAGE=${MAVEN_IMAGE}
                                    -e TOMCAT_IMAGE=${TOMCAT_IMAGE}
                                    -e APP_IMAGE=${APP_IMAGE}
                                    -e APP_GIT=${APP_GIT}
                                '''
                        }
                    }
                }
            }
        }
    }
}