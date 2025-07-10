#!/bin/bash

# Update tys-toolbox in current directory

set -e

SCRIPT_DIR="/Users/ty/global-scripts/jupyter"
SOURCE_TOOLBOX="$SCRIPT_DIR/tys-toolbox"

# Check if source exists
if [ ! -d "$SOURCE_TOOLBOX" ]; then
    echo "❌ Error: Source toolbox not found at $SOURCE_TOOLBOX"
    exit 1
fi

# Check if we're in a directory with tys-toolbox
if [ ! -d "./tys-toolbox" ]; then
    echo "❌ Error: No tys-toolbox found in current directory"
    echo "📁 Current directory: $(pwd)"
    exit 1
fi

# Update the toolbox
echo "🔄 Updating tys-toolbox..."
rm -rf ./tys-toolbox
cp -r "$SOURCE_TOOLBOX" ./
echo "✅ Toolbox updated successfully!"