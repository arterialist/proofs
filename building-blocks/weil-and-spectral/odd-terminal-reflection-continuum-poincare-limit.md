# Two terminal reflections and the continuum graph gap

Terminal primes above \(\sqrt X\) act on the odd half-window by reflection.
Two such reflections compose to a local translation, but the composition is
restricted to their overlap interval.  The dense-prime *continuum limit* of
one fixed terminal band has a strict relative graph gap.  The actual discrete
graph has no such all-test gap without a frequency restriction.  This note
separates these two precise statements; it proves no inequality uniform at
the archimedean budget \(H_a\lesssim e^a\) and no RH result.

Use \(X=e^{2a}\), \(\phi(x)=\cosh(x/2)\), and the actual odd
prime-shift normalization in [Suzuki's localized
form](https://arxiv.org/html/2606.09096v2).  Fix \(R>0\), take \(a>R\),
and retain ordinary primes \(Xe^{-R}<p<X\).  Put
\(c_p=\log(X/p)\in(0,R)\) and use boundary depth \(s=a-x\) on
\((0,a)\).  Write its unsigned reflection geometry as
\[
 (\mathsf R_c v)(s)={\bf1}_{0<s<c}v(c-s),
 \qquad 0<c<R.
 \tag{1}
\]
The corresponding term of the **odd** prime operator is
\(-\mathsf R_{c_p}\), multiplied by \((\log p)/\sqrt p\).  The two
minus signs cancel in a composition.
For \(c,d<R\), direct composition gives
\[
 (\mathsf R_c\mathsf R_dv)(s)
 ={\mathbf1}_{\max(0,c-d)<s<c}\,v(s+d-c).
 \tag{2}
\]
Thus the displacement \(d-c=\log(p/q)\) is a translation only on a
moving overlap interval.  This is the same projection/translation geometry
as the [two-prime mixed-scattering overlap identity](two-prime-mixed-scattering.md),
equation (26.2), in a boundary coordinate.  Equation (2) alone gives no
signed estimate for a sum of prime shifts.

## A strict gap in the fixed-band continuum limit

Let \(v\in C_c^\infty(0,R)\) be real and set
\(u_{a,v}(x)=v(a-x)\) on \((0,a)\), with odd full-window extension
\(F_{a,v}(x)=\operatorname{sgn}(x)u_{a,v}(|x|)/\sqrt2\).
Let \(P_{a,R}\) be the prime-shift operator using just the stated band,
and let \(S_{a,R}\) and \(D_{a,R}=S_{a,R}-\langle F,P_{a,R}F\rangle\)
be its exact positive Schur row and graph deficit, using the same gauge
\(\phi\) as in the [full graph identity](../prime-distribution/odd-prime-graph-logarithmic-uncertainty.md).
Define
\[
 M_R(s)=1-e^{s-R},\qquad
 \mathsf S_R[v]=\int_0^R M_R(s)|v(s)|^2ds,
 \tag{3}
\]
and
\[
 \mathsf D_R[v]
 =\frac12\iint_{s+r<R}e^{-(s+r)}
       |e^{s/2}v(s)+e^{r/2}v(r)|^2ds\,dr.
 \tag{4}
\]

**Theorem.** For every fixed real \(v\in C_c^\infty(0,R)\), the prime
number theorem gives
\[
 e^{-a}S_{a,R}[F_{a,v}]\longrightarrow\mathsf S_R[v],
 \qquad
 e^{-a}D_{a,R}[F_{a,v}]\longrightarrow\mathsf D_R[v].
 \tag{5}
\]
There is a constant \(\kappa_R>0\), depending only on \(R\), such that
\[
 \boxed{\quad\mathsf D_R[v]\ge\kappa_R\mathsf S_R[v]
       \quad\text{for every }v\in L^2(0,R).\quad}
 \tag{6}
\]
In particular, each fixed nonzero boundary profile in (5) has an
asymptotic relative graph deficit bounded below by \(\kappa_R\).

**Proof of the limits.** At \(x=a-s\), a band prime with gap \(c_p>s\)
connects to \(-a+(c_p-s)\).  Uniformly for \(0\le s,c_p\le R\),
\[
 \frac{\phi(-a+c_p-s)}{\phi(a-s)}
 =e^{s-c_p/2}(1+O_R(e^{-a})).
\]
The prime number theorem for \(\vartheta\) gives, uniformly in
\(0\le s\le R\),
\[
 e^{-a}\sum_{\substack{Xe^{-R}<p<Xe^{-s}}}
 \frac{\log p}{\sqrt p}
 \frac{\phi(-a+c_p-s)}{\phi(a-s)}
 \longrightarrow 1-e^{s-R}=M_R(s).
 \tag{7}
\]
This is the row limit.  The reflected odd pairing is
\[
 \langle F_{a,v},P_{a,R}F_{a,v}\rangle
 =-\sum_{Xe^{-R}<p<X}\frac{\log p}{\sqrt p}
                  (v*v)(c_p),
\]
and Stieltjes integration against \(d\vartheta\) gives
\[
 e^{-a}\langle F_{a,v},P_{a,R}F_{a,v}\rangle
 \longrightarrow
 -\iint_{s+r<R}e^{-(s+r)/2}v(s)v(r)ds\,dr.
 \tag{8}
\]
Expanding (4) shows that it equals \(\mathsf S_R\) plus the signed
cross term opposite to (8), proving (5).  Every **retained prime base**
exceeds \(\sqrt X\) for large \(a\), so its own higher powers lie beyond
the window.  Proper powers of smaller primes can still occur in the same
numerical band; this theorem defines \(P_{a,R}\) using ordinary primes.
For fixed \(R\), their total shift weight in that band is \(O_R(1)\)
(squares) plus \(o(1)\) (higher powers), so they do not affect the
order-\(e^a\) limits in (5).

**Proof of the gap.** Put \(q(s)=e^{s/2}v(s)\) and
\(d\mu(s)=e^{-s}M_R(s)ds\).  On \(L^2(\mu)\), define
\[
 (T_Rq)(s)=\frac1{M_R(s)}
                 \int_0^{R-s}e^{-r}q(r)dr.
 \tag{9}
\]
Detailed balance follows from the symmetric edge measure
\(e^{-(s+r)}{\bf1}_{s+r<R}ds\,dr\).  Thus \(T_R\) is a self-adjoint
Markov contraction, and
\[
 \mathsf S_R[v]=\|q\|_{L^2(\mu)}^2,
 \qquad
 \mathsf D_R[v]=\langle q,(I+T_R)q\rangle_{L^2(\mu)}.
 \tag{10}
\]
It is compact: after unitary transfer to \(L^2(ds)\), its kernel is
\[
 \frac{e^{-(s+r)/2}{\bf1}_{s+r<R}}
      {\sqrt{M_R(s)M_R(r)}}.
\]
This kernel is Hilbert--Schmidt.  Near \(s=R\),
\(M_R(s)\asymp R-s\), while \(r<R-s\), so the singularity is
integrable; near \(s=0,r=R\), the remaining bound is logarithmic and
also integrable.

An eigenvector with eigenvalue \(-1\) would make (4) zero.  It would
satisfy \(q(s)+q(r)=0\) for almost every \(s+r<R\).  All pairs in
\((0,R/2)^2\) are edges, forcing \(q=0\) there.  Every
\(s\in(R/2,R)\) has a positive-measure set of neighbors in
\((0,R-s)\), forcing \(q=0\) there too.  Hence \(-1\) is not an
eigenvalue.  Compact self-adjointness then gives
\(\inf\operatorname{spec}(T_R)>-1\); taking
\(\kappa_R=1+\inf\operatorname{spec}(T_R)\) proves (6).

## A quantitative transfer for moving profiles

The fixed-profile limit can be made uniform on a class whose spatial
oscillation grows with \(a\).  Fix \(0<\eta<R\), and put
\[
 \varepsilon_a
 =a^{1/4}\exp\!\left(-\sqrt{(2a-R)/6.455}\right).
 \tag{11}
\]
For every real \(v\in H_0^1(0,R-\eta)\), extended by zero to \((0,R)\),
the explicit prime-number-theorem bound for \(\vartheta\) gives,
uniformly for large \(a\),
\[
 \begin{aligned}
 |e^{-a}S_{a,R}[F_{a,v}]-\mathsf S_R[v]|
   &\le C_R(\varepsilon_a+e^{-a})\|v\|_2^2,\\
 |e^{-a}D_{a,R}[F_{a,v}]-\mathsf D_R[v]|
   &\le C_R(\varepsilon_a+e^{-a})
               (\|v\|_2^2+\|v\|_2\|v'\|_2).
 \end{aligned}
 \tag{12}
\]
Consequently, for all sufficiently large \(a\), **uniformly** over
nonzero profiles satisfying
\[
 v\in H_0^1(0,R-\eta)\text{ real},\qquad
 \|v'\|_2\le e^{\sqrt a/4}\|v\|_2,
\]
one has the discrete relative graph bound
\[
 \boxed{\quad D_{a,R}[F_{a,v}]
       \ge\frac{\kappa_R}{2}S_{a,R}[F_{a,v}].\quad}
 \tag{13}
\]
The estimate applies to moving profiles, rather than one fixed test,
but its derivative restriction is far stronger than an archimedean
budget \(H_a\lesssim e^a\).
It includes the **exact pole-null** subspace: in these coordinates the
condition is
\[
 \int_0^{R-\eta}
      (e^{-s/2}-e^{-a}e^{s/2})v(s)ds=0.
 \tag{14}
\]
Two fixed interior smooth bumps, with one coefficient adjusted by
\(O(e^{-a})\), give nonzero profiles satisfying (14) and the derivative
restriction for all large \(a\).  In this derivative class, elementary
Plancherel and Jensen estimates also give normalized logarithmic energy
\(H_a[u_{a,v}]/\|v\|_2^2=O(\sqrt a)\), well within \(e^a\).

To verify (12), the row calculation behind (7) uses
\(\vartheta(y)=y+O(y\varepsilon_a)\) uniformly on
\([Xe^{-R},X]\), plus the \(O_R(e^{-a})\) ratio error.  For the signed
pairing, write it as a Stieltjes integral with
\(f(x)=x^{-1/2}(v*v)(\log(X/x))\).  Both
\(\|v*v\|_\infty\le\|v\|_2^2\) and
\(\|(v*v)'\|_\infty\le\|v\|_2\|v'\|_2\).  One integration by parts
against \(\vartheta(x)-x\) bounds its endpoints and interior by
\(C_Re^a\varepsilon_a(\|v\|_2^2+\|v\|_2\|v'\|_2)\).
This is [Trudgian's explicit \(\vartheta\) error](https://arxiv.org/html/1401.2689v2),
Theorem 1, applied only at \(x\asymp X\).  Finally
\(M_R(s)\ge1-e^{-\eta}>0\) on the support of \(v\), while
\(\varepsilon_a e^{\sqrt a/4}\to0\); combine (6) and (12) to obtain
(13).  Every term in this argument is an ordinary-prime term; the
proper powers in the same numerical band have bounded total weight.

## What does not transfer to the discrete graph

At each fixed sufficiently large \(a\), the band contains a nonempty
finite set of primes by the prime number theorem.  Their
logarithms are rationally independent, so Kronecker's theorem supplies
arbitrarily late carriers \(t\) for which
\(e^{it\log p}\to1\) simultaneously for every band prime.  On
\(F_t(x)=\phi(x)\sin(tx)\), the exact graph identity then gives
\(D_{a,R}[F_t]/S_{a,R}[F_t]\to0\).  The pole moment is
\(O_a(1/t)\) after normalization; a vanishing projection and compact
smoothing make the tests exactly pole-null without changing the limit.
Their logarithmic archimedean energy grows like \(\log t\).  This proves
that the fixed-band continuum gap (6) cannot be promoted to a discrete
**all-test** gap by operator-norm convergence.

The recurrence argument gives no useful upper bound on these carrier
heights.  It therefore does not decide whether a uniform inequality holds
on the much smaller class \(H_a\lesssim e^a\).  At that budget, the
missing step is a quantitative arithmetic bound for the actual terminal
prime phases or their signed pairing; the overlap lengths in (2) and the
positive [Gamma edge-mass law](../prime-distribution/odd-prime-terminal-band-phase-transfer.md)
do not supply that bound by themselves.
