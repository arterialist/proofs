# The full time-ordered factorial birth correction is trace class

This proof strengthens the [diagonal loading theorem](factorial-source-clock-loading.md) to every polarized birth pair, including the actual unequal admission clocks. It uses the proved original-L2 domain and bounded forms, the full causal prime process, and the ordinary unconditional PNT error. It proves a structural arithmetic constraint on the complete signed correction. It does not bound the remaining original source energy at the RH scale.

All physical functions belong to the unchanged Hilbert space
$\mathcal H=L^2((1,\infty),dx)$. Put
$$
Hf=x^{-1}\int_1^x f,\qquad V=I-H,\qquad
b=xF'/F,\qquad R=V-bH.
$$
Here F is the full actual factorial potential. The [original-domain identities](factorial-ground-state-original-l2-domain.md) give
$$
\|Vf\|=\|f\|,\quad\|H\|\le2,\qquad
Q(f,g):=B_P(f,g)-B_C(f,g)
=\langle f,g\rangle-\langle Rf,Rg\rangle .
\tag{1}
$$
Thus Q is a bounded Hermitian form on the original space, and
$$
Q(f,g)=\langle Vf,bHg\rangle+\langle bHf,Vg\rangle
                     -\langle bHf,bHg\rangle .
\tag{2}
$$
Every observing prime power remains in B_P, including powers larger than a source cutoff. Formula (2) is an exact representation of their signed difference with density.

The actual births are
$$
v_n=\Lambda(n)\beta_n-\int_{n-1}^n\beta_y\,dy,\qquad
\beta_y(x)=\mathbf1_{x\ge y}/x,\qquad n\ge2.
\tag{3}
$$
Their support is contained in $[n-1,\infty)$, and
$$
a_n^2:=\|v_n\|^2\le C\frac{\Lambda(n)^2+1}{n-1}.
\tag{4}
$$
Let $T_s$ be the [full causal contraction semigroup](../successor-and-division/positive-successor-seed-jump-process.md). Its bounded generator is
$\mathsf A$, with $T_s=\exp(-s\mathsf A)$. Both T_s and $\mathsf A$ preserve each right-support subspace. No commutation between R or Q and T_s is assumed.

## 1. Two summable actual tail weights

For n>=3 set
$$
\beta_n^*=\mathop{\rm ess\,sup}_{x\ge n-1}|b(x)|,\qquad
A_*=\sum_{n\ge3}\beta_n^*a_n^2,\qquad
B_*=\sum_{n\ge3}(\beta_n^*)^2a_n^2.
\tag{5}
$$
The symbols $\beta_y$ in (3) and $\beta_n^*$ in (5) have different roles. The latter are scalar coefficient bounds.

The ordinary PNT error and the positive lower bound for F give
$$
\beta_n^*\le C\exp(-\nu\sqrt{\log(n-1)}).
\tag{6}
$$
Therefore A_* and B_* are finite. This requires no RH-strength error: even
$\Lambda(n)\le\log n$ in (4) suffices. If A_*(N), B_*(N) denote the corresponding sums over n>N, then, for some eta>0,
$$
A_*(N)+B_*(N)\le C\exp(-\eta\sqrt{\log N}),\qquad N\ge3.
\tag{7}
$$
To check the tail bound, compare with
$\int_{\log N}^{\infty}(1+u^2)e^{-\nu\sqrt u}\,du$;
the polynomial factor is absorbed by decreasing the exponent constant.

## 2. The full Gram correction at any nonnegative birth clocks

Choose arbitrary nonnegative numbers $\tau_n$, n>=3, and put
$f_n=T_{\tau_n}v_n$. Define column operators from
$\ell^2(\{3,4,\ldots\})$ to $\mathcal H$ by
$$
Ue_n=|b|^{1/2}Vf_n,\qquad
We_n=|b|^{1/2}Hf_n,\qquad
Ze_n=bHf_n.
\tag{8}
$$
These are literal Hilbert--Schmidt operators:
$$
\|U\|_{\rm HS}^2\le A_*,\qquad
\|W\|_{\rm HS}^2\le4A_*,\qquad
\|Z\|_{\rm HS}^2\le4B_*.
\tag{9}
$$
Indeed V, H and T_s preserve right support; on the support of the nth column, |b|<=beta_n^*. Use contraction, the isometry of V and the bound for H. Since n>=3, the singular endpoint x=1 is absent from these columns.

