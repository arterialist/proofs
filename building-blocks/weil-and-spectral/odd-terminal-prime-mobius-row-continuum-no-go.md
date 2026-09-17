# What averaging the prime–Möbius Type II row can and cannot remove

The [exact Vaughan reduction](odd-terminal-vaughan-zero-frequency-type-ii-barrier.md)
leaves a signed Type II term. This note isolates its
\(\ell=1\), \(p\asymp X^{1/4}\) row and tests the natural attempt to
average the primes by their continuous density. The average has an
exact Mellin transform whose prime-band factor does not vanish at any
zeta zero in \(1/2<\Re s<1\). Therefore this replacement alone
cannot remove a hypothetical off-line zero's power. The available
PNT control of the replacement error is also too large to transfer a
fixed-power saving. This is a limit of that particular averaging
argument, not a bound on the full Type II remainder.

Keep the real smooth profile \(g=v*v\) and
\(w_X(x)=x^{-1/2}g(\log(X/x))\) from the [terminal filter](odd-terminal-stretched-exponential-signed-cancellation.md).
For \(U\ge1\), let \(X=U^4\) and define
\[
 A_U(t)=\sum_{r\ge1}\mu(r)w_X(tr),\qquad
 R(U)=\sum_{2U<p\le4U}(\log p)A_U(p),\qquad
 C(U)=\int_{2U}^{4U}A_U(t)\,dt.
 \tag{1}
\]
All sums are finite. For sufficiently large \(U\), every contributing
\(r\) exceeds \(U\), so the actual \(R(U)\) is precisely the
\(\ell=1\), ordinary-prime slice selected in the Vaughan note;
\(C(U)\) replaces \(d\vartheta(t)\) by \(dt\), where
\(\vartheta(t)=\sum_{p\le t}\log p\).

**Theorem.** Define
\[
 h(y)=\int_2^4 t^{-1/2}g(y-\log t)\,dt.
 \tag{2}
\]
Then \(h\) is real, smooth, and compactly supported, and
\[
 C(U)=U^{1/2}\sum_{r\ge1}\frac{\mu(r)}{\sqrt r}
       h\!\left(\log\frac{U^3}{r}\right).
 \tag{3}
\]
For \(\Re z>2\), its ordinary Laplace transform in \(b=\log U\)
is exactly
\[
 \boxed{\quad
 \int_0^\infty e^{-zb}C(e^b)\,db
 =\frac1{3\zeta((z+1)/3)}
 F_v\!\left(\frac{2z-1}{3}\right)^2
 \int_2^4 t^{-(z+1)/3}\,dt.
 \quad}
 \tag{4}
\]
For any hypothetical nontrivial zero of the actual zeta function
\(\rho=\beta+i\gamma\) with \(1/2<\beta<1\), the right side
has a nonremovable pole at \(z=3\rho-1\). In particular,
\[
 C(U)=O(U^{2-\eta})\quad(0<\eta<3/2)
 \quad\Longrightarrow\quad
 \zeta(\rho)\ne0\ \text{for every }\Re\rho>1-\eta/3
 \text{ in the critical strip}.
 \tag{5}
\]
This is an obstruction to obtaining a fixed-power saving by
continuous prime averaging alone. It makes no assertion that the
actual prime row \(R(U)\) has the same lower growth.
The spectral power associated with \(\rho\) is
\(U^{3\beta-1}=X^{(3\beta-1)/4}\), approaching the natural
\(U^2=\sqrt X\) scale as \(\beta\uparrow1\).

The elementary prime-number-theorem replacement satisfies, for every
fixed \(A>0\),
\[
 R(U)-C(U)=O_{v,A}\!\left(\frac{U^2}{(\log U)^A}\right).
 \tag{6}
\]
Thus this replacement estimate by itself cannot transfer a bound
\(C(U)=O(U^{2-\eta})\) to the actual row at that power scale.

## The nonvanishing prime-band factor

Changing variables \(t=Uq\) in (1) gives (3). Let
\(H(s)=\int h(y)e^{-sy}dy\). Translation inside (2) yields
\[
 H(s)=F_v(2s)^2\int_2^4 q^{-s-1/2}\,dq.
 \tag{7}
\]
Since \(h\) is supported in a positive interval, direct Laplace
integration of (3) and \(\sum_r\mu(r)r^{-w}=1/\zeta(w)\) for
\(\Re w>1\) give (4). The interchange is absolute when
\(\Re z>2\).

