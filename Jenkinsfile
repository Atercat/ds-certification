pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            dir 'build'
            label 'myboxfuse-docker-agent'
            additionalBuildArgs  '--build-arg TERRAFORM=https://hashicorp-releases.website.yandexcloud.net/terraform/1.1.9/terraform_1.1.9_linux_amd64.zip'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    stage('Provision instances') {
        steps {
            sh 'echo "test"'
            sh 'touch testfile'
        }
    }
}