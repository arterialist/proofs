# A sharp harmonic Mangoldt gap and a quantitative Weil residual sign

**Status:** independently audited written proof (18 September 2026). The
arithmetic and analytic statements here are not Lean formalized. They
strengthen the signed residual in the [causal cone theorem](complete-weil-causal-exponential-signed-cone.md),
not the complete Weil form, and do not prove RH. No literature-priority
claim is made for the sharp constant.

Put
\[
 A(x)=\sum_{n\le x}\frac{\Lambda(n)}n,\qquad
 H(x)=\log x-A(x)\quad(x\ge1),\qquad
 \kappa=\frac{\log2}{2}.
\]
Every proper prime power has its usual weight
\(\Lambda(p^j)=\log p\); the sum includes \(n=x\) when \(x\) is an
integer.

**Sharp all-\(x\) gap.** For every real \(x\ge2\),
\[
 \boxed{\qquad A(x)\le\log x-\kappa.\qquad}             \tag{1}
\]
Equality occurs only at \(x=2\). In particular, (1) strengthens the
all-\(x\) bound \(A(x)\le\log x\) of
[Ramaré--Zuniga-Alterman, Theorem 1.3 and Balazard's appendix](https://arxiv.org/html/2312.05138)
on this range. It uses the actual \(\Lambda\) sequence, not an abstract
prime-counting surrogate.

The main input is [Johnston--Ramaré--Trudgian, Lemma 10](https://arxiv.org/html/2303.13785):
\[
 |A(x)-\log x+\gamma|\le x^{-1/2}
       \quad(1\le x\le10^{19}),\qquad
 |A(x)-\log x+\gamma|\le\frac{1.3}{(\log x)^2}
       \quad(x>1).                                      \tag{2}
\]
These unconditional estimates are weaker than RH. The first gives
\(H(x)\ge\gamma-19^{-1/2}>\kappa\) for
\(19\le x\le10^{19}\); the gap at 19 is
\(0.00122634075\ldots\). The second gives
\(H(x)\ge\gamma-1.3/(\log10^{19})^2>\kappa\) for
\(x>10^{19}\). The numerical comparisons can be certified, for
example, using \(\gamma>0.577\), \(\log2<0.6932\), and
\(19^{-1/2}<0.2295\); the large-\(x\) comparison has a much wider
margin.

For \(2\le x<19\), \(H(x)\) strictly increases as \(\log x\) between
prime-power jumps. Its only possible minima are at the following
right-closed jump points. The displayed numbers are lower bounds
rounded down to six decimal places for \(H(n)-\kappa\):

| \(n\) | 2 | 3 | 4 | 5 | 7 | 8 | 9 | 11 | 13 | 16 | 17 |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Lower bound | 0 | .039261 | .153656 | .054912 | .113397 | .160285 | .156000 | .138680 | .108430 | .272748 | .166713 |

At \(n=2\), the equality is exact:
\(H(2)=\log2-\Lambda(2)/2=\kappa\). The other finite
comparisons can be checked without floating-point assumptions:
for \(z\in\{2,3,4,5,7,8,9,11,13,16,17\}\), put
\(t=(z-1)/(z+1)\), use the rational partial sum
\[
 S_{100}(z)=2\sum_{j=0}^{99}\frac{t^{2j+1}}{2j+1},
 \qquad
 0<\log z-S_{100}(z)
 \le\frac{2t^{201}}{201(1-t^2)}<2.5\cdot10^{-12},       \tag{3}
\]
and combine the resulting rational intervals with the exact
prime-power weights. The executable
[exact-rational certificate](../../certificates/sharp_mangoldt_harmonic_gap.py)
checks every lower entry in the table and the constant comparisons
used above; it uses no floating-point arithmetic.
The 2013 Ramaré display \(0.0067/\log x\) from \(x\ge23\) is
false at \(x=23\); (2) comes from the corrected later source.

**Consequence for the complete actual-prime residual.** Let
\(h:[0,\infty)\to[0,\infty)\) be bounded, nonincreasing, of bounded
variation, and compactly supported, and set
\(f(x)=e^{-x/2}h(x)\mathbf1_{x\ge0}\). With
\[
 w_h(y)=\int_0^\infty e^{-t}h(t+\log y)h(t)\,dt
 \quad(y\ge1),
\]
the exact [Stieltjes identity](complete-weil-causal-exponential-signed-cone.md)
is
\[
 \langle f,(P-K)f\rangle
   =2\int_{[1,\infty)}H(y)\,(-dw_h(y)).                 \tag{4}
\]
Here \(K\) contains all \(\Lambda(p^j)/\sqrt{p^j}\) shifts, and
\(P\) has kernel \(e^{|x-y|/2}\). The exact \(H(y)=\log y\ge0\)
on \([1,2)\), (1) on \([2,\infty)\), and the continuity and monotonicity
of \(w_h\) give the quantitative sign
\[
 \boxed{\qquad
 \langle f,(P-K)f\rangle\ge(\log2)\,w_h(2)\ge0.
 \qquad}                                                \tag{5}
\]
Thus the prime-power-minus-continuum residual has a definite
negative margin whenever the profile overlaps its translate by
\(\log2\). Equation (5) does not include the gamma term; the latter
can be negative and remains the obstacle to full Weil positivity.

For the finite ramp \(f_L=e^{-x/2}\mathbf1_{[0,L]}\), a direct
specialization of (4) yields the exact identity
\[
 \langle f_L,(P-K)f_L\rangle
   =2\int_0^L e^{-(L-v)}H(e^v)\,dv.                    \tag{6}
\]
On \(0\le v<\log2\), \(H(e^v)=v\). Combining this exact initial
segment with (1), for \(L\ge\log2\) we obtain
\[
 \boxed{\qquad
 \langle f_L,(P-K)f_L\rangle
 \ge\log2-2(1-\log2)e^{-L}>0.
 \qquad}                                                \tag{7}
\]
At \(L=\log2\), (7) is an equality; the prime-power endpoint
\(n=e^L=2\) has zero correlation weight. The limit of the true
left-hand side is \(2\gamma\), so (7) is a uniform explicit
margin, not its asymptotically sharp value.

The source input (2) permits zeros away from the critical line and
does not give RH-scale control of \(\psi(x)-x\). The all-\(x\) gap
and residual margin are therefore unconditional but do not sign
arbitrary compact Weil tests.