At \(z=3\rho-1\), the filter factor in (4) is
\(F_v(2\rho-1)^2\ne0\), because \(\Re(2\rho-1)>0\) and the only
zero of \(F_v\) in that half-plane is at \(1\). The remaining factor
is
\[
 \int_2^4 q^{-\rho}\,dq
 =2^{1-\rho}\frac{2^{1-\rho}-1}{1-\rho}\ne0
 \qquad(\Re\rho<1).
 \tag{8}
\]
Indeed, \(|2^{1-\rho}|=2^{1-\beta}>1\). A zero of \(\zeta\)
therefore produces a pole of \(1/\zeta\) that neither multiplier
cancels. If (5)'s power bound held, the integral on the left of
(4) would be holomorphic on \(\Re z>2-\eta\); the pole at
\(z=3\rho-1\) would contradict that holomorphy whenever
\(3\beta-1>2-\eta\). This proves (5).

## Why the PNT replacement does not transfer a power saving

On \(2U\le t\le4U\), the support of \(w_X(tr)\) has
\(r\asymp U^3\). Its size is \(O_v(U^{-2})\), while
\(|r w_X'(tr)|=O_v(U^{-3})\). Summing absolutely over the
\(O(U^3)\) possible integers gives
\[
 \sup_{2U\le t\le4U}|A_U(t)|=O_v(U),\qquad
 \int_{2U}^{4U}|A_U'(t)|dt=O_v(U).
 \tag{9}
\]
Set \(E(t)=\vartheta(t)-t\). Stieltjes integration by parts gives
\[
 R(U)-C(U)
 =[A_U(t)E(t)]_{2U}^{4U}
  -\int_{2U}^{4U}E(t)A_U'(t)dt.
 \tag{10}
\]
The classical PNT error (for instance, the stronger
[Bellotti bound](https://arxiv.org/abs/2508.02041)) gives
\(\sup_{2U\le t\le4U}|E(t)|
 =O_A(U/(\log U)^A)\) for every fixed \(A\). Together with
(9), this proves (6). This estimate controls the difference between
the actual prime row and its continuous average only at
\(U^{2-o(1)}\) scale. Any stronger comparison would need signed
correlation between the prime-discrepancy measure and the actual
Möbius row \(A_U\).

## Reindexing by the product isolates squarefree parity

There is a separate exact arithmetic reorganization of the actual
row. Put
\(L_U(n)=\sum_{2U<p\le4U,\ p\mid n}\log p\). Reindexing
\(n=pr\) in (1) and using \(\mu(pm)=-\mu(m)\) when \(p\nmid m\)
give
\[
 \boxed{\quad
 R(U)=-\sum_{n\ge1}\mu(n)L_U(n)w_X(n)
 -\sum_{2U<p\le4U}(\log p)
   \sum_{\substack{m\ge1\\(m,p)=1}}
      \mu(m)w_X(p^2m).
 \quad}
 \tag{11}
\]
The second term can contribute only when a selected prime occurs to
exactly the second power and its remaining cofactor is squarefree.
Higher powers contribute zero because \(\mu(n/p)=0\).
Its absolute value is bounded by
\[
 \sum_{2U<p\le4U}(\log p)
 \sum_{m\ge1}|w_X(p^2m)|
 \ll_v\sqrt X\sum_{2U<p\le4U}\frac{\log p}{p^2}
 \ll_v U.
 \tag{12}
\]
Here \(\sqrt X=U^2\), and Chebyshev's bound suffices for the last
step. Thus all repeated-prime leakage in this row has a genuine
fixed-power saving, while its squarefree part is the weighted
Möbius parity sum \(-\sum_n\mu(n)L_U(n)w_X(n)\). The identity does
not bound that remaining signed sum; its medium-prime divisor mask
is exactly the correlation still to be estimated.

The generic uniform exponential-sum bound displayed in
[Robles's Heath–Brown comparison](https://arxiv.org/html/2608.07198)
has an \(xq^{-1/2}\) term, which is of size \(x\) at the
zero-frequency major arc \(q=1\). This is an analogy for the present
calculation, not a limitation on every possible bilinear method.
The smooth prime-error/zero-free-region connection in
[Han's exponential-kernel theorem](https://arxiv.org/html/2505.23795)
is consistent with (4)–(5), though its weight is different.
Finally, the full Vaughan remainder also contains every
\(\ell>1\), all prime powers, and other prime ranges. Neither
(4) nor (6) signs or bounds their combined contribution.
