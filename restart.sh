#!/bin/sh

REMOTE_USER="ubuntu"
REMOTE_IP="100.80.75.245"
CONTAINER="netbird-client"

echo "Checking container on $REMOTE_IP..."

STATUS=$(ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_IP} \
"docker inspect -f '{{.State.Running}}' ${CONTAINER}")

if [ "$STATUS" != "true" ]; then
    echo "Container stopped. Restarting..."
    ssh ${REMOTE_USER}@${REMOTE_IP} "docker restart ${CONTAINER}"
else
    echo "Container running."
fi