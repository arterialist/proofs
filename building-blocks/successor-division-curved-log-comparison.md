# A positive curved-log comparison with the two cancellations retained

Write $L(t)=\sum_{k\ge1}\mu(k)K(kt)$, with the actual scaling
kernel $K$. The independently checked
[division-kernel moments](successor-division-kernel-moments.md)
give $\int L=\int L\log t=0$. Here is a further signed comparison,
and its actual discrete arithmetic consequence. It does not assert
positivity for the original affine logarithm readout.

For every fixed $0<\eta<1/2$, define
$$
 c_\eta=\frac{\sqrt\pi\,\Gamma(1+\eta)\tan(\pi\eta)}
 {2(1+\eta)\zeta(1+\eta)}>0.
 \tag{1}
$$
Then
$$
 \boxed{\int_0^\infty L(t)
 [t^\eta-1-\eta\log t]\,dt=c_\eta.}
 \tag{2}
$$
This is a positive pairing with a nonnegative function convex in
$\log t$, notwithstanding the actual $+,-,+$ signs of $L$.
It also holds for nonnegative mixtures of these weights when the
integrals are finite. It does not extend by this proof to every
convex function of $\log t$.

The [direct beta-integral proof](successor-division-kernel-moments.md#direct-beta-integral-proof-of-the-positive-power-pairing) establishes (2), including absolute convergence and the full Möbius exchange. The proof below transfers that integral to the literal discrete weights.

## Actual discrete comparison near the boundary

For every fixed $0<\eta<1/2$, the actual inverse weights satisfy
$$
 \boxed{
 h^{\eta+1/2}\sum_{m\ge2}\varphi_{1-h}(m)m^\eta
 \longrightarrow c_\eta
 \quad(h\downarrow0).}
 \tag{6}
$$
To justify this limit rather than use pointwise scaling, sum the
global coefficient error from the
[scaling theorem](successor-feedback-kernel-scaling.md)
over $n=km$, then over $m\ge2$ with weight $m^\eta$.
For $g_0(t)=t^{-1/2}/(1+t)$, the decreasing function
$t^\eta g_0(t)$ is integrable. Rectangle comparison gives
$$
 \sum_{m\ge2}m^\eta g_0(hkm)
 \le C_\eta(hk)^{-1-\eta}.
 \tag{7}
$$
The second error term has the corresponding bound
$$
 \sum_{m\ge2}m^\eta
 \frac{e^{-hkm/2}}{hkm}
 \le C_\eta(hk)^{-1-\eta}.
 \tag{8}
$$
Summing $k^{-1-\eta}$ shows that the unnormalized error is
$O_\eta(h^{1/2-\eta}+h^{1-\eta})$.
The retained endpoint term obeys, by positive Tonelli,
$$
 h\sum_{m\ge2}m^\eta\sum_{k\ge1}E_1(hkm)
 \le C_\eta h^{-\eta}.
 \tag{9}
$$
For example $E_1(u)=\int_1^\infty e^{-uy}\,dy/y$, and the
elementary exponential power-sum bound proves (9).
After multiplication by $h^{\eta+1/2}$, all these errors vanish.

It remains to justify the principal Riemann sum
$h\sum_{m\ge2}(hm)^\eta L(hm)$.
The elementary absolute bounds for $K$ give
$$
 |L(t)|\le C/t\quad(0<t\le1),\qquad
 |L(t)|\le Ct^{-3/2}\quad(t\ge1).
 \tag{10}
$$
For the first bound split $k$ at $1/t$.
Both bounds control the corresponding Riemann-sum tails by
$C_\eta\varepsilon^\eta$ near zero and
$C_\eta R^{\eta-1/2}$ near infinity.
Local continuity handles the intervening compact interval.
Consequently the sum tends to $\int t^\eta L(t)dt=c_\eta$,
proving (6) with complete sharp integer endpoints.

Use the exact mass and logarithmic identities
$$
 \sum_{m\ge1}\varphi_r(m)=W_r(1)=O(1),\qquad
 \sum_{m\ge2}\varphi_r(m)\log m=E(r)=O(h^{-1/2}).
 \tag{11}
$$
Also $|\varphi_r(1)|\le\sum_k|W_r(k)|=O(h^{-1/2})$:
the $k\ge2$ part follows by summing the same global scaling bound,
and $W_r(1)=(hQ(r)-1)/r$ is bounded separately.
Thus (6) implies the stronger cancellation-preserving statement
$$
 \boxed{
 h^{\eta+1/2}
 \sum_{m\ge1}\varphi_{1-h}(m)
 [m^\eta-1-\eta\log m]\longrightarrow c_\eta>0.}
 \tag{12}
$$
In particular this actual signed comparison is positive for every
sufficiently small $h$, for each fixed $\eta$ in the stated range.

There is an exact divisor readout of (12). Put
$$
 J_\eta(n)=\sum_{d\mid n}\mu(n/d)d^\eta
 =n^\eta\prod_{p\mid n}(1-p^{-\eta}).
 \tag{13}
$$
Absolute rearrangement, valid since $\eta<1/2$, gives
$$
 \boxed{
 \sum_{m\ge1}\varphi_r(m)[m^\eta-1-\eta\log m]
 =\sum_{n\ge2}W_r(n)[J_\eta(n)-\eta\Lambda(n)].}
 \tag{14}
$$
The initial $n=1$ term cancels exactly. The coefficient in brackets
is nonnegative: for a prime power $p^a$,
$$
 J_\eta(p^a)=p^{a\eta}-p^{(a-1)\eta}\ge\eta\log p,
$$
while at integers with at least two prime factors $\Lambda(n)=0$
and $J_\eta(n)>0$. Thus (14) is a concrete complete-divisor
curvature readout, paired with the actual signed successor kernel;
it does not discard either its negative region or its proper powers.

Finally $c_\eta\sim(\pi^{3/2}/2)\eta^2$ as $\eta\downarrow0$.
The limit (12) is for fixed $\eta>0$; its proof has constants
depending on $\eta$, and the factor $h^{-\eta}$ is not uniform
at $\eta=0$. It cannot be differentiated there to infer the sign
of $E(r)$. The comparison controls a specific curved readout,
while the cancelled affine logarithm and its finer arithmetic
remainder remain separate.

The [two-order cancellation theorem](successor-division-two-order-cancellation.md) retains the affine logarithmic readout separately. These are written proofs; the discrete weighted limits and divisor comparison are not Lean formalized. The beta/gamma identities and Möbius inversion have classical attribution through the linked dependencies.

The [quadratic logarithmic endpoint](successor-division-quadratic-log-readout.md) has unconditional normalized limit $\pi^{3/2}$, using the classical full Selberg weight. The distinct [coherent lattice identity](actual-coherent-division-lattice-remainder.md), [mean-removal refinement](actual-coherent-successor-quadrature-refinement.md) and [dual cosine/centered ODE proof](actual-division-lattice-dual-cosine.md) retain the entire physical correction, fractional cell and periodic curvature. The signed first-logarithm comparison remains unproved.
