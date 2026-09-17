"""Exact finite minimum-clock discriminator; no floating arithmetic."""
import heapq


def factors(n):
    out = []
    p = 2
    while p * p <= n:
        while n % p == 0:
            out.append(p)
            n //= p
        p += 1
    if n > 1:
        out.append(n)
    return out


def check(N, bound):
    costs = {(1, 1): 0}
    heap = [(0, 1, 1)]
    while heap:
        cost, n, r = heapq.heappop(heap)
        if costs[n, r] != cost:
            continue
        edges = []
        if n < N:
            edges.append((n + 1, r, 1))
        for d in range(2, n + 1):
            if n % d == 0 and r * d <= bound:
                edges.append((n // d, r * d, 0))
        for m, t, step in edges:
            proposed = cost + step
            if proposed < costs.get((m, t), 10**9):
                costs[m, t] = proposed
                heapq.heappush(heap, (proposed, m, t))
    rows = []
    for r in range(1, bound + 1):
        primes = factors(r)
        reachable = not primes or max(primes) <= N
        assert ((1, r) in costs) == reachable
        if reachable:
            expected = sum(p - 1 for p in primes)
            assert costs[1, r] == expected
            rows.append([r, expected])
    return {"N": N, "bound": bound, "return_costs": rows}


if __name__ == '__main__':
    for N in range(2, 11):
        check(N, 60)
    print('All exact minimum-clock checks passed.')
