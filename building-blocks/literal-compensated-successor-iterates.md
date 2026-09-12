# Literal compensated successor iterates at a finite natural cutoff

This written proof uses the classical renewal recurrence to resolve the actual rank-one compensation. It retains the entire arithmetic driver and proves positivity only for the specified reference orbit. The [literal successor and charge](actual-successor-resonance-charge-cocycle.md) have separate Lean coverage; the iterate and renewal results below are not formalized there.

This note uses original physical $L^2(dx)$, or its unitary age representation. Fix the actual frozen source
$$
 g_N(x)=\mathbf1_{x\ge1}\frac{E_\psi(\min(x,N))}{x},
 \qquad a_N=Ug_N,\qquad N\ge2.
$$
The literal successor is $SH(x)=\mathbf1_{x\ge1}H(x+1)$. Write $h_1(x)=x^{-1}\mathbf1_{x\ge1}$, $a_0=Uh_1$, and
$$
 Q(H)=\frac12\int_1^\infty H(x)x^{-1/2}dx,\qquad
 \delta(H)=Q(SH)-Q(H),\qquad C=S-h_1\delta.
$$
In age coordinates the same $C$ is $S-a_0\delta$. Every function below at finite $N,k$ has an absolute charge integral, so these formulas are legitimate. $S$ is an original-$L^2$ contraction, and $\delta$ is a bounded original-$L^2$ functional by its [proved age kernel](charge-compensated-successor-memory.md#formalized-finite-prime-memory-domains). No positivity of $C$ on general functions is assumed.

The conclusion is an exact finite scalar renewal resolution of the compensation, with a bounded positive seed orbit. It gives a power bound independent of the number of successors for each finite source, and an explicit full-history Gram at $k$ comparable to $N$. Its absolute estimate is still of square-root size; it does not prove the logarithmic-time source target.

## 1. Every rank-one feedback term in the finite iterate

Put $\kappa_j=\delta(C^j g_N)$. Finite induction gives
$$
 \boxed{C^kg_N=S^kg_N-\sum_{j=0}^{k-1}
                          \kappa_jS^{k-1-j}h_1.}
\tag{1}
$$
Here $S^kg_N(x)=g_N(x+k)$ on $x\ge1$, and $S^\ell h_1(x)=1/(x+\ell)$. In particular, once $k\ge N-1$,
$$
 \boxed{C^kg_N(x)=\frac{E_\psi(N)}{x+k}
           -\sum_{j=0}^{k-1}\frac{\kappa_j}{x+k-1-j},
                    \qquad x\ge1.}
\tag{2}
$$
The equality at $x+k=N$ uses the actual right-continuous frozen value, including an arithmetic arrival at $N$. Thus the terminal term has not disappeared under iteration. Its original norm is
$$
 \|S^kg_N\|_2=\frac{|E_\psi(N)|}{\sqrt{k+1}},
                         \qquad k\ge N-1.
\tag{3}
$$

Define the exact seed charges
$$
 q_j=Q(S^jh_1)=
 \begin{cases}1,&j=0,\\
 \arctan(\sqrt j)/\sqrt j,&j>0,
 \end{cases}
 \qquad d_j=q_j-q_{j+1}>0.
\tag{4}
$$
They follow by substituting $x=y^2$ in the charge integral. Let
$$
 A_j=Q(S^jg_N),\qquad e_j=A_{j+1}-A_j.
$$
Applying $\delta$ to (1) proves the exact feedback recurrence
$$
 \boxed{\kappa_j=e_j+\sum_{i=0}^{j-1}d_{j-1-i}\kappa_i.}
\tag{5}
$$
The driver is the ordinary shifted source, not an assumed positive iterate. For $j\ge N-1$, it is explicitly $e_j=-E_\psi(N)d_j$.

Compensation preserves the actual charge. Thus (1) also gives the signed identity
$$
 \boxed{\sum_{j<k}\kappa_jq_{k-1-j}=A_k-M_N,}
 \qquad M_N=Q(g_N).
\tag{6}
$$
For each fixed $N$, $A_k=E_\psi(N)q_k\to0$, so this weighted feedback approaches $-M_N$. It cannot simply be removed when the ordinary shift becomes small.

## 2. A constructive stable resolution of the feedback

Let $r_0=1$, and set
$$
 r_n=\sum_{m=1}^n d_{m-1}r_{n-m},\qquad n\ge1.
\tag{7}
$$
These are nonnegative renewal coefficients. Since $\sum_{j\ge0}d_j=q_0=1$, induction gives $r_n\le1$. The feedback has total mass one, not a strictly contracting scalar mass. Its mean delay is infinite since $\sum_jq_j=\infty$.

A direct difference of consecutive convolutions proves
$$
 \boxed{\sum_{i=0}^nr_iq_{n-i}=1,\qquad n\ge0.}
\tag{8}
$$
Indeed the difference at $n$ equals
$r_n-\sum_{i<n}r_id_{n-1-i}=0$, and its initial value is one. Equations (5) and (7) give $\kappa=r*e$. Define
$$
 V_k=\sum_{j=0}^k r_jS^{k-j}h_1.
$$
Applying (1) to the seed itself, whose driver is $-d_j$, shows $\delta(C^jh_1)=-r_{j+1}$. Hence
$$
 \boxed{V_k=C^kh_1\ge0.}
\tag{9}
$$
This positivity is proved for this seed orbit only.

The elementary inequality
$\arctan x\ge x/\sqrt{1+x^2}$ gives
$\|S^\ell h_1\|_2=(1+\ell)^{-1/2}\le q_\ell$. Therefore (8) proves
$$
 \boxed{\|V_k\|_2\le1,\qquad Q(V_k)=1,\quad k\ge0.}
\tag{10}
$$
The rank-one feedback has thus been resolved without an exponential estimate on $\|C\|^k$. Rearranging the finite sums in (1) gives the useful driver formula
$$
 \boxed{C^kg_N=S^kg_N-\sum_{i=0}^{k-1}e_iV_{k-1-i}.}
\tag{11}
$$

Every $e_i$ is an explicit finite-source arithmetic quantity. For a birth at $t\ge1$, put
$$
 q_j(t)=Q(S^jh_t)=
 \begin{cases}
 t^{-1/2},&j=0,\\
 j^{-1/2}\arctan\sqrt{j/\max(1,t-j)},&j>0.
 \end{cases}
\tag{12}
$$
The full source then gives
$$
 A_j=-q_j(1)+\sum_{2\le n\le N}\Lambda(n)q_j(n)
                                    -\int_1^Nq_j(t)dt.
\tag{13}
$$
This retains the negative seed, every proper power and the whole cell continuum.

For fixed $t$, the continuous extension of $q_j(t)$ increases until $j=t-1$, then decreases to zero. On the increasing part it is
$\arcsin\sqrt{j/t}/\sqrt j$; monotonicity follows from that of $\arcsin y/y$. Its maximum is at most $\pi/(2\sqrt t)$. Thus its discrete total variation is bounded by
$$
 \sum_{j\ge0}|q_{j+1}(t)-q_j(t)|
      =2\max_{j\in\mathbb Z_{\ge0}}q_j(t)-q_0(t)
      \le(\pi-1)t^{-1/2}.
$$
Using (13), including its signed density, gives
$$
 \boxed{\sum_{j\ge0}|e_j|
 \le(\pi-1)\left[\sum_{2\le n\le N}\frac{\Lambda(n)}{\sqrt n}
                                      +2\sqrt N-1\right]
 \le C\sqrt N.}
\tag{14}
$$
The last estimate uses Chebyshev and partial summation. In particular the driver is absolutely summable for every literal source. Formula (11) supplies
$$
 \|C^kg_N\|_2\le\|S^kg_N\|_2+\sum_{i<k}|e_i|,
\tag{15}
$$
a bound independent of $k$ after bounding the shift by $\|g_N\|_2$. It is a finite-source result, not power boundedness of $C$ on unrestricted $L^2$.

## 3. The exact original norm, before and after the full prime process

For $k\ge N-1$, define $\alpha_k=E_\psi(N)$ and
$\alpha_\ell=-\kappa_{k-1-\ell}$, $0\le\ell<k$. The complete norm is the finite signed Gram
$$
 \boxed{\|C^kg_N\|_2^2
       =\sum_{\ell,m=0}^k\overline{\alpha_\ell}\alpha_mG(\ell,m),}
 \quad
 G(\ell,m)=
 \begin{cases}
 \dfrac{\log((m+1)/(\ell+1))}{m-\ell},&m\ne\ell,\\
 (1+\ell)^{-1},&m=\ell.
 \end{cases}
\tag{16}
$$
The actual coefficients are real, but the conjugation makes the original $L^2$ convention explicit. Neither the terminal-feedback nor the feedback-feedback cross terms are discarded.

Let $\phi_\ell=U(S^\ell h_1)$ and let $T_t$ be the complete prime-only age semigroup from the logarithmic-time target. At the same process time $t$ for the entire source,
$$
 \boxed{\|T_tUC^kg_N\|_2^2
        =\sum_{\ell,m=0}^k\overline{\alpha_\ell}\alpha_mG_t(\ell,m),\qquad
 G_t(\ell,m)=\langle T_t\phi_\ell,T_t\phi_m\rangle.}
\tag{17}
$$
This Gram has an exact two-history expression. For ages $u,v$, put
$L=\max(e^u,e^v)$, $A=\ell e^u$, $B=m e^v$. The dilation overlap is
$$
 G_{u,v}(\ell,m)=e^{(u+v)/2}
 \begin{cases}
 \dfrac{\log((L+B)/(L+A))}{B-A},&A\ne B,\\
 (L+A)^{-1},&A=B.
 \end{cases}
\tag{18}
$$
Indeed the dilated physical seed is
$e^{u/2}(x+\ell e^u)^{-1}\mathbf1_{x\ge e^u}$. Consequently
$$
 G_t(\ell,m)=\iint G_{u,v}(\ell,m)\,\mu_t(du)\mu_t(dv).
$$
Every no-jump and positive-age pair is retained. Cauchy bounds the integrand by
$(1+\ell)^{-1/2}(1+m)^{-1/2}$, so no positive exponential age moment is needed. This is the full actual process with all proper powers.

Contraction and (10)--(11) imply, at $k\ge N-1$,
$$
 \|T_tUC^kg_N\|_2
 \le |E_\psi(N)|/\sqrt{k+1}+\sum_{i<k}|e_i|.
\tag{19}
$$
At $k$ comparable to $N$, (14) makes this only $O(\sqrt N)$. The exact sharper quantity is the signed Gram (17), or its equivalent driver version obtained from (11). It is not replaced by the absolute estimate (19).

## 4. Why the small evolved first difference does not telescope on its own

The [source-transfer theorem](short-time-source-and-W-successor-transfer.md) gives, for $F_N=(C-I)g_N$,
$$
 \|T_tUF_N\|_2\le C/(1+t).
$$
The literal iterate instead has the exact identity
$$
 T_tUC^kg_N-T_tUg_N=\sum_{j=0}^{k-1}T_tUC^jF_N.
\tag{20}
$$
Only its first summand is bounded by the quoted estimate. The iterates $C^jF_N$ are not asserted to be natural sources with positive primitives. Nor does $C$ commute with age convolution.

There is a concrete compensation term if one tries to use ordinary shifts instead. Since $(S-I)g_N=F_N+\delta_Nh_1$,
$$
 \boxed{g_N=S^kg_N-\sum_{j<k}S^jF_N-\delta_NH_k,\qquad
 H_k(x)=\mathbf1_{x\ge1}\sum_{j=0}^{k-1}\frac1{x+j}.}
\tag{21}
$$
The positive carrier has the sharp original norm
$$
 \boxed{\|H_k\|_2^2\sim\frac{\pi^2}{3}k.}
\tag{22}
$$
To prove it, set $x=ky$. Decreasing-sum bounds give
$$
 \log(1+1/y)\le H_k(ky)
       \le \log(1+1/y)+(ky)^{-1}.
$$
On $y\ge1/k$, the added term has squared norm $1/k$; the missing interval shrinks in $L^2$. The limiting integral is
$$
 \int_0^\infty\log^2(1+1/y)dy
   =2\int_0^1\frac{-\log(1-z)}z dz=\frac{\pi^2}{3}.
$$
The no-jump part of the positive process gives the pointwise lower bound
$T_tUH_k\ge e^{-\lambda t}UH_k$, hence
$$
 \|\delta_NT_tUH_k\|_2\ge\delta_Ne^{-\lambda t}\|H_k\|_2.
\tag{23}
$$
As $k/N\to a>0$, $t=c\log N$, and [the actual charge limit](actual-successor-resonance-charge-cocycle.md) $\delta_N\to\kappa>0$, the right side is bounded below by
$$
 \left(\frac{\kappa\pi\sqrt a}{\sqrt3}+o(1)\right)
                        N^{1/2-\lambda c}.
$$
This is a lower bound for the retained compensation component only. It is not a lower bound for the net source, whose signed cross terms may cancel it.

Evolving (21) keeps the exact commutator remainder
$$
 T_tUg_N=T_tUS^kg_N-\sum_{j<k}US^jU^{-1}T_tUF_N
   -\delta_NT_tUH_k-\Gamma_{t,k,N},
$$
$$
 \Gamma_{t,k,N}
   =\sum_{j<k}[T_t,US^jU^{-1}]UF_N.
\tag{24}
$$
Even the contraction estimate on the displayed ordinary-shift sum is only $Ck/(1+t)$. Dropping either the charge carrier or $\Gamma$ would therefore not be a valid logarithmic-time argument.

Equations (9)--(19) give an alternative to that loss: the exact feedback has a positive bounded seed orbit and an explicit signed arithmetic driver. This mechanism does not require positivity of arbitrary $C$-iterates. What remains at $k$ comparable to $N$ is the terminal/source feedback and its evolved Gram, explicitly determined by (5), (12)--(13), and (17)--(18). The single-step $O(1/\log N)$ transfer neither evaluates that Gram nor proves the proposed subpower target. No completed uncut source is placed in global $L^2$, and no RH estimate is asserted.

The [birth-Gram calculation](original-l2-evolved-source-gram-work.md) supplies a separate complete-history formulation of the original source norm. Neither its diagonal loading nor the positive reference renewal above evaluates the signed terminal-source Gram.


The [uniform driver-square theorem](uniform-successor-driver-square-bound.md) strengthens the actual driver's constraint to a cutoff-uniform $\ell^2$ bound and proves the matching $\sqrt k$ norm of the reference synthesis. Both conclusions retain the signed Gram above.
