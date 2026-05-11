#!/usr/bin/env bash
set -euo pipefail
echo "NOTE: Karpenter requires a real EKS cluster — cannot run in kind."
echo "Apply manifests against your EKS cluster with Karpenter installed:"
echo "  kubectl apply -f manifests/"
echo ""
echo "To install Karpenter on EKS, see:"
echo "  https://karpenter.sh/docs/getting-started/getting-started-with-karpenter/"
