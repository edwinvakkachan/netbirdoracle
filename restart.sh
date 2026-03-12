#!/bin/sh
set -e

echo "=================================="
echo "Starting remote container restart"
echo "Time: $(date)"
echo "=================================="

echo "Target: $REMOTE_USER@$REMOTE_IP"
echo "Container: $CONTAINER_NAME"

SSH_CMD="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

echo "Testing SSH connection..."

$SSH_CMD ${REMOTE_USER}@${REMOTE_IP} "echo SSH OK"

echo "Restarting container..."

$SSH_CMD ${REMOTE_USER}@${REMOTE_IP} \
"docker restart ${CONTAINER_NAME}"

echo "Restart completed successfully"

echo "Finished at $(date)"