Let J be multiplication by sign(b), setting it to zero where b=0. Then
$$
\boxed{\mathcal Q=U^*JW+W^*JU-Z^*Z}
\tag{10}
$$
is a self-adjoint trace-class operator. Its matrix is exactly
$$
\langle e_i,\mathcal Qe_j\rangle=Q(f_i,f_j).
\tag{11}
$$
In particular
$$
\|\mathcal Q\|_1\le4A_*+4B_*.
\tag{12}
$$
This controls the entire polarized matrix, not only its diagonal.
If P_N projects onto 3<=n<=N, Hilbert--Schmidt product estimates give
$$
\|\mathcal Q-P_N\mathcal QP_N\|_1
\le8\{\sqrt{A_*A_*(N)}+\sqrt{B_*B_*(N)}\}
\le C e^{-\eta_1\sqrt{\log N}}.
\tag{13}
$$
All bounds are uniform over the chosen nonnegative clocks. For example, expand
$U^*JW-P_NU^*JWP_N$ as
$U^*JW(I-P_N)+(I-P_N)U^*JWP_N$, and apply the product inequality
$\|A^*B\|_1\le\|A\|_{\rm HS}\|B\|_{\rm HS}$.
The other two terms are treated identically.

The diagonal sum in the previous note is recovered as
$\operatorname{Tr}\mathcal Q=\sum Q(f_n,f_n)$. Trace class does not imply that the unweighted sum of every off-diagonal matrix entry converges.

## 3. A common-time differentiable family in trace norm

Let $\mathcal Q(s)$ be (10) with every column $T_sv_n$.
This family is continuously differentiable in trace norm, and
$$
\mathcal Q'(s)_{ij}
=-Q(\mathsf A T_sv_i,T_sv_j)-Q(T_sv_i,\mathsf A T_sv_j).
\tag{14}
$$
For completeness, the column derivative in U is
$-|b|^{1/2}V\mathsf A T_sv_n$; its Hilbert--Schmidt square sum is at most
$\|\mathsf A\|^2 A_*$. The analogous bounds for W and Z have factors 4A_* and 4B_*. Bounded-generator Taylor remainders obey the same right-support weighted bounds. Hence the column maps are differentiable in Hilbert--Schmidt norm, which justifies the trace-norm product rule in (14).

The same factorization and tail estimates imply
$$
\sup_{s\ge0}
\|\mathcal Q'(s)-P_N\mathcal Q'(s)P_N\|_1
\le C\|\mathsf A\|e^{-\eta_2\sqrt{\log N}},
\tag{15}
$$
and a finite uniform bound without P_N. No positivity of the derivative form is used.

## 4. The actual time-ordered birth matrix is also trace class

Now fix c>0 and take the original admissions $s_n=c\log n$.
The actual mixed work pairs both births at the LATER admission time.
Define
$$
\mathcal C_{ij}
=Q(T_{s_{\max(i,j)}}v_i,T_{s_{\max(i,j)}}v_j),
\qquad i,j\ge3.
\tag{16}
$$
This is different from the Gram matrix with separate times s_i and s_j in (11). The distinction is essential for the actual cocycle.

For s>=0 let P(s) project onto those indices n>=3 with s_n<s. The following integral converges in trace norm:
$$
\boxed{\mathcal C=\mathcal Q(0)+
\int_0^\infty
\{\mathcal Q'(s)-P(s)\mathcal Q'(s)P(s)\}\,ds.}
\tag{17}
$$
For large s, the integrand has trace norm at most
$C_c e^{-\eta_3\sqrt{s/c}}$, by (15); on the finite initial interval it is uniformly bounded. This proves convergence as an improper Bochner integral.

For each fixed pair i,j, the multiplier of $\mathcal Q'(s)_{ij}$ in the integrand is exactly $\mathbf1_{s\le\max(s_i,s_j)}$, up to immaterial equality endpoints. Entrywise integration of (14) proves (16). Thus the matrix defined by the true admission clocks is a self-adjoint trace-class operator.

There is also a tail estimate
$$
\boxed{\|\mathcal C-P_N\mathcal CP_N\|_1
\le C_c e^{-\eta_c\sqrt{\log N}}.}
\tag{18}
$$
Split (17) at s_N. Below s_N, P(s)<=P_N and the compressed difference of its integrand equals
$\mathcal Q'(s)-P_N\mathcal Q'(s)P_N$, so (15) is integrated over an interval of length c log N. Above s_N, the P_N compression of the integrand vanishes and its full trace norm is integrable with the displayed exponential-in-square-root tail. Absorb both resulting polynomial factors by reducing eta_c. The initial term is handled by (13).

## 5. Keep the literal seed and the first density cell

The actual source is
$$
g_N=g_1+\sum_{n=2}^N v_n,\qquad g_1=-1/x.
\tag{19}
$$
The preceding Hilbert--Schmidt factorization started at n=3 only to avoid a spurious singular weighted factor on g_1 near x=1. We now restore the seed and v_2 exactly.

