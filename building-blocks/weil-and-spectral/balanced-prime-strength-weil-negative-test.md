# Balanced prime strengths make the full Weil form negative

Written research note, 17 September 2026. This is a countermodel to a scale-doubling inequality based only on prime births and factorization histories, without the exact local scattering trace normalization. The model keeps the actual prime and prime-power locations, positive strengths shared by every power of a prime, a positive factorial ground with limit $1+\gamma$, a stretched-exponential PNT error, and the right pole residue and constant term of $\zeta$. Its formally deformed **full** Weil quadratic form, with the actual gamma term and both poles, is negative on smooth tests at arbitrarily large windows. The strengths differ from $\Lambda(p^r)=\log p$, so this is no negative test for the actual zeta Weil form.

Use the exact three-band weights and sparse scales $X_j$ from the [balanced prime-band construction](suzuki-balanced-prime-bands-pole-ground-countermodel.md), equations (1)–(14):
$$
 I_{j0}=(X_j/8,X_j/4],\quad
 I_{j1}=(X_j/4,X_j/2],\quad
 I_{j2}=(X_j/2,X_j],
$$
$$
 \Lambda_*(p^r)=(1+\varepsilon_jw_{jk})\log p
 \quad(p\in I_{jk},\ r\ge1),\qquad
 \varepsilon_j=e^{-(a_0/2)\sqrt{\log X_j}},
 \quad(w_{j0},w_{j1},w_{j2})=(-1,2,-1)+O((\log X_j)^{-1}).
 \tag{1}
$$
Elsewhere $\Lambda_*=\Lambda$. The two exact band moments in that construction give $F_*>0$, $F_*(\infty)=1+\gamma$, and the same first two right pole coefficients as $\zeta$. We may reduce the fixed $a_0>0$ so that every classical PNT error used below decays faster than $\varepsilon_j$.
The scales satisfy $X_{j+1}\ge X_j^2$ and
$\log X_j\ge j^4$.

Let $Q_*$ be the formally deformed complete geometric Weil form obtained by replacing only $\Lambda$ with $\Lambda_*$ in the prime term of [the full form](three-window-global-pole-null-weil-bound.md). Set
$$
 a_j=\tfrac12\log X_j,\qquad
 \phi_j(u)=\cosh(u/2)\mathbf1_{\{|u|<a_j\}}.
$$
The zero-extended $\phi_j$ lies in the logarithmic form domain. The theorem is
$$
 \boxed{\quad
 Q_*(\phi_j)=
 -\left(\frac{3\log2-1}{16}+o(1)\right)
          \varepsilon_jX_j<0
 \quad(j\to\infty). \quad}
 \tag{2}
$$
For every large $j$, a real even $g_j\in C_c^\infty(-a_j,a_j)$
also satisfies $Q_*(g_j)<0$.

## The actual broad test has a smaller baseline

For $a=\tfrac12\log X$, the two pole moments of
$\phi_a(u)=\cosh(u/2)\mathbf1_{\{|u|<a\}}$ both equal
$\sinh a+a$. Their complete pole contribution is
$$
 P(\phi_a)=2(\sinh a+a)^2
          =\frac X2+O(\sqrt X\log X).
 \tag{3}
$$
The gamma multiplier
$\Re\psi(1/4+i\xi/2)-\log\pi$ is
$O(\log(2+|\xi|))$. Both the $L^1$ norm and total variation
of the zero-extended $\phi_a$ are $O(e^{a/2})$. Hence
$$
 |\widehat{\phi_a}(\xi)|
 \ll e^{a/2}\min(1,|\xi|^{-1}),\qquad
 |\Gamma(\phi_a)|=O(e^a)=O(\sqrt X).
 \tag{4}
$$
These estimates include its endpoint jumps.

The complete prime edge at $n<X$, including every prime power,
has the exact value from the [terminal edge calculation](../prime-distribution/odd-prime-terminal-band-phase-transfer.md):
$$
 E_{a,n}
 =\Lambda(n)\left[
   \frac{\log(X/n)}4\left(1+\frac1n\right)
   +\frac12\left(\frac{\sqrt X}{n}-\frac1{\sqrt X}\right)\right].
 \tag{5}
$$
The prime part of $Q(\phi_a)$ is
$-2\sum_{n<X}E_{a,n}$. The classical effective PNT and partial
summation give, after reducing $a_0$ if needed,
$$
 \sum_{n<X}\Lambda(n)\log(X/n)
 =\int_1^X\frac{\psi(t)}t\,dt
 =X+O(Xe^{-a_0\sqrt{\log X}}).
$$
The $1/n$ and $\sqrt X/n$ terms in (5) cost
$O(\sqrt X\log^2X)$ in total. Equations (3)–(5) therefore prove
$$
 Q(\phi_a)=
 O(Xe^{-a_0\sqrt{\log X}}+\sqrt X\log^2X)
 =o(\varepsilon_jX_j)\quad(X=X_j).
 \tag{6}
$$
This is the actual leading pole-prime cancellation, with gamma retained.

## The balanced perturbation has a fixed negative sign

