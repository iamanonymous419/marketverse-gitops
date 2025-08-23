
## Vault CLI Commands

### 1. Vault Status and Cluster Information

```bash
# Check Vault status (shows sealed/unsealed, HA mode, leader/follower)
vault status

# Check status on specific pod
kubectl exec vault-0 -n vault -- vault status
kubectl exec vault-1 -n vault -- vault status
kubectl exec vault-2 -n vault -- vault status

# Get detailed cluster information
vault read sys/leader
vault read sys/health

# Check if current node is leader
vault status | grep "HA Mode"
# Output: HA Mode: active (leader) or HA Mode: standby (follower)
```

### 2. Raft Cluster Management Commands

```bash
# List all raft peers (shows leader/follower status)
vault operator raft list-peers

# List peers with detailed information
vault operator raft list-peers -detailed

# Get raft configuration
vault operator raft configuration

# Check raft autopilot status
vault operator raft autopilot get-config

# Force leadership step-down (current leader becomes follower)
vault operator step-down

# Join a node to raft cluster
vault operator raft join http://vault-0.vault-internal:8200

# Remove a peer from raft cluster
vault operator raft remove-peer vault-2
```

### 3. Vault Initialization Commands

```bash
# Initialize Vault cluster (only run once on leader)
vault operator init

# Initialize with custom shares and threshold
vault operator init -key-shares=5 -key-threshold=3

# Initialize with recovery keys (for auto-unseal)
vault operator init -recovery-shares=5 -recovery-threshold=3

# Initialize and output as JSON
vault operator init -format=json

# Check initialization status
vault status | grep "Initialized"
```

### 4. Seal/Unseal Operations

```bash
# Check seal status
vault status | grep "Sealed"

# Manually unseal (if auto-unseal is disabled)
vault operator unseal <unseal-key-1>
vault operator unseal <unseal-key-2>
vault operator unseal <unseal-key-3>

# Seal Vault (emergency use)
vault operator seal

# Check seal type (should show 'awskms' for auto-unseal)
vault status | grep "Seal Type"

# Get seal status details
vault read sys/seal-status
```

### 5. Authentication and Token Commands

```bash
# Authenticate with root token
vault auth -method=token token=<root-token>

# Login with userpass
vault auth -method=userpass username=admin password=admin123

# Check current token info
vault token lookup

# Check token capabilities
vault token capabilities <token> sys/auth

# Renew current token
vault token renew

# Revoke a token
vault token revoke <token>

# Create a new token
vault token create -policy=default -ttl=1h
```

### 6. Secrets Engine Commands

```bash
# List all secrets engines
vault secrets list

# Enable KV v2 secrets engine
vault secrets enable -path=secret kv-v2

# Enable KV v1 secrets engine
vault secrets enable -path=kv kv

# Enable database secrets engine
vault secrets enable database

# Disable a secrets engine
vault secrets disable kv

# Move/remount a secrets engine
vault secrets move secret/ newsecret/
```

### 7. Key-Value Operations

```bash
# Write a secret (KV v2)
vault kv put secret/myapp username=admin password=secret123

# Read a secret
vault kv get secret/myapp

# Read specific field
vault kv get -field=username secret/myapp

# List secrets
vault kv list secret/

# Delete a secret version
vault kv delete secret/myapp

# Destroy a secret version permanently
vault kv destroy -versions=1 secret/myapp

# Get secret metadata
vault kv metadata get secret/myapp
```

### 8. Policy Management Commands

```bash
# List all policies
vault policy list

# Read a policy
vault policy read default

# Write a new policy
vault policy write myapp-policy - << EOF
path "secret/data/myapp/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOF

# Delete a policy
vault policy delete myapp-policy

# Format and validate policy
vault policy fmt myapp-policy.hcl
```

### 9. Auth Method Commands

```bash
# List auth methods
vault auth list

# Enable auth method
vault auth enable userpass
vault auth enable -path=k8s kubernetes
vault auth enable ldap

# Disable auth method
vault auth disable userpass

# Configure Kubernetes auth
vault write auth/kubernetes/config \
    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt

# Create Kubernetes role
vault write auth/kubernetes/role/myapp \
    bound_service_account_names=myapp \
    bound_service_account_namespaces=default \
    policies=myapp-policy \
    ttl=1h
```

### 10. Audit and Monitoring Commands

```bash
# List audit devices
vault audit list

# Enable file audit
vault audit enable file file_path=/vault/logs/audit.log

# Enable syslog audit
vault audit enable syslog

# Disable audit device
vault audit disable file

# Get system metrics
vault read sys/metrics

# Get system health
vault read sys/health

# Get system capabilities
vault read sys/capabilities-self
```

### 11. Backup and Recovery Commands

