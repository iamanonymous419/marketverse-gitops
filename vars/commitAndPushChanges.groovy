def call() {
    script {
        withCredentials([usernamePassword(credentialsId: 'git-credentials', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
            echo "📤 Committing and pushing changes..."
            sh """
            git config --global user.email "your_email"
            git config --global user.name "anonymous"
            git add \${DEPLOYMENT_FILE}
            git commit -m "Update image to \${DOCKER_IMAGE}:\${IMAGE_TAG}" || echo "No changes to commit"
            git push https://\${GIT_USER}:\${GIT_PASS}@github.com/iamanonymous419/marketverse-gitops.git \${GIT_BRANCH}
            """
            echo "✅ Changes pushed successfully."
        }
    }
}

