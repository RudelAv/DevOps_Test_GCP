#!/bin/bash

# This script retrieves the public IP address of a Cloud Run service.

# get environment
ENVIRONMENT=${1:-dev}

# Configure project, region, and service based on the environment
case "$ENVIRONMENT" in
    dev)
        PROJECT_ID="the-program-470313-k9"
        REGION="us-central1"
        SERVICE="php-devops-service"
        ;;
    prod)
        PROJECT_ID="${GCP_PROJECT_ID_PROD:-}"
        REGION="${GCP_REGION_PROD:-}"
        SERVICE="${CLOUD_RUN_SERVICE_PROD:-}"

        if [[ -z "$PROJECT_ID" || -z "$REGION" || -z "$SERVICE" ]]; then
            echo "ERROR: incomplete configuration"
            exit 1
        fi
        ;;
    *)
        echo "ERROR: Invalid environment. Use dev or prod."
        exit 1
        ;;
esac

# Operation logging
LOG_FILE="scripts/cloud-run-ip.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# dependency check
for cmd in gcloud getent; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        log "ERROR: $cmd is not installed."
        exit 1
    fi
done

# Google Cloud Authentication Verification
if ! gcloud auth print-access-token >/dev/null 2>&1; then
    log "ERROR: Google Cloud authentication is missing."
    exit 1
fi

log "Starting execution"
log "Environment : $ENVIRONMENT"
log "Project : $PROJECT_ID"
log "Region : $REGION"
log "Service : $SERVICE"

# Retrieving Cloud Run public URL
SERVICE_URL=$(gcloud run services describe "$SERVICE" \
    --project="$PROJECT_ID" \
    --region="$REGION" \
    --format="value(status.url)" 2>/dev/null)

if [[ -z "$SERVICE_URL" ]]; then
    log "ERROR: Impossible de récupérer l'URL Cloud Run."
    exit 1
fi

# Extracting the DNS name
HOST=$(echo "$SERVICE_URL" | sed -E 's|https?://([^/]+).*|\1|')

log "Public URL : $SERVICE_URL"

# DNS resolution to get IPv4 address
IP=$(getent ahostsv4 "$HOST" | awk 'NR==1 {print $1}')

if [[ -z "$IP" ]]; then
    log "ERROR: Impossible to resolve the IP address of $HOST."
    exit 1
fi

# Display and logging of the result
log "Public IP Address : $IP"
log "Execution completed successfully."