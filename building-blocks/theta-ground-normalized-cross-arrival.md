# The actual normalized cross-arrival profile at a fixed core

Fix $R>0$, and use the actual bounded even exterior ground state $\psi$, the measure $d\gamma=\rho\psi\,d\nu$, and
$$
 g(u)=\Phi(u)\psi(u)1_{u>R},\quad
 G(z)=\int_R^\infty e^{-zu}g(u)\,du,\quad
 H=2[G(-1/2)-G(1/2)]>0.
$$
Let $K_\times$ include every continuous and prime-power transition between the two exterior half-lines. Define the even positive profile
$$
 v(u)=\frac{2K_\times\psi(u)}{|\tau(u)|},\qquad
 Z(u)=e^{|u|}-1,\qquad
 \bar v=\frac{E_\psi(\operatorname{sgn})}{H}.
\tag{1}
$$
Its exact normalization is
$$
 H=\int Z\,d\gamma,\qquad
 E_\psi(\operatorname{sgn})=\int Z v\,d\gamma.
\tag{2}
$$
Thus the squared residual is weighted by $Z^2\gamma$, whereas $\bar v$ is its mean under $Z\gamma/H$. These measures must not be identified.

## Actual continuity before applying pointwise PNT

The bounded ground-state theorem permits a direct use of Hernández-Santamaría–López Ríos–Saldaña, [Theorem 1.1](https://arxiv.org/html/2401.18033v2). Here is the required match, at the ground pole rather than at a sub-pole resolvent.

The zero extension $h=\psi1_O$ is in the full operator domain. Its physical history $f=\Phi h$ is bounded, has theta tails, and lies in the logarithmic form domain. On $O$,
$$
 Af=Sf+b(\alpha-1/2)\psi.
\tag{3}
$$
The entire prime series $Sf$ is locally bounded, since $|f|\le\|\psi\|_\infty\Phi$, and $S\Phi$ is locally bounded with every prime power included. Localize by a smooth compact cutoff $\chi$. The commutator $[A,\chi]f$ is bounded: the Lipschitz difference cancels the $1/|u-v|$ singularity, and the remaining kernel is integrable. Finally,
$\mathfrak a(\xi)-\log|\xi|+\log(2\pi)\in L^1(d\xi)$, so the correction from $2A$ to the logarithmic Laplacian is bounded convolution on the compact localized function. These are exactly the bounded-forcing and logarithmic-form hypotheses checked in the earlier return-clock boundary source.

For an interior localization choose a bounded interval contained in $O$; near a hard boundary choose an interval on its exterior side, with the localized function zero on the core side and near the other endpoint. The cited theorem gives continuity of each localized function, as well as zero boundary trace. Therefore $g$ has a continuous representative on $\mathbb R$, zero on $( -\infty,R]$, with the same theta envelope. No differentiability or bounded variation of the ground state follows from this argument or is used below.

## A proved relative tail limit for the actual profile

For $u>R$,
$$
 K_\times\psi(u)=\frac1{b(u)}\int_R^\infty r(u+w)g(w)\,dw
 +\frac1{b(u)}\sum_{\log n>u+R}
       \frac{\Lambda(n)}{\sqrt n}g(\log n-u).
\tag{4}
$$
The continuous term tends to zero, bounded by
$e^{-u}(1-e^{-4R})^{-1}G(1/2)$. The prime term tends to $G(-1/2)$ by ordinary PNT against this fixed continuous test. To justify its unbounded support, first truncate $w$ to a compact interval; PNT convergence of the positive translated Chebyshev measures applies to continuous compact tests. The discarded tail is uniformly bounded in $u$ by
$$
 C_\psi e\sum_{j\ge L-1}e^{j/2}
                  \sup_{j\le w\le j+1}|g(w)|,
$$
which tends to zero by the bounded-ground-state theta envelope. Thus no unsupported pointwise theorem for arbitrary $L^2$ tests is being invoked.

Since $|\tau(u)|\to1$, reflection gives
$$
 \boxed{\quad v(u)\longrightarrow v_\infty:=2G(-1/2)>0
                \qquad(|u|\to\infty).\quad}
\tag{5}
$$
This limit is for fixed $R$. In particular the convergence is uniform once $|u|$ exceeds a sufficiently large threshold, but that threshold depends on the actual fixed ground profile.

The measure $Z^2\gamma$ is finite, and has positive mass in every exterior tail. Uniform convergence in (5) therefore proves the precise weighted relative statement
$$
 \boxed{\quad
 \lim_{U\to\infty}
 \frac{\int_{|u|>U}Z^2|1-v/\bar v|^2d\gamma}
      {\int_{|u|>U}Z^2d\gamma}
 =\left|1-\frac{v_\infty}{\bar v}\right|^2.
 \quad}
\tag{6}
$$
For example, if $\sup_{|u|>U}|v-v_\infty|\le\epsilon\bar v$, the square root of the quotient in (6) differs from $|1-v_\infty/\bar v|$ by at most $\epsilon$. This is a bound in the requested squared weight, rather than a change to an unweighted local average.

## The remaining bias is exactly a prime-quadrature quantity

Write $C_R,P_R$ for the continuous and prime convolution terms in the sign-energy source, and $\mathcal R_g=P_R-G(-1/2)^2$ for its exact signed Chebyshev remainder. Then
$$
 \bar v=\frac{2(C_R+P_R)}{G(-1/2)-G(1/2)},
$$
$$
 \boxed{\quad
 \bar v-v_\infty
 =\frac{2\{C_R+\mathcal R_g+G(-1/2)G(1/2)\}}
        {G(-1/2)-G(1/2)}.
 \quad}
\tag{7}
$$
The continuous term and both exponential moments remain. Thus pointwise PNT in the remote observation variable does not make the actual normalized error vanish: it converges to the bias (7), which contains the complete prime convolution remainder for the fixed ground history.

Equations (5)–(7) are actual ground-compatible relative information in the specified far-exterior regime. They do not control the full integral over $|u|>R$, which may be dominated by a neighborhood of the core. Nor do they give a rate uniform as $R$ changes. The available absolute logarithmic-frequency budget for $g$, and boundedness of $\psi$, do not supply either a relative estimate for $\mathcal R_g$ or a normalized modulus of continuity on that near-core region. Consequently no bound strong enough to compare the full residual with the inverse denominator $a(e^R+1)/2$ is established here. That comparison still requires a quantitative ground-specific quadrature or profile estimate; generic positivity of $g$ and ordinary fixed-test PNT are insufficient inputs for this step.

## A moment-normalized positive-barrier estimate

The positive-barrier construction also gives a pointwise bound with the actual moment in its denominator. Distinguish the spectral distance
$d_R=1/2-\alpha_R>0$ from the barrier margin
$\delta_{\rm bar}=d_R/8$. The bounded-ground-state source constructs $1\le w\le M$ and $\varepsilon>0$ such that
$$
 (D_R+K_\varepsilon-\alpha_R)w\ge\delta_{\rm bar}w,
\quad
 K_\varepsilon h(u)=\frac1{b(u)}
 \int_{O,\,|u-v|\ge\varepsilon}r(|u-v|)\Phi(v)h(v)\,dv.
$$
All prime edges remain in the generator on the left. Since $\psi\ge0$, $b\ge2$, and $r$ is decreasing,
$$
 0\le K_\varepsilon\psi(u)
 \le\frac{r(\varepsilon)}2\int_O\Phi\psi
 =r(\varepsilon)G(0)
 \le r(\varepsilon)e^{-R/2}G(-1/2).
$$
Resolvent domination by $w$ therefore proves
$$
 \boxed{\quad
 \frac{\psi(u)}{G(-1/2)}
 \le\frac{r(\varepsilon)e^{-R/2}}{\delta_{\rm bar}}w(u),
 \qquad
 \frac{\|\psi\|_\infty}{G(-1/2)}
 \le\frac{M r(\varepsilon)e^{-R/2}}{\delta_{\rm bar}}.
 \quad}
\tag{8}
$$
The local bound omits the factor $M$ wherever the constructed barrier is one. This is a proved normalization by the actual positive moment, not an $L^2$-normalization substituted for it.

Its constants are not small. The construction chooses $\varepsilon$ by making the logarithmically divergent continuous departure rate dominate a compact-region deficit; it supplies no useful decaying-in-$R$ bound on $r(\varepsilon)$. Moreover a large ratio is unavoidable:
$$
 \frac{\|\psi\|_\infty}{G(-1/2)}
 \ge\left(\int_R^\infty e^{u/2}\Phi(u)du\right)^{-1}.
\tag{9}
$$
At $R=2$, the elementary theta envelope already used in the explicit score comparison gives the integral at most $(128/5)e^{-125}<3\cdot10^{-49}$. The ratio in (9) therefore exceeds $10^{49}/3$. This is not an obstruction to a good estimate for the normalized density $e^{u/2}\Phi\psi/G(-1/2)$, since its theta factor can offset the large ratio. It does show why (8) alone does not yield the desired relative profile or modulus estimate.

## Attribution and formal scope

The closed-form variational inverse, nonnegative-form Cauchy–Schwarz, finite-rank inverse identities and affine completion of squares used here are classical. The actual theta ground state, full continuous kernel, every prime power and stated fixed-core domains remain part of the theorem. These are written proofs; no Lean formalization of this profile comparison or evaluation of the required arithmetic smallness is asserted.
