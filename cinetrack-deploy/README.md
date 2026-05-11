# cinetrack-deploy

GitOps deployment subtree for CinéTrack. Used from Chapter 19 onwards.

## Structure

```
cinetrack-deploy/
  charts/
    catalog-service/        Helm chart (Deployment, Service, HPA, PDB, ServiceAccount)
    user-service/
    review-service/
    watchlist-service/
    api-gateway/
    notification-service/
  envs/
    dev/
      apps/                 ArgoCD Application YAMLs pointing at charts/
      values/               Per-service Helm value overrides for dev
    stage/
    prod-eu/
    prod-us/
```

## Services

| Service | Port | Image |
|---------|------|-------|
| catalog-service | 8080 | `ghcr.io/umur/cinetrack-catalog-service:latest` |
| user-service | 8081 | `ghcr.io/umur/cinetrack-user-service:latest` |
| review-service | 8082 | `ghcr.io/umur/cinetrack-review-service:latest` |
| watchlist-service | 8083 | `ghcr.io/umur/cinetrack-watchlist-service:latest` |
| api-gateway | 8090 | `ghcr.io/umur/cinetrack-api-gateway:latest` |
| notification-service | 8084 | `ghcr.io/umur/cinetrack-notification-service:latest` |

## Deploy to a local kind cluster

```bash
# Install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Apply app-of-apps for dev
kubectl apply -f ../chapter-19/manifests/app-of-apps.yaml

# Watch sync
kubectl get applications -n argocd --watch
```

## Manual Helm deploy (without ArgoCD)

```bash
helm upgrade --install catalog-service charts/catalog-service \
  --namespace cinetrack --create-namespace \
  --values envs/dev/values/catalog-service.yaml
```
