# Sharpness of the divisor packet bound

The [growing boundary-packet theorem](compact-weil-boundary-packet-growing-positive-space.md)
compresses the complete prime-power shift operator to a finite divisor
matrix \(A_N\) and proves \(\|A_N\|\le\log N+O(1)\). An explicit
positive vector attains the leading coefficient. The key Rayleigh
numerator collapses exactly by the divisor identity, so this lower
bound needs no prime number theorem.

For \(N\ge2\), the real symmetric matrix on labels \(1,\ldots,N\) is
\[
 (A_N)_{n,m}=
 \begin{cases}
 \Lambda(m/n)/\sqrt{m/n},&m/n\in\mathbb Z_{>1},\\
 \Lambda(n/m)/\sqrt{n/m},&n/m\in\mathbb Z_{>1},\\
 0,&\text{otherwise}.
 \end{cases}
 \tag{1}
\]
Its principal submatrix on \(2,\ldots,N\) is \(A_N^{[2,N]}\).
Set \(w_n=n^{-1/2}\), \(H_N=\sum_{n\le N}1/n\), and
\(M(N)=\sum_{2\le d\le N}\Lambda(d)/d\).

**Theorem.** As \(N\to\infty\),
\[
 \boxed{\quad
 \lambda_{\max}(A_N)=\log N+O(1),\qquad
 \lambda_{\max}(A_N^{[2,N]})=\log N+O(1).
 \quad}
 \tag{2}
\]
More precisely, the full-block Rayleigh quotient of \(w\) is
\[
 \frac{\langle w,A_Nw\rangle}{\|w\|_2^2}
 =\log N-\gamma+o(1),
 \tag{3}
\]
where \(\gamma\) is Euler's constant.

**Proof.** Each unordered edge \((n,nd)\), \(d\ge2\), contributes
\(2\Lambda(d)/(nd)\) to the numerator. Switching the finite divisor
sum and using \(\sum_{d\mid m}\Lambda(d)=\log m\) gives the exact identity
\[
 \begin{aligned}
 \langle w,A_Nw\rangle
 &=2\sum_{d=2}^N\frac{\Lambda(d)}d
       H_{\lfloor N/d\rfloor}\\
 &=2\sum_{m=1}^N\frac1m\sum_{d\mid m}\Lambda(d)
 =2\sum_{m=1}^N\frac{\log m}{m}.
 \end{aligned}
 \tag{4}
\]
[CompactWeilDivisorRayleighFinite.lean](../../formalization/BuildingBlocks/CompactWeilDivisorRayleighFinite.lean)
compiles the exact finite factor-pair equality in (4), with every
von Mangoldt prime-power weight retained. The matrix compression,
asymptotic quotient and eigenvalue conclusion remain written
mathematics.
Integral comparison gives
\(\sum_{m\le N}(\log m)/m=\tfrac12(\log N)^2+O(1)\).
Since \(H_N=\log N+\gamma+o(1)\), (3) follows. The weighted
Schur upper bound in the preceding note is
\(\|A_N\|\le\log N+O(1)\), proving the first claim of (2).

Deleting label \(1\) removes exactly \(2M(N)\) from (4) and \(1\)
from \(\|w\|_2^2\). The elementary estimate
\(M(N)=\log N+O(1)\) follows from
\[
 \log(N!)=\sum_{d\le N}\Lambda(d)\lfloor N/d\rfloor,\qquad
 \frac{\log(N!)}N\le M(N)
 \le\frac{\log(N!)+\psi(N)}N,
 \tag{5}
\]
using \(\psi(N)=O(N)\) and integral comparison for \(\log(N!)\).
Thus the restricted \(w\) also has Rayleigh quotient
\(\log N+O(1)\). The principal-submatrix upper bound proves the
second claim of (2). \(\square\)

In the resolved full-label packet regime, the prime compression is
\(A_N\oplus A_N^{[2,N]}\) with \(N\asymp e^{2L}\). Its largest
eigenvalue is therefore \(2L+O(1)\). No smaller leading coefficient
can replace \(2L\) in a scalar upper bound for that prime block.

The condition \(T>4(N+1)\) in the preceding note is sufficient for
packet disjointness and the exact compression; it is not necessary.
When \(T/N\to0\), adjacent packets coalesce and the last incoming
packet crosses the left endpoint, so that resolved model fails.
In particular, this occurs at \(T=e^{(2-\delta)L}\) for fixed
\(\delta>0\). The sharp prime eigenvalue does not sign the complete
Weil form there: one must keep the nonorthogonal gamma, pole, and
prime couplings.
