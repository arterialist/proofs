# Positive age evolution preserves the leading centered arrival loading

This written proof applies the [large-birth energy theorem](../prime-history/infinite-centered-birth-energy.md) and the [actual loading calculation](../dynamics-and-feedback/transformed-actual-arrival-loading.md) to any fixed probability law of nonnegative ages. It includes the [complete positive successor process](../successor-and-division/positive-successor-seed-jump-process.md), allowing infinite mean age. It preserves the leading loading rather than proving bounded transformed source energy. These are analytic proofs, not Lean theorems.

Let $A=\mathcal C_\infty h_1$ be the actual complete centered prime birth kernel, and let $\mathcal E$ be the original additive energy. For a fixed probability measure $\eta$ on $[0,\infty)$, define
$$
 \mathcal T_\eta f=\int_0^\infty D_{e^{-v}}f\,\eta(dv),
 \qquad D_af(x)=\sqrt a\,f(ax).
\tag{1}
$$
This includes every fixed time of the all-prime positive age process in the [positive successor-seed process](../successor-and-division/positive-successor-seed-jump-process.md). All its compound-Poisson histories are retained in $\eta$. The measure is held fixed in every limit below.

The [proved dilation bound](../successor-and-division/positive-successor-seed-jump-process.md) $\sup_{0<a\le1}\|D_a\|_{\mathcal E\to\mathcal E}\le C_{\mathcal E}$ gives $\|\mathcal T_\eta\|_{\mathcal E\to\mathcal E}\le C_{\mathcal E}$. On original $L^2(dx)$, it is a contraction by the unitary dilation norm and the probability normalization. No first age moment is required.

On each finite natural source, this is also the centered response of the evolved source. In logarithmic coordinates $\mathcal T_\eta$ has multiplier $\int e^{-i\nu v}\eta(dv)$, of modulus at most one. It therefore preserves the maximal domain of $C_\infty$ and commutes with that multiplier there. In particular $\mathcal T_\eta\mathcal C_\infty g_N=\mathcal C_\infty\mathcal T_\eta g_N$. This uses the original $L^2$ domain of the finite source, without asserting an infinite-source domain passage.

We prove
$$
 \boxed{\mathcal E(\mathcal T_\eta\mathcal C_\infty h_t)
                  \sim\frac{16}{t\log t}\qquad(t\to\infty).}
\tag{2}
$$
Consequently the actual arithmetic arrivals retain total loading asymptotic to $16\log N$ after this fixed positive age evolution. This is a statement about the response applied to the arrivals, not an assertion that the full infinite-source response exists.

## Actual kernel bounds with every jump retained

The explicit birth-kernel theorem gives
$$
 A(x)\sim-\frac2{\sqrt x\log(1/x)}\quad(x\downarrow0),
 \qquad A\in L^2(dx).
\tag{3}
$$
There is also, for sufficiently small $h>0$, the variation bound
$$
 \boxed{\|A\mathbf1_{[h,\infty)}\|_\infty
       +\operatorname{TV}(A\mathbf1_{[h,\infty)})
          \le\frac C{\sqrt h\log(1/h)}.}
\tag{4}
$$
To verify it, between its arithmetic thresholds the exact kernel has derivative $-A(x)/x$. On $(0,1)$, its jumps at $x=p^{-j}$, $j\ge2$, have size $-(1-1/p)$; those at $x=p^{-1}$ have size $1/p$. The number of proper prime powers up to $1/h$ is $O(h^{-1/2}/\log(1/h))$, by Chebyshev counting for squares and the smaller total of higher powers. The reciprocal-prime jumps have total $O(\log\log(1/h))$. The integral of $|A(x)|/x$ on $[h,\delta]$, using (3) with its pointwise upper bound, is $O(h^{-1/2}/\log(1/h))$. Initial bounded intervals contribute finite variation. On $[1,\infty)$, the jumps are $p^{-2}$ at $p$, and $-(1-1/p)p^{-j}$ at $p^j$, $j\ge2$; their absolute sum is finite. The derivative integral on this side is finite from the large-coordinate bound $A(x)=O(x^{-1/2}/\log x)$. Finally the artificial truncation jump at $h$ satisfies the same bound. This proves (4) using the actual steps, rather than a differentiable replacement for them.

