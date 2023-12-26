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
        stage('Clean workspace') {
            steps {
                sh 'git clean -xffd'
            }
        }
        stage('Set version = BRANCH_SNAPSHOT') {
            when { branch '*-SNAPSHOT' }
            steps {
                script {
                    VERSION = "${BRANCH_NAME.substring(0, BRANCH_NAME.indexOf("-SNAPSHOT"))}.${BUILD_NUMBER}-SNAPSHOT"
                }
            }
        }
        stage('Set version = TAG_RELEASE') {
            when { tag '*-RELEASE' }
            steps {
                script {
                    VERSION = TAG_NAME
                }
            }
        }
        stage ('Docker Build & Deploy To registry: DEV') {
            when {
                anyOf {
                    branch '*-SNAPSHOT'
                    tag '*-RELEASE'
                }
            }
            steps {
                sh """
                sed -i "s/'dev'/'dev'/g" src/settings/index.ts
                docker build -t ${APP_NAME}:${VERSION}-DEV-${TENANT_NAME} . --no-cache
                docker image tag ${APP_NAME}:${VERSION}-DEV-${TENANT_NAME} registry.intranet-teamwill-consulting.com/${APP_NAME}:${VERSION}-DEV-${TENANT_NAME}
                docker push registry.intranet-teamwill-consulting.com/${APP_NAME}:${VERSION}-DEV-${TENANT_NAME}
                """
            }
        }
        stage ('Docker Build & Deploy To registry: DEV-CAPITOL') {
            when {
                anyOf {
                    branch '*-SNAPSHOT'
                    tag '*-RELEASE'
                }
            }
            steps {
                sh """
                sed -i "s/'dev'/'cpt-dev'/g" src/settings/index.ts
                docker build -t ${APP_NAME}:${VERSION}-DEV-CAPITOL . --no-cache
                docker image tag ${APP_NAME}:${VERSION}-DEV-CAPITOL registry.intranet-teamwill-consulting.com/${APP_NAME}:${VERSION}-DEV-CAPITOL
                docker push registry.intranet-teamwill-consulting.com/${APP_NAME}:${VERSION}-DEV-CAPITOL
                """
            }
        }
        stage('Deploy To k8s') {
            when {
                anyOf {
                    branch '*-SNAPSHOT'
                    tag '*-RELEASE'
                }
            }
            steps {
                withKubeConfig([credentialsId: "Kube-Dev", serverUrl: "https://kube-dev.teamwill-digital.com:6443"]) {
                    sh """
                    cd kubernetes
                    sed -i 's/latest/${VERSION}-DEV-${TENANT_NAME}/g' ${APP_NAME}.yaml
                    kubectl apply -f ${APP_NAME}.yaml -n dev
                    """
                }
            }
        }
        stage ('Docker Build & Deploy To registry: INT') {
            when {
                anyOf {
                    branch '*-SNAPSHOT'
                    tag '*-RELEASE'
                }
            }
            steps {
                sh """
                sed -i "s/'cpt-dev'/'int'/g" src/settings/index.ts
                docker build -t ${APP_NAME}:${VERSION}-INT-${TENANT_NAME} . --no-cache
                docker image tag ${APP_NAME}:${VERSION}-INT-${TENANT_NAME} registry.intranet-teamwill-consulting.com/${APP_NAME}:${VERSION}-INT-${TENANT_NAME}
                docker push registry.intranet-teamwill-consulting.com/${APP_NAME}:${VERSION}-INT-${TENANT_NAME}
                """
            }
        }
        stage ('Docker Build & Deploy To registry: UAT') {
            when {
                anyOf {
                    branch '*-SNAPSHOT'
                    tag '*-RELEASE'
                }
            }
            steps {
                sh """
                sed -i "s/'int'/'uat'/g" src/settings/index.ts
                docker build -t ${APP_NAME}:${VERSION}-UAT-${TENANT_NAME} . --no-cache
                docker image tag ${APP_NAME}:${VERSION}-UAT-${TENANT_NAME} registry.intranet-teamwill-consulting.com/${APP_NAME}:${VERSION}-UAT-${TENANT_NAME}
                docker push registry.intranet-teamwill-consulting.com/${APP_NAME}:${VERSION}-UAT-${TENANT_NAME}
                """
            }
        }
    }
}
