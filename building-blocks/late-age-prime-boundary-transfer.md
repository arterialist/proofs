# Late-age transfer to the actual prime-history boundary

Let $S$ be a nonempty finite prime set, $k=|S|$, $h_p=\log p$, $r_p=p^{-1/2}$, and

$$
H_S=\sum_{p\in S}\log p,\qquad
A_S=\prod_{p\in S}(I-r_pE_{h_p}),\qquad
D_S=\prod_{p\in S}(I-r_pR_{h_p}),\qquad
U_S=A_SD_S^{-1}.
$$

Here $E_hf(v)=f(v+h)$ and $R_hf(v)=f(v-h)$ on the whole line. Let $P=1_{[0,\infty)}$ and $Q=I-P$. For a compactly supported causal input $f$, retain the complete histories

$$
Z=D_S^{-1}f,\qquad p=U_Sf,\qquad q=U_S^*f=D_SA_S^{-1}f.
$$

The two negative boundary sources are

$$
\eta_S=Qp,\qquad b_S=-QA_SPq.
\tag{1}
$$

Both are supported in $[-H_S,0]$. In particular, with $\Pi_S=\prod_{p\in S}p$, the second source is exactly

$$
b_S(-u)=-\sum_{\substack{e\mid\Pi_S\\e>1}}
\frac{\mu(e)}{\sqrt e}\,
q(\log e-u)1_{u<\log e},\qquad 0<u<H_S.
\tag{2}
$$

The signs and all squarefree cross terms in this numerator are retained. All prime powers occur in the inverse factors defining $q$ and $Z$. These sources satisfy

$$
p_+=A_SZ-\eta_S,\qquad A_Sq_+=D_Sf-b_S,
\qquad
f*f-p_+*q_+=\eta_S*q_++b_S*Z.
\tag{3}
$$

For $S=\{2,3\}$, these are exactly the two-history boundary sources and storage identity. Linearity lets us apply (1)--(3) to the late part of an actual cutoff separately. This does not discard either source from the complete history.

## A deterministic operator bound from the full coefficient tilt

Write the actual finite Euler multiplier in its absolutely convergent expansion

$$
U_S(t)=\sum_\lambda c_\lambda e^{i\lambda t}.
$$

With the Fourier convention $\widehat f(t)=\int e^{-itv}f(v)\,dv$, this term acts by $c_\lambda f(v+\lambda)$. At one prime the coefficients are $c_{h_p}=-r_p$ and $c_{-jh_p}=(1-r_p^2)r_p^j$ for every $j\ge0$. Thus, for $0<\delta<1/2$, the exact negative tilt is

$$
M_S(\delta)=\sum_\lambda|c_\lambda|e^{-\delta\lambda}
=\prod_{p\in S}\left[p^{-1/2-\delta}
+\frac{1-p^{-1}}{1-p^{-1/2+\delta}}\right].
\tag{4}
$$

Let $P_R=1_{[R,\infty)}$, $R\ge0$. A translation can carry $P_Rf$ into negative time under $U_S^*$ only if $\lambda<-R$. The triangle inequality for the complete sum of translation operators therefore proves

$$
\|QU_S^*P_R\|_{2\to2}
\le\sum_{\lambda<-R}|c_\lambda|
\le e^{-\delta R}M_S(\delta).
\tag{5}
$$

This is a deterministic operator estimate; no diagonal averaging is used. Moreover, $A_SU_S^*=D_S$ and $QD_Sf=0$ for causal $f$, so the inverse port has the useful alternative expression

$$
b_S=QA_SQU_S^*f.
\tag{6}
$$

Consequently

$$
\|b_S(P_Rf)\|_2
\le C_S e^{-\delta R}M_S(\delta)\|P_Rf\|_2,
\qquad C_S=\prod_{p\in S}(1+p^{-1/2}).
\tag{7}
$$

Using (6) avoids replacing $R$ by $R-H_S$. Such a replacement would lose a large part of the useful range when the number of admitted primes grows.

The forward source is controlled by the positive-frequency tail,

