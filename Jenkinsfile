pipeline {
    agent any

    parameters {
        choice(name: 'TARGET_STORE', choices: ['android', 'ios'], description: 'Defines the target environment where the application will be deployed')
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '3', artifactNumToKeepStr: '3'))
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


        stage('Build Android') {
            when { allOf {
                expression { params.TARGET_STORE == 'android' }
            }}
            steps {
                sh "sh install/build.sh"
            }
        }

        stage('Build IOS') {
            when { allOf {
                expression { params.TARGET_STORE == 'ios' }
            }}
            steps {
                sh "sh install/build-ios.sh"
            }
        }


        stage('Deploy to Playstore') {
            when { allOf {
                expression { params.TARGET_STORE == 'android' }
            }}
            steps {
                androidApkUpload googleCredentialsId: 'vlumy-mais-app-a9b16f8e86f4', apkFilesPattern: '**/*-release.apk', trackName: 'production'
            }
        }

        stage('Deploy to Apple') {
            when { allOf {
                expression { params.TARGET_STORE == 'ios' }
            }}
            steps {
                echo "TODO -> upload app"
            }
        }

    }
}
