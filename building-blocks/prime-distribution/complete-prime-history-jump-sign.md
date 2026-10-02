# Sign of the complete prime-history derivative jumps

The complete critical numerator has a negative derivative jump at every
prime. Almost every composite has a positive jump: the exceptions are
twice an odd prime and nine small prime powers. This is an unconditional
classification for every positive integer, proved below. It describes the
jumps of the complete arithmetic source; it does not establish a sign for
the numerator or a stronger prime-error power bound.

Let \(\Lambda\) be the actual von Mangoldt function and
\(b=\Lambda*\Lambda\), with Dirichlet convolution. The coefficient
identified with \(F'(n+)-F'(n-)\) for the complete
\(F=N_{\rm full}\) in the
[Gaussian recovery note](gaussian-recovery-complete-critical-numerator.md)
is
\[
 J_n=\frac{1+\sum_{d\mid n}\sqrt d\,[b(d)-2\Lambda(d)]}{\sqrt n}.
 \tag{1}
\]
The unit-origin term, all divisors and all proper prime powers are retained.

**Theorem.** For every integer \(n\ge1\),
\[
 J_n<0
 \quad\Longleftrightarrow\quad
 \begin{cases}
 n\text{ is prime},\quad\text{or}\\
 n=2p\text{ for an odd prime }p,\quad\text{or}\\
 n\in\{4,8,9,16,25,27,32,49,121\}.
 \end{cases}
 \tag{2}
\]
In every other case \(J_n>0\), including \(J_1=1\); no coefficient is zero.

The classification is written mathematics. An exact rational
[certificate](../../certificates/complete_prime_history_jump_sign.py)
checks the small numerical inequalities used in its proof. The
[Lean module](../../formalization/BuildingBlocks/FullPrimeHistoryJumpBound.lean)
checks the unconditional all-integer coefficient bounds and the exact
prime coefficient. The all-integer sign classification and its connection
to the continuum derivative have not been formalized in Lean.

## Reduction to the actual prime factors

Write \(n=\prod_p p^{a_p}\). For each prime dividing \(n\), define
\[
 S_p=\log p\sum_{k=1}^{a_p}p^{k/2},\qquad
 V_p=(\log p)^2\sum_{k=2}^{a_p}(k-1)p^{k/2}.
\]
The sum defining \(V_p\) is zero when \(a_p=1\).
The literal prime-power coefficients are
\[
 b(p^k)=(k-1)(\log p)^2,\quad
 b(p^kq^j)=2\log p\log q\quad(p\ne q, k,j\ge1),
\]
and \(b(d)=0\) when \(d\) has at least three distinct prime factors.
Substituting these into (1) gives the exact formula
\[
 H_n:=\sqrt n\,J_n
 =1-2\sum_p S_p+2\sum_{p<q}S_pS_q+\sum_p V_p.
 \tag{3}
\]
In particular, every \(V_p\) is nonnegative.

The rational certificate gives the strict corner bounds
\[
 \frac{97}{100}<\sqrt2\log2<1,\qquad
 \sqrt3\log3>\frac95,\qquad
 \sqrt5\log5>\frac72,
 \tag{4}
\]
\[
 (\sqrt2+2)\log2>\frac{23}{10},\quad
 (\sqrt3+3)\log3>5,\quad
 \frac{\sqrt3\log3}{1+\sqrt3}>\frac35.
 \tag{5}
\]
All factors in these expressions increase with the underlying prime.

## Integers with at least two distinct prime factors

For two prime factors with contributions \(S,T\), the part of (3)
excluding \(V_p,V_q\) is
\[
 1-2S-2T+2ST=2(S-1)(T-1)-1.
 \tag{6}
\]
If both primes are odd, their distinctness puts the smaller one at least
at 3 and the larger at least at 5. Equations (4) and (6) make this
expression greater than \(2(4/5)(5/2)-1=3\), for every pair of exponents.

Any integer with at least three distinct prime factors contains such an
odd pair. Adding a further prime contribution \(S\) changes the expression
in (3) by \(2S(\sum_{\rm old}S_p-1)+V_p>0\).
Thus all those integers have positive jumps.

It remains to consider \(n=2^a q^j\) for an odd prime \(q\).
If \(a\ge2\), then \(S_2>23/10\) and \(S_q>9/5\), so (6) is
greater than \(2(13/10)(4/5)-1=27/25>0\).

