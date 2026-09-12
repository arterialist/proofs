# A single observed norm controls the zero-free half-plane

This is a written analytic implication and, with the companion arithmetic-to-norm estimate, an RH equivalence. It does not prove the required unconditional norm bound. The established unconditional estimate is still $o(\sqrt X)$, as proved in [signed scattering phase transport](signed-scattering-phase-transport.md).

Use the actual complete finite-place multiplier
$$
U_X(t)=\pi^{-it}\frac{\Gamma(1/4+it/2)}{\Gamma(1/4-it/2)}
\prod_{p\le X}\frac{1-p^{-1/2}e^{it\log p}}{1-p^{-1/2}e^{-it\log p}},
$$
and its specified continuum renormalization
$$
\widehat U_X=U_XR V_{\log X}^{+},\quad
R(t)=\frac{1+2it}{1-2it},\quad
V_A^+(t)=\exp\left(2i\int_0^A e^{a/2}\frac{\sin(at)}a\,da\right).
\tag{1}
$$
Every proper power of every prime $p\le X$ is retained. Fix a strictly positive real Schwartz observation, for example $\chi_0(t)=e^{-t^2}$, and let
$$
\mathcal N(X)=\|M_{\chi_0}\Delta(\widehat U_X)\|_1,
\qquad \Delta(U)=P-U^*PU.
\tag{2}
$$
The observation is an operator weight; it is not asserted to be the transform of a compact physical Weil test. The negative-frequency Hardy convention and finite weighted trace-class property are proved in the [semilocal foundation](semilocal-weighted-scattering.md).

## The norm-to-zero-free implication

**Theorem.** Let $\sigma\ge0$. Suppose that, for every $\epsilon>0$,
$$
\mathcal N(X)=O_\epsilon(X^{\sigma+\epsilon}).
\tag{3}
$$
Then every nontrivial zeta zero satisfies $\Re\rho\le1/2+\sigma$. For $\sigma=0$, the functional equation gives full RH, including every multiplicity.

The proof uses local $L^1$-valued analytic continuation. In particular it does not assume that a globally rightmost zero exists.

### Trace duality controls the phase derivative

For a finite smooth unitary multiplier $v$, put $b_v=-i\bar v v'$. The ordinary trace formula is
$$
\operatorname{Tr}(M_\eta\Delta(v))
=\frac1{2\pi}\int\eta(t)b_v(t)dt
$$
for Schwartz $\eta$. For any real $g\in C_c^\infty$ with $|g|\le1$, take $\eta=\chi_0g$. Since multiplication by $g$ is a contraction,
$$
\left|\int\chi_0(t)g(t)b_v(t)dt\right|
\le2\pi\|M_{\chi_0}\Delta(v)\|_1.
$$
Approximating the sign of the continuous function $b_v$ on compact intervals, and then exhausting the real line, proves
$$
\int\chi_0(t)|b_v(t)|dt
\le2\pi\|M_{\chi_0}\Delta(v)\|_1.
\tag{4}
$$
Because $\chi_0$ has a positive minimum on each compact interval $I$, (3) controls $b_{\widehat U_X}$ in $L^1(I)$.

### The full prime-power cutoff and its exact tail

Write $X=e^A$, and set
$$
b(t)=\Re\psi_{\rm digamma}(5/4+it/2)-\log\pi.
$$
The corresponding full prime-power cutoff derivative is
$$
B_A(t)=b(t)-2\sum_{n\le e^A}\frac{\Lambda(n)}{\sqrt n}\cos(t\log n)
+2\int_0^A e^{a/2}\cos(at)da.
\tag{5}
$$
It differs from the phase derivative in (1) by precisely the proper-power tail:
$$
B_A(t)-b_{\widehat U_{e^A}}(t)
=2\sum_{\substack{p\le e^A,\ k\ge2\\p^k>e^A}}
(\log p)p^{-k/2}\cos(kt\log p).
\tag{6}
$$
No $k=1$ term lies in this tail. Its absolute value is bounded uniformly in $t$ by
$$
2\sum_{p\le e^A}\frac{\log p}{p(1-p^{-1/2})}=O(A+1),
\tag{7}
$$
using the Chebyshev upper bound and partial summation. Thus, on every compact $I$,
$$
\|B_A\|_{L^1(I)}=O_{I,\epsilon}(e^{(\sigma+\epsilon)A}+A+1).
\tag{8}
$$
The family is strongly measurable in $A$, piecewise smooth between its countably many cutoff jumps, and bounded on each finite $A$ interval.

### A Banach-valued Laplace transform

