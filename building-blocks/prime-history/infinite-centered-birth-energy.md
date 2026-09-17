# Large-birth energy of the actual infinite centered kernel

This written proof uses the [complete centered birth kernel](centered-infinite-prime-birth-kernel.md), classical PNT and an explicit bounded-variation estimate retaining every arithmetic jump. It identifies the exact small-translation modulus and large-birth additive energy. It does not use a bounded extension of the centered operator to the whole mixed completion. No Lean theorem here formalizes these analytic asymptotics.

Let $A=\mathcal C_\infty h_1$ be the actual centered infinite-prime birth kernel constructed in [centered infinite prime birth kernel](centered-infinite-prime-birth-kernel.md). Extend it by zero on $x\le0$. Its individual scaled birth profiles are
$$
 F_t(x)=\mathcal C_\infty h_t(x)=t^{-1}A(x/t),\qquad t>0.
\tag{1}
$$
They belong to the original additive-coordinate $L^2$ space. We prove
$$
 \boxed{M_A(h):=\|\tau_hA-A\|_2^2
                  \sim\frac8{\log(1/h)}\quad(h\downarrow0),}
\tag{2}
$$
and consequently
$$
 \boxed{\mathcal E(F_t)\sim\frac{16}{t\log t}
                                      \quad(t\to\infty),}
\tag{3}
$$
where $(\tau_hf)(x)=f(x+h)$ and
$$
 \mathcal E(f)=\int_0^1\|\tau_hf-f\|_2^2dh
           +\int_1^\infty\|\tau_hf-f\|_2^2\frac{dh}{h^2}.
\tag{4}
$$
The proof of (2) uses the actual prime-step variation away from zero. Pointwise comparison with a smooth singular model alone is not used to control translated errors.

## 1. Actual kernel and its complete jump variation

The exact kernel is
$$
 A(x)=\frac1x\left[\sum_{p\le x}\frac1p
           -\sum_{j\ge2}\sum_{p^j\le x}(1-p^{-1})\right]
                                      \quad(x\ge1),
$$
$$
 A(1/r)=-r\sum_{p<r}p^{-\lceil\log_p r\rceil}
                                      \quad(r>1),
\tag{5}
$$
up to immaterial choices at threshold points. The earlier theorem proves
$$
 A(x)\sim-\frac2{\sqrt x\log(1/x)}\quad(x\downarrow0),
 \qquad
 A(x)\sim-\frac2{\sqrt x\log x}\quad(x\to\infty),
\tag{6}
$$
as well as $A\in L^2$. In particular, for sufficiently small positive $x$,
$$
 |A(x)|\le\frac C{\sqrt x\log(1/x)}.
\tag{7}
$$

Every compact subinterval of $(0,\infty)$ contains only finitely many thresholds from (5). Between them, $A$ is a constant divided by $x$, so its ordinary derivative is $A'(x)=-A(x)/x$. The complete jump list, with right limit minus left limit, is
$$
 \begin{array}{c|c}
 \text{threshold}&\text{jump size}\\ \hline
 p^{-1}&p^{-1}\\
 p^{-j},\ j\ge2&-(1-p^{-1})\\
 p&p^{-2}\\
 p^j,\ j\ge2&-(1-p^{-1})p^{-j}.
 \end{array}
\tag{8}
$$
There is no residual jump at one after centering. Distinct prime powers have distinct thresholds, so no multiplicity has been lost in this list.

For $0<\delta\ll1$, put $R=1/\delta$. The number of proper-power thresholds on $[\delta,1]$ is
$$
 \sum_{2\le j\le\log_2R}\pi(R^{1/j})
    \ll\frac{\sqrt R}{\log R}+R^{1/3}\log(2R)
    \ll\frac{\sqrt R}{\log R}.
\tag{9}
$$
Here the prime-square term uses Chebyshev's bound; the displayed coarser bound for all higher powers is absorbed for large $R$. The positive reciprocal-prime jumps have total size
$\sum_{p\le R}p^{-1}\ll\log\log(3R)$, also absorbed by the final bound in (9).

The ordinary derivative on this interval has integral
$$
 \int_\delta^1|A'(x)|dx
      \ll 1+\int_\delta^{\delta_0}
                         \frac{dx}{x^{3/2}\log(1/x)}
      \ll\frac{\delta^{-1/2}}{\log(1/\delta)}.
\tag{10}
$$
For the last estimate substitute $r=1/x$, then split its integral at $\sqrt R$. On the upper part $\log r\ge\frac12\log R$; the lower part is $O(R^{1/4})$.

On $[1,\infty)$, the jump variation is finite, since
$$
 \sum_p p^{-2}+\sum_p\sum_{j\ge2}(1-p^{-1})p^{-j}<\infty.
$$
The ordinary derivative integral is finite there as well, by (6). Thus the truncated actual function
$$
 b_\delta=A\mathbf1_{[\delta,\infty)}
$$
has bounded variation on the whole real line, including the newly introduced jump at $\delta$. Equations (7)--(10) give
$$
 \boxed{\|b_\delta\|_\infty+
                  \operatorname{TV}(b_\delta)
       \ll\frac{\delta^{-1/2}}{\log(1/\delta)}.}
\tag{11}
$$
For the supremum bound, use that $\sqrt r/\log r$ is increasing for sufficiently large $r$, together with boundedness on the remaining compact interval. All inverse prime-power steps and all positive-coordinate steps are included in (11).

## 2. Splitting exactly at the translation length

