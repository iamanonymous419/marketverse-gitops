@Library('Library') _

pipeline {
    agent { label 'CD' } // Run on 'CD' agent if available

    options {
        disableConcurrentBuilds() // Ensures only one build runs at a time
    }

    parameters {
        string(name: 'IMAGE_TAG', defaultValue: '', description: 'Docker Image Tag')
    }

    environment {
        GIT_REPO = "https://github.com/iamanonymous419/marketverse-gitops.git"
        GIT_BRANCH = "main"
        DEPLOYMENT_FILE = "app/dep.yml"
        DOCKER_IMAGE = "anonymous292009/marketverse"
        EMAIL_RECIPIENT = 'anonymous292009@gmail.com'
    }

    stages {
        stage('Clean Workspace') {
            steps {
                script {
                    echo "🧹 Cleaning previous workspace..."
                    deleteDir()
                }
            }
        }

        stage('Validate Parameters') {
            steps {
                script {
                    if (!params.IMAGE_TAG?.trim()) {
                        error("❌ IMAGE_TAG parameter is required but is empty!")
                    }
                    echo "✅ IMAGE_TAG provided: ${params.IMAGE_TAG}"
                }
            }
        }

        stage('Checkout GitOps Repo') {
            steps {
                checkoutGitOpsRepo() // Calls the function from the shared library
            }
        }

        stage('Lint YAML') {
            steps {
                script {
                    echo "🔍 Validating YAML syntax..."
                    sh "yamllint ${DEPLOYMENT_FILE} || echo '⚠️ Warning: YAML issues found!'"
                    echo "✅ YAML lint check completed."
                }
            }
        }

        stage('Validate Git Changes') {
            steps {
                validateGitChanges()
            }
        }

        stage('Create a Backup') {
            steps {
                script {
                    echo "📦 Creating a backup of ${DEPLOYMENT_FILE}..."
                    sh "cp ${DEPLOYMENT_FILE} ${DEPLOYMENT_FILE}.bak"
                    echo "✅ Backup created: ${DEPLOYMENT_FILE}.bak"
                }
            }
        }

        stage('Update Image Tag') {
            steps {
                updateImageTag()
            }
        }

        stage('Commit & Push Changes') {
            steps {
                commitAndPushChanges()
            }
        }
    }

    post {
        success {
            script {
                def duration = currentBuild.durationString.replace(' and counting', '')
                echo "🎉 Build and deployment successful!"
            }
            emailext attachLog: true,
                subject: "[SUCCESS ✅] MarketVerse Build #${env.BUILD_NUMBER}",
                body: """
                    <html>
                    <body>
                        <h3 style="color: green;">✅ Build Successful!</h3>
                        <p><b>Project:</b> ${env.JOB_NAME}</p>
                        <p><b>Build Number:</b> ${env.BUILD_NUMBER}</p>
                        <p><b>Duration:</b> ${currentBuild.durationString}</p>
                        <p><b>Build URL:</b> <a href='${env.BUILD_URL}'>View Build</a></p>
                    </body>
                    </html>
                """,
                to: EMAIL_RECIPIENT,
                mimeType: 'text/html'
        }

        failure {
            script {
                echo "❌ Build failed!"
            }
            emailext attachLog: true,
                subject: "[FAILURE ❌] MarketVerse Build #${env.BUILD_NUMBER}",
                body: """
                    <html>
                    <body>
                        <h3 style="color: red;">❌ Build Failed!</h3>
                        <p><b>Project:</b> ${env.JOB_NAME}</p>
                        <p><b>Build Number:</b> ${env.BUILD_NUMBER}</p>
                        <p><b>Duration:</b> ${currentBuild.durationString}</p>
                        <p><b>Build URL:</b> <a href='${env.BUILD_URL}'>View Logs</a></p>
                        <p><b>Console Output:</b> <a href='${env.BUILD_URL}console'>View Console Logs</a></p>
                    </body>
                    </html>
                """,
                to: EMAIL_RECIPIENT,
                mimeType: 'text/html'
        }
    }
}