## Averaging all nonnegative ages keeps the singular coefficient

Put $F_\eta=\mathcal T_\eta A$ and $L=\log(1/x)$. If $x$ is sufficiently small, (3) holds uniformly for all arguments $e^{-v}x$, $v\ge0$. Hence
$$
 F_\eta(x)=-\frac2{\sqrt x}
       \int_0^\infty\frac{1+\epsilon(e^{-v}x)}{L+v}\,\eta(dv),
 \qquad \sup_{0<y\le x}|\epsilon(y)|\longrightarrow0.
$$
Since $0\le L/(L+v)\le1$ and this ratio tends to one for each fixed finite $v$, dominated convergence with respect to the full probability measure proves
$$
 \boxed{F_\eta(x)\sim-\frac2{\sqrt x\log(1/x)}.}
\tag{5}
$$
It also gives the same pointwise upper bound uniformly over such probability measures. This argument allows an infinite mean age and does not truncate histories.

Bound (4) transfers with a constant independent of $\eta$. Indeed for $a=e^{-v}\le1$, scaling the truncated function gives
$$
 \|D_aA\mathbf1_{[h,\infty)}\|_\infty
  +\operatorname{TV}(D_aA\mathbf1_{[h,\infty)})
 \le\frac C{\sqrt h[\log(1/h)+v]}
 \le\frac C{\sqrt h\log(1/h)}.
$$
Integrating and using convexity of total variation yields
$$
 \|F_\eta\mathbf1_{[h,\infty)}\|_\infty
  +\operatorname{TV}(F_\eta\mathbf1_{[h,\infty)})
       \le\frac C{\sqrt h\log(1/h)}.
\tag{6}
$$
The distributional variation inequality follows first for finite age mixtures and then by local integrability and the defining supremum against compact test derivatives. The preceding uniform bounds also justify the integral representative.

## Translation increments and the original energy

Write $a_h=F_\eta\mathbf1_{(0,h)}$ and $b_h=F_\eta\mathbf1_{[h,\infty)}$. The two translates of $a_h$ have disjoint support, so
$$
 \|\tau_h a_h-a_h\|_2^2=2\int_0^h|F_\eta(x)|^2dx
                  \sim\frac8{\log(1/h)}.
\tag{7}
$$
For bounded BV functions, $\|\tau_h b-b\|_1\le h\operatorname{TV}(b)$ and $\|\tau_h b-b\|_\infty\le2\|b\|_\infty$. Thus (6) gives
$$
 \|\tau_h b_h-b_h\|_2^2=O(\log^{-2}(1/h)).
$$
Their only increment cross term is the integral over $(0,h)$, with magnitude at most
$$
 2\sup_{h<x<2h}|F_\eta(x)|\int_0^h|F_\eta(x)|dx
                          =O(\log^{-2}(1/h)).
$$
Here the uniform pointwise bound gives $\int_0^h|F_\eta|\ll\sqrt h/\log(1/h)$. Therefore
$$
 M_\eta(h):=\|\tau_h F_\eta-F_\eta\|_2^2
                     \sim\frac8{\log(1/h)}.
\tag{8}
$$
The equivalence is for fixed $\eta$; its error has not been shown uniform in a growing process time.

All critical dilations commute, so
$\mathcal T_\eta\mathcal C_\infty h_t(x)=t^{-1}F_\eta(x/t)$. Exact change of variables in the two parts of the original energy gives
$$
 \mathcal E(t^{-1}F_\eta(\cdot/t))
    =\int_0^{1/t}M_\eta(v)dv
      +t^{-2}\int_{1/t}^\infty M_\eta(v)\frac{dv}{v^2}.
\tag{9}
$$
Each term in (9) is asymptotic to $8/(t\log t)$. For the first, integrate $1/\log(1/v)$ near zero; for the second, substitute $y=1/v$ and use $\int^t dy/\log y\sim t/\log t$. Squeezing (8) between fixed relative errors justifies both comparisons. The remaining fixed large-$v$ interval is $O(t^{-2})$, because $M_\eta(v)\le4\|F_\eta\|_2^2$. This proves (2).

