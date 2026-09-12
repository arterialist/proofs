# A cutoff-centered signed Gram estimate with an absorbable prefix error

This written proof uses cutoff-relative moments and finite signed Abel reconstruction to improve the error bound in the actual source-square expansion enough to make its conditional absorption work at fixed logarithmic process time. It uses the exact frozen source and finite prefix suprema; no upper bound for those suprema is assumed.

Retain the definitions and complete prime-only law from [the long-time signed-source expansion](long-time-signed-source-rank-one.md):
$$
 a_n(v)=e^{-v/2}E_\psi(\min(e^v,n))\mathbf1_{v\ge0},\quad
 Q_n(t)=\|T_ta_n\|_2^2,\quad M_n=D_n(1/2),
$$
$$
 k_t=\|T_t(e^{-v/2}\mathbf1_{v\ge0})\|_2^2,
 \qquad k_t\sim\frac{2}{\pi^2t}.
$$
Here $E_\psi(x)=\psi(x)-x$, with every prime power and right endpoint included, and
$$
 Q_n(0)=\int_1^n\frac{E_\psi(x)^2}{x^2}\,dx+\frac{E_\psi(n)^2}{n}.
\tag{1}
$$

Fix $\eta>0$ and a finite integer $R\ge2$. Define the actual finite quantities
$$
 \mathcal A_\eta(R)=\max\left(1,\max_{2\le n\le R}\frac{Q_n(0)}{n^\eta}\right),
 \qquad
 \mathcal B_\eta(R)=\max_{2\le n\le R}\frac{M_n^2}{n^\eta}.
\tag{2}
$$
We prove the uniform prefix estimate
$$
 \boxed{|Q_n(t)-k_tM_n^2|
 \le C_\eta\frac{\mathcal A_\eta(R)n^\eta}{t^3},
 \qquad 2\le n\le R,\ t\ge1.}
\tag{3}
$$
The constant is independent of $R,n,t$. The finite quantity $\mathcal A_\eta(R)$ is part of the estimate, not an assumed bounded constant. At a cutoff attaining a weighted energy record $\mathcal A_\eta(n)=Q_n(0)/n^\eta$, (3) has error $C_\eta Q_n(0)/t^3$, with no powers of $\log n$.

## 1. The actual source is localized relative to its weighted prefix bound

Translate the complete source to its cutoff:
$$
 f_n(w)=a_n(w+\log n),\qquad w\in\mathbb R.
$$
This is only a translation of the same function on the full real age axis. No source age or tail is removed. For $-\log n\le w\le0$, put $x=ne^w$. Up to age $\log x$, the unfrozen source agrees with the source at integer cutoff $m=\lceil x\rceil\le n$. Therefore
$$
 \int_{-\infty}^w|f_n(u)|^2du
 \le Q_m(0)
 \le 2^\eta\mathcal A_\eta(R)n^\eta e^{\eta w}.
\tag{4}
$$
When $x=1$ the integral is zero; when $x<1$ it remains zero. Thus there is no undefined cutoff below one. For $1<x<2$, the ceiling is two and the displayed bound still holds because $m\le2x$. All equalities or inequalities concerning point values at arithmetic jumps are used only in integrals, while the norm (1) retains the right endpoint exactly.

For $w\ge0$, the literal frozen tail is
$$
 f_n(w)=\frac{E_\psi(n)}{\sqrt n}e^{-w/2},\qquad
 \frac{E_\psi(n)^2}{n}\le\mathcal A_\eta(R)n^\eta.
\tag{5}
$$
For each fixed integer $j\ge0$, apply Cauchy on the unit intervals $[-h-1,-h]$, $h\ge0$, and use (4). The negative-side absolute moment is bounded by
$$
 2^{\eta/2}\sqrt{\mathcal A_\eta(R)n^\eta}
 \sum_{h\ge0}(h+1)^j e^{-\eta h/2}.
$$
The positive side follows by integrating $w^je^{-w/2}$ in (5). Consequently
$$
 \boxed{\int_{\mathbb R}|w|^j|f_n(w)|dw
 \le C_{\eta,j}\sqrt{\mathcal A_\eta(R)n^\eta}.}
\tag{6}
$$
In particular $\int f_n=2M_n$, so $M_n^2\le C_\eta\mathcal A_\eta(R)n^\eta$. The estimate concerns the complete signed source function, not the total variation of its prime and density measures estimated separately.

## 2. The signed square and its curvature retain every cross term

Translation changes a Fourier transform by a unit phase. Hence
$|\widehat f_n(\xi)|^2=|\widehat a_n(\xi)|^2$. The real cosine identity and (6) give
$$
 \left||\widehat a_n(\xi)|^2-4M_n^2\right|
 \le C_\eta\mathcal A_\eta(R)n^\eta\xi^2.
$$
Subtracting the exact seed denominator on a fixed small-frequency band gives
$$
 \left||\widehat a_n(\xi)|^2-
 \frac{M_n^2}{1/4+\xi^2}\right|
 \le C_\eta\mathcal A_\eta(R)n^\eta\xi^2.
\tag{7}
$$
The mixed products have not been discarded: their linear frequency contribution cancels in the real modulus square.

