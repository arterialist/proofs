# The linearized signed Goldbach cofactor has a better pointwise exponent

The [companion pointwise theorem](actual-prime-error-convolution-pointwise-vk-gain.md)
beats the inherited prime-number-theorem exponent for the full signed cofactor.
This note isolates its linear component and the exact signed remainder. Keep the
actual von Mangoldt function, including every prime power, and put

\[
E(x)=\psi(x)-x,\qquad e_y=E(y)/y,\qquad
Q_s=\sum_{m=2}^{s-2}\Lambda(m)e_{s-m}\quad(s\ge4).
\]

Reversing the complementary leg and writing \(\Lambda=1+(\Lambda-1)\) gives

\[
\boxed{Q_s=L_s+V_s,\qquad
L_s=\sum_{y=2}^{s-2}e_y,\qquad
V_s=\sum_{y=2}^{s-2}e_y\bigl(\Lambda(s-y)-1\bigr).}
\tag{1}
\]

The finite equality, including the two-leg endpoints, is compiled in
[GoldbachCofactorLinearSplitFinite.lean](../../formalization/BuildingBlocks/GoldbachCofactorLinearSplitFinite.lean).
There is no replacement of prime powers by primes in either term.

Write

\[
\Phi(x)=\frac{(\log x)^{3/5}}{(\log\log x)^{1/5}},\qquad
A_0=1/48.0718,\qquad
d=\left(\frac{5^6A_0^3}{2^2 3^4}\right)^{1/5}\approx0.212579.
\]

