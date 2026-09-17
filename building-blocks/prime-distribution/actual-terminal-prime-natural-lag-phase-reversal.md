# An actual prime atom reverses the terminal packet's far-lag phase

Written mathematical result with an exact integer-interval certificate,
17 September 2026. The literal zero-charge source \(\sigma_N\), its
prime autocorrelation \(q_N(k)\), and the first-moment factors \(J_N,T_N\)
are defined in the [terminal trace](../theta-and-heat/actual-terminal-heat-prime-trace-phase.md).
The [double-scale audit](../theta-and-heat/terminal-heat-double-scale-prime-lag-obstruction.md)
showed that \(k=N\) can have a critical correction, but treated \(N\)
as a real-lag diagnostic. Here \(N\) itself is prime, so the
sign reversal occurs at an admitted, actual von Mangoldt atom.

**Theorem.** At \(N=18553\), which is prime,

\[
 \boxed{\quad
 297<J_N<298,\qquad -2<T_N<-1,\qquad
 11349<N^2q_N(N)<11907.
 \quad}                                                   \tag{1}
\]

Consequently \(q_N(N)>0\), whereas the far-lag first-moment
approximation \(J_NT_N/N^2\) is negative. The actual prime atom
\(k=N\) contributes
\(-2\Lambda(N)q_N(N)<0\) to the Weil prime row, with the opposite
sign from the first-moment prediction. This does not sign the
complete late-prime row, the pole and gamma terms, or the Weil form.

## Exact kernel and monotonicity

For \(E(x)=\psi(x)-x\), put
\[
 K_N(s)=2\int_1^N\frac{E(x)}{(x+s)^3}dx,\qquad
 J_N=\int_1^N E(x)dx,\qquad T_N=K_N(0).
\]
The cumulative-source identity gives
\[
 N^2q_N(N)=\int_1^N E(y)K_N(y/N)dy.                 \tag{2}
\]
Stieltjes integration by parts retains the atom at \(1\), the
density cells, every prime power through \(N\), and the terminal
atom \(-E_N\delta_N\), \(E_N=\psi(N)-N\):
\[
 \boxed{\quad
 K_N(s)=\sum_{2\le n\le N}\frac{\Lambda(n)}{(n+s)^2}
 -\frac1{1+s}+\frac1{N+s}
 -\frac1{(1+s)^2}-\frac{E_N}{(N+s)^2}.
 \quad}                                                   \tag{3}
\]
In particular (3) reduces every rational \(s\) in the certificate
to rational combinations of finitely many \(\log p\).

The [positive factorial ground](../factorial-and-renewal/factorial-ground-state-original-l2-domain.md)
satisfies \(F(1)=0\), \(F(x)>0\) for \(x>1\), and
\(E(x)=-x^2F'(x)\) almost everywhere. For \(0\le s\le1\),
integration by parts yields
\[
 \begin{aligned}
 \int_1^N\frac{E(x)}{(x+s)^4}dx
 &=-\frac{N^2F(N)}{(N+s)^4}
   +\int_1^N
      \frac{2x(s-x)F(x)}{(x+s)^5}dx<0,\\
 K_N'(s)&=-6\int_1^N\frac{E(x)}{(x+s)^4}dx>0.
 \end{aligned}                                             \tag{4}
\]
The terminal boundary in (4) is essential. It proves monotonicity
on exactly the interval sampled by \(y/N\) in (2).

## An exact finite certificate

The companion
[Python certificate](../../certificates/terminal-prime-natural-lag-sign-certificate.py)
uses only integers and rational fractions. A sieve constructs
\(\Lambda(p^j)=\log p\) for all \(2188\) prime powers at most \(N\)
and verifies that \(N\) is prime. Each \(\log p\) is enclosed by
\(\log p=m\log2+2\operatorname{atanh}z\), where
\(2^m\le p<2^{m+1}\) and
\(z=(p-2^m)/(p+2^m)\in[0,1/3]\).
Twenty-six terms of
\[
 2\operatorname{atanh}z
 =2\sum_{j\ge0}\frac{z^{2j+1}}{2j+1}
\]
give a rational lower bound; the omitted positive tail is at most
\[
 \frac{2z^{53}}{53(1-z^2)}.                         \tag{5}
\]
All later bounds are outward-rounded integer intervals at scale
\(10^{24}\). No floating-point value enters the assertions.

Partition \([1,N]\) into blocks \([a,b]\) of at most \(20\) unit
cells. Since \(E(y)=\psi(m)-y\) on \([m,m+1)\), the block integral
\(J_{a,b}=\int_a^bE(y)dy\) is enclosed directly from the prime-power
log intervals. An upper bound for
\(A_{a,b}=\int_a^b|E(y)|dy\) is
\(\sum_{m=a}^{b-1}(|\psi(m)-m|+1)\).
By (4), the left-endpoint rectangle
\(K_N(a/N)J_{a,b}\) has error at most
\[
 [K_N(b/N)-K_N(a/N)]A_{a,b}.                         \tag{6}
\]
The program evaluates (3), sums these rectangles and error bounds,
and asserts the coarse strict inequalities in (1). Its outward
intervals are \(297<J_N<298\),
\(-2<T_N<-1\), and
\(11349<N^2q_N(N)<11907\).
Running the companion Python file from the repository root
reproduces the assertions in a few seconds.

This is a finite actual-source counterexample to extending the
far-lag first-moment **sign** down to the packet-scale prime atom.
The source's complete prime tail beyond a cutoff and the shifted
gamma-plus-arithmetic comparison in the
[coupled-scale audit](../theta-and-heat/terminal-heat-coupled-continuum-residual.md)
remain open. The certificate is executable exact arithmetic,
not a Lean formalization or an RH proof.