## The actual arithmetic loading and its required cross work

For $n\ge2$, retain the full actual arrival
$$
 v_n=(\Lambda(n)-1)h_n-b_n,\qquad
 b_n(x)=\frac{x-n+1}{x}\mathbf1_{[n-1,n)}(x).
\tag{10}
$$
The original Mellin multiplier envelope gives
$$
 \mathcal E(\mathcal C_\infty b_n)
          \ll\frac{(1+\log\log(3+n))^2}{n^2}.
\tag{11}
$$
One can verify this directly: $Ub_n$ has $L^1$ norm $O(n^{-3/2})$ and total variation $2n^{-1/2}$. Its Fourier transform is bounded by $C\min(n^{-3/2},n^{-1/2}/|\nu|)$. Integrate its squared modulus against the established symbol bound $C[1+\log_+(1/|\nu|)+\log\log(3+|\nu|)]^2$, splitting at $|\nu|=1,n$, to get original $L^2$ norm squared $O(n^{-2}(1+\log\log(3+n))^2)$. Then use $\mathcal E\le8\|\cdot\|_2^2$.

The same summable upper bound applies to $\mathcal T_\eta\mathcal C_\infty b_n$: its original $L^2$ norm is at most that of $\mathcal C_\infty b_n$, by the probability-mixture contraction, and then $\mathcal E\le8\|\cdot\|_2^2$ applies. Thus this ramp argument needs no additional completion-space operator estimate. Equations (2), (10), and energy Cauchy–Schwarz show that the sum of the absolute differences
$$
 \sum_{n\ge2}\left|
 \mathcal E(\mathcal T_\eta\mathcal C_\infty v_n)
  -(\Lambda(n)-1)^2
       \mathcal E(\mathcal T_\eta\mathcal C_\infty h_n)\right|
 <\infty.
\tag{12}
$$
Indeed the cross terms are bounded by a constant times
$(\log n+1)(1+\log\log(3+n))/(n^{3/2}\sqrt{\log n})$, whose sum converges. The ramp squares also sum absolutely.

PNT and partial summation now give
$$
 \boxed{\sum_{2\le n\le N}
     \mathcal E(\mathcal T_\eta\mathcal C_\infty v_n)
                         \sim16\log N.}
\tag{13}
$$
Primes supply this leading term: their birth contributions are asymptotic to $16\log p/p$, and $\sum_{p\le N}\log p/p\sim\log N$. The cells with $\Lambda(n)=0$, considered separately, supply $16\log\log N$ to leading order; deleting prime and proper-power indices from $\sum1/(n\log n)$ changes it by a convergent series. Proper prime-power cells have finite total energy, since $\sum_{p,k\ge2}\log(p^k)/p^k<\infty$. These separate statements do not yield a two-term expansion of (13) without a stronger error estimate in (2).

Finally set $F_N=\mathcal T_\eta\mathcal C_\infty g_N$. The actual seed is $F_1=-\mathcal T_\eta\mathcal C_\infty h_1$. At each finite integer $N$, linearity and polarization give the exact balance
$$
 \mathcal E(F_N)=\mathcal E(F_1)
   +2\sum_{n=2}^N\operatorname{Re}\mathcal B
      (F_{n-1},\mathcal T_\eta\mathcal C_\infty v_n)
   +\sum_{n=2}^N\mathcal E(\mathcal T_\eta\mathcal C_\infty v_n).
\tag{14}
$$
If a separate arithmetic argument were to bound $\mathcal E(F_N)$ uniformly, (13)–(14) would require cumulative cross work $-8\log N+o(\log N)$. No such source bound or sign estimate is proved here. The theorem establishes that every fixed positive age evolution preserves the leading loading of the complete centered arithmetic arrivals, despite its bounded action on the original source completion.

The quantitative PNT input may be taken from Trudgian, [*Updating the error term in the prime number theorem*, Theorem 1](https://arxiv.org/pdf/1401.2689). The elementary partial summation, BV increment and Hilbert-space polarization arguments used here are proved explicitly above.
