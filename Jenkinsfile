pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    }
    environment {
        VERSION = ""
        APP_NAME = 'twd-origination'
        TENANT_NAME = "WELEAF"
    }
    stages {
        stage('Prepare') {
            steps {
                sh 'git clean -xffd'
                sh "echo 'Test' "
            }
        }
    }
}
