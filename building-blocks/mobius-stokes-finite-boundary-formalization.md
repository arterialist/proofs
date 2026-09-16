# Finite Möbius–Stokes boundary formalization

[`MobiusStokesFiniteBoundary.lean`](BuildingBlocks/MobiusStokesFiniteBoundary.lean) now formalizes the finite algebra from [the future-boundary note](mobius-stokes-future-boundary-and-hard-reservoir.md) without a prime-split hypothesis. It makes no capacity, asymptotic, or RH claim.

For a finite sequence `F₁,…,F_L` over any commutative ring, it proves the exact Abel identity

\[
\sum_{a=1}^{L}F_aq^{a-1}
=(1-q)\sum_{A=1}^{L-1}C_Aq^{A-1}+C_Lq^{L-1},
\]

and its observed version after multiplication by `1-q`. It also certifies the complete divisor-renewal endpoint

\[
\sum_{1\le d\le N}\mu(d)\lfloor N/d\rfloor=1
\qquad(N>0)
\]

using Mathlib's actual `ArithmeticFunction.moebius`.

For a prime `p`, the module proves:

1. `μ(p*m)=-μ(m)` when `p∤m`;
2. `μ(d)=0` when `p|d` and `p|d/p`, explicitly retaining the `p²` correction;
3. the literal bijection from once-divisible `d∈(D,N]` to
   `m=d/p∈(D/p,N/p]` with `p∤m`;
4. the unconditional split

\[
B_{D,N}=F_p(D,N)-F_p(D/p,N/p);
\]

5. the exact endpoint cancellation

\[
B_{D,N}=F_p(\max(D,N/p),N)
-F_p(D/p,\min(D,N/p)).
\]

Here every face is a finite sum on a literal half-open integer interval and contains the literal condition `p∤m`. Thus equation (18) is unconditional apart from the elementary assumptions that `p` is prime and `D≤N`.

Compilation succeeds. Every printed theorem has only `propext`, `Classical.choice`, and `Quot.sound`; there is no `sorryAx`, compiler-trust axiom, or new axiom.