For a bounded function $b$ of bounded variation,
$$
 \|\tau_hb-b\|_1\le h\operatorname{TV}(b),
 \qquad
 \|\tau_hb-b\|_2^2
          \le2\|b\|_\infty h\operatorname{TV}(b).
\tag{12}
$$
The first inequality follows by expressing the increment as the derivative measure of the interval $(x,x+h]$ and applying Fubini to its total variation. It does not require the original function to be $L^1$; the increment is $L^1$. The second inequality uses the uniform bound on the increment.

Take $\delta=h$, and write
$$
 a_h=A\mathbf1_{(0,h)},\qquad
 b_h=A\mathbf1_{[h,\infty)},\qquad
 T(h)=\int_0^h|A(x)|^2dx,
 \quad L_h=\log(1/h).
$$
Equations (11) and (12) prove the quantitative remainder bound
$$
 \boxed{\|\tau_hb_h-b_h\|_2^2=O(L_h^{-2}).}
\tag{13}
$$
The supports of $a_h$ and $\tau_ha_h$ are disjoint, up to endpoints. Thus
$$
 \|\tau_ha_h-a_h\|_2^2=2T(h).
$$
The only overlap in the cross term of the two increments occurs on $(0,h)$. Consequently the exact real identity is
$$
 \boxed{M_A(h)=2T(h)+\|\tau_hb_h-b_h\|_2^2
                       -2\int_0^h A(x)A(x+h)dx.}
\tag{14}
$$
This retains the displaced singularity and the cut at $h$.

The cross term is also small. From (7),
$$
 \int_0^h|A(x)|dx\ll\frac{\sqrt h}{L_h},
 \qquad
 \sup_{h\le x\le2h}|A(x)|\ll\frac1{\sqrt h L_h}.
$$
Their product bounds the absolute integral in (14) by $O(L_h^{-2})$. Therefore the actual translation modulus has the useful sharper description
$$
 \boxed{M_A(h)=2\int_0^h|A(x)|^2dx+O(L_h^{-2}).}
\tag{15}
$$
The pointwise equivalent (6) can now be integrated without translating its error. Its relative error is uniformly small on $(0,h)$, and
$$
 T(h)\sim4\int_0^h\frac{dx}{x\log^2(1/x)}
                                  =\frac4{L_h}.
\tag{16}
$$
Equations (15)--(16) prove (2), and also give the uniform upper bound $M_A(h)\ll1/\log(1/h)$ for all sufficiently small $h$. The two terms of size $4/L_h$ correspond to the original and translated singular pieces. Their leading masses are determined by PNT, while the error control uses the complete arithmetic jump list.

## 3. The two energy integrals have equal leading contributions

The exact scaling (1) gives
$$
 \|\tau_hF_t-F_t\|_2^2=t^{-1}M_A(h/t).
$$
Change variables separately in the two parts of (4):
$$
 \boxed{\mathcal E(F_t)
      =\int_0^{1/t}M_A(v)dv
           +t^{-2}\int_{1/t}^\infty\frac{M_A(v)}{v^2}dv.}
\tag{17}
$$
Every integral is finite because $A\in L^2$, hence $M_A(v)\le4\|A\|_2^2$, and (15) controls zero.

For the first term substitute $v=u/t$:
$$
 t\log t\int_0^{1/t}M_A(v)dv
                   =\int_0^1(\log t)M_A(u/t)du.
$$
For every fixed $u>0$, the integrand tends to eight by (2). The small-increment upper bound gives a uniform dominating constant, since
$\log(t/u)\ge\log t$ for $0<u\le1$. Dominated convergence proves
$$
 \int_0^{1/t}M_A(v)dv\sim\frac8{t\log t}.
\tag{18}
$$

For the second term, first remove $v\ge t^{-1/2}$. Its contribution is at most
$$
 4\|A\|_2^2t^{-2}
                     \int_{t^{-1/2}}^\infty v^{-2}dv
                              =O(t^{-3/2}),
$$
which is negligible on the stated scale. In the remaining interval set $v=u/t$, with $1\le u\le\sqrt t$. After multiplication by $t\log t$ the integral is
$$
 \int_1^{\sqrt t}(\log t)M_A(u/t)\frac{du}{u^2}.
$$
Its integrand tends pointwise to $8/u^2$, and is dominated by $C/u^2$, since $\log(t/u)\ge\frac12\log t$. Extending it by zero beyond $\sqrt t$ permits dominated convergence on $[1,\infty)$. It follows that
$$
 t^{-2}\int_{1/t}^\infty\frac{M_A(v)}{v^2}dv
                              \sim\frac8{t\log t}.
\tag{19}
$$
Adding (18) and (19) proves (3) with coefficient sixteen. The argument also proves the bound $\mathcal E(F_t)\ll1/(t\log t)$ for sufficiently large $t$.

This is a theorem about the actual infinite centered image of each birth profile. It uses neither a Mellin-multiplier bound nor boundedness of the centered operator on the full mixed-energy completion. It does not interchange a growing prime cutoff with $t\to\infty$, or pass to the full infinite natural source. The much larger energy scale here than for a fixed single-prime profile records the loading from the complete centered prime history; its arithmetic source-level consequences require retaining the signed innovations separately.

The quantitative PNT input may be taken from Trudgian, [*Updating the error term in the prime number theorem*, Theorem 1](https://arxiv.org/pdf/1401.2689). The elementary partial summation, BV increment and Hilbert-space polarization arguments used here are proved explicitly above.
