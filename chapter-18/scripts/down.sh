#!/usr/bin/env bash
set -euo pipefail
kind delete cluster --name "cinetrack-ch18" 2>/dev/null || echo "cluster not found"
