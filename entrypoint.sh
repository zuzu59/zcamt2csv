#!/bin/bash
set -e
cd /app
ls -la
bundle install
exec "$@"