$$
\|\eta_S(P_Rf)\|_2
\le e^{-\delta R}M_S(-\delta)\|P_Rf\|_2.
\tag{8}
$$

Here $M_S(-\delta)\le M_S(\delta)$. At a single prime this follows by setting $r=p^{-1/2}$ and $x=p^\delta$ and subtracting the two factors; the difference is

$$
r(x-x^{-1})\left[
\frac{1-r^2}{(1-rx)(1-r/x)}-1\right]\ge0.
$$

There is also exact finite propagation: $\eta_S(P_Rf)=0$ when $R\ge H_S$, up to irrelevant endpoint values.

Take $S=\{p:p\le X\}$. Chebyshev prime counting applied to (4) gives the following concrete transfer. If $0<a<2$, $2\le X\le R^a$, and $R$ is sufficiently large, then

$$
\|QU_S^*P_R\|_{2\to2}
+\|f\mapsto b_S(P_Rf)\|_{2\to2}
+\|QU_SP_R\|_{2\to2}
\le C_a\exp\left[-\kappa(a)R+
\frac{C_aR}{\log R}\right],
\tag{9}
$$

where $\kappa(a)=\min(1/2,1/a-1/2)$. Indeed, for $1<a<2$ choose $\delta=1/a-1/2$ in (4); for $a\le1$ use $\delta=1/2-1/\log(R^a)$. Here is a direct check of the product cost. For $1<a<2$, put $\eta=1/2-\delta=1-1/a>0$. Each logarithmic factor in (4) is $O_a(p^{-\eta})$, so partial summation of $\pi(y)\ll y/\log y$ gives

$$
\log M_S(\delta)\ll_a \sum_{p\le R^a}p^{-\eta}\ll_a R/\log R.
$$

For $0<a\le1$, put $\epsilon=1/(a\log R)=1/2-\delta$. Primes $p\le R^{a/2}$ contribute at most $O_a(R^{a/2}\log\log R)$, since $1-p^{-\epsilon}\gg\epsilon\log p$. For larger primes, $\epsilon\log p\ge1/2$, so each logarithmic factor is bounded and their total is $O_a(R^a/\log R)$. These bounds are $O_a(R/\log R)$. The extra term $R/(a\log R)$ in $-\delta R$ is absorbed in the displayed error. Also $\log C_S\le\sum_{p\le X}p^{-1/2}=O(\sqrt X/\log X)$, which is absorbed in that error. The forbidden endpoint $\delta=1/2$ is never used.

Equation (9) preserves full coefficient correlations in the operator being bounded, although its proof bounds the sum of their absolute values. It gives no new sign for the boundary or storage.

## Why scalar overflow alone is insufficient

The coefficient stop-loss $\mathcal L_S(R)=\sum_\lambda|c_\lambda|^2(-\lambda-R)_+$ controls the averaged regularized half-line Hilbert--Schmidt density in the existing overflow identity. The connection to (5) is exact. Set $\mathcal C_S=R_{H_S}U_S$ and $\mathcal A_b=1_{(b,\infty)}\mathcal C_SQ$, as in that construction. Then

$$
(QU_S^*P_R)^*=E_{H_S}\mathcal A_{H_S+R},
\qquad
\|QU_S^*P_R\|=\|\mathcal A_{H_S+R}\|.
$$

Its established regularized density is
$\lim_{\Omega\to\infty}(\pi/\Omega)\|\mathcal A_{H_S+R}\Pi_\Omega\|_2^2=\mathcal L_S(R)$.
The finite-band formula retains all off-diagonal interference. The advance-length input port in that construction is not the boundary source $b_S$; the latter also includes the finite numerator in (6). This distinguishes the existing density identity from applying the actual source map to a specified arithmetic input. Even a single actual prime exhibits the difference in scale.

Take $S=\{p\}$, $h=\log p$, $r=p^{-1/2}$ and $R=Jh$ with an integer $J\ge1$. Decompose physical time into cells $\theta+jh$, $0\le\theta<h$. The compression $QU_p^*P_R$ has the age matrix

$$
(1-r^2)r^{j+m+1},\qquad j\ge J,\quad m\ge0,
$$

