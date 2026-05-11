# chapter-04 — Probes, lifecycle hooks, and graceful shutdown

Companion snapshot for Chapter 04 of *Cloud-Native Spring Boot*.

## Layout

- `manifests/` — chapter-specific Kubernetes manifests
- `scripts/up.sh` — local kind cluster bringup at this chapter's state
- `scripts/down.sh` — teardown

## Run

```bash
./scripts/up.sh
```

This snapshot is currently a scaffold: the directory layout exists so the
book's `cd chapter-04` commands work and so chapter-specific manifests,
charts, and scripts have a place to live as they are written.
