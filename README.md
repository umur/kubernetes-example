# Cloud-Native Spring Boot on Kubernetes

> Operating a Spring Boot fleet on production Kubernetes: the parts the docs leave out.

![Java](https://img.shields.io/badge/Java-21-ED8B00?logo=openjdk&logoColor=white) ![Kubernetes](https://img.shields.io/badge/Kubernetes-1.31%2B-326CE5?logo=kubernetes&logoColor=white) ![Spring Boot](https://img.shields.io/badge/Spring_Boot-4.0-6DB33F?logo=spring&logoColor=white) ![License: MIT](https://img.shields.io/badge/License%3A_MIT-MIT-blue)

Companion code for **Cloud-Native Spring Boot on Kubernetes** by [Umur Inan](https://umurinan.com).

## About the book

Picks up where *Microservices with Spring Boot 4* ends and operates that system on real Kubernetes. GitOps with Argo CD, Karpenter, CloudNativePG, Strimzi, External Secrets Operator, Linkerd, Argo Rollouts, Kyverno, supply-chain provenance with Sigstore. Every component picked, justified, and integrated against the same CinéTrack platform across 32 chapters.

## Who this is for

- Spring Boot engineers who already build microservices and want to operate them on real Kubernetes
- Platform and infrastructure engineers who need to know what Java workloads actually need from the cluster
- Anyone who has run `kubectl apply` in production and wondered why things keep breaking at 3am

## Chapters

1. Day 2 is the job
2. The cluster contract
3. JVM on Kubernetes, properly
4. Image discipline
5. Configuration at scale
6. Secrets in production
7. Workload identity
8. Image pull secrets and private registries
9. The service-to-service path
10. Ingress and Gateway API
11. North-south resilience
12. East-west without a mesh
13. Service mesh, honestly
14. HPA beyond CPU
15. Cluster Autoscaler and Karpenter
16. VPA, PDBs, and co-tenants
17. Capacity planning for Java workloads
18. FinOps for Spring on K8s
19. GitOps that survives Friday
20. Progressive delivery
21. Helm vs Kustomize vs both
22. Supply chain
23. Multi-tenancy and namespaces
24. Postgres on (or off) Kubernetes
25. Kafka on Kubernetes
26. Redis, Elasticsearch, and the StatefulSet tax
27. Observability boundaries
28. Debugging on the cluster
29. The on-call runbook
30. Five real incidents on CinéTrack
31. Multi-cluster, honestly
32. Capstone: the 50x load event

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

- `chapter-01/ ... chapter-32/`: cumulative cluster state at the end of each chapter, with `manifests/` and `scripts/up.sh`
- `cinetrack-deploy/`: GitOps deployment subtree referenced from Chapters 19 (app-of-apps, ApplicationSets) and 31 (multi-cluster ApplicationSets); contains `envs/{dev,stage,prod-eu,prod-us}/` and `charts/`
- `cinetrack/`: the baseline CinéTrack codebase carried forward from *Microservices with Spring Boot 4*

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

## Related books

- [Microservices with Spring Boot 4](https://github.com/umur/microservices-example): this book builds and deploys the same CineTrack system that Kubernetes operates
- [Production Observability](https://github.com/umur/observability-example): the observability stack plugged into the Kubernetes deployment in Chapter 26
- [Spring Boot 4 Performance in Practice](https://github.com/umur/spring-boot-performance-book-example): performance tuning covered at the JVM level; Kubernetes-level scaling covered here

## About the author

I'm Umur Inan. I write production-focused books about Java, Spring Boot, distributed systems, and everything that makes software reliable at scale.

[umurinan.com](https://umurinan.com)

## License

MIT. See [LICENSE](LICENSE).