At $X=X_j$, every altered prime in the current block exceeds
$X/8$, so its proper powers lie beyond the window for large $j$.
The PNT on the three bands and (1), (5) give
$$
 \begin{aligned}
 Q_*(\phi_j)-Q(\phi_j)
 &=-\frac{\varepsilon_jX_j}{2}
     \left[
     \sum_{k=0}^2(-1,2,-1)_k
       \int_{\alpha_k}^{\beta_k}\log(1/y)\,dy
       +o(1)\right]
       +R_j\\
 &=-\varepsilon_jX_j
       \left(\frac{3\log2-1}{16}+o(1)\right)+R_j,
 \end{aligned}
 \tag{7}
$$
where
$(\alpha_k,\beta_k)=(1/8,1/4),(1/4,1/2),(1/2,1)$.
The bracket integral equals $(3\log2-1)/8>0$.
The smaller terms in (5) contribute only
$O(\varepsilon_j\sqrt{X_j}\log X_j)$.

Here $R_j$ includes **all** altered powers from earlier blocks.
For $i<j$, $X_i\le\sqrt{X_j}$. In (5), bound
$\log(X_j/n)\le\log X_j$, count at most
$\log X_j/\log p$ eligible powers of each altered prime base,
and use
$\sum_{p\in I_{ik}}\sum_{r\ge1}(\log p)/p^r=O(1)$.
With $L_j=\log X_j$, this gives
$$
 |R_j|\ll jL_j^2\sqrt{X_j}
       =o(\varepsilon_jX_j).
 \tag{8}
$$
Future blocks have no eligible prime power. Equations (6)–(8)
prove (2).

For each fixed $j$, the pole and finite prime parts are continuous
under $L^2$ approximation. The logarithmic gamma form is continuous
under $H^s$ approximation for any $0<s<1/2$.
The zero-extended endpoint-jump function $\phi_j$ belongs to such
an $H^s$, and smooth even interior cutoffs converge to it there.
Its strict negative value therefore passes to some
$g_j\in C_c^\infty(-a_j,a_j)$.

## What the mixed history modes do see

The [critical mixed-character theorem](compact-weil-critical-mixed-character-kernel.md)
has a positive complete-Weil limit for each fixed finite set of prime
phase characters at packet scale $T=cN$, $c>4$.
The balanced deformation does not reverse that limit.
Take $N=X_j$ and fix a finite character set whose primes lie below
the first altered band. For altered $d=p^r$, every character has
value $1$ at $d$. The mixed prime correction, before division by
$H_N\sim\log N$, is a sum of
$$
 2\sum_{d\le N}\frac{\Lambda_*(d)-\Lambda(d)}d
       \sum_{n\le N/d}\frac{\theta(n)}n .
 \tag{9}
$$
For each fixed mixed character $\theta$,
$\sum_{n\le y}\theta(n)/n=\kappa_\theta\log y+O_\theta(1)$
uniformly for $y\ge1$.
The exact harmonic band moment
$\sum_d(\Lambda_*(d)-\Lambda(d))/d=0$ cancels the
$\log N$ coefficient in each completed block.
Its remaining logarithmic moment is $O(\varepsilon_i)$:
subtract $\log X_i$ using that zero moment, use
$|\log(p/X_i)|\le\log8$ on first powers, and sum the
proper-power tail, which is
$O(\varepsilon_i\log X_i/X_i)$.
The omitted proper-power harmonic tail at cutoff $N$ is
$O(\varepsilon_iX_i/N)$, and its contribution after multiplication
by $\log N$ remains $o(1)$ for $i<j$, since
$X_i\le\sqrt N$ and $\log N\ge j^4$. The current block has
$N/d\le8$ and contributes $O(\varepsilon_j)$.
Since $\sum_i\varepsilon_i<\infty$, (9) is $O_\theta(1)$
after summing all blocks. The mixed normalized correction is
therefore $O_\theta(1/\log N)=o(1)$.
Gamma and poles are unchanged, so every fixed finite mixed-character
limit remains the positive one in that theorem.

The broad $\phi_j$ test sees an order-$\varepsilon_jX_j$
strength error that fixed finite history modes miss. The
prime locations and factorization paths are identical in the model.
Even unimodular local multipliers with the same prime periods do not
determine the strengths: with $\rho=p^{-1/2}$, $L=\log p$, and
continuous logs on $|\rho|<1$, the multiplier
$$
 v_{p,*}(t)=\exp\!\left(\lambda_p[
   \log(1-\rho e^{itL})-\log(1-\rho e^{-itL})]\right)
$$
is unimodular and has period $2\pi/L$, while its logarithmic
derivative is $\lambda_p$ times that of $u_p$.
The *exact* local scattering factor is a stricter datum:
its [signed trace identity](exact-prime-scattering-fibers.md)
produces $(\log p)/p^{r/2}$ at every depth and does not produce the
perturbed coefficients $(1+\varepsilon_jw_{jk})\log p$.
Thus this is a counterexample to a birth/history-only inequality,
not to an inequality that uses the trace normalization of the actual
local factor. Even with that normalization, the actual
[two-prime mixed second moment](two-prime-mixed-scattering.md)
has both signs. Its positive-square bound cannot replace the signed
gamma, pole, and all-prime comparison. This countermodel supplies no
such comparison and proves nothing about RH.
