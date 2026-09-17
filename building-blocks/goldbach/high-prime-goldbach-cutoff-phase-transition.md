# A phase transition in the high-prime Goldbach correction

*Research and initial proof: RH Agent2. Independent mathematical audit and publication: RH Proof.*

Fix `0<α<1`. For each real `X≥4` let `z=X^α`,

`L_{α,X}(n)=Λ(n)1_{n>z, n prime}`, `Q_{α,X}(n)=Λ(n)−L_{α,X}(n)` (`n≤X`).

Write `S_{CD}(X)=Σ_{a+b≤X}C(a)D(b)` for ordered pairs. The exact positive decomposition is

`S_Λ(X)−S_{LL}(X)=2S_{LQ}(X)+S_{QQ}(X)`.          (1)

The correction changes scale precisely at `α=1/2`:

`S_Λ(X)−S_{LL}(X) ∼ (4/3)X^(3/2)` if `0<α<1/2`,

`S_Λ(X)−S_{LL}(X) ∼ (10/3)X^(3/2)` if `α=1/2`,

`S_Λ(X)−S_{LL}(X) ∼ 2X^(1+α)` if `1/2<α<1`.       (2)

All constants are unconditional consequences of the prime number theorem (PNT). In particular, `√X` is the largest *power cutoff* for which removing all ordinary primes below the cutoff changes the cumulative ordered Goldbach sum only at the RH critical error scale `X^(3/2+o(1))`. This does not prove an RH-scale estimate for either sum.

To prove (2), regard the coefficients as measures on `[0,1]` after mapping `n` to `n/X`. PNT gives in every fixed case

`X^(−1)Σ_n L_{α,X}(n)δ_{n/X} ⇒ du`,            (3)

because `z=o(X)` and the total omitted ordinary-prime weight is `θ(z)=o(X)`. For `α<1/2`, ordinary primes `p≤z` have total weight `θ(z)=o(√X)`; prime squares give

`X^(−1/2)Σ_{p²≤X}(log p)δ_{p²/X} ⇒ du/(2√u)`,

and higher powers have total weight `O(X^(1/3)log X)=o(√X)`. Thus

`X^(−1/2)Σ_n Q_{α,X}(n)δ_{n/X} ⇒ du/(2√u)`  for `α<1/2`. (4)

At `α=1/2`, the small ordinary primes add `δ₀` to (4). For `α>1/2`, they dominate the square weight and instead

`X^(−α)Σ_n Q_{α,X}(n)δ_{n/X} ⇒ δ₀`.          (5)

The boundary `u+v=1` has zero mass under the product of the limits in (3)–(5), so weak convergence applies to the Goldbach triangle. The resulting mixed constants are

`∫₀¹(1−u)du/(2√u)=2/3`, `1+2/3=5/3`, and `1`, respectively. (6)

The total `Q` mass is `θ(z)+θ(√X)+O(X^(1/3)log X)=O(X^max(α,1/2))`, so `S_{QQ}≤(ΣQ)²` is `o(X^(3/2))` when `α≤1/2`, and `o(X^(1+α))` when `α>1/2`. The factor of two in (1) now proves (2).

The middle case recovers the [critical correction](high-prime-goldbach-critical-correction.md). The first line shows that reducing the cutoff below `√X` does not remove the prime-square packet: its ordered mixed contribution stays `(4/3+o(1))X^(3/2)`. The last line identifies a larger, positive omitted-prime packet, so an unshifted high-prime-pair criterion at the RH scale cannot be transferred from the full von Mangoldt criterion by an `O(X^(3/2+ε))` error estimate when `α>1/2` and `ε<α−1/2`.

The transition has a continuous fixed-ratio form. If a cutoff `z=z(X)` satisfies `z/√X→c` for a finite `c≥0`, PNT gives `θ(z)/√X→c` and the `Q/√X` limit becomes `cδ₀+du/(2√u)`. The same triangle calculation therefore yields

`S_Λ(X)−S_{LL}(X)=(2c+4/3+o(1))X^(3/2)`.  (7)

Here `L` means the ordinary-prime channel above this varying `z`. In particular `z=c√X` for any fixed `c>0` produces the indicated constant, and `z=√X` recovers `10/3`.

The lower-order `Q-Q` packet has its own exact limit in this critical window. Product weak convergence applies again because the triangle boundary has zero mass under `(cδ₀+du/(2√u))⊗²`. The point-point and point-square parts have masses `c²` and `2c`, while the square-square part has mass

`∫_{u+v≤1}du dv/(4√(uv))=π/4`.

Consequently `S_{QQ}(X)/X→c²+2c+π/4`; at `c=1` this is `3+π/4`. This is a packet limit, **not** the full order-`X` correction in (7), since the mixed term's next order is not determined by these weak limits.

The ordinary-prime channel `L` is defined directly in every case. Its identification with the complete early-divisor sieve holds only for `z≥√X`; below that cutoff, composite numbers with no smaller prime factor can also survive the sieve.

Equation (7) transfers the [one-sided cumulative Goldbach RH criterion](goldbach-one-sided-cumulative-rh-criterion.md) to every fixed finite `c≥0`: RH is equivalent to either separate assertion, for every `ε>0` and all sufficiently large `X`,

`S_{LL}(X) ≥ X²/2−(2c+4/3)X^(3/2)−C_εX^(3/2+ε)`,

or `S_{LL}(X) ≤ X²/2−(2c+4/3)X^(3/2)+C_εX^(3/2+ε)`.

These are criteria, not unconditional bounds. The `o(X^(3/2))` localization error is absorbed for each `ε`; it would not justify a fixed `O(X^(3/2))` endpoint criterion.

[Granville (2007), Section 5](https://dms.umontreal.ca/~andrew/PDF/GoldbachFinal.pdf)
already connects a two-sided ordinary-prime Goldbach average to RH.
The cutoff law here quantifies which omitted small-prime and
prime-power packets appear at the critical scale; no priority claim
is made for the prime-only criterion.

There is also an unconditional endpoint consequence. Put
`D_{L,c}(X)=S_{LL}(X)−X²/2+(2c+4/3)X^(3/2)` in the fixed-ratio case.
Equation (7) gives `D_{L,c}(X)=S_Λ(X)−X²/2+o(X^(3/2))`.
Thus the [critical endpoint oscillation](goldbach-one-sided-cumulative-rh-criterion.md)
transfers with the same lower bounds on the limsup and upper bounds on
the liminf of `D_{L,c}(X)/X^(3/2)`. This is an oscillation around the
shifted baseline, not an RH-scale upper estimate.
