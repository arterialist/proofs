# The loading of the transformed actual integer arrivals

This written proof combines the [large-birth energy theorem](../prime-history/infinite-centered-birth-energy.md), the [original centered multiplier domain](../prime-distribution/centered-prime-mellin-domain.md), and classical PNT with exact finite arithmetic increments. It separates the actual prime, proper-power and density-cell contributions and keeps the ramp cross terms. The cumulative loading is proved; the signed past-arrival cancellation required for bounded transformed energy is not. No Lean formalization of this analytic theorem is claimed.

This note derives the actual arithmetic loading from the following proved birth-kernel theorem:
$$
\boxed{\mathcal E(C_\infty h_t)\sim\frac{16}{t\log t}\quad(t\to\infty),
\qquad h_t(x)=x^{-1}1_{x\ge t}.}
\tag{H}
$$
Theorem (H) is proved in [infinite centered birth energy](../prime-history/infinite-centered-birth-energy.md), equation (3), in the same original additive-coordinate energy used here. The loading conclusions below follow from that theorem, the established original Mellin-domain construction in [centered prime mellin domain](../prime-distribution/centered-prime-mellin-domain.md), and classical PNT. They are unconditional. The ramp and domain estimates in sections 1--2 do not use (H).

All additive functions are extended by zero to the negative line. Use
$$
\mathcal E(f)=\int_0^1\|\tau_hf-f\|_2^2dh+
\int_1^\infty\|\tau_hf-f\|_2^2\frac{dh}{h^2}.
\tag{1}
$$
Write its polarized inner product as $\langle f,g\rangle_{\mathcal E}$. The actual natural-cutoff source and its seed are
$$
g_N(x)=1_{x\ge1}\frac{\psi(\min(x,N))-\min(x,N)}x,
\qquad g_1=-h_1.
$$
For integer $n\ge2$, define
$$
b_n(x)=\frac{x-n+1}{x}1_{[n-1,n)}(x),\qquad
v_n=g_n-g_{n-1}=(\Lambda(n)-1)h_n-b_n.
\tag{2}
$$
This is the exact increment, including the unit-cell density ramp and the inclusive arrival at $n$. Put
$$
H_n=C_\infty h_n,\qquad B_n=C_\infty b_n,\qquad
V_n=C_\infty v_n=(\Lambda(n)-1)H_n-B_n.
\tag{3}
$$

By theorem (H), the complete integer-admission loading satisfies
$$
\boxed{\sum_{2\le n\le N}\mathcal E(V_n)\sim16\log N.}
\tag{4}
$$
Its separated actual arithmetic components are
$$
\boxed{\begin{aligned}
\sum_{\substack{p\le N\\p\ {\rm prime}}}\mathcal E(V_p)&\sim16\log N,\\
\sum_{\substack{2\le n\le N\\\Lambda(n)=0}}\mathcal E(V_n)&\sim16\log\log N,\\
\sum_{\substack{q=p^k\\k\ge2}}\mathcal E(V_q)&<\infty.
\end{aligned}}
\tag{5}
$$
No two-term expansion of (4) is inferred from the birth equivalent alone.

## 1. The actual ramp in the Mellin domain

The unitary map from additive $L^2(dx)$ to logarithmic $L^2(dv)$ is
$$
(\mathcal U f)(v)=e^{v/2}f(e^v).
$$
The centered operator on additive functions means
$\mathcal U^{-1}C_\infty\mathcal U$, with the original-space multiplier from [centered prime mellin domain](../prime-distribution/centered-prime-mellin-domain.md). In this note the same symbol $C_\infty$ denotes this conjugated realization. Its sufficient domain is controlled by
$$
|c_\infty(\nu)|\le C\Omega(\nu),\qquad
\Omega(\nu)=1+\log_+\frac1{|\nu|}+\log\log(3+|\nu|),
\qquad \nu\ne0.
\tag{6}
$$
Use the unitary Fourier transform in $v$.

For the ramp,
$$
f_n(v):=(\mathcal U b_n)(v)
=e^{-v/2}(e^v-n+1)\,
1_{[\log(n-1),\,\log n)}(v).
\tag{7}
$$
It increases from zero to $n^{-1/2}$ on this interval: its interior derivative is
$$
\tfrac12e^{v/2}+\tfrac12(n-1)e^{-v/2}>0.
$$
At the upper endpoint it jumps back to zero. Therefore
$$
\operatorname{TV}(f_n)=2n^{-1/2},\qquad
\|f_n\|_1\le n^{-1/2}\log\frac n{n-1}\le2n^{-3/2}.
\tag{8}
$$
These estimates retain the upper jump; it is not smoothed away. Fourier estimation by $L^1$, and by the total variation of the distributional derivative, gives
$$
|\widehat f_n(\nu)|
\le C\min\left(n^{-3/2},\frac{n^{-1/2}}{|\nu|}\right).
\tag{9}
$$

