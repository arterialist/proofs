# Exact-horizon energy of the signed smooth Möbius sum

**Status:** written analytic proof, independently reviewed, not yet formalized in Lean. Publication priority remains provisional: a bounded search of primary signed-friable and RH-criterion literature found no same-horizon lower-energy theorem or this sign criterion. This is not a claim that an exhaustive literature search can prove nonexistence.

For fixed $c>0$, let $y=c(\log N)^2$ and

$$
F_y(x)=\sum_{\substack{n\le x\\P^+(n)\le y}}\mu(n),\qquad
Z_N(f)=(1-e^{-2/N})\sum_{m\le N}e^{-2m/N}f(m)^2.
$$

The [full proof](../building-blocks/signed-smooth-exact-horizon-energy.md) establishes

$$
\log\frac{Z_N(F_y)}N\ge
\left(1+\log2+\frac12\log c+o(1)\right)
\frac{\log N}{\log\log N}.
$$

It localizes a parity resonance of the finite squarefree Euler product *below the same observation horizon* by a complex stationary-phase and compact Fourier filter. For each fixed $c>e^{-2}/4$, the lower bound and the conditional Mertens estimate give the exact criterion

$$
\mathrm{RH}\quad\Longleftrightarrow\quad
Z_N(M)-Z_N(F_{c(\log N)^2})\le0
\quad\text{for all sufficiently large integers }N.
$$

The signed inequality on the right has **not** been proved unconditionally. Its proof would solve RH; the theorem above does not.

Closest antecedents found: [Hildebrand's smooth-number RH criterion](https://doi.org/10.1112/S0025579300012481) concerns unsigned smooth numbers and the exponent-two scale; [Alladi's smooth Möbius lower result](https://doi.org/10.1090/S0002-9947-1982-0656482-7) takes a supremum over substantially larger smoothness thresholds; [de la Bretèche--Tenenbaum](https://arxiv.org/pdf/2207.04777) gives signed-friable asymptotics and upper bounds, but its log-squared regime does not provide the displayed deterministic same-horizon energy lower bound. The conditional RH direction uses [Soundararajan's Mertens estimate](https://arxiv.org/pdf/0705.0723), which was independently reworked and sharpened by [Balazard--de Roton](https://arxiv.org/abs/0810.3587). These comparisons support a *provisional* original-contribution classification, not an absolute priority guarantee.