The zero-free constant \(A_0\) is from [Bellotti's 2024 zero-free-region paper](https://arxiv.org/abs/2306.10680).
For the density and prime-error estimates below we use independent
classical/Johnston inputs; see the [source audit](../prime-distribution/bellotti-2025-density-proof-source-audit.md)
of the posted 2025 Bellotti density proof.

**Linear-term theorem.** For every fixed \(\varepsilon>0\),

\[
\boxed{|L_s|\ll_\varepsilon
s\exp\!\left[-\bigl(2^{2/5}d-\varepsilon\bigr)\Phi(s)\right]}
\qquad(s\to\infty).
\tag{2}
\]

The leading constant \(2^{2/5}d\approx0.280500\) exceeds the
\(d\approx0.212579\) supplied, with an arbitrary small exponent loss,
by [Johnston's prime-error estimate](https://arxiv.org/abs/2411.13791)
for \(E(x)\) from the same zero-free region. Equation (2) is an
unconditional bound for **\(L_s\)**,
not for \(Q_s\).

## Endpoint-corrected explicit formula

Set \(R_0(x)=\int_1^x E(t)/t\,dt\). Finite interchange gives

\[
R_0(x)=\sum_{n\le x}\Lambda(n)\log(x/n)-(x-1).
\tag{3}
\]

The unconditional [Soundararajan explicit formula, Lemma 1](https://arxiv.org/pdf/math/0612106),
at its permitted parameter \(z=0\), yields

\[
R_0(x)=-\sum_\rho\frac{x^\rho}{\rho^2}+O(\log x)
\qquad(x\ge2),
\tag{4}
\]

where nontrivial zeros are counted with multiplicity. The \(O(\log x)\)
keeps the residue at \(z=0\), the pole at \(1\), the trivial-zero
contribution and the constant from subtracting \(x-1\). The zero
series is absolutely convergent for fixed \(x\), since a dyadic
height block has \(O(T\log T)\) zeros and denominator \(\asymp T^2\).

For every integer \(y\ge1\) and \(y\le t<y+1\),
\(E(t)=E(y)-(t-y)\). Chebyshev's \(|E(y)|\ll y\) therefore gives

\[
\left|\frac{E(y)}y-\int_y^{y+1}\frac{E(t)}t\,dt\right|
\le\frac{|E(y)|}{2y^2}+\frac1{2y}\ll\frac1y.
\]

Summing cells through \(s-2\) and retaining \(E(1)=-1\) shows
\(L_s=R_0(s-1)+O(\log s)\). In particular,

\[
L_s=-\sum_\rho\frac{(s-1)^\rho}{\rho^2}+O(\log s).
\tag{5}
\]

## Zero-density estimate

Let \(u(T)=(\log T)^{-2/3}(\log\log T)^{-1/3}\). The
Korobov–Vinogradov region gives \(\beta\le1-A_0u(|\gamma|)\) for
large zero ordinates. The classical [Ingham zero-density estimate,
as stated and made explicit by Chourasiya–Simonič](https://arxiv.org/abs/2507.15184),
is \(N(\sigma,T)\ll T^{3(1-\sigma)/(2-\sigma)}(\log T)^5\).
At \(\sigma=1-2A_0u(2T)\), this is \(T^{o(1)}\), since
\(u(T)=o(1)\). On the dyadic block \(T\le|\gamma|<2T\),
separate these near-edge zeros from the \(O(T\log T)\) others.
Their contributions
to the absolute zero sum in (5) are respectively bounded by

\[
s\left(
\frac{e^{-A_0u(2T)\log s}}{T^{2-o(1)}}
+\frac{(\log T)e^{-2A_0u(2T)\log s}}{T}
\right).
\tag{6}
\]

For fixed \(a,k>0\), elementary minimization of the
zero-free-region profile gives

\[
\min_T\{aA_0u(T)\log s+k\log T\}
=\bigl(a^{3/5}k^{2/5}d+o(1)\bigr)\Phi(s).
\]

The first term in (6) has limiting constant \(2^{2/5}d\), while the
second has the larger constant \(2^{3/5}d\). Summing dyadic
blocks costs only a polynomial in \(\Phi(s)\), absorbed by the
arbitrarily small \(\varepsilon\) in (2); the high-ordinate tail is
geometric. The finitely many low zeros contribute \(O(s^{1-c})\)
for some fixed \(c>0\). The \(T^{o(1)}\) count can be replaced
uniformly by \(T^\delta\) at large height for any fixed \(\delta>0\);
letting \(\delta\) be small absorbs its optimizer loss into
\(\varepsilon\). Equations (5)–(6) prove (2).

## The remaining actual-prime term

The exact remainder \(V_s\) in (1) is a shifted signed correlation
of the centered birth \(\Lambda(m)-1\) with the complete prefix
error. The currently available absolute estimates do not inherit
the linear term's improved exponent. [Johnston's bound](https://arxiv.org/abs/2411.13791)
gives \(|e_y|\ll_\eta e^{-(d-\eta)\Phi(y)}\) for every
\(\eta>0\). Slow variation then gives
\(\sum_{y\le s}|e_y|^2\ll_\eta s e^{-2(d-\eta)\Phi(s)}\),
while \(\sum_{m\le s}|\Lambda(m)-1|^2\ll s\log s\).
Cauchy gives only

\[
|V_s|\ll_\eta s\sqrt{\log s}\,e^{-(d-\eta)\Phi(s)}.
\tag{7}
\]

Thus (2) alone does **not** improve the bound for \(Q_s\). The
[companion written proof](actual-prime-error-convolution-pointwise-vk-gain.md)
now supplies the required signed estimate
\(|V_s|\ll_\varepsilon s\exp[-(c_*-\varepsilon)\Phi(s)]\), where
\(c_*=0.2714144067\ldots>d\), by a fixed truncated zero cutoff and
summation by parts on \(\Lambda(m)-1\). This is below the linear ceiling
\(2^{2/5}d\) but improves Johnston's direct PNT transfer for the full
\(Q_s\). Equation (7) alone does not supply that gain. No RH claim follows.

The finite split in (1) is Lean-compiled with standard axioms.
The explicit formula, zero-density optimization and analytic bound
(2) are written proofs.
