# Jenkins Setup Guide for Marketverse Project

This comprehensive guide will help you set up Jenkins infrastructure and CI/CD pipelines for the Marketverse project.

## Prerequisites

Before starting, ensure you have completed the infrastructure setup as described in [`./iac/README.md`](./iac/README.md).

## 📦 Plugin Installation

### Required Plugins

Navigate to **Manage Jenkins** → **Manage Plugins** → **Available** and install the following plugins:

- **Pipeline Stage View** - For visual pipeline representation
- **OWASP Dependency-Check** - For security vulnerability scanning
- **SonarQube Scanner** - For code quality analysis
- **Git** - For source code management
- **SSH Agent** - For worker node connections
- **Email Extension** - For notification capabilities

## 🔧 Tool Configuration

### 1. OWASP Dependency-Check Setup

1. Go to **Manage Jenkins** → **Tools**
2. Find **Dependency-Check installations**
3. Configure:
   - **Name**: `OWASP`
   - **Install automatically**: ✅ Enabled
   - **Install from**: `github.com` (latest version)

### 2. SonarQube Scanner Setup

1. Navigate to **Manage Jenkins** → **Tools**
2. Find **SonarQube Scanner installations**
3. Configure:
   - **Name**: `Sonar`
   - **Install automatically**: ✅ Enabled
   - **Install from**: `Maven Central` (latest version)

### 3. SonarQube Server Configuration

1. Go to **Manage Jenkins** → **System**
2. Find **SonarQube installations**
3. Configure:
   - **Name**: `Sonar`
   - **Server URL**: `[Your SonarQube URL]`
   - **Server authentication token**: `[Reference to Sonar credential]`

## 🔐 Credentials Management

Navigate to **Manage Jenkins** → **Credentials** → **System** → **Global credentials** and add the following:

| Credential ID | Type | Description |
|---------------|------|-------------|
| `dockerhublogin` | Username with password | Docker Hub authentication |
| `gmailAuth` | Username with password | Gmail SMTP authentication |
| `clerk-publishable-key` | Secret text | Clerk API key |
| `git-credentials` | Username with password | Private GitHub repository access |
| `Sonar` | Secret text | SonarQube authentication token |
| `ubuntu-agent-private-key` | SSH Username with private key | Ubuntu worker node connection |

### 🔑 How to Generate SonarQube Token

Before adding the SonarQube credential in Jenkins, you need to generate a token from your SonarQube server:

1. **Login to your SonarQube server**
2. Navigate to **Administration** → **Security** → **Users**
3. In the **Users** section, find your user (e.g., Administrator)
4. Click on the **Tokens** column (the number in blue)
5. In the **Generate Tokens** section:
   - **Name**: Enter `Jenkins` (or any descriptive name)
   - **Expires in**: Select `30 days` (or your preferred duration)
   - Click **Generate** button
6. **Important**: Copy the generated token immediately as it won't be shown again
7. Use this token when creating the `Sonar` credential in Jenkins

### 🔗 SonarQube Webhook Configuration

To enable automatic analysis reporting back to SonarQube after Jenkins builds:

1. **Login to your SonarQube server**
2. Navigate to **Administration** → **Configuration** → **Webhooks**
3. Click **Create** button
4. Configure the webhook:
   - **Name**: `Jenkins-webhook`
   - **URL**: `http://[JENKINS_SERVER_IP]:8080/sonarqube-webhook/`
     - Replace `[JENKINS_SERVER_IP]` with your actual Jenkins server IP
     - Example: `http://54.176.108.7:8080/sonarqube-webhook/`
     - Example: `https://jenkins.iamanonymous.in/sonarqube-webhook/`
   - **Secret**: Leave empty (optional)
5. Click **Create**

**Note**: The webhook URL should point to your Jenkins server with the `/sonarqube-webhook/` endpoint.

## 🔗 GitHub Webhook Configuration

To enable automatic pipeline triggers when code is pushed to the Marketverse repository:

### Setting up GitHub Webhook

