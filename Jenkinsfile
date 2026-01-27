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
                dir('terraform_expressions') {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform_expressions') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform_expressions') {
                    sh 'terraform plan -out=tfplan -input=false'
                }
            }
        }

        stage('Approval') {
            steps {
                script {
                    timeout(time: 30, unit: 'MINUTES') {
                        input message: 'Do you want to proceed with Terraform Apply?', ok: 'Yes, Apply'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform_expressions') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Destroy Approval') {
            steps {
                script {
                    timeout(time: 30, unit: 'MINUTES') {
                        input message: 'Do you want to proceed with Terraform Destroy?', ok: 'Yes, Destroy'
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                dir('terraform_expressions') {
                    sh 'terraform destroy -auto-approve'
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
