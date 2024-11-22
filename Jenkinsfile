pipeline{
    environment{
        DOCKERHUB_CRED = credentials("dockerhub_id")
        GITHUB_REPO_URL = 'https://github.com/KalyanRam1234/SPE_Final_Project.git'
        PATH = "/opt/homebrew/bin:$PATH" 
    }
    agent any
    stages{
        stage("Stage 1 : Git Clone"){
            steps{
                git branch : 'vikas', url : "${GITHUB_REPO_URL}"
            }
        }
        
        stage("Stage 2: Docker Compose Build") {
            steps {
                echo 'Building Docker containers...'
                sh 'docker-compose -p libraryapp build'
            }
        }
        
        stage("Stage 3 : Push to Dockerhub"){
            steps{
                sh 'echo $DOCKERHUB_CRED_PSW | docker login -u $DOCKERHUB_CRED_USR --password-stdin'
                sh "docker-compose -p libraryapp push"
            }
        }
        
        stage("Stage 4 : Clean Unwanted Docker Images"){
            steps{
                sh "docker-compose -p libraryapp down --rmi all --volumes --remove-orphans"
            }
        }
        stage("Stage 5: Prepare Docker Compose File") {
            steps {
                archiveArtifacts artifacts: 'docker-compose.yml', allowEmptyArchive: false
                sh 'echo "Workspace location is $WORKSPACE"'
                sh 'ls -l $WORKSPACE' 
            }
        }
        
        stage('Stage 6 : Ansible Deployment') {
            steps {
                ansiblePlaybook colorized: true,
                credentialsId: 'localhost',
                installation: 'Ansible',
                inventory: 'inventory',
                playbook: 'Deploy-LibraryApp.yml',
                extraVars: [
                    workspace: "${env.WORKSPACE}"
                ]
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Cleaning up resources...'
            sh "docker-compose -p libraryapp down --rmi all --volumes --remove-orphans || true"
        }
    }
}