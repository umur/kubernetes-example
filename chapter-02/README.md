# chapter-02: Cluster bootstrap: kind, KIND profiles, and EKS-baseline

Companion snapshot for Chapter 02 of *Cloud-Native Spring Boot*.

## Layout

- `manifests/`: chapter-specific Kubernetes manifests
- `scripts/up.sh`: local kind cluster bringup at this chapter's state
- `scripts/down.sh`: teardown

## Run

```bash
./scripts/up.sh
```

This snapshot is currently a scaffold: the directory layout exists so the
book's `cd chapter-02` commands work and so chapter-specific manifests,
charts, and scripts have a place to live as they are written.
