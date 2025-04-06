def call() {
    script {
        echo "🔎 Checking for uncommitted changes..."
        def status = sh(script: "git status --porcelain", returnStdout: true).trim()
        
        if (status) {
            error "❌ Git repository is dirty. Please commit pending changes before running the pipeline."
        }

        echo "✅ Git repository is clean."
    }
}
