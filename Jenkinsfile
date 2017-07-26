pipeline {
    agent { label 'docker' }

    stages {
        stage('Test') {
            steps {
                sh 'docker pull jadametz/serverspec'
                sh 'docker run --rm --name ebs-warmer-test \
                        -v /var/run/docker.sock:/var/run/docker.sock \
                        -v /mnt/$WORKSPACE/:/ebs-warmer \
                        -w /ebs-warmer \
                        jadametz/serverspec \
                        --format progress --format RspecJunitFormatter --out rspec.xml'
                junit 'rspec.xml'
            }
        }
        stage('Tag') {
            steps {
                sh 'docker tag invocaops/ebs_warmer:test invocaops/ebs_warmer:citest'
                sh 'docker rmi invocaops/ebs_warmer:test'
            }
        }
        stage('Push') {
            environment {
                DOCKERHUB_USER = credentials('dockerhub_user')
                DOCKERHUB_PASSWORD = credentials('dockerhub_password')
            }
            steps {
                sh 'docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD'
                sh 'docker push invocaops/ebs_warmer:citest'
            }
        }
    }
}
