# Runbook: OOMKilled — catalog-service

## Symptoms
- `kubectl describe pod <pod> -n cinetrack` shows `OOMKilled`
- `kubectl top pods -n cinetrack` shows memory near limit
- Alert: `CatalogServiceOOMKilled`

## Immediate mitigation

```bash
# 1. Check current memory limits
kubectl get deployment catalog-service -n cinetrack -o jsonpath='{.spec.template.spec.containers[0].resources}'

# 2. Temporarily increase memory limit
kubectl patch deployment catalog-service -n cinetrack --type='json' \
  -p='[{"op":"replace","path":"/spec/template/spec/containers/0/resources/limits/memory","value":"1Gi"}]'

# 3. Watch pods recover
kubectl rollout status deployment/catalog-service -n cinetrack
```

## Root cause investigation

```bash
# Check heap usage before OOM
kubectl logs <pod> -n cinetrack --previous | grep -E "(heap|GC|OOM)"

# Look for memory leak pattern: steadily increasing GC overhead
kubectl logs <pod> -n cinetrack | grep "GC overhead"
```

## Permanent fix
1. Review `JAVA_TOOL_OPTIONS` — ensure `MaxRAMPercentage` ≤ 75
2. Check for Caffeine cache unbounded growth (set `maximumSize`)
3. Consider VPA recommendation: `kubectl get vpa catalog-service -n cinetrack`

## Prevention
- Set VPA in `Recommend` mode for 48 hours post-incident to get a sizing baseline
- Add `CatalogServiceMemoryHigh` alert at 80% of limit with longer window (10m)
