# A coupled quadratic Bernoulli history energy in the original metric

This note gives a bounded quadratic attempt to control the actual
integer-edge pairing. The original max kernel couples the two histories,
so the construction is more than a separable square of one scalar
Bernoulli transform. Its prefix divisor reduction exposes partial divisor
overlaps. Coprimality removes shared divisors but does not remove their
distinct interacting channels or supply the required cross-term bound.

For integer $N\ge2$, retain
$$
\nu_N=-\delta_1+\sum_{2\le n\le N}\Lambda(n)\delta_n
-\mathbf1_{[1,N]}dx,
\qquad q_N(x)=\mathcal B_2(N/x),
$$
where $\mathcal B_2(t)=\{t\}^2-\{t\}+1/6$. Define the actual
weighted signed measure
$$
\omega_N(dx)=p_N(x)\nu_N(dx),\qquad
p_N(x)=\frac{x}{N}q_N(x),
$$
and its original-metric energy
$$
\boxed{
P_N=\iint\frac{p_N(x)p_N(y)}{\max(x,y)}\nu_N(dx)\nu_N(dy)\ge0.
}
\tag{1}
$$
This includes all prime-power pairs, both density cross terms, the density
pair, the origin, and same-prime terms. The endpoint prime-power atom is
present with $p_N(N)=1/6$; it is not removed.

## 1. Exact coupled prefix square

Put
$$
C_N(Z)=\omega_N([1,Z]),\qquad 1\le Z\le N.
$$
The original source is $C_N(\min(x,N))/x$, so
$$
\boxed{
P_N=\int_1^N\frac{C_N(Z)^2}{Z^2}\,dZ+\frac{C_N(N)^2}{N}.
}
\tag{2}
$$
The frozen tail is retained. The complete process gives a further
nonnegative form $P_{N,s}=\|T_sU g_{\omega_N}\|^2\le P_N$, retaining
its no-jump and all-history components; no observation commutation is
assumed.

Since $N$ is an integer, the exact cumulative function is
$$
C_N(Z)=-\frac1{6N}
+\frac1N\sum_{2\le n\le Z}n\Lambda(n)q_N(n)
-\frac1N\int_1^Zxq_N(x)\,dx.
\tag{3}
$$
The first term is the literal origin atom. Point values of the continuous
density have no effect, while every arithmetic right endpoint is included.

## 2. Partial divisor reduction preserves a genuine pair overlap

For $1\le Z\le N$, define
$$
L_Z(m)=\sum_{\substack{d\mid m\\d\le Z}}\Lambda(d),\qquad m\le N.
$$
These are partial complete-division channels. At $Z=N$, they become
$\log m$. For $Z<N$, the omitted divisor channels remain visible.

Expanding $q_N(n)$ with $M_n=\lfloor N/n\rfloor$, as in the
linear Bernoulli synthesis, gives
$$
\boxed{\begin{aligned}
\sum_{2\le n\le Z}n\Lambda(n)q_N(n)
={}&N^2\sum_{2\le n\le Z}\frac{\Lambda(n)}n
-N\psi(Z)+\frac16\sum_{2\le n\le Z}n\Lambda(n)\\
&+2\sum_{m\le N}(m-N)L_Z(m).
\end{aligned}}
\tag{4}
$$
Indeed,
$$
\sum_{n\le Z}\Lambda(n)M_n=\sum_{m\le N}L_Z(m),
\quad
\sum_{n\le Z}n\Lambda(n)(M_n^2+M_n)
=2\sum_{m\le N}mL_Z(m).
$$
Both identities retain every divisor and prime-power depth. Formula (4)
is exact for real $Z$; integer endpoints include the newly admitted
atom on both sides.

When (4) is substituted into the square in (2), one obtains coupled
products $L_Z(m)L_Z(k)$ at their shared admission scale. These do not
reduce to $\log m\log k$ before integrating over $Z$. The common
divisor $d$ can contribute to both only if $d\mid\gcd(m,k)$, but
the full product also includes $d\ne e$, with $d\mid m,e\mid k$.
For example,
$$
L_Z(2)L_Z(3)=\log2\log3>0\quad(Z\ge3),
$$
despite $\gcd(2,3)=1$. Coprimality is not an orthogonality law for
the complete paired histories. Deleting the distinct channels would
change the actual form.

## 3. Exact small actual scalars and the signed prime-pair term

For $N=2$, on $1<x<2$,
$$
C_2(x)=-2\log x+3x-13x^2/24-61/24,
\qquad C_2(2)=31/24-(11/6)\log2.
$$
Integration in (2) gives the exact scalar
$$
\boxed{
P_2=\frac{8011}{432}-\frac{3221}{144}\log2
-\frac{455}{72}(\log2)^2.
}
\tag{5}
$$
For $N=3$, the cumulative pieces are
$$
C_3(x)=\begin{cases}
-3\log x+5x-37x^2/36-145/36,&1<x<3/2,\\
-3\log x+3x-13x^2/36-91/36,&3/2<x<2,\\
-3\log x+3x-13x^2/36-91/36-\log2/18,&2<x<3,
\end{cases}
$$
and $C_3(3)=29/9-(17/6)\log3-\log2/18$. Thus
$$
\boxed{\begin{aligned}
P_3={}&\frac{98719}{1944}-\frac{8249}{162}\log3
-\frac{1655}{108}(\log3)^2-\frac{3563}{648}(\log2)^2\\
&+\frac{1889}{162}\log2\log3+\frac{5429}{216}\log2.
\end{aligned}}
\tag{6}
$$
The rational interval certificate proves
$$
0.003430<P_2<0.003431,\qquad
0.004393<P_3<0.004394.
\tag{7}
$$
It uses the same 64-term rational logarithm bounds as the heat birth sign
certificate. These scalars include the full density integrals and frozen
tail, not only the prime atoms.

