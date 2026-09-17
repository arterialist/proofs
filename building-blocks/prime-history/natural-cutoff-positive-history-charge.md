# Every natural cutoff has a negative nonzero-delay charge

This is the arithmetic consumer of the complete positive process in the [finite-time operator theorem](../successor-and-division/positive-history-successor-charge-relaxation.md). The process and its completed L¹ commutator are used with their stated domains; their operator proof is not repeated. The conclusion below holds at every positive process time, rather than only after a sufficiently large time. The natural arithmetic cutoff and the prime cutoff remain separate.

## 1. The exact natural source and all its Laplace coefficients

For an integer N≥1 define
$$
 h_t(x)=x^{-1}1_{x\ge t},\qquad
 g_N=-h_1+\sum_{2\le n\le N}\Lambda(n)h_n-\int_1^Nh_t\,dt.
$$
Thus, for x≥1,
$$
 g_N(x)=\frac{\psi(\min(x,N))-\min(x,N)}x.
$$
Its physical representative is
$$
 a_N(u)=e^{u/2}g_N(e^u)
 =e^{-u/2}\bigl[\psi(\min(e^u,N))-\min(e^u,N)\bigr],
 \quad u\ge0.
 \tag{1}
$$
It is not a hard physical truncation: the tail beyond log N is retained exactly. For every finite N this is a causal L¹ function, with an exponentially decaying tail. All prime-power terms in Λ remain present.

For j≥1 put s=j+1/2. Integrating each finite history and the retained density term gives
$$
 \boxed{L_N(j):=\int_0^\infty e^{-ju}a_N(u)du
 =\frac1s\left[
 \sum_{n\le N}\frac{\Lambda(n)}{n^s}
 -1-\frac{1-N^{1-s}}{s-1}\right].}
 \tag{2}
$$
Indeed $\int_{\log t}^\infty e^{-su}du=t^{-s}/s$. Finite sums and the finite density interval justify all exchanges directly. The empty history at 1 contributes the explicit −1 inside the brackets. Formula (2) in fact holds for every real s>1, with Laplace parameter s−1/2.

