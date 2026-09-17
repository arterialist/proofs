# A selected old root recovers while its full derivative remains below one

Throughout, $\Phi_n$ denotes the $n$th cyclotomic polynomial, including $\Phi_1(z)=z-1$, and $F_N=\prod_{n=1}^N\Phi_n$. Its roots are simple. The weight $w_N(a/n)$ is half the sum of the two neighboring gaps of $a/n$ in the circular Farey set of order $N$; thus the weights sum to one. The clipped deficit is $[-\log|F_N'(e^{2\pi ia/n})|]_+$. These are the same actual histories used in the [weighted-orbit obstructions](cyclotomic-weighted-orbit-obstructions.md).


The single fixed phase $7/145$ at cutoff $N=1533$ gives a certified actual recovery. Its cyclotomic factor has modulus greater than one, and both the previous and updated full derivatives have modulus less than one. Thus positive selected factor increments do not occur only above the clipping threshold.

Take

$$
n=145=5\cdot29,\qquad a=7,\qquad N=1533=3\cdot7\cdot73.
$$

These satisfy $(n,N)=1$ and

$$
aN=10731=1+74n.
$$

The phase is exactly the modular-inverse selected phase. Its previous left Farey neighbor has order $N-n=1388$, since

$$
7\cdot1388-67\cdot145=1,
\qquad
\frac7{145}-\frac{67}{1388}=\frac1{145\cdot1388}.
$$

This is the actual selected root, with its actual history; no embedding is substituted.

## Rational full-history certificate

For $\alpha=e^{2\pi i7/145}$, let

$$
L_K=\log|F_K'(\alpha)|,
\qquad F_K=\prod_{j=1}^K\Phi_j.
$$

The standalone checker proves the rational interval enclosures

$$
\boxed{-6.760829797<L_{1532}<-6.760829796,}
\tag{1}
$$

$$
\boxed{-6.350406430<L_{1533}<-6.350406429.}
\tag{2}
$$

Both are strictly negative. These are full derivative logs. In particular,

$$
\lfloor1532/145\rfloor=\lfloor1533/145\rfloor=10,
\qquad145\operatorname{lcm}(1,\ldots,10)=365400.
$$

The exact scalar 365400 is included at both cutoffs.

The certificate evaluates

$$
L_K=\log365400+
\sum_{\substack{1\le d\le K\\145\nmid d}}
M(\lfloor K/d\rfloor)
\log\left(2\left|\sin\frac{7\pi d}{145}\right|\right),
\tag{3}
$$

with exact integer Möbius values, exact Mertens coefficients, and the actual cutoff $K$. Formula (3) follows from the radial simple-zero limit of the complete Möbius product. The omitted multiples of 145 are not discarded: their regularized leading coefficients give $\log365400$. Thus the certificate does not rely on a scalar-free unit log.

## Independent positive factor certificate

At the old root,

$$
v=\log|\Phi_{1533}(\alpha)|=L_{1533}-L_{1532}.
$$

Using the eight divisors of the squarefree index 1533 gives the exact sine ratio

$$
\boxed{
|\Phi_{1533}(\alpha)|
=\frac{
\sin(\pi/145)\sin(21\pi/145)
\sin(49\pi/145)\sin(69\pi/145)}{
\sin(2\pi/145)\sin(7\pi/145)
\sin(48\pi/145)\sin(62\pi/145)}.
}\tag{4}
$$

All eight sines are positive. This follows directly from $\prod_{d\mid1533}(1-\alpha^d)^{\mu(1533/d)}$, folding residue angles above $\pi/2$. Four numerator and four denominator chord factors make the powers of two cancel.

A separate rational evaluation of the eight terms in (4), without subtracting the full-log enclosures, proves

$$
\boxed{0.410423366<v<0.410423367.}
\tag{5}
$$

The checker also verifies the exact coefficient identity

$$
M(\lfloor1533/d\rfloor)-M(\lfloor1532/d\rfloor)
=\mathbf1_{d\mid1533}\mu(1533/d)
$$

for every $d\le1533$, taking the old coefficient to be zero at $d=1533$. Thus the independent factor enclosure and the full-history difference agree with the actual same-cutoff update.

## Actual clipping and weights

Since both logs in (1)–(2) are negative, the deficits satisfy

$$
b_{145,1533}(7)-b_{145,1532}(7)
=-v<0.
\tag{6}
$$

The inverse of seven modulo 145 is 83. Consequently the actual neighboring denominator pairs are

$$
(1388,1512)\quad\text{at }1532,
\qquad(1533,1512)\quad\text{at }1533.
$$

Their exact half-gap weights are

$$
w_{1532}(7/145)=\frac5{1049328},\qquad
w_{1533}(7/145)=\frac1{220752}.
$$

The loss is $1/[2\cdot1533\cdot1388]$, as required for the selected modular-inverse event. The actual weighted signed old response is therefore

$$
\boxed{
-\frac{0.410423367}{220752}
< w_{1533}(7/145)\,\Delta b
< -\frac{0.410423366}{220752}<0.
}\tag{7}
$$

No birth or weight-transport term is included in (7). It is precisely the old-root increment with its new-cutoff weight.

At horizon 1533, the reduced conductor and age are 145 and 1388, both greater than $\lfloor\sqrt{1533}\rfloor=39$. The index has three distinct prime factors. The example refutes the proposed threshold-based rescue for selected higher-order updates. It does not by itself determine a cumulative signed sum or exclude a different history-dependent control.

## Reproducibility

Run the [standalone rational checker](../../certificates/cyclotomic_selected_recovery.py) with Python 3. It examines only this fixed phase and these two full cutoffs. There is no nearby-parameter search and no large full-prefix polynomial quotient.

Every enclosure uses rational arithmetic. Machin's identity and alternating arctangent sums enclose $\pi$; alternating sine sums enclose the folded positive chords; a positive atanh series with an explicit geometric tail encloses logarithms after rational rescaling into $[1,2]$. Intermediate endpoints are rounded outward on rational decimal grids, and the displayed endpoints are rational multiples of $10^{-9}$. The checker verifies both negative full histories, the independent positive factor increment, the exact scalar and coefficient difference, and the rational Farey weights. All assertions pass.
