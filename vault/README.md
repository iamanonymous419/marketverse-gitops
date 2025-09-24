# Vault Persistent Configuration

This folder contains the Kubernetes manifests to ensure Vault authentication configuration persists across pod restarts.

## Files

- `vault-init-script.yaml` - ConfigMap containing the initialization script
- `vault-config-cronjob.yaml` - CronJob that runs every 2 minutes to maintain configuration
- `vault-init-job.yaml` - One-time Job for initial setup

## Usage

```bash
# Apply all configurations
kubectl apply -f vault/

# Or apply individually
kubectl apply -f vault/vault-init-script.yaml
kubectl apply -f vault/vault-config-cronjob.yaml

# For one-time setup only
kubectl apply -f vault/vault-init-job.yaml
```

## What it does

1. **Enables Kubernetes auth method** in Vault
2. **Configures JWT token reviewer** for service account authentication  
3. **Creates marketverse-policy** with read access to secrets
4. **Creates marketverse-role** bound to marketverse-sa service account
5. **Runs automatically** every 2 minutes to ensure persistence

## Troubleshooting

```bash
# Check CronJob status
kubectl get cronjobs -n vault

# Check recent jobs
kubectl get jobs -n vault

# View job logs
kubectl logs job/vault-config-sync-<timestamp> -n vault
```
