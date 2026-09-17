# The centered prime ground graph applied to the natural arithmetic source

This written proof combines the [birth kernel](../prime-history/centered-infinite-prime-birth-kernel.md), [original multiplier domain](centered-prime-mellin-domain.md), and [fixed-Cauchy ground graph](fixed-cauchy-prime-covariance-seed.md). The arithmetic source cutoff is finite; its two temporal outputs retain their cross term. The [sharp cutoff law](../dynamics-and-feedback/fixed-source-centered-cutoff-law.md) gives the exact leading error for each fixed source. These analytic results are not formalized in Lean.

This note applies the complete centered prime kernel to each actual natural source cutoff. It gives a convergent original-Hilbert-space expression with its seed, prime-power births, density, and both temporal directions retained. It does not assert convergence as the arithmetic source cutoff tends to infinity.

Write
$$
 E_\psi(x)=\psi(x)-x,\qquad
 g_N(x)=\mathbf1_{x\ge1}\frac{E_\psi(\min(x,N))}{x},\qquad N\ge1,
$$
and use the unitary change of coordinates
$$
 (Uf)(v)=e^{v/2}f(e^v),\qquad
 a_N=Ug_N,\qquad a_0(v)=e^{-v/2}\mathbf1_{v\ge0}.
\tag{1}
$$
The full-line functions on the additive coordinate vanish on $x\le0$. Let $C_P$ be the complete logarithmic prime generator with its mean removed, as in [centered prime mellin domain](centered-prime-mellin-domain.md), and put $\mathcal C_P=U^{-1}C_PU$. Thus
$$
 C_P=\sum_{p\le P}\left[
 p^{-3/2}(E_{\log p}+E_{-\log p})
 -(1-p^{-1})\sum_{j\ge2}p^{-j/2}(E_{j\log p}+E_{-j\log p})\right],
 \quad E_hf(v)=f(v+h).
\tag{2}
$$
Every local depth series is retained and converges in operator norm.

## The exact innovation measure

In distributions on the whole logarithmic line,
$$
 \boxed{(\partial_v+\tfrac12)a_N=\mu_N
 =-\delta_0+\sum_{2\le n\le N}\frac{\Lambda(n)}{\sqrt n}\delta_{\log n}
       -e^{v/2}\mathbf1_{(0,\log N)}(v)\,dv.}
\tag{3}
$$
The initial value $E_\psi(1)=-1$ gives the negative seed atom. Each prime power contributes its actual von Mangoldt weight. The derivative of $-e^v$ gives the continuous density term. Beyond $\log N$, $a_N(v)=E_\psi(N)e^{-v/2}$, which is killed by $\partial_v+1/2$. There is no additional terminal atom: the function is continuous at that cutoff unless a genuine arithmetic jump occurs there, and that jump already occurs in the sum in (3).

Since $(\partial_v+1/2)a_0=\delta_0$, direct convolution gives
$$
 \boxed{a_N=a_0*\mu_N.}
\tag{4}
$$
For example, the discrete term becomes $e^{-v/2}\sum_{n\le\min(e^v,N)}\Lambda(n)$, the density becomes $-e^{-v/2}(\min(e^v,N)-1)$, and the seed cancels the remaining $+e^{-v/2}$. This verifies the exact natural cutoff, including its tail.

The finite total variation is
$$
 V_N:=\|\mu_N\|_{\rm TV}
 =\sum_{2\le n\le N}\frac{\Lambda(n)}{\sqrt n}+2\sqrt N-1
 \ll\sqrt N.
\tag{5}
$$
Chebyshev's estimate $\psi(t)\ll t$ and partial summation prove the upper bound. PNT gives $V_N\sim4\sqrt N$. These are absolute-variation estimates; they do not use cancellation between the births and density.

## Convergence at each finite natural cutoff

Let
$$
 k_P=C_Pa_0=UA_P,\qquad k=UA,