Suppose \(a=1\), and put \(s=\sqrt2\log2\).
For \(j=1\), both \(V\) terms vanish and
\[
 H_{2q}=1-2s-2(1-s)\sqrt q\log q<0,
\]
because \(s>1/2\) and \(s<1\).
For \(j\ge2\), put \(r=\sqrt q\). The weighted mean of
\(k-1\), with weights \(r^k\) for \(1\le k\le j\), increases as
\(j\) increases. Its value for \(j=2\) is \(r/(1+r)\).
Consequently (5) gives
\[
 \frac{V_q}{S_q}\ge\frac{r\log q}{1+r}>\frac35,
 \qquad S_q>5.
\]
Using \(s>97/100\) and \(s<1\) in (3), we obtain
\[
 H_{2q^j}>-1-\frac{3}{50}S_q+\frac35S_q
          =-1+\frac{27}{50}S_q>0.
\]
This covers every mixed prime-power case.

## Pure prime powers

For \(n=p^a\), equation (3) becomes
\[
 H_{p^a}=1+\log p\sum_{k=1}^{a}p^{k/2}
                  [(k-1)\log p-2].
 \tag{7}
\]
When \(a=1\), this is \(1-2\sqrt p\log p<0\), by (4).

For \(a=2\), set \(\ell=\log p\). Division of (7) by \(p\) gives
\[
 J_{p^2}=g(\ell):=\ell^2-2\ell-2\ell e^{-\ell/2}+e^{-\ell}.
\]
For \(\ell\ge2\),
\[
 g'(\ell)=2\ell-2+(\ell-2)e^{-\ell/2}-e^{-\ell}>0.
\]
The certificate checks \(\log13>2\) and \(J_{13^2}>0\).
Thus every \(p\ge13\) has \(H_{p^2}>0\). All further terms added in
(7) are positive, so every exponent \(a\ge2\) is covered.

For the remaining primes, the certificate checks precisely the following
thresholds, as well as the negativity of every earlier exponent:

| Prime \(p\) | Negative exponents \(a\) | First positive exponent |
| --- | --- | --- |
| 2 | 1 through 5 | 6 |
| 3 | 1 through 3 | 4 |
| 5, 7, 11 | 1 and 2 | 3 |

At each first positive exponent, \((a-1)\log p>2\).
Every subsequent increment in (7) is therefore positive. This proves
(2) for every exponent, completing the classification.

The certificate bounds \(\log z\), for each needed integer \(z\ge2\),
by the first 200 terms of
\[
 \log z=2\sum_{k\ge0}\frac{t^{2k+1}}{2k+1},\qquad
 t=\frac{z-1}{z+1},
\]
with the explicit positive tail bound
\(2t^{401}/[401(1-t^2)]\). Integer square roots give rational
enclosures for \(\sqrt z\). All sign decisions use exact fractions.
The finite checks certify the corners; the monotonicity arguments above
are what cover unbounded primes and exponents.

## One-sided recovery and its limit

For every \(n\ge1\), nonnegativity of \(b\) and the actual identity
\(\sum_{d\mid n}\Lambda(d)=\log n\) also give
\[
 J_n\ge n^{-1/2}-2\log n.
 \tag{8}
\]
This is a smaller bound on the negative part than the two-sided
\(O(\log^2(2n))\) estimate. The nonnegative Gaussian Green kernel in the
[recovery proof](gaussian-recovery-complete-critical-numerator.md) turns
it into
\[
 F(x)\le T_\tau F(x)+
 C(\tau x^2+\sqrt\tau\,x)\log(2x),
 \quad x\ge2,\quad 0<\tau\le1,
 \tag{9}
\]
with an absolute constant. This improvement needs (8), rather than the
full sign classification. The analytic Gaussian deduction remains
written mathematics.

At a prime, \(J_p=p^{-1/2}-2\log p\), so the negative seam has
logarithmic size. At balanced distinct semiprimes the positive seam has
order \(\log^2 n\). These signs explain the asymmetry in (9).
They do not bound the signed smoothed numerator or its global
prime-error fluctuations. That missing input, and the RH proof chain,
remain open. No originality claim is made for the elementary convolution
or Gaussian methods.
