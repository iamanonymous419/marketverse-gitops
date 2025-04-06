def call(String projectName, String imageTag) {
    script {
        echo "Running Trivy security scan on Docker image..."
        try {
            sh """
                trivy image --exit-code 1 --severity CRITICAL,HIGH ${projectName}:${imageTag}
            """
            echo "No critical vulnerabilities found."
        } catch (Exception e) {
            echo "Security vulnerabilities detected!"
            error "Trivy scan failed. Please check the logs."
        }
    }
}

