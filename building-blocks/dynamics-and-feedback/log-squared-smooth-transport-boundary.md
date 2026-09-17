# The log-squared smooth cutoff and its transport boundary

Let $M(x)=\sum_{n\le x}\mu(n)$ and
$F_y(x)=\sum_{n\le x,\,P^+(n)\le y}\mu(n)$. For each integer $N\ge2$,
hold $y=y_N$ fixed as $m$ runs from $1$ to $N$, and set

$$
Z_N(f)=(1-e^{-2/N})\sum_{m\le N}e^{-2m/N}f(m)^2,
\qquad T_N(y)=Z_N(M)-Z_N(F_y).
$$

The exact largest-prime admission identity makes $T_N(y)$ the complete signed
transport from the $y$-smooth Möbius source to the actual source. It retains
every composite cofactor. Its sign is unknown at the critical cutoff below.

## Squarefree support at the boundary

Write $L=\log N$, $\ell=\log L$, and

$$
Q(N,y)=\#\{n\le N:\mu(n)^2=1,\ P^+(n)\le y\}.
$$

For fixed $c>0$ and $B\ge0$, take $y=\lfloor cL^2/\ell^B\rfloor$. The
squarefree smooth count obeys

$$
\log Q(N,y)=\frac L2-\frac B4\frac{L\log\ell}{\ell}
 +\left(\frac{1+\log2}{2}+\frac{\log c}{4}+o(1)\right)\frac L\ell.
\tag{1}
$$

For $B=0$ define $c_*=e^{-2}/4$. Equation (1) gives $Q=o(\sqrt N)$
when $c<c_*$ and $Q/\sqrt N\to\infty$ when $c>c_*$. At equality, a further
saddle expansion gives

$$
\log Q(N,c_*L^2)=\frac L2+
 \left(\frac14+o(1)\right)\frac L{\ell^3};
\tag{2}
$$

the unsigned support is already larger than $\sqrt N$. This says nothing
by itself about the signed size of $F_y$.

To see the count, for $0<\sigma<1$ use Rankin's inequality

$$
Q(N,y)\le N^\sigma\prod_{p\le y}(1+p^{-\sigma}).
$$

The logarithm is strictly convex in $\sigma$. Its saddle satisfies
$\sum_{p\le y}\log p/(p^\sigma+1)=L$. The prime number theorem gives the
moving saddle

$$
\sigma=\frac12-\frac B4\frac{\log\ell}{\ell}
 +\frac{\log(2\sqrt c)}{2\ell}+o(1/\ell),
$$

which yields the upper bound in (1). For the matching lower bound, choose
each prime independently with probability $p^{-\sigma}/(1+p^{-\sigma})$.
The logarithm of the chosen squarefree product has mean $L$ at the saddle,
variance $\asymp L\ell$, and maximal summand $O(\ell)$. The triangular-array
central limit theorem gives a fixed positive probability that this logarithm
lies in $[L-\sqrt{L\ell},L]$. Changing measure loses only
$O(\sqrt{L\ell})=o(L/\ell^K)$ for every fixed $K$, enough even for (2).
The first two terms at $c=c_*$ cancel; expanding the saddle and logarithmic
integral one order further gives the coefficient $1/4$ in (2).

## What the critical-line zeros rule out

Every prefix satisfies $|F_y(m)|\le Q(N,y)$, so $Z_N(F_y)\le Q(N,y)^2$.
A critical-line zero of $\zeta$ forces

$$
\limsup_{N\to\infty}\frac{Z_N(M)}N>0.\tag{3}
$$

For a short proof of (3), suppose $Z_N(M)=o(N)$. The Abel weights give
$\sum_{m\le X}M(m)^2=o(X^2)$. On each dyadic interval the Cauchy–Schwarz
bound for the summation-by-parts series

$$
\frac1{\zeta(s)}=
\sum_{m\ge1}M(m)\bigl(m^{-s}-(m+1)^{-s}\bigr)
$$

has the form $e_k2^{-k(\Re s-1/2)}$ with $e_k\to0$. At a zero
$\rho=1/2+i\gamma$, an Abel limit would then give
$a/\zeta(\rho+a)\to0$ as $a\downarrow0$, contrary to the pole of
$1/\zeta$ at $\rho$, whatever its multiplicity. Hardy proved that such
zeros exist.

Combining (1), (3), and the support bound gives

$$
\limsup_{N\to\infty}\frac{T_N(y_N)}N>0
\quad\text{if }B>0,
\quad\text{or if }B=0\text{ and }0<c<c_*.
\tag{4}
$$

Thus complete transport cannot be eventually nonpositive at those cutoffs.
For $y=(\log N)^A$ with fixed $A<2$, the simpler support bound
$Q=N^{\max(0,1-1/A)+o(1)}$ yields the same obstruction. At $A=2$,
$Z_N(F_y)\le N^{1+o(1)}$, so eventual $T_N(y)\le0$ would imply RH. More
generally, the family $T_N(y)\ll_\varepsilon N^{1+\varepsilon}$ for every
$\varepsilon>0$ is equivalent to RH. The reverse direction uses the standard
RH estimate $M(x)\ll_\varepsilon x^{1/2+\varepsilon}$.

The count does **not** establish a transport sign for $c\ge c_*$. Even at
$c=c_*$, (2) concerns unsigned labels. A proof at $c=1$ would need a bound
on the actual signed smooth energy and the complete rough–smooth
correlation; support estimates alone cannot supply either.

The [signed smooth-energy theorem](../prime-distribution/signed-smooth-exact-horizon-energy.md) now supplies the first of those two ingredients at $c=1$ and, more generally, for every fixed $c>c_*$. The complete rough–smooth transport sign remains unproved.

The squarefree saddle calculation is an application of standard friable
counting methods, not a claim of a new general smooth-number theorem.
The exponent $2$ itself was already central in
[Hildebrand's 1984 RH criterion for smooth-number asymptotics](https://doi.org/10.1112/S0025579300012481):
his criterion uses the range $y\ge(\log x)^{2+\varepsilon}$.
[Gorodetsky's later analysis](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/68FF9370894E1142B975BAC783DFF162/S0308210523001154a.pdf/smooth-integers-and-de-bruijns-approximation.pdf)
describes a different asymptotic regime below
$(\log x)^{2-\varepsilon}$. Those results concern the unsigned smooth
count and its Dickman approximation. The transport statement here
concerns the signed Möbius prefix and does not follow from an unsigned
asymptotic alone. The constant $c_*$ is a threshold for this note's
*support-only* energy ceiling, not a claimed universal transition.
Closest sources are [Hildebrand and Tenenbaum's saddle method](https://tenenb.perso.math.cnrs.fr/PPP/Psi%2B.pdf)
and [de la Bretèche and Tenenbaum's signed friable averages](https://arxiv.org/abs/2207.04777).
The latter's published saving does not by itself settle $Z_N(F_y)$ for
$y\asymp(\log N)^2$ when $c\ge c_*$. The finite Rankin and powerset
ingredients were checked in Lean in the working module
`LogPowerSmoothFinite.lean`; the PNT, CLT, Hardy-zero argument, and RH
implication in this note remain written proofs.
