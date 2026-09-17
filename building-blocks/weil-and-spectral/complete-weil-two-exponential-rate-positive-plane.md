# A positive two-rate plane for the complete actual-prime Weil form

**Status:** independently audited written analytic proof (18 September
2026); the rational packet-sign and Gram determinant algebra are
[Lean compiled](../../formalization/BuildingBlocks/TwoRateWeilGramAlgebra.lean),
while the analytic bridge is not formalized. The result signs every complex linear combination
of two specified decaying exponentials after a sufficiently large compact
cutoff. It does not sign arbitrary tests or prove RH.

Use the [exact complete Weil split](compact-weil-successor-cell-negative-part-bound.md)
on the real logarithmic line:
\[
 Q(f)=\frac1{2\pi}\int_{\mathbb R}
 \left(\Re\psi_{\rm digamma}(5/4+it/2)-\log\pi\right)
 |\widehat f(t)|^2\,dt-\langle f,(K-P)f\rangle.       \tag{1}
\]
The operator \(K\) contains every actual \(\Lambda(p^k)/\sqrt{p^k}\)
shift, \(P\) has kernel \(e^{|x-y|/2}\), and the digamma argument
already includes both pole terms. Let \(Q(f,g)\) be the Hermitian
polarization of (1). For \(a>1/2\), put
\[
 u_a(x)=e^{-ax}\mathbf1_{[0,\infty)}(x),\qquad
 F(a)=\frac{\xi'}{\xi}\!\left(a+\frac12\right),\qquad
\xi(s)=\frac12s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s).        \tag{2}
\]
The definition and reflection \(\xi(s)=\xi(1-s)\) are recorded in
[DLMF §25.4](https://dlmf.nist.gov/25.4).
For these rates the full prime and continuous terms converge
absolutely. The gamma logarithmic Fourier integral also converges.
We use (1) on this noncompact form-domain extension, justified below
as the limit of compact tests.

**Exact Gram identity.** For real \(a,b>1/2\),
\[
 \boxed{\qquad Q(u_a,u_b)=\frac{F(a)+F(b)}{a+b}.\qquad}  \tag{3}
\]
To see every arithmetic term, for \(v\ge0\) the two cross
correlations are
\[
 \int_{\mathbb R}u_a(x+v)u_b(x)\,dx=\frac{e^{-av}}{a+b},
 \qquad
 \int_{\mathbb R}u_b(x+v)u_a(x)\,dx=\frac{e^{-bv}}{a+b}.
\]
Writing \(\sigma_a=a+1/2\), the prime and continuum terms are
respectively
\[
 \frac1{a+b}\sum_{n\ge2}\Lambda(n)
       \bigl(n^{-\sigma_a}+n^{-\sigma_b}\bigr),\qquad
 \frac1{a+b}\left(\frac1{\sigma_a-1}+
                          \frac1{\sigma_b-1}\right).       \tag{4}
\]
The gamma cross term equals
\[
 \frac1{a+b}\left[
 \frac{\psi_{\rm digamma}(\sigma_a/2+1)+
       \psi_{\rm digamma}(\sigma_b/2+1)}2-\log\pi\right]. \tag{5}
\]
One way to verify (5) is to insert the integral representation of
digamma into the Fourier integral in (1). The two exponential
correlations average its cosine factor; equivalently, contour
integration of
\(\widehat u_a(t)\overline{\widehat u_b(t)}
 =((a-it)(b+it))^{-1}\)
gives the two digamma evaluations. Now
\(\sum\Lambda(n)n^{-s}=-\zeta'(s)/\zeta(s)\), the digamma recurrence
\(\psi(z+1)=\psi(z)+1/z\), and (2) turn (4)--(5) into (3).
This is an identity with every prime power and the complete gamma
and pole terms, not a replacement of the arithmetic source.

**Two-rate positivity theorem.** If \(a,b>1/2\) and \(a\ne b\), the
matrix
\[
 G_{a,b}=\begin{pmatrix}
     F(a)/a & (F(a)+F(b))/(a+b)\\
     (F(a)+F(b))/(a+b) & F(b)/b
   \end{pmatrix}                                           \tag{6}
\]
is positive definite. Consequently
\(Q(cu_a+du_b)>0\) for every nonzero \((c,d)\in\mathbb C^2\).
There is also \(L_0(a,b)\) such that for every \(L\ge L_0(a,b)\)
the complete Weil form is positive definite on the compact
two-dimensional span of
\(u_{a,L}=e^{-ax}\mathbf1_{[0,L]}\) and
\(u_{b,L}=e^{-bx}\mathbf1_{[0,L]}\). Nearby smooth compact pairs
have the same property.

Here is the unconditional sign input for (6). The symmetric
Hadamard product and \(\xi(s)=\xi(1-s)\) group its nontrivial zeros
\(\rho=1/2+\delta+i\gamma\) into conjugate/reflected packets.
For \(a>0\), define
\[
 g_{\delta,\gamma}(a)
 =\frac{a-\delta}{(a-\delta)^2+\gamma^2}
  +\frac{a+\delta}{(a+\delta)^2+\gamma^2}
 =\frac{2a(a^2+p)}{D},                                  \tag{7}
\]
where \(p=\gamma^2-\delta^2\), \(q=\gamma^2+\delta^2\),
and \(D=a^4+2pa^2+q^2>0\). A zero on the critical line has
\(\delta=0\); an off-line quartet has both signs of \(\delta\).
Writing \(m_\rho\) for zero multiplicity, the precise sum is
\[
 F(a)=\sum_{\substack{\Im\rho>0\\\Re\rho=1/2}}
             m_\rho g_{0,\Im\rho}(a)
       +2\sum_{\substack{\Im\rho>0\\\Re\rho>1/2}}
             m_\rho g_{\Re\rho-1/2,\Im\rho}(a).        \tag{7a}
\]
Subtract \(\xi'/\xi(1/2)=0\) from the genus-one Hadamard
logarithmic derivative before pairing. The subtracted constants
cancel, and the grouped summands and their first derivatives are
\(O(\gamma^{-2})\) locally uniformly in \(a\); standard zero counting
makes (7a) and its differentiated series convergent. There are no
real nontrivial zeros: on \(0<s<1\), the alternating eta series is
positive and \(\zeta(s)=\eta(s)/(1-2^{1-s})<0\). Thus every summand
has \(\gamma>0\).
The [standard critical strip](https://dlmf.nist.gov/25.10) gives
\(|\delta|<1/2\).
The [rigorous finite-height verification by Platt and Trudgian](https://arxiv.org/abs/2004.09765)
puts every zero with \(0<|\gamma|\le3\cdot10^{12}\) on the critical
line. For zeros above that height, \(|\delta|<1/2\) alone implies
\(|\gamma|>(1+\sqrt2)|\delta|\). Hence *every* packet obeys
\[
 p>0,\qquad q^2\le2p^2.                              \tag{8}
\]
Direct differentiation of (7) gives
\[
 \frac{d}{da}\bigl(a g_{\delta,\gamma}(a)\bigr)
 =\frac{4a(pa^4+2q^2a^2+pq^2)}{D^2}>0,
\]
\[
 -\frac{d}{da}\bigl(g_{\delta,\gamma}(a)/a\bigr)
 =\frac{4a(a^4+2pa^2+2p^2-q^2)}{D^2}>0.                 \tag{9}
\]
Thus \(F(a)>0\), \(aF(a)\) strictly increases, and \(F(a)/a\)
strictly decreases on \((0,\infty)\). In particular, for
\(1/2<a<b\),
\[
 \frac{a}{b}<\frac{F(b)}{F(a)}<\frac{b}{a}.             \tag{10}
\]
The determinant of (6), after multiplication by
\(ab(a+b)^2>0\), is
\[
 F(a)F(b)(a-b)^2-ab(F(a)-F(b))^2,                      \tag{11}
\]
which is strictly positive by (10). Its diagonal entries are
positive, proving the theorem.

For the compact claim, \(u_{a,L}\to u_a\) in the logarithmic gamma
form norm because the Fourier transform of the deleted tail is
\(e^{-aL}e^{itL}/(a-it)\), with integrable
\(\log(2+|t|)/(a^2+t^2)\). The prime forms converge absolutely by
\(\sum\Lambda(n)n^{-\sigma_a}<\infty\), and the continuous and
pole kernels are integrable since \(a,b>1/2\). Hence the compact
Gram matrices converge entrywise to (6); positive definiteness is
open in finite dimension. The compact tests are bounded-variation
members of the form domain and can be mollified as in the
[causal cone note](complete-weil-causal-exponential-signed-cone.md).
The exact cutoff includes a prime power at \(n=e^L\) with zero
correlation weight, so no endpoint term is silently discarded.

This is stronger than positivity on one exponential or on a cone
of nonnegative monotone profiles: the two-dimensional plane includes
sign-changing and complex tests. It remains compatible with a
hypothetical high off-line zero, since (8) permits such a quartet.
It therefore supplies no full-form sign on arbitrary compact tests.
No literature-priority claim is made for the kernel identity or the
two-rate consequence.
