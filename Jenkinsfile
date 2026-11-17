pipeline {
    agent any
 
    tools {
        terraform 'terraform-lab'
    }
 
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Apply or Destroy resources')
        string(name: 'ENV_NAME', defaultValue: 'staging', description: 'Target environment name')
    }
 
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
 
        stage('Init & Validate') {
            steps {
                sh 'terraform init -input=false'
                sh 'terraform validate'
            }
        }
 
        stage('Plan') {
            steps {
                script {
                    def destroyFlag = (params.ACTION == 'destroy') ? '-destroy' : ''
                    sh "terraform plan ${destroyFlag} -var=\"environment_name=${params.ENV_NAME}\" -out=tfplan -input=false"
                }
            }
        }
 
        stage('Approve') {
            steps {
                input message: "Approve Terraform ${params.ACTION} for ${params.ENV_NAME}?", ok: 'Proceed'
            }
        }
 
        stage('Execute') {
            steps {
                sh 'terraform apply -input=false tfplan'
            }
        }
    }
 
    post {
        always {
            sh 'rm -f tfplan'
        }
    }
}  