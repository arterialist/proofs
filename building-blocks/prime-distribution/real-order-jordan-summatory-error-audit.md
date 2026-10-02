# Real-order Jordan summatory errors: a source audit

For each fixed real order \(0<a<1/2\) and each fixed integer modulus \(m\ge1\), the centered ordinary Jordan sum has excursions of both signs at square-root scale. This contradicts the \(O_a(x^a2^{\omega(m)})\) remainder printed in Apostol–Tóth's Equation (4). We give the exact object, the pole-to-oscillation argument and a safe elementary replacement upper bound. The replacement is not asserted to be optimal, and correction history and priority remain unresolved.

## The literal published object

Let
\[
 J_a(n)=\sum_{d\mid n}\mu(d)(n/d)^a
       =n^a\prod_{p\mid n}(1-p^{-a}),\qquad a>0,
\]
and, for real \(x\ge1\) and integer \(m\ge1\), put
\[
 \Phi_{a,m}(x)=\sum_{\substack{n\le x\\(n,m)=1}}J_a(n),
 \qquad
 E_{a,m}(x)=\Phi_{a,m}(x)-c_{a,m}x^{1+a},
\]
where
\[
 c_{a,m}=
 \frac{m^a\varphi(m)}{(1+a)\zeta(1+a)J_{1+a}(m)}.
                                                               \tag{1}
\]
The sum includes the unit \(J_a(1)=1\), every ordinary divisor, and the upper endpoint when \(x\) is an integer. The modulus has no prescribed relation to the cutoff.