Use the already proved actual process bounds
$\operatorname{Re}\Phi(i\xi)\ge c|\xi|$ on that small band and
$\operatorname{Re}\Phi(i\xi)\ge\gamma>0$ outside it. Integrating (7) only on the band costs $C_\eta\mathcal A_\eta(R)n^\eta/t^3$. On its complement, Plancherel and (2), (6) bound the complete contribution by
$$
 C_\eta\mathcal A_\eta(R)n^\eta e^{-2\gamma t}.
$$
Absorb this exponential bound into $Ct^{-3}$ for $t\ge1$. This proves (3). The no-jump part is retained in this high-frequency estimate; a polynomial Fourier bound is never integrated over the full finite-activity multiplier.

The refinement with the first signed correction also loses no logarithmic powers. Let
$$
 \mathcal C_n=D_n'(1/2)^2-M_nD_n''(1/2).
$$
Centering replaces $D_n(s)$ by $n^{s-1/2}D_n(s)$; a direct differentiation shows that $D_n'^2-D_nD_n''$ at $s=1/2$ is unchanged. Equivalently, the moment combination $(\int wf_n)^2-(\int f_n)(\int w^2f_n)$ is translation invariant. Using (6) through degree four in the previously proved signed expansion yields
$$
 |\mathcal C_n|\le C_\eta\mathcal A_\eta(R)n^\eta,
$$
$$
 Q_n(t)-k_tM_n^2=\frac{\mathcal C_n}{\pi^4t^3}
 +O_\eta\!\left(\mathcal A_\eta(R)n^\eta
 \left[\frac{\log(2+t)}{t^4}+\frac1{t^5}+e^{-2\gamma t}\right]\right).
\tag{8}
$$
The [certified opposite actual signs at cutoffs two and six](long-time-signed-source-rank-one.md#7-both-correction-signs-occur-for-actual-cutoffs) remain unchanged. Neither (3) nor (8) supplies a relative equivalent when the mass is small.

## 3. Finite signed Abel reconstruction and noncircular absorption

The exact finite-cutoff identity is
$$
 E_\psi(x)=\sqrt x\,M_x-\frac12\int_1^x y^{-1/2}M_y\,dy,
 \qquad M_x=D_x(1/2).
\tag{9}
$$
For $x\in[n,n+1)$,
$M_x-M_n=-\int_n^x y^{-1/2}dy$. Combining this real-cell extension, the bounded initial interval, and (2) gives
$$
 |E_\psi(x)|\le C_\eta(1+\sqrt{\mathcal B_\eta(R)})
 x^{(1+\eta)/2},\qquad 1\le x\le R.
$$
Insert this in (1), keeping its terminal contribution. Since $\eta>0$, the integral is $(n^\eta-1)/\eta$, and therefore
$$
 \boxed{\mathcal A_\eta(R)\le C_\eta[1+\mathcal B_\eta(R)].}
\tag{10}
$$

Suppose $t_n\to\infty$, and suppose for this fixed $\eta>0$ that
$$
 \sup_{n\ge2}\frac{t_nQ_n(t_n)}{n^\eta}<\infty.
\tag{11}
$$
Positivity and continuity of $k_t$, together with its asymptotic, give $k_t\ge c/t$ for all $t\ge1$. Dividing (3) by this lower bound gives, for all sufficiently large $n\le R$,
$$
 \frac{M_n^2}{n^\eta}
 \le C\frac{t_nQ_n(t_n)}{n^\eta}
 +\frac{C_\eta}{t_n^2}\mathcal A_\eta(R).
\tag{12}
$$
Choose an initial cutoff so that the second coefficient is at most a prescribed $\varepsilon>0$, uniformly thereafter. All earlier $M_n$ are fixed finite numbers and enter a separate constant. Taking the finite prefix maximum gives
$$
 \mathcal B_\eta(R)\le K_{\eta,\varepsilon}
 +\varepsilon\mathcal A_\eta(R).
\tag{13}
$$
Choose $\varepsilon<1/(2C_\eta)$, where $C_\eta$ is the constant in (10). Substituting (13) into (10) proves $\sup_R\mathcal A_\eta(R)<\infty$. This is an absorption of a finite unknown quantity with a strictly smaller coefficient, not an assumption of its boundedness.

In particular, if a diverging subpolynomial schedule obeys the actual subpower target
$Q_n(t_n)=O_\delta(n^\delta)$ for every $\delta>0$, then (11) holds for every $\eta>0$. Thus $Q_n(0)=O_\eta(n^\eta)$ for every $\eta>0$. Contraction proves the converse. This applies to $t_n=c\log n$ for any fixed $c>0$, with the seed, ramps, all prime powers, complete history, and frozen tail present throughout.

This improves the direct Gram consumer in Section 6 of [the long-time signed-source expansion](long-time-signed-source-rank-one.md): its uncentered pointwise moment bound required $t_n/(\log n)^{3/2}\to\infty$. The finite-prefix centered bound removes that restriction when $t_n\to\infty$. The [variable-Laplace theorem](variable-time-source-exponent.md) already proves exponent preservation for every subpolynomial schedule, including bounded ones; the present argument supplies a distinct signed source-square mechanism and the stronger estimate (3).

The missing arithmetic input is still (11) at every positive exponent, or the equivalent full source bound. No estimate in this note proves that input. The displayed source-square and reconstruction theorems are written proofs, not Lean theorems. They do not prove RH.
