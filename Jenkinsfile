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
                sh "git clone git@github.com:vlumy/flutter-app.git"
                sh "cd flutter-app && git checkout deploy"
                sh "cp install/key.properties flutter-app/android"
            }
        }


        stage('Build bundle') {
            steps {
                sh "sh install/build.sh"
            }
        }

        stage('Upload to Play Store') {
            steps {
                androidApkUpload googleCredentialsId: 'vlumy-mais-app-a9b16f8e86f4', apkFilesPattern: '**/*-release.apk', trackName: 'production'
            }
         }

    }
}
