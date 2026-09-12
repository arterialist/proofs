# Paired metric defects and the complete finite-prime source domain

This note completes the finite-prime source-domain step needed to use the two physical ports after removal of the arithmetic cutoff. It also identifies the exact bulk term introduced by changing the conserved physical pairing to the additive-energy pairing. These are different pairings; the latter need not be Hermitian when written with the unmodified reciprocal reflection.

Use the actual sources and unconditional estimates from [actual-source-mixed-dirichlet-completion.md](actual-source-mixed-dirichlet-completion.md):
$$
g_T(x)=1_{x\ge1}\chi_T(\log x)(\psi(x)/x-1),\qquad g_T\longrightarrow g\quad\hbox{in }\mathcal E,
$$
$$
\sup_T\|g_T\|_{\mathcal E}<\infty,\qquad
\|D_ag_T\|_{\mathcal E}\le C\sqrt a\,e^{-c\sqrt{\log a}}\ (a\ge2),
\qquad \|D_ag_T\|_{\mathcal E}\le C\ (0<a\le2).
\tag{1}
$$
Here $D_af(x)=\sqrt a f(ax)$. The seed jump, density subtraction, prime powers and both cutoff endpoints are part of this source. The metric is $M=m(D_x)=4I-\mathcal K$, where $\mathcal Kf=\kappa*f$, $\kappa(x)=1$ for $|x|\le1$ and $\kappa(x)=|x|^{-2}$ otherwise. Its exact adjoints and single-prime domain are proved in [prime-transport-in-mixed-completion.md](prime-transport-in-mixed-completion.md).

## All finite-prime inverse histories converge on the actual source

Let $S$ be a fixed finite set of primes, $k=|S|$, $r_p=p^{-1/2}$, and put
$$
A_S=\prod_{p\in S}(I-r_pD_p),\qquad
D_S=\prod_{p\in S}(I-r_pD_{1/p}),\qquad U_S=A_SD_S^{-1}.
\tag{2}
$$
The factors commute. Each inverse delay series is bounded on $\mathcal E$, so $D_S^{-1}$ and $U_S$ are bounded for this fixed set. Each advance factor is injective, but has no bounded inverse on the full completion. In particular the notation below defines an inverse on the actual source, not a bounded inverse on arbitrary inputs.

For a vector $\mathbf j=(j_p)_{p\in S}\in\mathbb N^S$, set
$n(\mathbf j)=\prod_{p\in S}p^{j_p}$. Define the full advance series
$$
\mathcal A_S g_T
=\sum_{\mathbf j\in\mathbb N_0^S}n(\mathbf j)^{-1/2}D_{n(\mathbf j)}g_T.
\tag{3}
$$
It converges absolutely in $\mathcal E$, uniformly in $T$. Indeed every nonzero-index term has norm at most
$C\exp[-c\sqrt{\sum_p j_p\log p}]$. For $k\ge1$, its total is bounded by
$$
C\sum_{N\ge1}\binom{N+k-1}{k-1}e^{-c\sqrt{N\log2}}<\infty.
\tag{4}
$$
The zero-index term is bounded by (1). This estimate retains every exponent and its intermediate division history; it is not a truncation to squarefree terms. For the empty set the sum is simply $g_T$.

For each fixed $\mathbf j$, boundedness of its dilation gives convergence of its term to the corresponding term with $g$. Dominated convergence in the absolutely summable family therefore gives
$$
\mathcal A_Sg_T\longrightarrow\mathcal A_Sg\quad\hbox{in }\mathcal E.
\tag{5}
$$
Multiplication by any one advance factor telescopes the corresponding index of (3). Absolute convergence justifies rearranging the sums and applying the other bounded factors. Consequently
$$
A_S\mathcal A_Sg_T=g_T,\qquad A_S\mathcal A_Sg=g.
\tag{6}
$$
Since $A_S$ and $D_S$ commute and $A_S$ is injective, the following are the actual opposite histories:
$$
q_T=U_S^{-1}g_T=D_S\mathcal A_Sg_T\longrightarrow
q=D_S\mathcal A_Sg=U_S^{-1}g,
$$
$$
p_T=U_Sg_T\longrightarrow p=U_Sg,\qquad
Z_T=D_S^{-1}g_T\longrightarrow Z=D_S^{-1}g.
\tag{7}
$$
All convergences hold in $\mathcal E$ and have cutoff-uniform bounds depending on $S$. For compact $g_T$, the vector in (3) is also the old $L^2$ inverse: the same series converges in $L^2$, since its coefficient sum is $\prod_{p\in S}(1-r_p)^{-1}$, and the continuous embedding of $L^2$ into $\mathcal E$ identifies the two limits.

