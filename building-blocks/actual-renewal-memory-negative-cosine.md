# An elementary-tail certificate for a negative renewal frequency

The [causal renewal cell audit](causal-renewal-euler-discrepancy-audit.md)
proves positivity of the primitive \(J=\int_0^u H\) and the linked
step-and-arch decomposition. Those properties do not make the actual
memory a positive quadratic lag kernel. This note gives a specific
negative frequency for the complete integer-minus-continuum discrepancy.
The same sign is already enclosed more sharply by direct Arb evaluation
in the [actual finite-packet autocorrelation](actual-centered-packet-lag-autocorrelation.md);
the contribution here is a separate proof reducing the infinite zeta value
to 512 elementary terms and a deterministic tail bound.
It is a counterexample to an all-input passivity claim, not a test of the
distinguished arithmetic heat source or a proof about zeta zeros.

Use exactly the audit's right-continuous convention:
\[
H(u)=1_{u\ge0}\left[
\sum_{n\le e^u}n^{-1/2}-2(e^{u/2}-1)-c\right],
\qquad c=2+\zeta(1/2).
\tag{1}
\]
The cell expansion in that audit gives \(H(u)=O(e^{-u/2})\), so
\(H\in L^1(0,\infty)\). Define its cosine multiplier by
\(M(\omega)=\int_0^\infty H(u)\cos(\omega u)du\).

**Theorem.** For every real \(\omega\ne0\),
\[
\boxed{\quad
M(\omega)=\frac{\Im\zeta(1/2+i\omega)}{\omega}
               +\frac1{\omega^2+1/4}.
\quad}
\tag{2}
\]
Moreover \(M(12)<-1/200\). Consequently, for some real
\(h\in C_c^\infty(\mathbb R)\), with \(f=h'\),
\[
\int_0^\infty H(s)\int_{\mathbb R}f(v+s)f(v)\,dv\,ds<0.
\tag{3}
\]

To prove (2), let \(\nu=\sum_{n\ge1}n^{-1/2}\delta_{\log n}\)
and \(\kappa=e^{u/2}1_{u\ge0}du\). The endpoint-exact cell identity
is \(\nu-\kappa=c\delta_0+DH\), where the derivative of the causal
zero extension includes its origin atom. For \(\Re z>1/2\), taking
Laplace transforms gives
\[
z\widehat H(z)=\zeta(z+1/2)-\frac1{z-1/2}-c.
\tag{4}
\]
Both sides continue analytically through \(\Re z>0\): the pole at
\(z=1/2\) cancels, and \(\widehat H\) is analytic there because
\(H\in L^1\). At \(z=i\omega\), take real parts. The constant \(c\)
is real, and \(\Im[1/(i\omega-1/2)]=-\omega/(\omega^2+1/4)\),
yielding (2). The value at zero is its continuous limit
\(M(0)=\int H=4+\zeta'(1/2)>0\).

Here is a finite certified sign calculation with a separate analytic
tail. Put \(s=1/2+12i\), \(D=1-2^{1-s}\), and
\[
Z_{512}=D^{-1}\sum_{n=1}^{512}(-1)^{n-1}n^{-s}.
\]
The accompanying [ball-arithmetic check](certificates/renewal_discrepancy_negative_cosine.py)
using [python-flint/Arb](https://python-flint.readthedocs.io/en/stable/arb.html)
proves the strict finite inequalities
\(\Im Z_{512}<-37/50\) and \(|D|>2\). The standard alternating
Dirichlet identity \(\zeta(s)=D^{-1}\sum_{n\ge1}(-1)^{n-1}n^{-s}\)
holds at this \(s\). Pairing the tail after the even index 512 and
using \(x^{-s}-(x+1)^{-s}=s\int_x^{x+1}t^{-s-1}dt\) gives
\[
\left|\zeta(s)-Z_{512}\right|
\le\frac{2|s|}{\sqrt{513}|D|}
<\frac{13}{22},
\tag{5}
\]
since \(|s|<13\) and \(\sqrt{513}>22\). Therefore
\(\Im\zeta(s)<-37/50+13/22=-41/275\), and (2) gives
\[
M(12)<-\frac{41}{3300}+\frac4{577}<-\frac1{200}.
\tag{6}
\]
Only the two finite strict inequalities use ball arithmetic; the
infinite tail is paid by (5). This gives a smaller computational
consumer than directly enclosing the infinite zeta value.

For (3), Plancherel and Fubini give, for real \(f\in L^2\),
\[
\int_0^\infty H(s)C_f(s)ds
=\frac1{2\pi}\int_{\mathbb R}M(\omega)|\widehat f(\omega)|^2d\omega,
\qquad C_f(s)=\int f(v+s)f(v)dv.
\tag{7}
\]
The multiplier \(M\) is continuous and even. Taking
\(h_T(v)=\chi(v/T)\cos(12v)\) for a nonzero real
\(\chi\in C_c^\infty\), the normalized Fourier mass of \(h_T'\)
concentrates at \(\pm12\) as \(T\to\infty\). The quotient of the
left side of (7) by \(\|h_T'\|_2^2\) tends to \(M(12)<0\), proving
(3) for a sufficiently large finite \(T\).

The negative frequency does not contradict the positive primitive
\(J\) or the linked finite-horizon inequality in the cell audit.
It rules out replacing their actual arithmetic linkage by a universal
positive-definite lag assertion. The signed work for the specific
prime-power heat response, especially before its cutoff, remains open.
This result is written analysis plus a finite ball certificate; it has
not been formalized in Lean.
