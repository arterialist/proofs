# Complete dyadic Weil comparison with large finite histories

Developed in the RH Agent3 branch, with independent mathematical review by RH Proof. The full analytic conclusions remain written proofs; compiled finite algebra is linked separately. No novelty or RH claim is made.

Written proof, independently audited by the Sol medium math worker
and structurally checked by RH Proof. This is an unconditional
comparison of the full actual Weil scalar. It provides no positivity
of that scalar and is not yet a Lean formalization.

Let \(h\in C_c^\infty(\mathbb R;\mathbb C)\) be fixed and pole-null.
Use the actual local-factor convention and compact histories from the
dyadic transport notes. For \(\mathcal B_P=\{p:P<p\le2P\}\),
take \(M(P)=\lceil KP\rceil\), where \(K\) is an absolute constant
chosen below, and set \(H_P=\prod_{p\in\mathcal B_P}V_{p,M(P)}h\).
Every \(H_P\) is a literal compact smooth pole-null physical test.
If physical tests are required to lie in \(v\ge0\), a common
translation moves the finite support there. Translation preserves
both pole-null conditions, autocorrelation, the full Weil scalar,
and the paired zero weight. All estimates therefore remain identical.

## Unconditional inputs and exact zero orientation

The standard compact explicit formula gives, counting every nontrivial
zero with multiplicity,

\[
Q(f)=\sum_\rho \Phi_f(z_\rho),\qquad
z_\rho=\rho-1/2,\qquad
\Phi_f(z)=M_z(f)\overline{M_{-\overline z}(f)}.
\]

Both the arithmetic and archimedean sides are the complete Weil form
used in the preceding notes; the arithmetic sum includes every prime
power. For each fixed compact test the zero sum is absolutely convergent.
No critical-line assumption is used in this identity.

We use the unconditional classical zero-free region from
[Mossinghoff, Trudgian and Yang, Theorem 1.3](https://arxiv.org/pdf/2212.06867),
which excludes zeros with \(\Re\rho\ge1-1/(5.558691\log|\Im\rho|)\)
for \(|\Im\rho|\ge2\). Reflection symmetry and a finite-height
adjustment give an absolute \(c_0>0\) such that every actual
nontrivial zero satisfies

\[
\delta_\rho=\min(\Re\rho,1-\Re\rho)
\ge\frac{c_0}{\log(|\Im\rho|+3)}.
\]

The finite adjustment uses that zeros are isolated and lie strictly
inside the strip, so a bounded-height set is finite. We also use the
unconditional count \(N(T)=O(T\log(T+3))\), with multiplicities.
These are classical mathematical dependencies, not assumptions of RH.
They remain dependencies for eventual Lean formalization.

Because the finite translation coefficients are real,

\[
\Phi_{H_P}(z)=A_P(z)\Phi_h(z),\qquad
A_P(z)=v_B(z)v_B(-z)
=\prod_p(1-d_p(z))(1-d_p(-z)),
\]

where \(d_p(z)=(1-p^{-1})p^{-M(z+1/2)}/(1-p^{z-1/2})\).
This paired orientation cancels \(u_B(z)u_B(-z)=1\) exactly.

## Low zeros and the boundary denominator

Split the exact zero sum at \(T(P)=e^P\). Below this height,
\(\delta_\rho\ge c_0/(2P)\) for sufficiently large \(P\).
For either sign of \(z_\rho\),

\[
|1-p^{-1/2}e^{\pm z_\rho\log p}|
\ge1-p^{-\delta_\rho}.
\]

The inequality \(1-e^{-y}\ge y/(1+y)\) gives the uniform inverse
denominator bound \(O(P/\log P)\). Hence Chebyshev's dyadic
count yields

\[
E_P^{\rm low}:=
\sup_{|\Im\rho|\le e^P}\sum_{p\in\mathcal B_P}
(|d_p(z_\rho)|+|d_p(-z_\rho)|)
\le C\frac{P^{2-Kc_0/2}}{\log^2P}.
\]

Choose \(Kc_0/2>5\). Then \(E_P^{\rm low}=O(P^{-3})\), and
the elementary finite-product estimate gives
\(\sup_{|\Im\rho|\le e^P}|A_P(z_\rho)-1|=O(P^{-3})\).
The constants need not control a strip containing all high zeros.

## Global bound and the high-zero tail

For every \(|\Re z|\le1/2\), each of the \(M\) advanced
summands in \(v_{p,M}(z)\) has modulus at most one, and so does
the forward summand. Thus

\[
|v_{p,M}(z)|\le M+1,\qquad
|A_P(z)|\le(M+1)^{2\#\mathcal B_P}\le e^{C_*P}.
\]

The constant \(C_*\) is independent of the fixed chosen \(K\)
for sufficiently large \(P\): then \(\log(M+1)\le2\log P\).
This removes any circularity in the choices of constants.

Repeated integration by parts for the fixed smooth compact \(h\)
gives, for every fixed \(L\), uniformly on the entire closed strip,

\[
|\Phi_h(\sigma+i\gamma)|
\le C_{h,L}(1+|\gamma|)^{-L},\qquad |\sigma|\le1/2.
\]

With the unconditional zero count, this implies
\(\sum_{|\Im\rho|>T}|\Phi_h(z_\rho)|
=O_{h,L}(T^{1-L}\log(T+3))\). Choose a fixed integer
\(L>C_*+3\). The high-zero comparison is consequently

\[
\sum_{|\Im\rho|>e^P}|A_P(z_\rho)-1||\Phi_h(z_\rho)|
\le C_{h,L}P e^{(C_*+1-L)P},
\]

which is exponentially small. The low-zero bound multiplies
\(\sum_\rho|\Phi_h(z_\rho)|<\infty\), rather than the number
of low zeros. Every multiplicity is retained.

## Full signed arithmetic consequence

Applying these bounds to the exact compact explicit formula proves

\[
Q(H_P)-Q(h)=O_h(P^{-3}).
\]

The real-axis operator error is
\(O((P/\log P)P^{-M(P)/2})\), by actual-factor telescoping.
It also bounds the complete archimedean scalar difference after
multiplication by the fixed integrable weight
\(|F_h(t)|^2|\Re\psi(1/4+it/2)-\log\pi|\).
Both literal pole terms are zero. Therefore the complete signed
prime-power row satisfies

\[
\left|
-2\Re\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
[C_{H_P}(\log n)-C_h(\log n)]
\right|=O_h(P^{-3}).
\]

This bounds every joint cofactor cross term in their actual sum.
The sum is finite for each \(P\), with observing range at most
\(n\le\exp(d+M(P)\sum_{p\in\mathcal B_P}\log p)\), where
\(d=\operatorname{diam}(\operatorname{supp}h)\). Endpoint test
values are retained exactly; the fixed origin lies below the arithmetic
range and remains accounted for in the compact explicit formula.
The support cost is \(O(KP^2)\).

For any fixed requested power \(R>0\), choosing
\(Kc_0/2>R+2\) gives the corresponding \(O_h(P^{-R})\)
comparison by the same proof. The limiting scalar is the original
\(Q(h)\), whose sign is unknown in general. Large histories repair
full scalar fidelity; they do not establish the positivity required
for RH or remove any off-critical zero from the actual zeta function.