$$
where the actual kernels $A_P,A$ are constructed in [centered infinite prime birth kernel](../prime-history/centered-infinite-prime-birth-kernel.md). That construction proves
$$
 \|k-k_P\|_2^2\sim\frac4{\log P}.
\tag{6}
$$
Because $C_P$ commutes with translations, (4) implies
$$
 \boxed{C_Pa_N=k_P*\mu_N\longrightarrow k*\mu_N\quad\text{in }L^2(dv).}
\tag{7}
$$
Indeed the Bochner integral against the finite measure is well defined and
$$
 \|(k-k_P)*\mu_N\|_2\le V_N\|k-k_P\|_2.
\tag{8}
$$
This limit is the maximal multiplier $C_\infty a_N$ from the domain note. For completeness, let $m_N(\nu)=\int e^{-i\nu w}\mu_N(dw)$. Then $\widehat a_N=\widehat a_0m_N$, $|m_N|\le V_N$, and the seed belongs to the explicit weighted multiplier domain. Thus $c_\infty\widehat a_N\in L^2$, and its inverse transform is exactly $k*\mu_N$.

In particular, uniformly in $N\ge1$ and sufficiently large $P$,
$$
 \boxed{\|C_\infty a_N-C_Pa_N\|_2^2\ll\frac N{\log P}.}
\tag{9}
$$
This comparison also tends to zero along $N=N(P)=o(\log P)$. It compares two operators on the same finite natural source; it does not imply that either side has a limit as $N\to\infty$.

There is also exact compact stabilization. The birth-kernel difference $A-A_P$ vanishes on $(1/P,P)$, and every physical birth coordinate in $g_N$ lies in $[1,N]$. The scaling $\mathcal C_Ph_t(x)=t^{-1}A_P(x/t)$ therefore gives
$$
 (\mathcal C_\infty-\mathcal C_P)g_N(x)=0
       \quad\text{for }N/P<x<P,
\tag{9a}
$$
almost everywhere. This interval is nonempty when $N<P^2$; on a fixed compact observation interval $[A,B]\subset(0,\infty)$, equality follows when $P>\max(N/A,B)$. Its dependence on the source cutoff is explicit.

The original additive energy is
$$
 \mathcal E(f)=\int_0^\infty w(h)\|f(\cdot+h)-f\|_2^2\,dh,
 \qquad w(h)=\begin{cases}1,&0<h\le1,\\h^{-2},&h>1.\end{cases}
$$
Since $\int_0^\infty w=2$, one has $\mathcal E(f)\le8\|f\|_2^2$. Thus (7) also holds in this original energy after applying $U^{-1}$, with energy of the error at most $8V_N^2\|k-k_P\|_2^2$. No new metric or adjoint enters this implication.

## The two temporal pieces after arithmetic forcing

The ground graph in the [fixed-Cauchy covariance theorem, sections 7–8](fixed-cauchy-prime-covariance-seed.md), gives
$$
 b(v)=-\sum_p B_p(v),\qquad
 B_p(v)=e^{v/2}p^{-\lfloor v/\log p\rfloor-1}\mathbf1_{v\ge\log p},
$$
$$
 (\mathcal Vb)(v)=-b(v)+\int_0^v e^{-(v-u)/2}b(u)\,du,
 \qquad
 k(v)=\begin{cases}b(-v),&v<0,\\(\mathcal Vb)(v),&v>0.\end{cases}
\tag{10}
$$
Here $b\in L^2(0,\infty)$, $\mathcal V$ is a fixed causal isometry, and $\|k\|_2^2=2\|b\|_2^2$. All profile equalities in (10)–(14) are almost everywhere or in $L^2$. The displayed floor formula selects one representative. To recover literal values inherited from the right-continuous physical birth $h_t$, its reflected negative profile instead uses the left-continuous kernel $b(v)=-e^{v/2}\sum_{p,j\ge2}p^{-j}\mathbf1_{(p^{j-1},p^j]}(e^v)$. These representatives differ only at prime-power logarithms, but their distinction must be retained in a pointwise arithmetic sampling identity. The ground graph follows for the infinite-prime limit by continuity from the finite-prime identity; it is not assumed for general arithmetic inputs.

