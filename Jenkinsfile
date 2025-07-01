pipeline {
    agent any

    options {
        timestamps()
        skipDefaultCheckout()
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Cloning GitHub repo...'
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                echo 'Initializing Terraform...'
                sh '''
                    terraform init -input=false
                '''
            }
        }

        stage('Terraform Format') {
            steps {
                echo 'Checking Terraform formatting...'
                sh 'terraform fmt -recursive -check'
            }
        }

        stage('Terraform Validate') {
            steps {
                echo 'Validating Terraform code...'
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                echo 'Planning infrastructure changes...'
                sh 'terraform plan -out=tfplan -input=false'
            }
        }

        stage('Terraform Apply') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Approve apply?', ok: 'Apply'
                echo 'Applying infrastructure changes...'
                sh 'terraform apply -input=false tfplan'
            }
        }
    }

    post {
        success {
            echo 'Terraform pipeline completed.'
        }
        failure {
            echo 'Something went wrong.'
        }
        cleanup {
            deleteDir()
        }
    }
}
