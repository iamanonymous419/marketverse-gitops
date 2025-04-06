// vars/checkoutGitOpsRepo.groovy
def call() {
    script {
        echo "🔄 Cloning GitOps repository from ${env.GIT_REPO} on branch ${env.GIT_BRANCH}..."
        checkout([
            $class: 'GitSCM',
            branches: [[name: "*/${env.GIT_BRANCH}"]],
            userRemoteConfigs: [[url: env.GIT_REPO, credentialsId: 'git-credentials']],
            extensions: [[$class: 'LocalBranch', localBranch: env.GIT_BRANCH]]
        ])
        echo "✅ Repository checked out successfully."
    }
}