Every vector in (7) has positive support. The positive-support energy completion embeds in $L^2$ on each bounded physical interval, with the representative pinned by its vanishing on the negative half-line. This local embedding, proved in [additive-energy-reflection-domain.md](additive-energy-reflection-domain.md), therefore applies to all histories in (7), including their values close to zero. No global unweighted norm of the limiting histories is used.

## The two compact ports and signed readout survive the cutoff limit

Now fix $S=\{2,3\}$, let $P=1_{[1,\infty)}$, and retain the two actual compact sources
$$
\eta_T=(I-P)p_T,
\qquad
b_T(x)=1_{x>1/2}q_T(2x)+1_{x>1/3}q_T(3x)-q_T(6x)
\quad(1/6<x<1),
\tag{8}
$$
with $b_T=0$ elsewhere. The same definitions give $\eta,b$. The support of $\eta_T$ and $\eta$ is also contained in $[1/6,1]$: each numerator advance can reduce the causal threshold by at most its prime, while the delay resolvent preserves causality. Local $L^2$ convergence in (7) yields convergence of both ports in $L^2(1/6,1)$. Multiplication by these fixed interval indicators is used only after local convergence; no global bounded causal projection on $\mathcal E$ is assumed.

The finite-cutoff physical identity from the reflection note is
$$
\begin{split}
\sqrt c\int_1^c g_T(x)g_T(c/x)\frac{dx}{x}
={}&\sqrt c\int_1^c p_T(x)q_T(c/x)\frac{dx}{x}\\
&+\sqrt c\int_{1/6}^1
\bigl[\eta_T(x)q_T(c/x)+b_T(x)Z_T(c/x)\bigr]\frac{dx}{x},
\qquad c\ge1.
\end{split}
\tag{9}
$$
Equations (7)–(8) justify passage to the limit in every term of (9). Moreover convergence is uniform for $1\le c\le C$, for each fixed $C$. To see this, every history used belongs to the fixed physical window $[1/6,6C]$. Its unitary logarithmic image belongs to a fixed bounded logarithmic interval. The difference of each product convolution is bounded uniformly in its output point by the sum of its two $L^2$-difference times $L^2$-norm products. This is Cauchy–Schwarz for convolution; it applies separately to the two compact ports.

Thus the following complete identity holds for the actual untruncated source, at every finite observation point:
$$
\boxed{
\begin{split}
\sqrt c\int_1^c g(x)g(c/x)\frac{dx}{x}
={}&\sqrt c\int_1^c p(x)q(c/x)\frac{dx}{x}\\
&+\sqrt c\int_{1/6}^1
\bigl[\eta(x)q(c/x)+b(x)Z(c/x)\bigr]\frac{dx}{x}.
\end{split}}
\tag{10}
$$
The second integral still reads $q,Z$ on $[c,6c]$. It is not determined by the compact boundary sources alone. The constant in the convergence argument may depend on $C$ and on the admitted primes.

Let $a(v)=e^{v/2}g(e^v)$, let $H(v)$ be the first integral on the right of (10) at $c=e^v$, and let $B(v)$ be its complete second integral. Write the exact harmonic/filter readout as
$$
\mathscr T_t h=
\sum_{d\le e^t}\frac{h(t-\log d)}d
-\int_0^t e^{-3(t-v)/2}\sum_{d\le e^v}\frac{h(v-\log d)}d\,dv.
\tag{11}
$$
Uniform convergence on the fixed observation window permits this finite harmonic sum and finite integral. The complete arithmetic quantities use the [harmonic-convolution normalization](harmonic-convolution.md):

$$
T(x)=\sum_{p^j\le x}(x-p^j)(j-1)(\log p)^2,\qquad
S_{\rm crit}(x)=\sum_{d\le x}\sqrt d\,T(x/d),\qquad
s_{\rm crit}(t)=e^{-3t/2}S_{\rm crit}(e^t).
$$

