# The full-prime successor potential and its original-metric midpoint identity

This extends the [finite-prime two-port construction](../dynamics-and-feedback/positive-primitive-two-port-drift-curvature.md). Sections 1–4 retain each actual fixed source cutoff and the original maximal multiplier domains. Sections 5–8 use local prime-kernel variation and block convolution to prove uniform bounds and joint convergence for the successor correction. The [fixed-source companion](../prime-distribution/all-prime-fixed-source-drift-curvature.md) retains the shorter finite-measure method. No sign is assigned to the full midpoint curvature.

Write $D=\partial_v$, $a=Ug_N$, $b=Ca$, and $\delta_N=\delta(a)$. The literal causal successor is
$$
(Sa)(v)=\mathbf1_{v\ge0}\sqrt{\frac{e^v}{e^v+1}}
                    a(\log(e^v+1)),\qquad
 b=Sa-\delta_Na_0,
 \quad a_0=e^{-v/2}\mathbf1_{v\ge0}.
$$
The actual primitive is $P(v)=\int_{-\infty}^v(b-a)(u)du$. Its [proved strict positivity](natural-cutoff-successor-primitive.md) on $v>0$ will be retained, rather than inferred from any prime-operator positivity.

## 1. The complete derivative measures, including the boundary

The original source innovation is
$$
\nu_a=(D+\tfrac12)a
 =-\delta_0+\sum_{2\le n\le N}\frac{\Lambda(n)}{\sqrt n}\delta_{\log n}
             -e^{v/2}\mathbf1_{(0,\log N)}(v)\,dv.
\tag{1}
$$
Every prime-power arrival at $n=N$ is included. The frozen terminal tail introduces no additional artificial atom.

Put $x=e^v$, $E_N=\psi(N)-N$, and define the integrable density
$$
s_N(v)=\sqrt x\left[\frac{\psi(x+1)}{(x+1)^2}-1\right]
                        \mathbf1_{1<x<N-1}
       +E_N\frac{\sqrt x}{(x+1)^2}
                        \mathbf1_{x>\max(1,N-1)}.
\tag{2}
$$
The complete compensated-successor innovation is
$$
\nu_b=(D+\tfrac12)b
 =\left(\frac{\log2-2}{2}-\delta_N\right)\delta_0
  +\sum_{3\le n\le N}\frac{\sqrt{n-1}}{n}\Lambda(n)
                                  \delta_{\log(n-1)}
  +s_N(v)dv.
\tag{3}
$$
Indeed the causal boundary value of $Sg_N$ is $g_N(2)=(\log2-2)/2$, with the arrival at two already included. For $x>1$, applying $D+1/2$ to $U[g_N(x+1)]$ gives the ordinary density