```bash
# Create raft snapshot
vault operator raft snapshot save backup.snap

# Restore from raft snapshot
vault operator raft snapshot restore backup.snap

# Force restore (dangerous)
vault operator raft snapshot restore -force backup.snap

# Generate root token using recovery keys
vault operator generate-root -init
vault operator generate-root -nonce=<nonce> -otp=<otp> <recovery-key>

# Rekey the cluster
vault operator rekey -init
vault operator rekey -nonce=<nonce> <current-key>
```

### 12. System Administration Commands

```bash
# Get Vault version
vault version

# Get system configuration
vault read sys/config/state/sanitized

# Reload configuration
vault operator reload

# Get mount information
vault read sys/mounts

# Get system statistics
vault read sys/stats

# Check system capabilities
vault read sys/capabilities

# Get system wrapping information
vault read sys/wrapping/lookup

# Rotate encryption key
vault operator rotate
```

### 13. Namespace Commands (Vault Enterprise)

```bash
# List namespaces
vault namespace list

# Create namespace
vault namespace create myorg

# Delete namespace
vault namespace delete myorg

# Set namespace context
export VAULT_NAMESPACE=myorg
```

### 14. Performance and Debugging Commands

```bash
# Enable debug mode
vault debug -duration=30s -output=debug.tar.gz

# Get performance standby info
vault read sys/replication/performance/status

# Monitor real-time metrics
vault monitor -log-level=debug

# Test network connectivity
vault operator diagnose

# Get detailed cluster info
vault read sys/storage/raft/stats

# Check memory usage
vault read sys/pprof/heap
```


## High Availability (HA) Cluster Commands

### 1. Check Leader/Follower Status

```bash
# Check which node is the leader
vault status | grep "HA Mode"
# Output examples:
# HA Mode: active (leader)    <- This node is the leader
# HA Mode: standby           <- This node is a follower

# Check leader status on all nodes
for i in 0 1 2; do
    echo "=== Vault-$i ==="
    kubectl exec vault-$i -n vault -- vault status | grep "HA Mode"
done

# Get current leader information
vault read sys/leader
# Output shows leader address and cluster info

# Alternative way to check leader
vault operator raft list-peers | grep leader
```

### 2. Raft Cluster Status Commands

```bash
# List all raft peers with roles
vault operator raft list-peers
# Output format:
# Node       Address                        State       Voter
# ----       -------                        -----       -----
# vault-0    vault-0.vault-internal:8201    follower    true
# vault-1    vault-1.vault-internal:8201    leader      true
# vault-2    vault-2.vault-internal:8201    follower    true

# Get detailed raft peer information
vault operator raft list-peers -detailed

# Check raft configuration
vault operator raft configuration

# Get raft cluster statistics
vault read sys/storage/raft/stats
# Shows applied_index, commit_index, fsm_pending, etc.
```

### 3. Leadership Management Commands

```bash
# Force current leader to step down (triggers new election)
vault operator step-down
# The leader becomes a follower, and followers elect a new leader

# Check leadership after step-down
sleep 5
vault operator raft list-peers | grep leader

# Monitor leadership changes
watch -n 2 'vault operator raft list-peers | grep -E "(leader|follower)"'
```

### 4. Cluster Health and Consensus Commands

```bash
# Check cluster health
vault read sys/health
# Returns cluster health status

# Check if cluster has quorum
vault read sys/storage/raft/stats | grep commit_index
# If commit_index is advancing, cluster has quorum

# Check raft autopilot status (if enabled)
vault operator raft autopilot get-config

# Get cluster ID and information
vault read sys/storage/raft/configuration
```

### 5. Node Management in HA Cluster

```bash
# Add a new node to raft cluster
vault operator raft join http://vault-0.vault-internal:8200

# Remove a node from raft cluster (run from leader)
vault operator raft remove-peer vault-2

# Check if a node needs to rejoin
vault status | grep "HA Enabled"
# If false, node may need to rejoin cluster

# Force a node to rejoin cluster
kubectl exec vault-2 -n vault -- vault operator raft join http://vault-0.vault-internal:8200
```

### 6. Failover Testing Commands

```bash
# Test 1: Identify current leader
CURRENT_LEADER=$(vault operator raft list-peers | grep leader | awk '{print $1}')
echo "Current leader: $CURRENT_LEADER"

# Test 2: Simulate leader failure (delete leader pod)
kubectl delete pod $CURRENT_LEADER -n vault

# Test 3: Monitor new leader election
sleep 10
vault operator raft list-peers | grep leader
echo "New leader elected"

# Test 4: Verify cluster is still functional
vault kv put secret/failover-test timestamp="$(date)"
vault kv get secret/failover-test
```

### 7. Cluster Synchronization Commands

```bash
# Check if all nodes are in sync
for i in 0 1 2; do
    echo "=== Vault-$i Raft Index ==="
    kubectl exec vault-$i -n vault -- sh -c \
        "VAULT_TOKEN=\$VAULT_ROOT_TOKEN vault read sys/storage/raft/stats" | grep applied_index
done

# Force synchronization (if nodes are out of sync)
vault operator raft autopilot set-config \
    -cleanup-dead-servers=true \
    -dead-server-last-contact-threshold=10s

# Check replication status
vault read sys/replication/status
```

