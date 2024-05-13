#!/bin/bash
# Start docker-compose or podman-compose

# Check if docker-compose or podman-compose is installed
if command -v docker compose &> /dev/null; then
  docker compose up -d
elif command -v podman compose &> /dev/null; then
  podman compose up -d
else
  echo "docker-compose or podman-compose is not installed"
  exit 1
fi