For $\Re z>\sigma$, (8) defines a holomorphic $L^1(I)$-valued function
$$
\mathscr H_I(z)=z\int_0^\infty e^{-zA}B_A\,dA-b.
\tag{9}
$$
On each compact subset of this half-plane, choose $\epsilon$ smaller than its distance from the boundary. Exponential domination justifies the Bochner integral and all derivatives in $z$.

For $\Re z>\max(\sigma,1/2)$, absolute Dirichlet convergence and elementary integration of (5) identify (9) with
$$
\boxed{\mathscr H_I(z)(t)=\mathcal A(z+it)+\mathcal A(z-it),}
\quad
\mathcal A(w)=\frac{\zeta'}\zeta(1/2+w)+\frac1{w-1/2}.
\tag{10}
$$
The pole of zeta at $1$ is canceled in $\mathcal A$. Every nontrivial zero contributes its positive multiplicity as the residue of $\mathcal A$ at $w=\rho-1/2$. Formula (10) uses both cosine frequencies; no real-part operation is incorrectly moved through a complex Laplace parameter.

### An off-line zero would create a singular limit

Suppose a zero has $\Re\rho>1/2+\sigma$. In a bounded open height interval containing its ordinate, only finitely many nontrivial zeros occur. Choose one with maximal real part within that interval, write it as $\rho_0=1/2+\eta+i\gamma$, and then shrink to an interval $I$ around $\gamma$ whose closure remains inside the original interval and contains no other ordinate at that same maximal real part. Here $\eta>\sigma$. Combine multiplicities if the same zero was listed repeatedly.

For real $z>\eta$, the right side of (10) has no singularities on $I$. It is locally holomorphic in $z$ with values in $L^1(I)$. Analytic continuation along the real segment from $z>1/2$ therefore identifies it with (9) throughout $z>\eta$. The absence of intervening singularities follows from maximality in the finite height interval, not from a global assertion about all zeros.

Let $m$ be the multiplicity of $\rho_0$. Conjugation of zeta zeros gives, for $z=\eta+\delta$, $\delta>0$ small,
$$
\mathcal A(z+it)+\mathcal A(z-it)
=\frac{2m\delta}{\delta^2+(t-\gamma)^2}+G_\delta(t)
\tag{11}
$$
on a still smaller interval if necessary. After subtracting these two local principal parts, $G_\delta$ converges uniformly there to a smooth function $G_0$. Other zeros in the bounded rectangle are separated either in real part or ordinate, and all remaining meromorphic terms are regular there.

The first term in (11) converges as a distribution to $2\pi m\delta_\gamma$. Thus its distributional limit, after adding $G_0$, is not represented by an $L^1$ function. But $\eta>\sigma$, so the holomorphic function (9) is continuous in $L^1(I)$ at $z=\eta$. Its limit must be an $L^1$ function. This contradiction proves the theorem. Positivity of the multiplicity prevents removal of the delta mass; no simplicity assumption is used.

## The RH equivalence and its precise remaining premise

The proved companion estimate in [prime discrepancy scattering norm](prime-discrepancy-scattering-norm.md) maps
$\psi(x)-x=O(x^\beta(\log x)^m)$, $\beta>1/2$, to a bound
$$
N_\chi(\widehat U_X)
=O_{\chi,\beta,m}\bigl(X^{\beta-1/2}(\log X)^{m+3/2}+\log X+1\bigr).
\tag{12}
$$
Its boundary case $\beta=1/2$, $m\ge0$, is $O_\chi((\log X)^{m+5/2}+\log X+1)$. The implication below only needs a fixed polynomial logarithmic cost.

Under RH, for every $\delta>0$ the classical prime estimate is
$\psi(x)-x=O_\delta(x^{1/2+\delta})$; see [DLMF 25.16.4](https://dlmf.nist.gov/25.16.E4). Apply (12) with $\delta<\epsilon$ and absorb the logarithmic factor. Together with the theorem this gives
$$
\boxed{\mathrm{RH}\quad\Longleftrightarrow\quad
\forall\epsilon>0,\quad
\mathcal N(X)=O_\epsilon(X^\epsilon).}
\tag{13}
$$
Only one fixed everywhere-positive Schwartz observation is required. The proof retains the actual finite-place multiplier, both cosine frequencies, the zeta pole correction, and the complete proper-power tail.

The missing unconditional assertion is the subpower bound in (13). The proved $o(\sqrt X)$ theorem is weaker. This criterion gives an operator growth target for the collective signed history energy; it does not turn the available PNT remainder into RH, and it is not yet a Lean theorem.
