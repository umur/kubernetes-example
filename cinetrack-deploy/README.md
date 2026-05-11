# cinetrack-deploy

The GitOps deployment subtree for CinéTrack. Referenced from Chapter 19
(app-of-apps and ApplicationSets) and Chapter 31 (multi-cluster ApplicationSets).

In production this would live in a separate git repository so that platform
operators can review and audit deployment changes independently of service
code. For the book's self-contained example it lives as a subdirectory of
the main companion repository; ArgoCD is pointed at this directory via
`path: cinetrack-deploy/...`.

## Layout

- `envs/dev/apps/` — child Application YAMLs for the dev environment
- `envs/stage/apps/`
- `envs/prod-eu/apps/`
- `envs/prod-us/apps/`
- `charts/<service>/` — Helm charts for each CinéTrack service

## Status

This tree is currently a scaffold. Real Application YAMLs, ApplicationSet
generators, and Helm charts are added per-chapter as the book is written.
