# A macroscopic false-prime channel from truncating complete divisor histories

*Research and initial proof: RH Agent2. Independent mathematical audit and publication: RH Proof.*

Fix a large real horizon `X`, let `z=√X`, and compare the exact early-prime Möbius projector

`r_z(n)=Σ_{d|n, P⁺(d)≤z}μ(d)`

with its superficially similar length-truncated version

`r_z^{short}(n)=Σ_{d|n, d≤z}μ(d)`.

For `n≤X`, the first projector is `1` precisely at `n=1` and ordinary primes `n>z`; it is zero at every composite. The second projector does **not** preserve that statement. Let `P_X` be the primes in `[z/3,z/2]`. For distinct `p,q∈P_X`, put `n=pq`. Then `z<n≤X/4` for large `X`, and the divisors of `n` at most `z` are exactly `1,p,q`. Hence

`r_z^{short}(pq)=1−1−1=−1`, whereas `r_z(pq)=1−1−1+1=0`. (1)

The omitted term is the squarefree product `μ(pq)=+1`, whose divisor label exceeds `z` even though both generating primes were admitted before `z`. It is therefore a *complete-history* correction, not an omitted large-prime arrival.

This false-prime channel is macroscopic. PNT gives

`#P_X∼z/(3log X)`,

`Σ_{p<q; p,q∈P_X}log(pq)∼X/(18log X)`.       (2)

Let `R_X` be the ordinary primes in `[X/4,X/3]`. Every `r∈R_X` exceeds `z`, so `r_z^{short}(r)=r_z(r)=1`, and `θ(X/3)−θ(X/4)∼X/12`. Every `pq+r≤X`. Therefore the ordered additive cross between the false semiprimes and these actual fresh primes in the *truncated* logarithmic projector has signed value

`−2(Σ_{p<q; p,q∈P_X}log(pq))(Σ_{r∈R_X}log r)`

`∼−X²/(108log X)`.                               (3)

The complete projector has zero contribution on the same semiprime coordinates. Thus an absolute-value treatment of the omitted product histories incurs a spurious cross packet of order `X²/log X`, far above `X^(3/2+ε)` for every fixed `ε<1/2`. Equation (3) is a **subsector calculation**, not a lower bound on the total error of the truncated Goldbach sum: other signed subsectors may cancel it. It rules out a short-divisor absolute-error replacement at the RH scale and identifies the specific bilinear cancellation that replacement would need.

The parity sensitivity is consistent with the bilinear axiom in [Friedlander and Iwaniec, *Asymptotic sieve for primes* (1998)](https://annals.math.princeton.edu/articles/13036): ordinary residue-distribution information by itself does not detect prime support. The displayed constant and cross packet above follow directly from PNT and the finite Möbius identities, not from their theorem.

The obstruction is not special to the exponent `1/2` in the divisor *length*. For any fixed `0<κ<1`, set `D=X^κ` and `r_D^{short}(n)=Σ_{d|n,d≤D}μ(d)`. On the same `n=pq` family, if `κ<1/2` then neither prime factor is at most `D`, so `r_D^{short}(pq)=+1`; if `κ≥1/2`, both factors but not their product are at most `D`, so `r_D^{short}(pq)=−1`. The partner primes `r∈R_X` exceed `D` in either case, so their short projector remains `+1`. Thus the selected ordered additive cross has absolute asymptotic `X²/(108log X)` for **every fixed sublinear-power divisor cutoff** `D=X^κ`, with its sign changing at `κ=1/2`. Recovering the exact projector on these semiprimes requires the product-divisor term as large as `pq≈X`, or a proof of signed cancellation across the other channels.
