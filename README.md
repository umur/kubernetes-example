# Cloud-Native Spring Boot on Kubernetes

> Operating a Spring Boot fleet on production Kubernetes — the parts the docs leave out.

![Java](https://img.shields.io/badge/Java-21-ED8B00?logo=openjdk&logoColor=white) ![Kubernetes](https://img.shields.io/badge/Kubernetes-1.31%2B-326CE5?logo=kubernetes&logoColor=white) ![Spring Boot](https://img.shields.io/badge/Spring_Boot-4.0-6DB33F?logo=spring&logoColor=white) ![License: MIT](https://img.shields.io/badge/License%3A_MIT-MIT-blue)

Companion code for the book **Cloud-Native Spring Boot on Kubernetes** by [Umur Inan](https://umurinan.com).

## About the book

Picks up where *Microservices with Spring Boot 4* ends and operates that system on real Kubernetes. GitOps with Argo CD, Karpenter, CloudNativePG, Strimzi, External Secrets Operator, Linkerd, Argo Rollouts, Kyverno, supply-chain provenance with Sigstore — every component picked, justified, and integrated against the same CinéTrack platform across 32 chapters.

## Prerequisites

- [kind](https://kind.sigs.k8s.io) (Kubernetes IN Docker)
- kubectl
- Helm 3
- Docker

## Quick start

```bash
git clone https://github.com/umur/kubernetes-example
cd kubernetes-example/chapter-01
./scripts/up.sh    # spins up a kind cluster with the chapter-1 baseline
```

## Layout

- `chapter-01/ … chapter-32/` — cumulative cluster state at the end of each chapter, with `manifests/` and `scripts/up.sh`
- `cinetrack-deploy/` — GitOps deployment subtree referenced from Chapters 19 (app-of-apps, ApplicationSets) and 31 (multi-cluster ApplicationSets); contains `envs/{dev,stage,prod-eu,prod-us}/` and `charts/`
- `cinetrack/` — the baseline CinéTrack codebase carried forward from *Microservices with Spring Boot 4*

## Stack

- Kubernetes 1.31+
- Java 21 + Spring Boot 4
- Argo CD (GitOps)
- Karpenter (node provisioning)
- CloudNativePG (Postgres operator)
- Strimzi (Kafka operator)
- External Secrets Operator
- Linkerd (service mesh)
- Argo Rollouts (progressive delivery)
- Kyverno (policy)
- Sigstore / cosign (supply chain)
- Prometheus + Tempo (observability boundary)

## About the author

I'm Umur Inan. I write books about Spring Boot, Java, distributed systems, and the practices that make production reliable.

📚 **More writing and books → [umurinan.com](https://umurinan.com)**

## License

MIT — see [LICENSE](LICENSE).