[Apostol and Tóth, *Some remarks on regular integers modulo n*](https://www.pmf.ni.ac.rs/filomat-content/2015/29%20-%204/F29-4-4%20-%20500.pdf), Filomat 29:4 (2015), pp. 687–701, expressly allows every fixed real \(a>0\) and states on pp. 689–690, Equation (4),
\[
 E_{a,m}(x)=O_a\bigl(x^a2^{\omega(m)}\bigr).             \tag{source 4}
\]
The current official journal PDF and [arXiv v1](https://arxiv.org/pdf/1304.2699v1) and [v2](https://arxiv.org/pdf/1304.2699v2) agree on the object, range, main term and final error. The different unitary-divisor function \(\varrho_a\) in Proposition 2.2 has an \(a>1\) restriction; it is not the function audited here. The main coefficient in (1) is correct.

## Surviving actual poles

The [common-ordinate theorem](../zeta-and-zeros/shared-ordinate-zeros-and-shifted-zeta-poles.md) supplies actual simple zeros \(\rho=1/2+i\gamma\), \(\gamma>0\), for which \(\zeta(\rho-a)\ne0\) simultaneously for every \(0<a<1/2\). The same zeros survive every finite coprimality deletion. The complete Dirichlet series is
\[
 D_{a,m}(s)=\frac{\zeta(s-a)}{\zeta(s)}H_{a,m}(s),\qquad
 H_{a,m}(s)=\prod_{p\mid m}\frac{1-p^{a-s}}{1-p^{-s}}.
                                                               \tag{2}
\]
For fixed \(a,m\), partial summation gives the centered Mellin identity
\[
 \mathcal A_{a,m}(s):=\int_1^\infty E_{a,m}(x)x^{-s-1}\,dx
       =\frac{D_{a,m}(s)}s-\frac{c_{a,m}}{s-1-a},
 \qquad \Re s>1+a.                                    \tag{3}
\]
This convergence follows from \(0\le J_a(n)\le n^a\). The unit remains in \(D_{a,m}/s\). The residue of \(D_{a,m}/s\) at \(s=1+a\) equals \(c_{a,m}\), since
\[
 H_{a,m}(1+a)=
 \prod_{p\mid m}\frac{1-p^{-1}}{1-p^{-1-a}}
 =\frac{m^a\varphi(m)}{J_{1+a}(m)}.
\]
Thus (3) removes the real main pole exactly.

The meromorphic continuation of (3) is holomorphic near every positive real point. The zeta denominator has no positive real zero; its pole at one gives a removable reciprocal zero. The local denominators \(1-p^{-s}\) can vanish only on \(\Re s=0\). The numerator's sole positive real pole is the one just removed. In particular the continuation is holomorphic at the real point \(1/2\), while at a retained simple zero it has residue
\[
 r_{a,m,\rho}
 =\frac{\zeta(\rho-a)H_{a,m}(\rho)}{\rho\zeta'(\rho)}\ne0.
                                                               \tag{4}
\]
The factor \(1/\rho\) comes from the Mellin normalization and is essential.

## Both signs at exact square-root scale

For every fixed \(0<a<1/2\), integer \(m\ge1\), and retained zero \(\rho\),
\[
 \boxed{\quad
 \limsup_{x\to\infty}\frac{E_{a,m}(x)}{\sqrt x}
       \ge |r_{a,m,\rho}|>0,
 \qquad
 \liminf_{x\to\infty}\frac{E_{a,m}(x)}{\sqrt x}
       \le-|r_{a,m,\rho}|<0.
 \quad}                                                \tag{5}
\]
These are fixed-parameter statements. They follow from the classical Landau argument, in the precise form of [Mahatab–Mukhopadhyay, Assumptions 3.1 and Theorem 3.2](https://arxiv.org/pdf/1512.03144v4): the nonreal simple pole gives the boundary limit \(|r|\), while real-point holomorphy gives both real-axis limits zero. No rightmost-zero assumption is needed.

For a direct proof, suppose \(E(x)\le b\sqrt x\) eventually for some \(0<b<|r|\). Beyond that onset set \(f(x)=b\sqrt x-E(x)\ge0\), and set it to zero before the onset. Its Mellin transform, initially convergent far to the right, is
\[
 G(s)=\frac b{s-1/2}-\mathcal A(s)+U(s),
\]
where \(U\) is entire. Landau's convergence theorem for nonnegative sources, using analyticity along the real ray \(s>1/2\), forces this integral to converge for \(\Re s>1/2\). Positivity then gives
\[
 |G(\sigma+i\gamma)|\le G(\sigma),\qquad\sigma>1/2.
\]
Multiply by \(\sigma-1/2\) and let \(\sigma\downarrow1/2\). The complex-side limit is \(|r|\), and the real-side limit is \(b\), a contradiction. Apply the same argument to \(b\sqrt x+E(x)\) for the negative excursions. If a farther-right nonreal pole prevents integral convergence, Landau's real-axis conclusion already gives the contradiction; the proof never assumes that \(\rho\) is rightmost.

The primary theorem gives noninteger witnesses through positive-measure excursion sets. Its half-weight endpoint convention leaves the Mellin integral unchanged. Alternatively, at an integer \(n\), the endpoint difference is at most \(J_a(n)/2\le n^a/2=o(\sqrt n)\), so it cannot alter this conclusion in the audited range.

Consequently \(E_{a,m}=\Omega_\pm(\sqrt x)\), and it is not \(O_{a,m}(x^a)\) for any fixed \(0<a<1/2\). The finite factor \(2^{\omega(m)}\) does not repair the printed estimate at a fixed modulus. This is stronger than finding an omitted step in a proof: it rules out the asserted bound itself in this range. We do not settle the optimal error for \(1/2\le a\le1\).

No positive oscillation amplitude or onset is established uniformly as the parameters vary. For a fixed \(m,\rho\), finite Taylor expansion gives
\[
 r_{a,m,\rho}=-a/\rho+O_{m,\rho}(a^2),\qquad a\downarrow0.
\]
The common pole-count threshold and these oscillation constants have different quantifiers. No estimate for an order depending on \(x\) follows.

## A complete elementary replacement upper bound

For all real \(a>0\), \(x\ge1\), and integers \(m\ge1\),
\[
 \boxed{\quad
 |E_{a,m}(x)|\le
 2^{\omega(m)}x^a\sum_{1\le d\le x}d^{-a}
 +\frac{\varphi(m)}m\frac{x/a+1}{1+a}.
 \quad}                                                \tag{6}
\]
In particular, \(\varphi(m)/m\le1\le2^{\omega(m)}\) gives the simpler upper
\[
 |E_{a,m}(x)|\le2^{\omega(m)}
 \left[x^a\sum_{1\le d\le x}d^{-a}+\frac{x/a+1}{1+a}\right].
                                                               \tag{7}
\]

To retain all cutoffs, first put \(P_a(y)=\sum_{1\le n\le y}n^a\). Integer-cell integration and telescoping give
\[
 \left|P_a(y)-\frac{y^{1+a}}{1+a}\right|\le y^a,
 \qquad y\ge0.                                         \tag{8}
\]
For \(y\ge1\), compare each \(n^a\) with its integral over \([n-1,n]\), bound the total difference by \(\lfloor y\rfloor^a\), and account for the remaining fractional interval. For \(0\le y<1\), the sum is empty and \(y^{1+a}/(1+a)\le y^a\).

Coprime inclusion–exclusion keeps every squarefree divisor \(r\mid m\), including \(r>y\):
\[
 P_{a,m}(y)=\sum_{r\mid m}\mu(r)r^a P_a(y/r),\qquad
 \left|P_{a,m}(y)-\frac{\varphi(m)}m\frac{y^{1+a}}{1+a}\right|
       \le2^{\omega(m)}y^a.                            \tag{9}
\]
The complete Jordan sum then regroups exactly as
\[
 \Phi_{a,m}(x)=\sum_{\substack{d\le x\\(d,m)=1}}\mu(d)P_{a,m}(x/d).
\]
Apply (9) and subtract the absolutely convergent full main coefficient. The aggregate inner error is bounded by the first term of (6). For the remaining tail, with \(M=\lfloor x\rfloor+1>x\),
\[
 \sum_{d>x}d^{-1-a}
 \le M^{-1-a}+\int_M^\infty t^{-1-a}\,dt
 \le x^{-1-a}+x^{-a}/a.
\]
Multiplication by \((\varphi(m)/m)x^{1+a}/(1+a)\) gives the second term of (6). This includes the first omitted integer at fractional cutoffs, the unit, \(x=1\), and all divisors of arbitrarily large \(m\).

The published proof drops the accumulated divisor sum from the first error and absorbs a tail of order \(x\) into \(x^a\). Retaining both gives the valid elementary regimes
\[
 E_{a,m}(x)=
 \begin{cases}
 O_a(x\,2^{\omega(m)}),&0<a<1,\\
 O(x\log(2x)\,2^{\omega(m)}),&a=1,\\
 O_a(x^a2^{\omega(m)}),&a>1.
 \end{cases}                                          \tag{10}
\]
These upper bounds have constants independent of \(x,m\), with the displayed dependence on fixed \(a\). They are safe estimates from the source's own calculation, not best-known remainder bounds. The constants are not uniform as \(a\) approaches zero or one.

## Source and proof status

The journal text was checked against the current official PDF and both arXiv versions. Its SHA-256 is `4d28afb180b39df7c1dbed2f83c4fa6bdee628bd8f31e8eaf0ae4af77f0a19b4`. A bounded search did not identify a corrigendum; this does not establish that no correction or previous discussion exists. The full 2019 Kiuchi–Matsuoka discussion was unavailable during this audit. No priority claim is made.

The [external Lean companion](../../formalization/verification/anthropic-shared-ordinate/README.md) checks the actual optimized common-set population, all-shifts noncancellation and local shifted-ratio and finite-Euler-deletion pole orders against the pinned upstream zero definitions. Its exact source import variant, runtime and axiom scope are recorded in the companion and common-ordinate note. The infinite Dirichlet/Mellin identities, interpretation through the coprimality modulus, explicit residues, real-axis continuation, Landau application and complete coprime upper estimate remain independently reviewed written analysis. This audit does not supply a stronger signed prime-error upper bound or prove RH.