Extend $b$ causally by zero to obtain $b_+$. For $r,v>0$, define
$$
 H_N(r)=\int_{[0,\log N]}b(r+w)\,\mu_N(dw),
$$
$$
 J_N(v)=\int_{[0,v]}b(v-w)\,\mu_N(dw),\qquad
 R_N(v)=\int_{(v,\log N]}b(w-v)\,\mu_N(dw).
\tag{11}
$$
Measures are restricted to their support in these formulas. Endpoint values affect only null sets of output coordinates; one can take $b(0)=0$. All three expressions are well-defined in $L^2(0,\infty)$, by the triangle inequality for finite measures and translations of an $L^2$ function.

Splitting the convolution in (7) at $w=v$ proves
$$
 \boxed{(C_\infty a_N)(-r)=H_N(r),\qquad
 (C_\infty a_N)(v)=(\mathcal VJ_N)(v)+R_N(v).}
\tag{12}
$$
For the second identity, the part with $w\le v$ is the causal convolution of $\mathcal Vb$ with $\mu_N$. Causal convolution commutes with $\mathcal V=-I+a_0*$, giving $\mathcal VJ_N$. The part with $w>v$ sees the negative ground profile and gives $R_N$. This latter term carries future innovations back into the positive observation coordinate.

The exact energy decomposition therefore is
$$
 \boxed{\|C_\infty a_N\|_2^2
 =\|H_N\|_2^2+\|J_N\|_2^2+\|R_N\|_2^2
       +2\operatorname{Re}\langle\mathcal VJ_N,R_N\rangle.}
\tag{13}
$$
The isometry of $\mathcal V$ proves the $\|J_N\|_2^2$ term. It does not remove the displayed cross term. In particular the final negative profile $H_N$ alone has not been shown to determine the final positive profile by the same ground-state map $\mathcal V$.

The negative piece makes the actual cancellation explicit:
$$
 \boxed{H_N(r)=-b(r)
 +\sum_{2\le n\le N}\frac{\Lambda(n)}{\sqrt n}b(r+\log n)
 -\int_0^{\log N}e^{w/2}b(r+w)\,dw.}
\tag{14}
$$
The analogous split in (11) retains the same seed and density on each side of the observation time. There is no replacement by an independently sampled prime process.

## The remaining infinite-source step

The explicit kernel gives $b(v)\sim-2/v$ as $v\to\infty$. Consequently, even for fixed $r>0$, the density integral in (14) is not absolutely convergent as $N\to\infty$: its absolute integrand is asymptotic to $2e^{w/2}/(r+w)$. The prime-power sum and density must therefore be kept together. The total variation bound (5), and hence the finite-source comparison (9), are not uniform in that limit.

The signed mass of the actual innovation is exactly
$$
 \mu_N(\mathbb R)=1+\sum_{2\le n\le N}\frac{\Lambda(n)}{\sqrt n}-2\sqrt N
 =\frac{E_\psi(N)}{\sqrt N}
     +\frac12\int_1^N\frac{E_\psi(t)}{t^{3/2}}\,dt.
\tag{15}
$$
The last equality follows by partial summation, including $E_\psi(1)=-1$. It is an identity for the actual signed source, not an assertion that its right side converges.

The [proved natural convergence](../dynamics-and-feedback/natural-arrival-cutoff-completion.md) $g_N\to g$ in $\mathcal E$ does not itself pass the unbounded centered multiplier through this limit. A further argument must control the signed expressions (11)–(14) in the norm or local readout required by the intended infinite-source statement. In particular, a result in the additive completion need not require the full source to belong to original $L^2$. The present theorem supplies the exact finite-source formula and its quantitative prime-cutoff error while leaving that arithmetic cancellation question explicit.
