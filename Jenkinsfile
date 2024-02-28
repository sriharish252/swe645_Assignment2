pipeline{
    agent any
    tools{
        maven 'Maven'
    }
    stages{
        stage("Build Maven Project"){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sriharish252/swe645_Assignment2']])
                sh 'mvn clean install'
            }
        }
        stage("Build Docker Image"){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                        sh 'docker login -u sriharishj -p $dockerhubpwd'
                        sh 'docker build -t sriharishj/swe645_assignment2 .'
                    }
                }
            }
        }
        stage("Push Image to DockerHub"){
            steps{
                script{
                    sh 'docker push sriharishj/swe645_assignment2'
                }
            }
        }
        stage("Deploy to Kubernetes"){
            steps{
                script{
                    env.KUBECONFIG = '/home/ubuntu/.kube/config'
                    sh("kubectl --kubeconfig=${env.KUBECONFIG} set image deployment/assignment2 assignment2=sriharishj/swe645_assignment2 -n default")
                }
            }
        }
    }
}