Put $\ell_n=1+\log\log(3+n)$. We claim
$$
\int_{\mathbb R}\Omega(\nu)^2|\widehat f_n(\nu)|^2d\nu
\le C n^{-2}\ell_n^2.
\tag{10}
$$
On $|\nu|\le1$, use $n^{-3}$ and the integrability of
$\log^2(1/|\nu|)$, giving $O(n^{-3})$. On $1<|\nu|\le n$,
$\Omega(\nu)\le C\ell_n$, giving $O(n^{-2}\ell_n^2)$.
On $|\nu|>n$, use $n^{-1}\nu^{-2}$. The remaining bound
$$
\int_n^\infty\frac{(1+\log\log(3+\nu))^2}{\nu^2}d\nu
\le C\frac{\ell_n^2}{n}
$$
follows, for example, by splitting into $[2^jn,2^{j+1}n]$. Their weights are $O(2^{-j}/n)$, and the logarithmic factor is at most a constant times $\ell_n+\log(2+j)$. The resulting geometric series converges. This proves (10).

In particular every $b_n$ is in the original sufficient domain of $C_\infty$, and
$$
\|C_\infty b_n\|_{L^2(dx)}^2\le Cn^{-2}\ell_n^2.
$$
For every $L^2$ function, the definition (1) gives
$\mathcal E(f)\le8\|f\|_2^2$. Thus the required estimate is
$$
\boxed{\mathcal E(B_n)\le Cn^{-2}
\bigl(1+\log\log(3+n)\bigr)^2.}
\tag{11}
$$
It follows independently of (H) that $\sum_{n\ge2}\mathcal E(B_n)<\infty$.

## 2. Domain of the finite actual sources and the exact seed

The birth vector has logarithmic representation
$$
(\mathcal U h_t)(v)=e^{-v/2}1_{v\ge\log t}.
$$
Its Fourier transform is a scalar multiple of a translated Cauchy profile:
$$
\widehat{\mathcal U h_t}(\nu)
=\frac{t^{-1/2-i\nu}}{\sqrt{2\pi}(1/2+i\nu)}.
\tag{12}
$$
The logarithmic singularity of $\Omega$ at zero and its double-logarithmic growth at infinity are both square-integrable against this profile. Hence every fixed $h_t$, including $h_1$, is in the original domain, and $C_\infty h_t$ is in $L^2(dx)$.

Together with (10), this proves that each finite $g_N=-h_1+\sum_{n=2}^N v_n$ is in that same linear domain. Define
$$
G_N=C_\infty g_N,\qquad G_1=-C_\infty h_1.
\tag{13}
$$
Then $G_N\in L^2(dx)$, has finite mixed energy, and
$$
G_N=G_1+\sum_{n=2}^N V_n
\tag{14}
$$
exactly. No boundedness of $C_\infty$ on the entire mixed completion is asserted. In particular this finite-source domain statement does not assert that the limiting actual $g$ belongs to the original operator domain.

## 3. The ramp square and cross corrections are absolutely summable

Theorem (H) implies
$$
\mathcal E(H_n)\le \frac{C}{n\log n}
\tag{15}
$$
for all $n\ge2$, after absorbing finitely many initial values. Let $a_n=\Lambda(n)-1$, retaining its actual sign, including $a_2<0$. Expansion in the mixed inner product gives
$$
\boxed{\mathcal E(V_n)
=a_n^2\mathcal E(H_n)
-2a_n\Re\langle H_n,B_n\rangle_{\mathcal E}
+\mathcal E(B_n).}
\tag{16}
$$
The mixed term is not discarded or presumed to have either sign. Cauchy--Schwarz, (11), and (15) show that its absolute sum is finite:
$$
\begin{aligned}
\sum_{n\ge2}|a_n|\,
|\langle H_n,B_n\rangle_{\mathcal E}|
&\le C\sum_{n\ge2}
\frac{(\Lambda(n)+1)\ell_n}{n^{3/2}\sqrt{\log n}}\\
&\le C\sum_{n\ge2}
\frac{\ell_n\sqrt{\log(2n)}}{n^{3/2}}<\infty.
\end{aligned}
\tag{17}
$$
Here only $\Lambda(n)\le\log n$ was needed. Therefore the cumulative difference
$$
\sum_{n=2}^N
\left[\mathcal E(V_n)-a_n^2\mathcal E(H_n)\right]
$$
converges to a finite real constant. The same statement holds after restriction to primes, to $\Lambda(n)=0$, or to proper prime powers, because the full absolute correction sum converges.

