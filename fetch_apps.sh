#!/bin/bash

OBJECT_ID="0xe8417c530cde59eddf6dfb760e8a0e3e2c6f17c69ddaab5a73dd6a6e65fc463b"
CURSOR=""
LIMIT=10  # Adjust limit as needed
TEMP_FILE=$(mktemp)
FILTER_FILE=$(mktemp)
FETCH_ALL=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --all)
            FETCH_ALL=true
            shift
            ;;
        *)
            shift
            ;;
    esac
done

cat > "$FILTER_FILE" << 'EOF'
.data[] | {
  app: .name.value.app[0],
  org: (.name.value.org.labels | reverse | join(".")),
  objectId: .objectId
}
EOF

while true; do
    if [ -z "$CURSOR" ]; then
        sui client dynamic-field "$OBJECT_ID" --limit "$LIMIT" --json 2>/dev/null > "$TEMP_FILE"
    else
        sui client dynamic-field "$OBJECT_ID" --cursor "$CURSOR" --limit "$LIMIT" --json 2>/dev/null > "$TEMP_FILE"
    fi

    # Extract app info and fetch object details for each entry
    jq -c -f "$FILTER_FILE" "$TEMP_FILE" | while read -r entry; do
        app=$(echo "$entry" | jq -r '.app')
        org=$(echo "$entry" | jq -r '.org')
        obj_id=$(echo "$entry" | jq -r '.objectId')
        
        # Fetch the object details
        obj_json=$(sui client object "$obj_id" --json 2>/dev/null)
        
        # Extract package_address
        package_address=$(echo "$obj_json" | jq -r '.content.fields.value.fields.app_info.fields.package_address // "null"')
        
        # Extract metadata contents as key-value pairs
        metadata_formatted=$(echo "$obj_json" | jq -r '
            .content.fields.value.fields.metadata.fields.contents // [] |
            if length == 0 then "(none)"
            else map("    \(.fields.key): \(.fields.value)") | join("\n")
            end
        ')
        
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "📦 App: $app"
        echo "🏢 Org: $org"
        echo "📍 Package: $package_address"
        echo "📄 AppRecord: $obj_id"
        if [ "$metadata_formatted" = "(none)" ]; then
            echo "📋 Metadata: (none)"
        else
            echo "📋 Metadata:"
            echo "$metadata_formatted"
        fi
    done

    # Check if there's a next page
    HAS_NEXT=$(jq -r '.hasNextPage' "$TEMP_FILE")
    if [ "$HAS_NEXT" = "false" ]; then
        echo "No more pages."
        break
    fi

    # Get next cursor
    CURSOR=$(jq -r '.nextCursor' "$TEMP_FILE")

    # Wait for user input unless --all flag is set
    if [ "$FETCH_ALL" = false ]; then
        echo "Press Enter to fetch the next page..."
        read -r
    fi
done

rm "$FILTER_FILE" "$TEMP_FILE"