1. **Navigate to your GitHub repository**: `https://github.com/iamanonymous419/marketverse`
2. Go to **Settings** → **Webhooks** (in the left sidebar)
3. Click **Add webhook**
4. Configure the webhook:
   - **Payload URL**: `https://jenkins.iamanonymous.in/github-webhook/` 
     - Replace with your actual Jenkins server URL
     - Ensure the URL ends with `/github-webhook/`
   - **Content type**: `application/json`
   - **Which events would you like to trigger this webhook?**: 
     - Select **Just the push event** (recommended)
     - Or **Send me everything** for all events
   - **Active**: ✅ Ensure this is checked
5. Click **Add webhook**

### Webhook Event Configuration
- **Push events**: Triggers CI pipeline on code push
- **Pull request events**: Triggers CI pipeline on PR creation/updates (optional)
- **Release events**: Can trigger CD pipeline for production deployments (optional)

**Important**: Ensure your Jenkins server is publicly accessible or configure appropriate firewall rules to allow GitHub webhook traffic.

## 🖥️ Worker Node Configuration

### Adding CI/CD Nodes

1. Go to **Manage Jenkins** → **Nodes**
2. Click **New Node**
3. Create two nodes with the following configuration:

#### Node Configuration Template
- **Node name**: `CI-Node` / `CD-Node`
- **Description**: CI/CD worker node for Marketverse
- **Number of executors**: `2`
- **Remote root directory**: `/home/ubuntu`
- **Labels**: `CI` / `CD`
- **Usage**: Use this node as much as possible
- **Launch method**: Launch agents via SSH
  - **Host**: `[Worker node IP address]`
  - **Credentials**: `ubuntu-agent-private-key`
  - **Host Key Verification Strategy**: Non verifying Verification Strategy
- **Availability**: Keep this agent online as much as possible

## 📚 Global Pipeline Libraries

Configure shared pipeline libraries for reusable code (especially for CD pipelines):

1. Navigate to **Manage Jenkins** → **System**
2. Find **Global Trusted Pipeline Libraries**
3. Configure:
   - **Library Name**: `Library`
   - **Default version**: `main`
   - **Retrieval method**: Modern SCM
     - **Source Code Management**: Git
     - **Project Repository**: `[Your shared library repository URL]`
     - **Credentials**: `git-credentials` (if required)
   - **Behaviors**:
     - ✅ Allow default version to be overridden
     - ✅ Include @Library changes in job recent changes

**Note**: The shared library is primarily used for CD pipelines to standardize deployment processes and reuse common deployment functions across multiple projects.

## 📧 Email Notification Setup

### Extended E-mail Notification

1. Go to **Manage Jenkins** → **System**
2. Find **Extended E-mail Notification**
3. Configure:
   - **SMTP server**: `smtp.gmail.com`
   - **SMTP Port**: `465`
   - **Advanced**:
     - **Credentials**: `gmailAuth`
     - ✅ Use SSL
     - **Charset**: `UTF-8`

### Standard E-mail Notification

1. In the same **System** configuration page
2. Find **E-mail Notification**
3. Configure:
   - **SMTP server**: `smtp.gmail.com`
   - **Advanced**:
     - ✅ Use SMTP Authentication
     - **User Name**: `[Gmail username]`
     - **Password**: `[Gmail app password]`
     - ✅ Use SSL
     - **SMTP Port**: `465`
     - **Reply-To Address**: `test.com@gmail.com`
     - **Charset**: `UTF-8`

4. **Test configuration** by sending a test email

## 🚀 Pipeline Configuration

### CI Pipeline Setup

1. **New Item** → Enter name: `CI`
2. Select **Pipeline** → **OK**

#### General Configuration
- **Description**: CI pipeline for Marketverse project
- **Build Options**:
  - ✅ Discard old builds
    - **Days to keep builds**: `30`
    - **Max # of builds to keep**: `10`
  - ✅ Do not allow concurrent builds
  - ✅ Abort previous builds

#### GitHub Integration
- ✅ GitHub project
- **Project url**: `https://github.com/iamanonymous419/marketverse/`

#### Build Triggers
- ✅ GitHub hook trigger for GITScm polling

#### Pipeline Definition
- **Definition**: Pipeline script from SCM
- **SCM**: Git
  - **Repository URL**: `https://github.com/iamanonymous419/marketverse`
  - **Credentials**: `git-credentials` (if private repo)
  - **Branches to build**: `*/main`
- **Script Path**: `Jenkinsfile`
- ✅ Lightweight checkout

### CD Pipeline Setup

1. **New Item** → Enter name: `CD`
2. Select **Pipeline** → **OK**

