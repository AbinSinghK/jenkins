pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'us-east-1'
    }

    stages {
        stage('Checkout from SCM') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/AbinSinghK/Terraform.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('vpc_peering') {   // 👈 change to your Terraform folder name
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('vpc_peering') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('vpc_peering') {
                    sh 'terraform plan -out=tfplan -input=false'
                }
            }
        }

        stage('Approval') {
            steps {
                script {
                    input message: 'Do you want to proceed with Terraform Apply?', 
                          ok: 'Yes, Apply', 
                          timeout: 30, unit: 'MINUTES'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('vpc_peering') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Infrastructure created successfully in AWS!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs for errors.'
        }
    }
}