tensored with the identity on the cell coordinate. The rank-one age matrix gives the exact norm

$$
\|QU_p^*P_R\|_{2\to2}=r^{J+1}.
\tag{10}
$$

The actual inverse boundary is $b_p(-u)=r q(h-u)$ for $0<u<h$. Its corresponding operator norm is

$$
\|f\mapsto b_p(P_Rf)\|_{2\to2}
=\sqrt{1-r^2}\,r^{J+1}.
\tag{11}
$$

Meanwhile, summing every negative power gives exactly

$$
\mathcal L_p(Jh)
=h(1-r^2)^2\sum_{j>J}(j-J)r^{2j}
=h r^{2J+2}.
\tag{12}
$$

Thus the port norm has the square-root scale of this scalar overflow, not its scale. The whole-line compression is not itself Hilbert--Schmidt, since the cell-coordinate identity has infinite rank. Regularized or averaged Hilbert--Schmidt statements must retain their stated localization. No claim about localized trace norm follows from (10)--(12).

There is a second obstruction for the actual source. A finite cutoff of $a(v)=e^{v/2}\beta(v)$ can have an $L^2$ norm whose unconditional available upper bound grows essentially like $e^{T/2}$. Multiplication by the factor $e^{-\delta R}$ in (7), with $\delta<1/2$, does not give a bound uniform in the upper cutoff $T$. The following weighted completion uses the actual source instead.

## A cutoff-uniform actual port bound

Use the classical quantitative PNT remainder in the form

$$
|\beta(v)|\le C_0e^{-c\sqrt v},\qquad v\ge0,
\tag{13}
$$

for fixed positive $c,C_0$. Let $0\le\chi_T\le1$ be the actual finite cutoff, equal to one through $T$ and linear to zero at $T+1$. Define the retained late source

$$
f_{R,T}(v)=1_{v\ge R}\chi_T(v)a(v).
\tag{14}
$$

All following bounds are uniform in $T\ge R$. Write $\mathcal N_S$ for the positive integers with all prime factors in $S$, including $1$. The inverse advance expansion is exact,

$$
A_S^{-1}f(v)=\sum_{d\in\mathcal N_S}d^{-1/2}f(v+\log d).
$$

It is pointwise finite on compact sets for (14). Expanding the finite numerator $D_S$, and using $a=e^{v/2}\beta$, gives

$$
e^{-v/2}q(v)
=\sum_{e\mid\Pi_S}\frac{\mu(e)}e
\sum_{d\in\mathcal N_S}
\beta(w)\chi_T(w)1_{w\ge R},
\qquad w=v+\log d-\log e.
\tag{15}
$$

The cancellation of the geometric factors in (15) is the reason the PNT envelope can be used. Replacing it by an unweighted $L^2$ estimate would lose this information.

For $0\le v\le H_S$, an argument $w\in[m,m+1)$ in (15) requires $\log d\le m+1+H_S$. The elementary count

$$
\#\{d\in\mathcal N_S:\log d\le y\}
\le(1+y/\log2)^k
\tag{16}
$$

follows by bounding each prime exponent separately. Define

$$
\mathcal E_S(R)=C_0(2^k-1)
\prod_{p\in S}(1+p^{-1})
\sum_{m\ge\lfloor R\rfloor}
e^{-c\sqrt m}
\left(1+\frac{m+1+H_S}{\log2}\right)^k.
\tag{17}
$$

Equations (13)--(16), followed by the exact source formula (2), prove

$$
\sup_{0<u<H_S} e^{u/2}|b_S(f_{R,T})(-u)|
\le\mathcal E_S(R).
\tag{18}
$$

Indeed, the factor $e^{(\log e-u)/2}/\sqrt e$ in (2) equals $e^{-u/2}$. This accounts for every numerator term, including both prime terms and the mixed term when $S=\{2,3\}$. In particular,

$$
\|b_S(f_{R,T})\|_2\le\mathcal E_S(R),\qquad
\|e^{u/2}b_S(f_{R,T})(-u)\|_{L^2(0,H_S)}
\le\sqrt{H_S}\,\mathcal E_S(R).
\tag{19}
$$

