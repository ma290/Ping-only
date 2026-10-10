#!/bin/bash

# Define your API endpoints
API_ENDPOINTS=(
    "intelligent-lydia-ashutosh0879-d6443fa6.koyeb.app/"
    "giant-elinor-namezakikr-6c7a4f8a.koyeb.app/"
)

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "========================================="
echo "🚀 Starting API Ping Service"
echo "📡 Monitoring ${#API_ENDPOINTS[@]} endpoints"
echo "⏱️  Checking every 1 minute"
echo "========================================="
echo ""

while true; do
    echo "📅 $(date '+%Y-%m-%d %H:%M:%S')"
    echo "-----------------------------------------"
    
    for url in "${API_ENDPOINTS[@]}"; do
        # Extract short name for display
        name=$(echo "$url" | sed 's|https://||' | cut -d'.' -f1)
        
        # Send POST request with empty JSON (since it's a transcription endpoint)
        response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$url" \
            -H "Content-Type: application/json" \
            -d '{}' 2>/dev/null)
        
        if [ "$response" = "200" ] || [ "$response" = "201" ] || [ "$response" = "202" ]; then
            echo -e "${GREEN}✅${NC} $name - Status: $response"
        elif [ "$response" = "000" ]; then
            echo -e "${RED}❌${NC} $name - Connection failed"
        else
            echo -e "${YELLOW}⚠️${NC}  $name - Status: $response"
        fi
    done
    
    echo "-----------------------------------------"
    echo "⏳ Next check in 60 seconds..."
    echo ""
    
    sleep 60
done
