#!/bin/bash
set -e
cd /app
ls -la
exec "$@"

