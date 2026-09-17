# Macroscopic negative odd block in the actual centered Goldbach heat

*Research and initial proof: RH Agent3. Independent mathematical audit and publication: RH Proof.*

This unconditional calculation uses the actual von Mangoldt function, all prime powers, and the exact centering coefficients. It refutes termwise positivity and shows that paying odd/even totals separately by absolute values loses order \(N\); it does not lower-bound the full positive heat energy.

Let \(G(k)=\sum_{a+b=k}\Lambda(a)\Lambda(b)\) and
\[
 R_a(k)=G(k)-2\psi(k-1)+(k-1),\qquad
 K_N(k)=\frac{e^{-k/N}-e^{-k}}k.
\]
The complete positive square is
\[
 E(N)=\int_{1/N}^1\left|
 \sum_{n\ge1}(\Lambda(n)-1)e^{-nt}\right|^2dt
 =\sum_{k\ge2}R_a(k)K_N(k).
\tag{1}
\]
The coefficient at \(n=1\) is \(-1\), and \(G\) contains the full \(\Lambda(2^j)=\log2\) row.

For odd \(k\), if \(\Lambda(a)\Lambda(b)\ne0\) and \(a+b=k\), precisely one of \(a,b\) is even. Its even prime power is \(2^j\). Therefore
\[
 G(k)=2\log2\sum_{\substack{j\ge1\\2^j<k}}\Lambda(k-2^j)
 \le 2\log2\,\lfloor\log_2k\rfloor\log k
 =O(\log^2 k).
\tag{2}
\]
This includes every proper power; deleting them would invalidate the identity, though not the upper bound. The prime number theorem gives \(\psi(k-1)=k+o(k)\) uniformly as \(k\to\infty\), so
\[
 \boxed{R_a(k)=-k+o(k)\quad\text{for odd }k\to\infty.}
\tag{3}
\]
In particular \(R_a(k)<-k/2\) for every sufficiently large odd \(k\). This is an actual-source sign statement, not a free coefficient perturbation.

Fix \(0<a<b<\infty\). Because \(K_N(k)=e^{-k/N}/k+O(e^{-k}/k)\) uniformly for \(aN\le k\le bN\), the odd contribution to (1) from this compact macroscopic band obeys
\[
 \boxed{\displaystyle
 \sum_{\substack{aN\le k\le bN\\k\ {\rm odd}}}
 R_a(k)K_N(k)
 =-\frac N2\int_a^b e^{-u}\,du+o(N).}
\tag{4}
\]
The mesh of the odd integers is \(2/N\), and (3)'s \(o(k)\) is uniform on the band. For example, the odd \(N\le k\le2N\) block contributes
\(-\tfrac N2(e^{-1}-e^{-2})+o(N)\).

Thus the nonnegative complete heat integral necessarily balances a negative contribution of order \(N\) from odd additive totals against even totals and possibly other bands. A proof of the RH-scale condition \(E(N)\ll_\epsilon N^\epsilon\) must capture this global signed cancellation. Positivity of raw Goldbach \(G(k)\), or termwise positivity of \(R_a(k)\), cannot supply it. No estimate here controls the corresponding original multiplicative Fejér/Lambert signed covariance.

## The first unconditional even–odd repair

The prime number theorem also determines the corresponding *even* block at
leading order. Let \(G_{\le}(x)=\sum_{k\le x}G(k)\). The scaled measure
\(N^{-1}\sum_n\Lambda(n)\delta_{n/N}\) converges weakly on compact
positive intervals to Lebesgue measure, by PNT and partial summation.
Its additive self-convolution over the triangle \(u+v\le x/N\) gives
\[
 G_{\le}(x)=\frac{x^2}{2}+o(x^2).
\tag{5}
\]
The odd \(G(k)\) contribute only \(O(x\log^2x)\) by (2), so the even
cumulative sum has the same asymptotic. Stieltjes partial summation with
the smooth weight \(e^{-k/N}/k\), for fixed \(0<a<b\), yields
\[
 \sum_{\substack{aN\le k\le bN\\k\ {\rm even}}}
 G(k)K_N(k)
 =N\int_a^b e^{-u}\,du+o(N).
\tag{6}
\]
The centering coefficient \(-2\psi(k-1)+(k-1)=-k+o(k)\) has
\(-\frac N2\int_a^b e^{-u}\,du+o(N)\) heat weight on each parity.
Consequently
\[
 \sum_{\substack{aN\le k\le bN\\k\ {\rm even}}}
 R_a(k)K_N(k)
 =+\frac N2\int_a^b e^{-u}\,du+o(N),
\tag{7}
\]
which cancels (4) to \(o(N)\) within each fixed macroscopic band. This
is an unconditional leading-scale signed repair, but its \(o(N)\)
error is far larger than the required \(N^\epsilon\) bound. Neither
(5) nor its parity refinement controls the fluctuation that is
equivalent to RH.

The same argument can include *all* additive totals. From (2),
\(\sum_{k\ {\rm odd}}G(k)K_N(k)=O(\log^3(2N))\):
use \(K_N(k)\le e^{-k/N}/k\) and split at \(k=N\).
For the centering terms, PNT gives uniformly beyond any fixed
large cutoff \(-2\psi(k-1)+(k-1)=-k+o(k)\).
The finitely many smaller terms contribute \(O(1)\), and
\(\sum_{k\ge1,\ k\ {\rm odd}}e^{-k/N}=N/2+O(1)\). Thus
\[
 \sum_{\substack{k\ge2\\k\ {\rm odd}}}R_a(k)K_N(k)
 =-\frac N2+o(N).
\tag{8}
\]
Separately, PNT and the Laplace transform
\(P(t)=t\int_0^\infty e^{-tx}\psi(x)\,dx\) show \(A(t)=o(1/t)\) as
\(t\downarrow0\). Splitting its defining energy at a small fixed
\(t_0\), then using this bound on \(1/N\le t\le t_0\), proves
\(E(N)=o(N)\). Hence (1) and (8) force the **complete even contribution**
\[
 \sum_{\substack{k\ge2\\k\ {\rm even}}}R_a(k)K_N(k)
 =+\frac N2+o(N).
\tag{9}
\]
These \(N/2\) terms are not independent positive energies; they are
signed coefficient contributions to the same nonnegative heat square.
