# Proper-cofactor cutoff transfer and dual Dirichlet reduction

**Status:** incomplete written reduction, corrected 19 September 2026
**Classification:** exact Mellin scaling and an individual-zero approximate-functional-equation identity

## Result

Let `g_N` be the pole-null packet used in the associated Weil calculation. For every integer `k >= 1` and nontrivial zeta zero `rho`, the change of variables `u = kx` gives the exact factorization

```text
integral x^(rho - 1) g_N(kx) dx = k^(-rho) J(rho, T),
```

where the integral is over the positive real axis and `J(rho, T)` is independent of `k`.

Take `K = T ^ (1 - delta)` with `0 < delta < 1 / 2`, and suppose `rho = beta + i * gamma` lies in a height band with `|gamma|` comparable to `T`. The dual cutoff depends on the zero:

```text
y_rho = |gamma| / (2 * pi * K).
```

The approximate functional equation at the individual zero gives

```text
sum_(2 <= k <= K) k^(-rho)
  = -1 - chi(rho) * sum_(1 <= n <= y_rho) n^(rho - 1)
    + O(T^(-(1 - delta) * beta)
        + T^(1 / 2 - beta - delta * (1 - beta))).
```

For `beta >= 1 / 2`, a weaker form of the error is

```text
O(T^(-(1 - delta) * beta) + T^(-delta * (1 - beta))).
```

Only on the critical line `beta = 1 / 2` does this specialize to `O(T ^ (-delta / 2))`.

The `-1` term displays a formal cancellation with the `k = 1` factor after inserting the identity into a suitably truncated explicit formula.

## What remains unproved

This reduction does not bound the dual Dirichlet polynomial. Its length is `y_rho = |gamma| / (2 * pi * K)`, which is comparable to `T ^ delta` only within the chosen height band and is not a common cutoff `T ^ delta / (2 * pi)` for every zero.

The report also does not justify exchanging the cofactor and full zero sums, control zeros outside the selected height band, bound the omitted cofactor tail, or prove uniform bounds for the pole, archimedean, truncation, and smoothing remainders. The individual-zero error cannot be promoted to a complete `O(T ^ (-delta / 2))` zero-sum error without those arguments.

Accordingly, the exact factorization and individual-zero dual identity are useful reductions. They do not eliminate the `O(H / sqrt N)` barrier, prove a signed estimate for the complete prime row, or resolve an RH obstruction.

## Attribution and source context

The finite cofactor algebra is represented in `ActualPrimeCofactorFutureFinite.lean`. The approximate-functional-equation step is classical; the corrected derivation cites Titchmarsh's treatment of the Riemann zeta function. Priority for this packaging has not been established by an exhaustive search.
