// SWE645 Assignment Jenkinsfile - Provides the build stages and commands for Jenkins pipeline
// Author: Sri Harish Jayaram
pipeline{
    agent any
    tools{
        maven 'Maven'
    }
    stages{

        // Stage 1: Build Maven Project and generate WAR file
        stage("Build Maven Project"){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sriharish252/swe645_Assignment2']])
                sh 'mvn clean install'
            }
        }

        // Stage 2: Build Docker image using the credentials stored in Jenkins
        stage("Build Docker Image"){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                        sh 'docker login -u sriharishj -p $dockerhubpwd'
                        sh 'docker build -t sriharishj/swe645_assignment2:${BUILD_TIMESTAMP} .'
                    }
                }
            }
        }

        // Stage 3: Push Docker image to DockerHub
        stage("Push Image to DockerHub"){
            steps{
                script{
                    sh 'docker push sriharishj/swe645_assignment2:${BUILD_TIMESTAMP}'
                }
            }
        }

        // Stage 4: Deploy docker image to Kubernetes, edit the env.KUBECONFIG path, deployment name, container name and image name as needed.
        stage("Deploy to Kubernetes"){
            steps{
                script{
                    env.KUBECONFIG = '/home/ubuntu/.kube/config'
                    sh("kubectl --kubeconfig=${env.KUBECONFIG} set image deployment/assignment2 assignment2=sriharishj/swe645_assignment2:${BUILD_TIMESTAMP} -n default")
                }
            }
        }
    }
}