$$
\sqrt x\,[g_N(x+1)+xg_N'(x+1)],
$$
which is precisely (2) on its two intervals. A jump at $n\ge3$ has size $\sqrt{n-1}\Lambda(n)/n$. Thus the arrival at two is not counted twice, and the shifted arrival at $n=N$ is retained. The density beyond $\log(N-1)$ is noncompact and decays as $O_N(e^{-3v/2})$. These facts also prove finite total variation of (3).

Both $a,b$ are in $L^1\cap L^2\cap BV$ on the whole age line. They vanish below zero and have exponential tails. The compensation satisfies
$$
\int_{\mathbb R}(b-a)=0,
$$
because $\delta_N=\tfrac12\int(Sa-a)$ and $\int a_0=2$. Consequently $P,P'\in L^1$, $P\in H^1$, and $P(0)=0$. For example, beyond $\log N$,
$$
P'(v)=\left[-\delta_N-\frac{E_Ne^{-v}}{1+e^{-v}}\right]e^{-v/2},
 \qquad P(v)=-\int_v^\infty P'(u)du.
\tag{4}
$$
There is no boundary atom in $P'=b-a$. There is, however, a boundary atom in the next derivative:
$$
\boxed{P''=\nu_b-\nu_a-\tfrac12P'(v)dv.}
\tag{5}
$$
More explicitly, the full finite signed measure in (5) is
$$
\begin{aligned}
 P''={}&(\tfrac12\log2-\delta_N)\delta_0
  +\sum_{3\le n\le N}\frac{\sqrt{n-1}}n\Lambda(n)
                                      \delta_{\log(n-1)}
  -\sum_{2\le n\le N}\frac{\Lambda(n)}{\sqrt n}\delta_{\log n}\\
 &+\left[s_N(v)+e^{v/2}\mathbf1_{(0,\log N)}(v)
                         -\tfrac12P'(v)\right]dv.
\end{aligned}
\tag{6}
$$
All coincidences are to be added as signed measures. At $N=2$ the shifted sum and the first density in (2) are empty; the boundary atom and the unshifted arrival at $\log2$ remain. At $N=3$, the shifted $n=3$ arrival at $\log2$ combines with the unshifted $n=2$ arrival there. No separation of coincident atoms is needed.

## 2. The all-prime potential converges in $H^2$

For a finite prime cutoff $Q$, retain every depth of every admitted prime:
$$
B_Q(v)=\sum_{p\le Q}e^{v/2}p^{-\lfloor v/\log p\rfloor-1}
                             \mathbf1_{v\ge\log p}.
$$
The [established complete kernel](positive-successor-seed-jump-process.md) satisfies $B=\sum_pB_p\in L^2(\mathbb R)$. Since $0\le B_Q\le B$ and $B_Q\to B$ pointwise almost everywhere, dominated convergence gives
$$
e_Q:=\|B_Q-B\|_2\longrightarrow0.
\tag{7}
$$
This uses the full kernel theorem, including its $B(v)\sim2/v$ tail. It does not assert $B\in L^1$ or that $dB$ has finite total variation. Those stronger properties fail for the complete positive prime sum.

Let $\check B(v)=B(-v)$, and define
$$
r_+=B*P,\qquad r_-=\check B*P.
$$
For either orientation $K=B$ or $K=\check B$, distributional differentiation and Young's inequalities give
$$
KP:=K*P\in L^2,\qquad
 (KP)'=K*P'\in L^2,\qquad
 (KP)''=K*P''\in L^2,
\tag{8}
$$
where the last convolution is against the finite measure (5). Thus both potentials belong to $H^2(\mathbb R)$, and
$$
\boxed{\|r_{\pm,Q}-r_\pm\|_{H^2}
 \le e_Q\bigl(\|P\|_1+\|P'\|_1+\|P''\|_{\rm TV}\bigr).}
\tag{9}
$$
The sum norm on the right bounds the usual $H^2$ norm. This proof places both derivatives on the actual source primitive; it never differentiates the infinite-prime kernel as a finite measure.

Since $B,P\ge0$, both complete potentials remain nonnegative. In fact their convolutions are continuous, using $B,P\in L^2$. The anticausal potential is a full-line function. Its negative-age part is retained.

## 3. Both actual columns belong to their original operator domains

Define the other two finite signed measures
$$
\eta_a=a(v)dv-\nu_a=(\tfrac12-D)a,
 \qquad \eta_b=b(v)dv-\nu_b=(\tfrac12-D)b.
$$
The complete actual columns have the concrete $L^2$ representations
$$
\boxed{y_+=-B*\eta_a,\quad y_+^C=-B*\eta_b,
 \qquad y_-=-\check B*\nu_a,\quad y_-^C=-\check B*\nu_b.}
\tag{10}
$$
Their finite-prime versions converge in the original $L^2$, with, for example,
$$
\|y_{-,Q}-y_-\|_2\le e_Q\|\nu_a\|_{\rm TV},\qquad
 \|y_{+,Q}^C-y_+^C\|_2\le e_Q\|\eta_b\|_{\rm TV}.
\tag{11}
$$
The corresponding two bounds use the other two measures. These also give convergence in the original additive energy because $\mathcal E(U^{-1}f)\le8\|f\|_2^2$.

For completeness, the operator identification can be made without treating $B*$ as a bounded operator on all $L^2$. Use the Fourier convention $\widehat f(\xi)=\int e^{-i\xi v}f(v)dv$. The closed maximal multiplier
$$
A:\ \widehat{Af}=(\tfrac12-i\xi)\widehat B(\xi)\widehat f(\xi)
$$
has domain consisting precisely of the $f\in L^2$ for which the displayed product lies in $L^2$. Its original $L^2$ adjoint has multiplier
$(\tfrac12+i\xi)\overline{\widehat B(\xi)}$.
The identities
$$
(\tfrac12+i\xi)\widehat a=\widehat{\nu_a},\qquad
 (\tfrac12-i\xi)\widehat a=\widehat{\eta_a}
$$
and their $b$ counterparts show that $a,b\in D(A)\cap D(A^*)$: each measure transform is bounded, while $\widehat B\in L^2$. Formula (10) is exactly $-Aa,-Ab,-A^*a,-A^*b$, rather than a different extension of the prime action. Unitarity of $U$ preserves the original physical adjoint.

Taking derivatives in (8), or passing to the limits of the finite-prime identities, now proves in $L^2$
$$
\boxed{y_+^C-y_+=(D^2-\tfrac12D)r_+,
 \qquad y_-^C-y_-=-(D^2+\tfrac12D)r_-.}
\tag{12}
$$

## 4. The actual full-prime grouped midpoint identity

Let $\widehat L=U\mathcal LU^{-1}$, where the physical energy uses
$\mathcal L=4I-\mathsf K*$ and $\mathsf K(h)=\min(1,|h|^{-2})$, with zero extension on the negative physical half-line. Then $\widehat L$ is bounded self-adjoint on $L^2(dv)$, with norm at most eight. Set
$$
m_+=(y_+^C+y_+)/2,\qquad m_-=(y_-^C+y_-)/2.
$$
For the actual real source, the complete anticausal energy change is
$$
\boxed{\mathcal E(U^{-1}y_-^C)-\mathcal E(U^{-1}y_-)
 =-\left\langle r_-,(D^2-\tfrac12D)
                      \widehat L(y_-^C+y_-)\right\rangle_{H^2,H^{-2}}.}
\tag{13}
$$
Equivalently its right side is the ordinary $L^2$ pairing
$-\langle(D^2+\tfrac12D)r_-,\widehat L(y_-^C+y_-)\rangle$.
The actual complete mixed change is
$$
\boxed{\begin{aligned}
 \mathcal B_E(U^{-1}y_+^C,U^{-1}y_-^C)
       -\mathcal B_E(U^{-1}y_+,U^{-1}y_-)
 ={}&\left\langle r_+,(D^2+\tfrac12D)\widehat Lm_-\right\rangle\\
 &-\left\langle r_-,(D^2-\tfrac12D)\widehat Lm_+\right\rangle.
\end{aligned}}
\tag{14}
$$
Both terms use the same $H^2,H^{-2}$ pairing as (13). Midpoint polarization retains the entire quadratic increment, including both halves of the cross term of the two column increments.

Equations (13)--(14) follow directly from (12) and the bounded original metric. They are also the limits of the exact finite-prime equations: the potentials converge in $H^2$, the columns and forces in $L^2$, and
$$
|\langle r,(D^2\pm\tfrac12D)\widehat Lz\rangle|
       \le C\|r\|_{H^2}\|z\|_2.
\tag{15}
$$
In particular each complete midpoint readout is finite; its finite-prime error is bounded by $C_N\|B\|_2 e_Q$, with $C_N$ expressed through the finite measure and primitive norms in (9)--(11). No unproved limit in the source cutoff is used.

The curvature is kept grouped in these equations. Its physical kernel still contains the diagonal $4I$, the two regions $|e^v-e^w|<1$ and $>1$, and the exact successor/predecessor interface. The convergence proof does not interchange a prime limit with separately expanded pointwise curvature integrals, nor claim absolute integrability of such separate expansions. Their distributional commutator identities, when used, must be read on their justified Sobolev domains. The single pairing in (13), and each complete pairing in (14), are already well defined without that extra split.

Thus the positive successor potential supplies an actual full-prime original-metric comparison at every fixed natural source cutoff. Positivity of the potential alone gives no sign for its pairing with the retained signed curvature. The following stronger estimate controls the successor correction even when the natural source cutoff grows.

## 5. Local variation of the complete prime kernel

Let $I_k=[k,k+1)$, $k\in\mathbb Z$, and for a locally finite signed measure $\sigma$ set
$$
V_2(\sigma)=\left(\sum_{k\in\mathbb Z}|\sigma|(I_k)^2\right)^{1/2}.
$$
The complete $B$ is locally BV because only finitely many primes and prime powers occur on a bounded age interval. Its derivative contains the ordinary positive part $B(v)dv/2$, positive initial jumps $p^{-3/2}\delta_{\log p}$, and every negative proper-power jump
$$
-(1-p^{-1})p^{-j/2}\delta_{j\log p},\qquad j\ge2.
\tag{16}
$$
These are exact local signed measures, not an absolutely summable global decomposition.

The complete kernel bound $B(v)\le C/(1+v)$, $v\ge0$, controls its values and continuous variation on $I_k$. The positive initial jumps in that block have total at most
$$
\sum_{p\ge e^k}p^{-3/2}\le C e^{-k/2},\qquad k\ge1,
$$
even using all integers in place of primes. Let $U_k,D_k$ denote the positive and negative jump masses. The signed variation identity across the block gives
$$
D_k\le U_k+\tfrac12\int_{I_k}B(v)dv
                  +|B(k-)|+|B((k+1)-)|.
$$
Left traces retain any atom at the lower endpoint and exclude an atom at the upper endpoint, consistently with $I_k$. Consequently
$$
\boxed{|DB|(I_k)\le\frac C{1+k}\quad(k\ge0),\qquad
                   V_2(DB)<\infty.}
\tag{17}
$$
There is no mass in negative blocks. The same proof applies uniformly to every $B_Q$, using $0\le B_Q\le B$ and its subset of positive initial births. Each fixed block has $DB_Q=DB$ once $Q>e^{k+1}$. Thus square-summable domination gives the stronger convergence
$$
\boxed{V_2(DB_Q-DB)\longrightarrow0.}
\tag{18}
$$
Equations (17)--(18) retain the full negative power-jump balance. They do not claim globally finite variation.

## 6. A block convolution estimate

For a function $f$, write
$$
W_{2,1}(f)=\sum_{j\in\mathbb Z}\|\mathbf1_{I_j}f\|_2.
$$
If $V_2(\sigma)<\infty$ and $W_{2,1}(f)<\infty$, then convolution has an $L^2$ realization satisfying
$$
\boxed{\|\sigma*f\|_2\le\sqrt2\,V_2(\sigma)W_{2,1}(f).}
\tag{19}
$$
To prove it, first restrict to finitely many measure and function blocks. For one function block $f_j$, the support of $\sigma|_{I_k}*f_j$ lies in $[k+j,k+j+2]$. These supports overlap at most twice almost everywhere as $k$ varies. Hence
$$
\left\|\sum_k\sigma|_{I_k}*f_j\right\|_2^2
 \le2\sum_k\|\sigma|_{I_k}*f_j\|_2^2
 \le2V_2(\sigma)^2\|f_j\|_2^2.
$$
Sum over $j$ by the triangle inequality. Truncation then gives an $L^2$ limit and proves (19). Reflection preserves both block norms, apart from irrelevant choices of endpoints for function blocks; for measures one may instead use the reflected half-open partition. The same bound holds with that partition, or with a fixed harmless overlap constant if one insists on the original partition.

## 7. Uniform control of the actual successor difference

Put $x=e^v\ge1$. In the physical coordinate the exact compensated difference is
$$
P_N'(v)=\sqrt x\,[g_N(x+1)-g_N(x)]-\delta_Nx^{-1/2}.
\tag{20}
$$
Away from the actual arithmetic jumps, the ordinary derivative of $g_N$ is
$$
g_N'(x)=
 \begin{cases}-\psi(x)/x^2,&1<x<N,\\-E_N/x^2,&x>N.
 \end{cases}
$$
Chebyshev's bound and $|E_N|\le C N$ give $|g_N'(x)|\le C/x$ in both regions. This also controls a unit interval crossing the cutoff. Its only jumps are $\Lambda(n)/n$ at the actual $2\le n\le N$. The right-continuous difference on $(x,x+1]$ includes at most one such integer, even when an endpoint is an integer. Therefore
$$
|g_N(x+1)-g_N(x)|
 \le\frac{C(1+\log(x+1))}{x}.
$$
The actual charge formula in the [natural-cutoff proof](natural-cutoff-successor-primitive.md) gives bounded $\delta_N$ and $\delta_N\to\kappa$. It follows that, uniformly over all natural cutoffs $N\ge2$,
$$
\boxed{|P_N'(v)|\le C(1+v)e^{-v/2}\mathbf1_{v\ge0},
             \qquad W_{2,1}(P_N')\le C.}
\tag{21}
$$
This estimate uses the actual unit-step arithmetic, rather than the much larger total variation of the unshifted source innovation. It retains the frozen tail and the compensation term.

Since $\int P_N'=0$, integration from infinity also gives
$$
|P_N(v)|\le C(1+v)e^{-v/2}\mathbf1_{v\ge0},
 \qquad \|P_N\|_1+\|P_N'\|_1\le C.
\tag{22}
$$
For each fixed $v\ge0$, both uncorrected physical source values in (20) stabilize once $N\ge e^v+1$. Together with $\delta_N\to\kappa$, this gives $P_N'\to P_\infty'$ pointwise. Applying (21) on each block and then summing its summable envelope yields
$$
W_{2,1}(P_N'-P_\infty')\to0,
 \qquad \|P_N'-P_\infty'\|_1\to0.
\tag{23}
$$
Define $P_\infty(v)=-\int_v^\infty P_\infty'(u)du$ for $v\ge0$, and zero below zero. Dominated convergence also preserves the zero integral of $P_N'$, so $P_\infty(0)=0$. Moreover
$$
\|P_N-P_\infty\|_1
 \le\int_0^\infty u|P_N'(u)-P_\infty'(u)|du\longrightarrow0.
\tag{24}
$$
The limiting potential remains nonnegative. This does not assert that the individual uncut source $Ug$ belongs to $L^2$.

## 8. Uniform and convergent full-prime column corrections

For the causal potential the second derivative can now be taken in the different form
$$
r_{+,N}''=(DB)*P_N'.
$$
For the anticausal potential the reflection sign must be retained:
$$
\boxed{r_{-,N}''=-(DB)^{\vee}*P_N',\qquad
                     r_{-,N}'=\check B*P_N'.}
\tag{25}
$$
These agree with (8). One rigorous way to identify them is first to use $B_Q$, whose derivative has finite global variation, and then pass using (7), (18), and (19). Combining (17), (19), (21), and (22) proves
$$
\boxed{\sup_{N\ge2}\|r_{\pm,N}\|_{H^2}<\infty.}
\tag{26}
$$
The prime-cutoff version is uniform as well, and its $H^2$ error is bounded independently of $N$ by
$$
C\bigl(\|B_Q-B\|_2+V_2(DB_Q-DB)\bigr)\longrightarrow0.
\tag{27}
$$
Equations (23)--(24) and the same convolution estimates further give
$$
r_{\pm,N}\longrightarrow r_{\pm,\infty}
                 \quad\hbox{in }H^2\quad(N\to\infty).
\tag{28}
$$
Thus both full-prime successor corrections
$$
z_{+,N}=y_{+,N}^C-y_{+,N}=(D^2-\tfrac12D)r_{+,N},
 \qquad
 z_{-,N}=y_{-,N}^C-y_{-,N}=-(D^2+\tfrac12D)r_{-,N}
$$
are uniformly bounded and converge in the original $L^2$, and therefore in the original additive energy. By (27), the same limits hold jointly along any $N\to\infty$, $Q\to\infty$. All local depths remain present.

There are also elementary quantitative bounds for this actual joint limit. The exact charge formula gives
$$
\delta_N-\kappa=\int_N^\infty d(t)dt
                 -\sum_{n>N}\Lambda(n)d(n),\qquad
 d(t)=\arcsin(t^{-1/2})-t^{-1/2}\le Ct^{-3/2}.
$$
Using only $\Lambda(n)\le\log n$,
$$
|\delta_N-\kappa|\le C(1+\log N)/\sqrt N.
$$
Below $\log(N-1)$, the difference $P_N'-P_\infty'$ is exactly
$-(\delta_N-\kappa)a_0$, since both physical source samples have stabilized. Above that age, (21) supplies its full tail. Summing block norms and, for the primitive, integrating the weighted tail gives
$$
W_{2,1}(P_N'-P_\infty')+\|P_N'-P_\infty'\|_1
       \le C\frac{1+\log N}{\sqrt N},
 \qquad
 \|P_N-P_\infty\|_1\le C\frac{1+(\log N)^2}{\sqrt N}.
\tag{28a}
$$
Likewise $B_Q=B$ and $DB_Q=DB$ below $\log Q$. Their block bounds above that age imply
$$
\|B_Q-B\|_2+V_2(DB_Q-DB)\le C(\log Q)^{-1/2}.
$$
Since the column correction uses only $P_N'$, not $P_N$, (19) and (25) give the sharper source factor
$$
\boxed{\|z_{\pm,N,Q}-z_{\pm,\infty}\|_2
 \le C\left[\frac{1+\log N}{\sqrt N}
                         +\frac1{\sqrt{\log Q}}\right].}
\tag{28b}
$$
No PNT error estimate is needed for (28a)--(28b). The complete prime kernel bound used in (17) remains an established arithmetic input.

In particular the exact finite-$N$ midpoint identity has a bounded full-prime correction, and
$$
\big|\|U^{-1}y_{\pm,N}^C\|_E-\|U^{-1}y_{\pm,N}\|_E\big|
 \le C,
$$
$$
\left|\mathcal E(U^{-1}y_{\pm,N}^C)
               -\mathcal E(U^{-1}y_{\pm,N})\right|
 \le C\|U^{-1}y_{\pm,N}\|_E+C^2.
\tag{29}
$$
This is not convergence or boundedness of the individual anticausal columns. Their midpoint forces can still grow, and no sign is assigned to (13). The stronger conclusion is that their exact compensated-successor correction has a convergent full-prime $L^2$ realization, despite the increasing number of raw source atoms. It follows from local prime-kernel variation and the actual unit-step source cancellation, while preserving the grouped original-metric curvature.


The block convolution estimate is the elementary Young inequality with a two-fold support-overlap bound. It supplements the classical finite-measure argument in the fixed-source companion. The [actual finite-history example](../prime-history/actual-finite-history-curvature-domains.md) explains why the resulting distributional curvature cannot simply be assumed to be a nonnegative measure. These are written proofs with exact arithmetic domains and no priority claim.