## 4. Prime arrivals carry the leading loading

At a prime $p$, $a_p=\log p-1$. The leading arithmetic weight is
$$
\frac{(\log p-1)^2}{p\log p}
=\frac{\log p}{p}-\frac2p+\frac1{p\log p}.
\tag{18}
$$
PNT and partial summation give
$$
\sum_{p\le N}\frac{\log p}{p}\sim\log N,\qquad
\sum_{p\le N}\frac1p=O(\log\log(3N)),\qquad
\sum_p\frac1{p\log p}<\infty.
\tag{19}
$$
The final two statements already follow from Chebyshev counting, except that no sharp reciprocal-prime constant is needed here. Thus the sum of (18) is asymptotic to $\log N$.

Write (H) at integer arguments as
$$
\mathcal E(H_n)=\frac{16}{n\log n}(1+\varepsilon_n),
\qquad \varepsilon_n\to0.
\tag{20}
$$
All weights $a_n^2/(n\log n)$ are nonnegative. Splitting off a fixed initial segment, then bounding $|\varepsilon_n|$ by its uniform small tail supremum, proves that the relative error in a divergent weighted sum tends to zero. Applying this argument to (18)--(19), and then adding the absolutely summable correction from (16), proves
$$
\sum_{p\le N}\mathcal E(V_p)=16\log N+o(\log N).
\tag{21}
$$
No rate for $\varepsilon_n$ is assumed.

## 5. The no-arrival cells and all proper powers

For $\Lambda(n)=0$, $a_n^2=1$. The ordinary harmonic-logarithmic sum is
$$
\sum_{2\le n\le N}\frac1{n\log n}=\log\log N+O(1).
\tag{22}
$$
Removing prime and proper-prime-power indices changes this by a bounded amount. The prime removal is bounded by the last series in (19). For proper powers, elementary counting gives
$$
Q(t):=\#\{p^k\le t:k\ge2\}=O(\sqrt t),
$$
and partial summation gives a convergent sum of $1/(q\log q)$ over those $q$. Consequently
$$
\sum_{\substack{2\le n\le N\\\Lambda(n)=0}}\frac1{n\log n}
=\log\log N+O(1).
\tag{23}
$$
Using the positive-weight argument after (20), followed by the restricted summable ramp correction, proves
$$
\sum_{\substack{2\le n\le N\\\Lambda(n)=0}}\mathcal E(V_n)
=16\log\log N+o(\log\log N).
\tag{24}
$$

At a proper prime power $q=p^k$, $k\ge2$,
$$
(\Lambda(q)-1)^2\mathcal E(H_q)
\le C\frac{\log(2q)}q.
$$
The counting bound $Q(t)=O(\sqrt t)$ makes the sum of this upper bound finite by partial summation. Together with (16)--(17), it follows that
$$
\sum_{\substack{q=p^k\\k\ge2}}\mathcal E(V_q)<\infty.
\tag{25}
$$
Every proper power, including the powers of two with $\Lambda(q)-1<0$, remains in this estimate.

Adding (21), (24), and (25) proves (4)--(5). The prime term's unspecified $o(\log N)$ error could dominate $\log\log N$. Therefore these statements do not justify a two-term expansion of the total loading.

## 6. Exact telescoping and the required cross work

The polarized form of (1) and the exact finite history (14) give
$$
\boxed{\mathcal E(G_N)
=\mathcal E(G_1)+\sum_{n=2}^N\mathcal E(V_n)
+2\sum_{n=2}^N\Re\langle G_{n-1},V_n\rangle_{\mathcal E}.}
\tag{26}
$$
The seed is the actual $G_1=-C_\infty h_1$, not a freely chosen zero state. All finite cross work appears in the last sum.

If the transformed source energies $\mathcal E(G_N)$ were bounded, then (4) and (26) would force
$$
\boxed{\sum_{n=2}^N\Re\langle G_{n-1},V_n\rangle_{\mathcal E}
=-8\log N+o(\log N).}
\tag{27}
$$
Boundedness of these transformed energies has not been proved here. The already established bounded mixed energies of the untransformed $g_N$ do not supply it, because the centered infinite-prime operator is unbounded and has its own domain.

The quantity in (4) is the sum of squared actual increments at the integer admission clock. It is not identified with the classical quadratic variation of a continuously parametrized path. The theorem gives the loading that the signed cross work would have to offset, while leaving that actual cancellation problem open.

The quantitative PNT input may be taken from Trudgian, [*Updating the error term in the prime number theorem*, Theorem 1](https://arxiv.org/pdf/1401.2689). The elementary partial summation, BV increment and Hilbert-space polarization arguments used here are proved explicitly above.
