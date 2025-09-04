#!/bin/bash

set -e

# Function to keep terminal open on error
trap 'echo ""; echo "❌ Script failed. Press any key to exit..."; read -n 1; exit 1' ERR

echo "🔧 Building Minecraft plugin with Docker..."
docker build -t minecraft-plugin-builder .

echo "📦 Extracting compiled JAR..."
mkdir -p ./debug/plugins
docker run --rm minecraft-plugin-builder:latest cat /output/plugin.jar > ./debug/plugins/example_plugin.jar

# echo "🚀 Starting Minecraft server with debug enabled..."
# docker-compose up -d --remove-orphans

# echo "⏳ Waiting for server to start..."
# echo "Checking if debug port 5005 is available..."

# # Wait for the debug port to be available
# timeout=60
# while [ $timeout -gt 0 ]; do
#     if nc -z localhost 5005 2>/dev/null; then
#         echo "✅ Debug port 5005 is ready!"
#         break
#     fi
#     echo "Waiting for debug port... ($timeout seconds remaining)"
#     sleep 2
#     timeout=$((timeout - 2))
# done

# if [ $timeout -eq 0 ]; then
#     echo "❌ Timeout waiting for debug port. Check server logs:"
#     docker compose logs minecraft-server --tail=20
#     echo ""
#     echo "Press any key to exit..."
#     read -n 1
#     exit 1
# fi

# echo "✅ Setup complete!"
# echo ""
# echo "🔍 Debug connection details:"
# echo "  Host: localhost"
# echo "  Port: 5005"
# echo "  Transport: dt_socket"
# echo ""
# echo "📋 Useful commands:"
# echo "  View logs:    docker-compose logs -f"
# echo "  Stop server:  docker-compose down"
# echo "  Restart:      docker-compose restart"
# echo ""
# echo "Connect your debugger to localhost:5005 to debug the plugin."