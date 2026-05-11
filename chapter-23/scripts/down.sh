#!/usr/bin/env bash
set -euo pipefail
kind delete cluster --name "cinetrack-ch23" 2>/dev/null || echo "cluster not found"
