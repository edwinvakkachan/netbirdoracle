#!/bin/sh
set -x

REMOTE_USER="ubuntu"
REMOTE_IP="100.80.75.245"
CONTAINER="netbird-client"

echo "=================================="
echo "Monitor started at: $(date)"
echo "Target: $REMOTE_USER@$REMOTE_IP"
echo "Container: $CONTAINER"
echo "=================================="

SSH_CMD="ssh -vvv -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

echo "Testing SSH connection..."

$SSH_CMD ${REMOTE_USER}@${REMOTE_IP} "echo SSH connection successful"

echo "Checking container state..."

STATUS=$($SSH_CMD ${REMOTE_USER}@${REMOTE_IP} \
"docker inspect -f '{{.State.Running}}' ${CONTAINER}" 2>&1)

echo "Docker status output:"
echo "$STATUS"

if [ "$STATUS" != "true" ]; then
    echo "Container appears stopped. Attempting restart..."
    
    RESTART_OUTPUT=$($SSH_CMD ${REMOTE_USER}@${REMOTE_IP} \
    "docker restart ${CONTAINER}" 2>&1)

    echo "Restart result:"
    echo "$RESTART_OUTPUT"
else
    echo "Container is running normally."
fi

echo "Check finished at $(date)"
echo ""