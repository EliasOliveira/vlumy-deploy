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
                sh "sh install/build.sh"
//                 sh 'git clean -xffd'
//                 sh "git clone git@github.com:vlumy/flutter-app.git"
//                 sh "cd flutter-app && git checkout deploy"
//                 sh "cp install/key.properties flutter-app"
            }
        }


//         stage('Build bundle') {
//             steps {
//                 //sh "cd flutter-app && flutter pub get && flutter pub run flutter_launcher_icons && flutter packages pub run build_runner build --delete-conflicting-outputs && flutter build appbundle && flutter build apk"
//             }
//         }

    }
}