#### General Configuration
- **Description**: CD pipeline for Marketverse project using shared libraries
- **Build Options**:
  - ✅ Do not allow concurrent builds
  - ✅ Abort previous builds

#### Parameters
- ✅ This project is parameterized
- **String Parameter**:
  - **Name**: `IMAGE_TAG`
  - **Default Value**: `latest`
  - **Description**: Docker Image Tag for deployment
  - ✅ Trim the string

#### GitHub Integration
- ✅ GitHub project
- **Project url**: `https://github.com/iamanonymous419/marketverse-gitops`

#### Build Triggers
- ✅ GitHub hook trigger for GITScm polling

#### Pipeline Definition
- **Definition**: Pipeline script from SCM
- **SCM**: Git
  - **Repository URL**: `https://github.com/iamanonymous419/marketverse-gitops`
  - **Credentials**: `git-credentials` (if private repo)
  - **Branches to build**: `*/main`
- **Script Path**: `Jenkinsfile` (or appropriate CD pipeline file)
- ✅ Lightweight checkout

**Note**: The CD pipeline will automatically use the configured shared library (`Library`) for standardized deployment functions and reusable deployment components.

## 🔍 Verification Steps

After completing the setup:

1. **Test Worker Nodes**: Verify both CI and CD nodes are online and responding
2. **Test Credentials**: Ensure all credentials are properly configured and accessible
3. **Test Tools**: Run a simple pipeline to verify OWASP and SonarQube tools are working
4. **Test Email**: Send test notifications to verify email configuration
5. **Test GitHub Webhook**: 
   - Push a commit to the repository
   - Verify that Jenkins receives the webhook and triggers the CI pipeline
   - Check webhook delivery status in GitHub Settings → Webhooks
6. **Verify SonarQube Integration**:
   - Run a pipeline with SonarQube analysis
   - Check that results appear in your SonarQube dashboard
   - Verify webhook is receiving notifications from Jenkins builds
7. **Test Shared Library**: Ensure CD pipeline can access and use the shared library functions

## 🛠️ Integration Troubleshooting

### GitHub Webhook Issues:
- **Webhook not triggering**: Verify Jenkins URL is publicly accessible
- **SSL certificate errors**: Ensure proper SSL configuration or use HTTP for testing
- **Payload delivery failed**: Check Jenkins logs and GitHub webhook delivery logs
- **Wrong branch triggering**: Verify branch configuration in Jenkins pipeline

### SonarQube Integration Issues:
- **Token expired**: Generate a new token from SonarQube and update Jenkins credential
- **Webhook not receiving data**: Check Jenkins server IP and ensure `/sonarqube-webhook/` endpoint is accessible
- **SSL/Network issues**: Verify network connectivity between Jenkins and SonarQube servers
- **Analysis not appearing**: Ensure the SonarQube server URL in Jenkins matches your actual server URL

### Shared Library Issues:
- **Library not found**: Verify the shared library repository URL and credentials
- **Version mismatch**: Check the library version specified in CD pipeline
- **Function not available**: Ensure the required functions are properly defined in the shared library

## 📝 Pipeline Files Structure (Shared Library Structure for CD pipelines)

Ensure your repository contains the following Jenkins pipeline files:

```
├── Jenkinsfile         # CD Pipeline
└── vars/
    ├── checkoutGitOpsRepo.groovy      # GitOps repository checkout functions
    ├── commitAndPushChanges.groovy    # Git commit and push automation
    ├── trivyScan.groovy               # Security scanning functions for CI/CD
    ├── updateImageTag.groovy          # Image tag update functions for CD
    └── validateGitChanges.groovy      # Git changes validation functions
```

## 🚨 Security Considerations

- Use SSH key authentication for worker nodes
- Store all sensitive information as Jenkins credentials
- Enable CSRF protection in Jenkins global security
- Regularly update Jenkins and plugins
- Use least privilege principle for service accounts
- Enable audit logging for compliance

## 📞 Support

For issues related to Jenkins setup:
1. Check Jenkins logs: **Manage Jenkins** → **System Log**
2. Verify worker node connectivity
3. Test individual pipeline stages
4. Review credential permissions

---

**Note**: Replace placeholder values (URLs, credentials, etc.) with your actual configuration values before implementation.