Here $W$ is exactly the complete sum in the [actual sign criterion](actual-critical-sign-criterion.md). The harmonic-convolution theorem proves its full identity and $s_{\rm crit}(t)=t^2/6+O(t)$ without discarding prime powers.

The actual signed bridge is therefore still
$$
\boxed{e^{-3t/2}W(e^t)=\mathscr T_t H+\mathscr T_t B-s_{\rm crit}(t).}
\tag{12}
$$
The all-power subtraction, harmonic coefficients, density, initial seed, and both ports have been retained. No growing-observation bound or sign follows from this domain completion.

## Exact full-product bulk defect in the changed pairing

The following calculations take place first on the old $L^2(0,\infty)$ histories, embedded into the full additive line by zero extension. Regard $D_a$ and $U_S$ on the full line; they preserve each half-axis and are unitary in the old metric. Let $\mathcal R_cf(x)=\sqrt c\,f(c/x)/x$ for $x>0$, zero otherwise. It is the old selfadjoint reciprocal reflection on the positive half-axis. Since
$\mathcal R_cU_S^{-1}=U_S\mathcal R_c$, the old physical pairing
$b_0(f,h)=\langle f,\mathcal R_ch\rangle_2$ is conserved by the opposite transports.

If it is replaced by $b_E(f,h)=\langle f,\mathcal R_ch\rangle_{\mathcal E}$, the exact result is instead
$$
\boxed{
b_E(U_Sf,U_S^{-1}h)-b_E(f,h)
=\left\langle f,(U_S^{-1}MU_S-M)\mathcal R_ch\right\rangle_2
=\left\langle f,(\mathcal K-U_S^{-1}\mathcal KU_S)\mathcal R_ch\right\rangle_2.}
\tag{13}
$$
All operators in (13) are bounded on this old $L^2$ domain. The first equality follows by moving the old unitary $U_S$ across the inner product; the second uses $M=4I-\mathcal K$. Neither equality asserts that full reflection extends to the actual limiting source in $\mathcal E$. In fact it does not, by the reflection note.

For an ordered list $p_1,\ldots,p_k$ of the admitted primes, let $T_0=I$ and $T_j=U_{p_j}T_{j-1}$. Telescoping gives the exact intermediate-history expansion
$$
U_S^{-1}MU_S-M
=\sum_{j=1}^k T_{j-1}^{-1}
(U_{p_j}^{-1}MU_{p_j}-M)T_{j-1}.
\tag{14}
$$
Thus the full product contains the metric defect at each prime evaluated on the preceding history. The defect is not a sum of independent scalar prime corrections. On the completed space itself the bounded norm-defect identity is
$$
U_S^\dagger U_S-I
=\sum_{j=1}^kT_{j-1}^\dagger
(U_{p_j}^\dagger U_{p_j}-I)T_{j-1},
\tag{15}
$$
where each single-prime defect retains both full resolvents and its same-prime term as in equation (12) of the prime-transport note.

An alternative way to display (13), without any inverse metric, is
$$
4b_0(f,h)=b_E(f,h)+\langle f,\mathcal K\mathcal R_ch\rangle_2.
\tag{16}
$$
The changes of the two terms on the right cancel exactly under the opposite transports. Dropping the convolution term changes the conservation law. Also, because $M$ does not commute with $\mathcal R_c$, the modified pairing $b_E$ is not in general Hermitian. A selfadjoint form built from it must first be symmetrized, and inherits the symmetrized version of the same bulk defect.

The physical form can instead be represented through $M^{-1}\mathcal R_c$ on its stated energy-dual domain, as in equation (14) of the reflection note. This retains the original conservation, but the inverse metric is unbounded at zero additive frequency. Equations (10)–(12) complete the actual source by local windows and do not require that inverse-metric domain to contain the full reflected source.

Finally, the single-prime failure of bounded invertibility cannot be repaired by a norm equivalent to $\mathcal E$. An equivalent norm preserves whether an operator is bounded below; the approximate null sequence for $U_p$ therefore survives. In particular no equivalent Hilbert norm on this completion can make the actual $U_p$ unitary. The positive comparison constructed in [positive-prime-comparison-in-mixed-completion.md](positive-prime-comparison-in-mixed-completion.md) changes the dilation operators themselves, and its source and readout must be transformed accordingly. None of these identities settles the sign of the literal arithmetic expression (12).

All domain, transport and readout assertions in this note are written mathematics. They make no Lean or arithmetic-sign claim.
