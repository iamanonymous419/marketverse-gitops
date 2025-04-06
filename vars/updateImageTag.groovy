def call() {
    script {
        echo "🛠 Updating deployment file with new image tag..."
        
        def oldTag = sh(script: "grep -o '${env.DOCKER_IMAGE}:.*' ${env.DEPLOYMENT_FILE} | cut -d':' -f2", returnStdout: true).trim()
        
        if (oldTag) {
            sh "sed -i 's|${env.DOCKER_IMAGE}:${oldTag}|${env.DOCKER_IMAGE}:${env.IMAGE_TAG}|g' ${env.DEPLOYMENT_FILE}"
            echo "✅ Updated image tag to: ${env.DOCKER_IMAGE}:${env.IMAGE_TAG}"
        } else {
            error "❌ Could not find image tag in ${env.DEPLOYMENT_FILE}"
        }
    }
}

