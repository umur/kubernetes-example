# chapter-19 — GitOps with Argo CD: app-of-apps and ApplicationSets

Companion snapshot for Chapter 19 of *Cloud-Native Spring Boot*.

## Layout

- `manifests/` — chapter-specific Kubernetes manifests
- `scripts/up.sh` — local kind cluster bringup at this chapter's state
- `scripts/down.sh` — teardown

## Run

```bash
./scripts/up.sh
```

This snapshot is currently a scaffold: the directory layout exists so the
book's `cd chapter-19` commands work and so chapter-specific manifests,
charts, and scripts have a place to live as they are written.
