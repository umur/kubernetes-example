# Runbook: High Latency: catalog-service

## Symptoms
- p95 latency > 500ms (alert: `CatalogServiceHighLatency`)
- Users report slow search results

## Quick diagnosis

```bash
# 1. Is it the DB?
kubectl exec -it $(kubectl get pod -n cinetrack -l app.kubernetes.io/name=catalog-service -o name | head -1) \
  -n cinetrack -- curl -s localhost:8080/actuator/metrics/jdbc.connections.active

# 2. Is it Redis?
kubectl exec -it redis-0 -n cinetrack -- redis-cli info stats | grep -E "(instantaneous_ops|rejected)"

# 3. Are we CPU-throttled?
kubectl top pods -n cinetrack --sort-by=cpu | head -10
```

## Common causes

| Cause | Signal | Fix |
|-------|--------|-----|
| DB connection pool exhaustion | `HikariCP.Connections.Active` near max | Increase `maximum-pool-size` |
| Redis timeout | `RedisConnectionException` in logs | Check Redis memory, increase timeout |
| CPU throttling | `container_cpu_cfs_throttled_seconds_total` | Raise CPU limit or add replicas |
| N+1 queries | Slow query log, high DB CPU | Add `@BatchSize` or rewrite fetch joins |

## Escalation
If latency persists > 15 minutes after mitigation: page the on-call backend engineer.