In the $N=3$ prime-pair part of (1),
$p_3(2)=-1/18$ and $p_3(3)=1/6$, so the two cross orders give
$$
-\frac{\log2\log3}{162}.
\tag{8}
$$
The coprime histories therefore have a nonzero signed interaction.
Same-prime diagonals, density and origin complete the nonnegative total.
This is an exact weighted scalar, not a claim about negative prime
covariance or independent channels.

Actual same-prime cross terms can also be negative. At $N=6$,
$p_6(2)=1/18$, $p_6(4)=-1/18$, and both births have
$\Lambda=\log2$. Their two max-kernel cross orders contribute exactly
$$
-\frac{(\log2)^2}{648}.
\tag{8a}
$$
Consecutive-index coprimality does not remove these nonadjacent retained
depths of the same prime.

## 4. What survives all scales, and what does not

The simple Chebyshev bound and $|q_N|\le1/6$ give
$|C_N(Z)|\le C(Z^2+1)/N$, hence $P_N\le CN$.
One can retain actual cancellation through Stieltjes integration by parts:
$$
C_N(Z)=p_N(Z)E(Z)-\int_1^ZE(x)p_N'(x)\,dx,
\quad
p_N'(x)=q_N(x)/N+2(1/2-\{N/x\})/x
\tag{9}
$$
almost everywhere. The continuous Bernoulli cells contribute no missing
atomic derivative. The origin is already included in this cumulative
formula.

Using only the ordinary PNT, (9) gives, after reducing $\nu>0$,
$$
|C_N(Z)|\le CZ e^{-\nu\sqrt{\log Z}},\qquad 2\le Z\le N,
$$
and consequently
$$
\boxed{P_{N,s}\le P_N\le CN e^{-2\nu\sqrt{\log N}}.}
\tag{10}
$$
The initial interval is absorbed into the constants. This actual
quadratic constraint still has nonnegative power scale one, so it does
not give the required subpower estimate.

The leading Euler chirp $J_N$ is linked to this cumulative observable
by the exact origin-inclusive identity
$$
J_N=\frac{E(N)}{12}-\frac{C_N(N)}2
-\frac1{2N}\int_1^NE(x)q_N(x)\,dx.
\tag{11}
$$
It follows from the Stieltjes identity in the linear synthesis; the
explicit origin terms cancel only after (3) is retained. Equation (11)
does not identify $P_N$ with the low-band cross term
$\Re\langle G_U,R_U\rangle_U$. Paying that cross term with the
nonnegative square (1) would require a new inequality controlling all
the linked terms in (11), not an isolated endpoint bound.

There is a further exact obstruction to recovering the low-band
functional directly from this weighted measure. The target is
$A_U(\xi)=\int K_s(x)\nu_N(dx)$, while the new measure is
$p_N\nu_N$. Its formal test would be $K_s/p_N$. The Bernoulli
weight vanishes at
$$
\{N/x\}=\frac{1\pm1/\sqrt3}{2},
$$
with interior zeros on the density support. At $\xi=0$, $K_{1/2}$
is strictly positive for $x<N$, so these are genuine poles of the
quotient. It is not a bounded test in the max-energy dual. Thus the
nonnegative norm alone supplies no pullback inequality for the actual
joint low-band datum. An actual-source inequality could still use
additional arithmetic information, but it is not proved by this weight
or by coprimality.

This construction exposes a genuine partial-divisor pair overlap, but
neither coprimality nor complete-history positivity signs the centered
overlap or bounds it at the RH scale. The bounded attempt therefore
preserves (1)--(11) as a quadratic constraint and an exact obstruction
to the proposed coprime-channel inference. It does not prove RH, and no
Lean formalization is claimed.

## Dependencies, certificate and attribution

The [linear Bernoulli synthesis](integer-history-low-band-pairing.md#5-the-linked-successor-jumps-turn-the-leading-chirp-into-exact-synthesis) supplies the exact successor and division formulas. The [max-kernel norm](max-sum-process-transfer.md) fixes the original metric, and the [complete process](positive-successor-seed-jump-process.md) supplies its contraction. The [rational certificate](heat-birth-sign-certificate.py) evaluates (5)–(7) with proved logarithm remainders and all density pieces. Bernoulli expansion and divisor regrouping are classical; the actual weighted arithmetic form and its limits are stated here without a priority claim. The certificate is not a Lean proof.