The forward source is exactly zero for $R\ge H_S$. This proves a bound for both late-input ports without removing either from the complete storage identity (3).

For fixed $S$, (17) is a polynomial factor times a decaying PNT envelope. More generally, let $S=S(R)$ vary and assume

$$
H_{S(R)}\le R,\qquad |S(R)|\log R=o(\sqrt R).
\tag{20}
$$

Then, uniformly in the upper cutoff,

$$
\mathcal E_{S(R)}(R)=O(e^{-c\sqrt R/2}).
\tag{21}
$$

To verify the uniformity, absorb the finite products in (17) into $(C(m+1))^k$. For $m\ge R-1$, the function $\log(C(m+1))/\sqrt m$ decreases once $R$ is large. Condition (20) therefore makes this factor at most $e^{c\sqrt m/4}$ throughout the tail. Finally,

$$
\sum_{m\ge R-1}e^{-3c\sqrt m/4}
\ll_c(1+\sqrt R)e^{-3c\sqrt R/4}
\ll_c e^{-c\sqrt R/2}.
$$

For example, (20) holds for all primes $p\le R^a$ with any fixed $0<a<1/2$, using even the elementary bounds $k\le R^a$ and $H_S\le R^a\log(R^a)$. Thus (21) is a growing-generator completion for the actual critical history. Its range is narrower than the operator estimate (9), because it also pays for the specified arithmetic source.

## Direct use in the age lift

Let

$$
B_{S,R,T}(\lambda)=\int_0^{H_S}b_S(f_{R,T})(-u)e^{\lambda u}\,du.
$$

The age lift uses $\lambda=1/2-q+i\omega_k$. For every $\sigma=\Re q>0$ and every integer $j\ge0$, (18) gives the explicit uniform bound

$$
\sup_{\Im q,\,k,\,T\ge R}
\left|B_{S,R,T}^{(j)}(1/2-q+i\omega_k)\right|
\le\frac{j!}{\sigma^{j+1}}\mathcal E_S(R).
\tag{22}
$$

In particular, on the critical section $\Re q=1/2$, the factor is $2^{j+1}j!$. The same conclusion holds for every cell mode, with no truncation of the Fourier heights. At $q=0$, the finite strip instead gives $H_S^{j+1}\mathcal E_S(R)/(j+1)$.

Equations (18)--(22) are actual boundary-source estimates in the retained-age system. They do not bound the complete age-weighted source $F_z$, the storage convolution, or a localized Schatten-one norm. Slowly growing admitted prime sets with all their powers are not the full set of prime arrivals through the physical age cutoff.

## Sources

The coefficient tilt follows from the complete one-prime geometric series; the endpoint-dependent choices and their Chebyshev bounds are proved above. The regularized half-line formula and its finite-band interference terms are from [Complete prime histories as causal delay overflow](causal-history-overflow.md), equations (4)--(8); no new regularized trace formula is asserted here. The two-history sources and the warning about the complete boundary sum are from [Two-prime unilateral transport and the common resonance](two-prime-unilateral-boundary.md). The age substitution is from [An age-resolved lift of the actual prime-error history](age-resolved-prime-history-lift.md).

For a precise primary source for (13), Tim Trudgian, [Updating the error term in the prime number theorem](https://arxiv.org/pdf/1401.2689), Theorem 1, printed page 3, proves

$$
|\psi(x)-x|\le x\sqrt{\frac8{17\pi}}\,
X_0^{1/2}e^{-X_0},\qquad
X_0=\sqrt{\frac{\log x}{6.455}},\qquad x\ge23.
$$

Setting $x=e^v$ and absorbing the factor $v^{1/4}$ gives (13) for any fixed $0<c<1/\sqrt{6.455}$, with $C_0$ enlarged over the initial compact interval. This unconditional theorem supplies the classical square-root-log PNT envelope used here; no assumption of RH is involved. The smooth-history count (16), the operator compression bound and the finite numerator expansions are proved here. No new prime-error estimate or Lean claim is made.
