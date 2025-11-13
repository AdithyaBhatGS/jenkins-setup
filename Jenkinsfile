pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['plan', 'apply', 'destroy'], description: 'Terraform action to perform')
    }

    environment {
        AWS_DEFAULT_REGION = "us-east-1"
    }

    stages {
        stage('Setup') {
            steps {
                script {
                    withCredentials([
                        usernamePassword(credentialsId: 'AWS_CREDENTIALS', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY'),
                        file(credentialsId: 'TFVARS_FILE', variable: 'TFVARS_PATH')
                    ]) {
                        sh '''
                            terraform init -input=false
                            terraform fmt -check
                            terraform validate
                        '''
                    }
                }
            }
        }

        stage('Terraform Plan / Apply / Destroy') {
            steps {
                script {
                    if (params.ACTION == 'plan') {
                        sh 'terraform plan -var-file=$TFVARS_PATH'
                    } else if (params.ACTION == 'apply') {
                        input(message: "Do you want to apply these changes?", ok: "Apply")
                        sh 'terraform apply -auto-approve -var-file=$TFVARS_PATH'
                    } else if (params.ACTION == 'destroy') {
                        input(message: "Are you sure you want to destroy the infrastructure?", ok: "Destroy")
                        sh 'terraform destroy -auto-approve -var-file=$TFVARS_PATH'
                    }
                }
            }
        }
    }

    post {
        always {
            echo "✅ Terraform ${params.ACTION} stage completed."
        }
    }
}