If g has support in [n-1,infinity), n>=3, formula (2) and right support give
$$
|Q(f,g)|\le
4\beta_n^*(1+\beta_n^*)\|f\|\|g\|,\qquad f\in\mathcal H.
\tag{20}
$$
Every integrand in (2) lies where the late input or its Hardy image is supported; hence the same tail bound for b applies even if f reaches the singular initial endpoint.

Adjoin an index 0 for u_0=g_1, with s_0=0, and an index 2 for u_2=v_2. Set u_n=v_n for n>=3. For indices in $\{0,2,3,\ldots\}$, let
$$
\mathfrak C_{ij}
=Q(T_{\max(s_i,s_j)}u_i,T_{\max(s_i,s_j)}u_j).
\tag{21}
$$
Its 2 by 2 initial block is finite because Q is bounded on the full original space. For each initial index i in {0,2}, (20) proves
$$
\sum_{n\ge3}|\mathfrak C_{in}|^2
\le C\|u_i\|^2
\sum_{n\ge3}(\beta_n^*)^2(1+\beta_n^*)^2a_n^2<\infty.
\tag{22}
$$
Each initial cross row therefore defines a bounded finite-rank extension. Together with (17), this proves that the complete $\mathfrak C$, including seed and first cell, is self-adjoint and trace class. Its tails have the same qualitative bound (18), with the initial indices retained in every compression.

There is no undefined singular integral of $|b||Vg_1|^2$ in this argument. It would diverge; boundedness of Q and the one-sided support argument are what justify the initial block and rows.

## 6. Exact signed budget and the remaining obstruction

Let $\mathbf1_N$ be the finite coefficient vector equal to 1 on indices 0,2,...,N. It has square norm N. Set $s_1=c\log1=0$, and use the actual quantities
$$
W_N^Q=\sum_{n=2}^N
\operatorname{Re}Q(T_{s_n}g_{n-1},T_{s_n}v_n),\quad
L_N^Q=\sum_{n=2}^N Q(T_{s_n}v_n,T_{s_n}v_n),
$$
$$
J_N^Q=Q(T_{s_N}g_N,T_{s_N}g_N),\quad
D_N^Q=\sum_{n=2}^N\int_{s_{n-1}}^{s_n}
2\operatorname{Re}Q(T_sg_{n-1},\mathsf A T_sg_{n-1})\,ds.
\tag{23}
$$
Expanding (21) at finite N, followed by the exact seeded telescope, gives
$$
\boxed{
\langle\mathbf1_N,\mathfrak C\mathbf1_N\rangle
=Q(g_1,g_1)+2W_N^Q+L_N^Q
=J_N^Q+D_N^Q.}
\tag{24}
$$
Thus (17)--(22) constrain the actual complete prime-minus-density budget, with both mixed orders, the full density ramps, every prime observation and the unequal clock intervals retained. No component dissipation sign is asserted.

Compactness does imply
$$
J_N^Q+D_N^Q=o(N),
\tag{25}
$$
because $\mathbf1_N/\sqrt N$ is a bounded weakly null sequence and $\mathfrak C$ is compact. This statement is not presented as a better error exponent than already follows from the PNT source estimates.

Trace class does not supply an RH-scale bound for (24). The actual coefficient vector of infinitely many successive births is the constant sequence, which is not in $\ell^2$. For an explicit limitation of this operator-class argument, choose $u_n=n^{-\alpha}$, $1/2<\alpha<1$. The positive rank-one operator $u\otimes u$ is trace class and has polynomially decaying trace-norm tails, stronger than (18), but
$$
\langle\mathbf1_N,(u\otimes u)\mathbf1_N\rangle
\asymp N^{2-2\alpha}.
\tag{26}
$$
This example concerns an inference from trace class alone, not a replacement of the actual arithmetic matrix or a counterexample to RH.

The new unconditional constraint is the trace-class factorization of the entire arithmetic correction and its exact time-ordered, seeded budget identity. To obtain an RH bound one must still control its actual coherent constant-coefficient direction together with the ground-gradient budget. Neither (10) nor (17) supplies that missing estimate.

## Dependencies and formal scope

The [factorial maximal domain and inverse](factorial-ground-state-original-l2-domain.md) make $Q=B_P-B_C$ a bounded form on the original space. The [Picone source identity](../dynamics-and-feedback/picone-frozen-source-work.md), [diagonal loading theorem](factorial-source-clock-loading.md) and [growing-time cocycle](../dynamics-and-feedback/growing-time-actual-source-cocycle.md) retain every arithmetic cell and the initial source. Hilbert–Schmidt product inequalities, trace-norm differentiation and Bochner integration are classical operator tools; the actual weighted columns and the later-admission-time matrix are constructed explicitly here. This is a written proof, with no Lean formalization of the trace-class matrix or coherent constant-coefficient estimate.