The elementary inequality
$$
 D(s):=-\frac{\zeta'}{\zeta}(s)<\frac1{s-1},\qquad s>1,
 \tag{3}
$$
was proved by the integer-block probability argument in the [elementary zeta inequality proof](../dynamics-and-feedback/actual-source-causal-charge-law.md#6-actual-arithmetic-laplace-coefficients-and-the-signs-of-the-two-ports). The known stronger bound of Alzer--Kwong, Theorem 1.1, is not needed for this finite-cutoff sign.

Suppose first N≥4 and s≥3/2. With r=s−1≥1/2,
$$
 N^{-r}\le4^{-r}\le\tfrac12\le r.
$$
Consequently
$$
 1+\frac{1-N^{-r}}r\ge\frac1r
 >D(s)\ge\sum_{n\le N}\Lambda(n)n^{-s}.
$$
Equation (2) is strictly negative, including the endpoint N=4,s=3/2.

For N=2 or 3 and s≥3/2,
$$
 \sum_{n\le N}\Lambda(n)n^{-s}
 \le\frac{\log2}{2^{3/2}}+\frac{\log3}{3^{3/2}}
 <\frac12+\frac13<1.
$$
Here $\log x<\sqrt x$ for x>0 follows by minimizing $\sqrt x-\log x$ at x=4 and using $\log2<1$. The baseline in (2) is strictly greater than 1 for N≥2. Finally N=1 gives $L_1(j)=-1/s$. Therefore
$$
 \boxed{L_N(j)<0\quad\text{for every integer }N\ge1,
                         \text{ every integer }j\ge1.}
 \tag{4}
$$
More generally the same proof gives strict negativity for every real Laplace parameter at least 1.

## 2. Every nonzero process history has negative charge

The exact relative-charge kernel is
$$
 \delta(f)=\tfrac12\int_0^\infty k(u)f(u)du,
 \qquad
 k(u)=\begin{cases}
 -1,&0\le u<\ell,\\
 (1-e^{-u})^{-1/2}-1,&u\ge\ell,
 \end{cases}
 \quad\ell=\log2.
$$
Let $R_vf(u)=1_{u\ge v}f(u-v)$ and
$$
 c_j=\binom{2j}{j}/4^j>0.
$$
For every v≥ell, changing variables avoids the negative initial strip and gives
$$
 \boxed{\delta(R_va_N)
 =\tfrac12\sum_{j\ge1}c_j e^{-jv}L_N(j)<0.}
 \tag{5}
$$
The exchange is absolute: a_N is in L¹ and
$\sum c_je^{-jv}\le\sum c_j2^{-j}<\infty$. There is no assertion of (5) at v=0. The zero-delay history must retain its original charge.

For N≥2 the [exact natural-charge identity](../successor-and-division/actual-successor-resonance-charge-cocycle.md) is
$$
 \delta_N:=\delta(a_N)
 =\sum_{2\le n\le N}\Lambda(n)d(n)+\int_N^\infty d(t)dt,
$$
where, for t≥2,
$$
 d(t)=\arcsin(t^{-1/2})-t^{-1/2}>0.
$$
At t=2 this equals $\pi/4-1/\sqrt2$. Thus an explicit uniform positive lower bound is
$$
 \boxed{\delta_N\ge\delta_*:=(\log2)
       \left(\frac\pi4-\frac1{\sqrt2}\right)>0,
       \qquad N\ge2.}
 \tag{6}
$$
Positivity of d follows from $\arcsin z>z$ for 0<z<1. The density tail and all other prime-power terms are retained, not dropped from the identity; positivity permits their omission only in the displayed lower bound.

## 3. Both cutoffs and the no-jump atom

Let P≥2 denote a prime cutoff, allowing P=∞, and set
$$
 B_P=\sum_{p\le P}B_p,
 \qquad \nu_P(dv)=B_P(v)\frac{dv}{v},
 \qquad \lambda_P=\nu_P((0,\infty)).
$$
At P=∞ these mean the complete B, ν, and λ. Every proper-power interval of every admitted prime is retained. The rate is finite and positive, and the jump measure is supported in [log 2,∞).

Let $\mu_{P,t}$ be the compound Poisson law with rate measure ν_P and let
$$
 U_{P,t}f=\int R_vf\,\mu_{P,t}(dv),\qquad t\ge0.
$$
The zero-delay atom has mass $e^{-\lambda_Pt}$; every other history has delay at least log 2. For t>0 the nonzero histories have positive total probability. Equation (5), kept separate from the no-jump atom, proves
$$
 \boxed{\delta(U_{P,t}a_N)
 <e^{-\lambda_Pt}\delta_N,
 \qquad N\ge1,\ P\ge2,\ t>0.}
 \tag{7}
$$
All integrals are absolute because a_N is L¹, k is bounded, and U is a probability average of L¹ isometries. In particular strict negativity of the nonzero-history integral is legitimate even without a lower bound uniform in its delay.

## 4. An all-positive-time negative commutator mass

At finite N the exact integral identity needs no completion argument. The causal successor S is bounded on physical L¹; U is a positive L¹ contraction preserving the integral. Hence both $SU_{P,t}a_N$ and $U_{P,t}Sa_N$ belong to L¹, and
$$
 \begin{aligned}
 \int[S,U_{P,t}]a_N
 &=\left(\int a_N+2\delta(U_{P,t}a_N)\right)
   -\left(\int a_N+2\delta_N\right)\\
 &=2\delta(U_{P,t}a_N)-2\delta_N.
 \end{aligned}
 \tag{8}
$$
Combining (6)--(8) gives
$$
 \boxed{\int[S,U_{P,t}]a_N
 <-2\delta_*(1-e^{-\lambda_Pt})<0,
 \qquad N\ge2,\ P\ge2,\ t>0.}
 \tag{9}
$$
At the all-prime process this is precisely the bound with λ. To make the estimate uniform over all finite and infinite prime cutoffs, use $\lambda_P\ge\lambda_2>0$:
$$
 \boxed{\int[S,U_{P,t}]a_N
 <-2\delta_*(1-e^{-\lambda_2t}),
 \qquad N\ge2,\ P\ge2,\ t>0.}
 \tag{10}
$$
Using λ instead of λ_P at a finite prime cutoff would not follow from this argument. At process time zero the commutator is exactly zero, so the strict time domain t>0 is essential.

The full rank-one decomposition remains
$$
 [S,U_{P,t}]a_N=[C,U_{P,t}]a_N
 +a_0\delta(U_{P,t}a_N)-(U_{P,t}a_0)\delta_N.
$$
Both charge terms are present. The operator theorem in the cited positive-history source supplies a bounded E→L¹ extension of the first term and its zero integral, along with prime-cutoff continuity. Together with the established natural-source E convergence, it justifies the joint N,P completion of the full commutator at every fixed t. The estimates above do not require duplicating that operator proof and preserve a strictly negative upper bound in the completed limit.

The local identification distinguishes the compensated and full operators: the compensated commutator $[C,U_t]$ agrees locally with $CU_ta-U_tCa$; the expression $SU_ta-U_tSa$ is the full commutator and requires the two rank-one terms above. These are different local functions in general.

This proves a negative total physical L¹ mass for the specified actual successor response at every positive process time and every natural cutoff N≥2. It does not assert pointwise negativity, a negative quadratic pairing, or a sign for the full Weil readout.

This is a written actual-source consumer of the classical zeta bound and the complete probability law. The process now has separate [Lean coverage](../successor-and-division/positive-successor-seed-jump-process.md#formalized-cutoff-law-convergence-and-its-normalization); this arithmetic charge and commutator sign are not formalized by those modules.