### 8. Performance Monitoring for HA

```bash
# Monitor raft performance metrics
vault read sys/storage/raft/stats | grep -E "(commit_index|applied_index|fsm_pending)"

# Check leadership stability
vault read sys/leader | grep leader_address

# Monitor cluster latency
time vault kv put secret/perf-test value="$(date)"
time vault kv get secret/perf-test

# Get detailed performance metrics
vault read sys/metrics | grep raft
```

### 9. Troubleshooting HA Issues

```bash
# Check if cluster has split-brain
for i in 0 1 2; do
    echo "=== Vault-$i Leader Status ==="
    kubectl exec vault-$i -n vault -- vault status | grep "HA Mode"
done
# Should only show ONE leader

# Check raft logs for errors
kubectl logs vault-0 -n vault | grep -i raft | grep -i error

# Verify network connectivity between nodes
kubectl exec vault-0 -n vault -- nc -zv vault-1.vault-internal 8201
kubectl exec vault-0 -n vault -- nc -zv vault-2.vault-internal 8201

# Check if nodes can reach each other's raft port
for i in 0 1 2; do
    for j in 0 1 2; do
        if [ $i != $j ]; then
            echo "Testing vault-$i -> vault-$j"
            kubectl exec vault-$i -n vault -- nc -zv vault-$j.vault-internal 8201
        fi
    done
done
```

### 10. Advanced HA Operations

```bash
# Take a consistent snapshot from leader
LEADER=$(vault operator raft list-peers | grep leader | awk '{print $1}')
kubectl exec $LEADER -n vault -- sh -c \
    "VAULT_TOKEN=\$VAULT_ROOT_TOKEN vault operator raft snapshot save /tmp/ha-backup.snap"

# Restore cluster from snapshot (emergency only)
vault operator raft snapshot restore /tmp/ha-backup.snap

# Force leadership to specific node (if needed)
kubectl exec vault-1 -n vault -- vault operator step-down  # Step down current leader
# Wait for vault-1 to become leader through election

# Check cluster consensus
vault read sys/storage/raft/configuration | grep -A 10 servers
```

## Quick Reference - Essential Vault HA Commands

### Most Used Commands for HA Cluster Management

```bash
# 🔍 CHECK LEADER/FOLLOWER STATUS
vault status | grep "HA Mode"                    # Check if current node is leader/follower
vault operator raft list-peers                  # List all nodes with leader/follower status
vault read sys/leader                           # Get current leader information

# 👑 LEADERSHIP OPERATIONS  
vault operator step-down                        # Force leader to step down (triggers election)
vault operator raft list-peers | grep leader   # Find current leader quickly

# 🏥 CLUSTER HEALTH
vault read sys/health                           # Overall cluster health
vault read sys/storage/raft/stats              # Raft consensus statistics
vault status                                    # Individual node status

# 🔧 NODE MANAGEMENT
vault operator raft join <leader-address>      # Join node to cluster
vault operator raft remove-peer <node-name>    # Remove node from cluster
vault operator raft configuration              # Show cluster configuration

# 💾 BACKUP/RESTORE
vault operator raft snapshot save backup.snap  # Create cluster backup
vault operator raft snapshot restore backup.snap # Restore from backup

# 🚨 EMERGENCY COMMANDS
vault operator seal                             # Emergency seal (stops all operations)
vault operator generate-root -init             # Generate new root token
vault operator raft list-peers -detailed       # Detailed cluster information
```

### Real-World Usage Examples

```bash
# Example 1: Check which node is currently the leader
$ vault operator raft list-peers
Node       Address                        State       Voter
----       -------                        -----       -----
vault-0    vault-0.vault-internal:8201    follower    true
vault-1    vault-1.vault-internal:8201    leader      true  ← LEADER
vault-2    vault-2.vault-internal:8201    follower    true

# Example 2: Force leadership change
$ vault operator step-down
Success! Stepped down: vault-1

$ vault operator raft list-peers
Node       Address                        State       Voter
----       -------                        -----       -----
vault-0    vault-0.vault-internal:8201    leader      true  ← NEW LEADER
vault-1    vault-1.vault-internal:8201    follower    true
vault-2    vault-2.vault-internal:8201    follower    true

# Example 3: Check cluster health after failover
$ vault read sys/health
Key                     Value
---                     -----
initialized             true
sealed                  false
standby                 false  ← This node is active
performance_standby     false
replication_perf_mode   disabled
replication_dr_mode     disabled
version                 1.20.1
cluster_name            vault-cluster-58bf4e5b
cluster_id              f829bdab-2d87-1d8d-05f1-c3e8409a9a1d

# Example 4: Monitor real-time leadership changes
$ watch -n 2 'vault operator raft list-peers | grep -E "(leader|Node)"'
# This will refresh every 2 seconds showing current leader
```