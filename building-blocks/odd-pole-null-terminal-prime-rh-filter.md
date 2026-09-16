# An exact pole-null terminal-prime filter with an RH-equivalent one-sided bound

A single fixed boundary profile turns the signed odd Weil prime pairing into a
smoothed count of **ordinary primes in one terminal logarithmic band**.  Its
leading continuous-prime moment vanishes, its pole moment can be made exactly
zero, and either eventual one-sided bound at the bounded archimedean scale is
equivalent to RH.  No such bound is proved here.  This sharpens the earlier
[moving-packet criterion](suzuki-odd-continuum-green-and-moving-prime-residual.md)
by imposing exact pole-nullity and isolating ordinary primes above
\(\sqrt X\); it does not supply an all-test positivity estimate.

Use the odd half-line normalization of [Suzuki's localized Weil
form](https://arxiv.org/html/2606.09096v2).  Let \(P_a^{\rm odd}\) contain
every admitted prime-power shift with weight \(\Lambda(n)/\sqrt n\), and let
\(h(x)=\sqrt2\sinh(x/2)\) be its pole vector.  For \(X=e^{2a}\), define the
ordinary-prime score
\[
 T_v(a)=\sum_{Xe^{-3/2}<p<Xe^{-1/2}}
       \frac{\log p}{\sqrt p}\,(v*v)(\log(X/p)).
 \tag{1}
\]
The convolution and the score are signed; \(v\) below changes sign.

**Theorem.** There is an explicit nonzero real \(v\in C_c^\infty(\mathbb R)\),
supported in \([1/4,3/4]\),
and, for all sufficiently large \(a\), real \(u_a\in C_c^\infty(0,a)\) such that
\[
 \langle h,u_a\rangle=0,\qquad
 \|u_a\|_2=\|v\|_2+O(e^{-a}),\qquad
 H_a[u_a]=O(1),
 \tag{2}
\]
where \(H_a\) is the positive logarithmic odd archimedean form.  The original
Suzuki archimedean form is also \(O(1)\) in absolute value.  Their full
prime-power pairing satisfies
\[
 \boxed{\quad\langle u_a,P_a^{\rm odd}u_a\rangle=-T_v(a)+O(1).\quad}
 \tag{3}
\]
Every prime in (1) exceeds \(\sqrt X\) for large \(a\), so its square and
the product of any two such primes lie beyond the window.  With this *one
fixed* profile, each of the following eventual estimates, separately, is
equivalent to RH:
\[
 \boxed{\quad T_v(a)\le C\quad\text{for all large }a,
 \qquad\text{or}\qquad
 T_v(a)\ge-C\quad\text{for all large }a,\quad}
 \tag{4}
\]
for some finite constant \(C\).  By (3), the analogous eventual upper or
lower \(O(1)\) bound for the exact pole-null prime pairing is equivalent as
well.

## The fixed filter and the exact pole correction

For \(j\ge1\), put \(\ell_j=2^{-j-1}\) and
\(q_j(s)=e^{-s}{\bf1}_{(0,\ell_j)}(s)/(1-e^{-\ell_j})\).
Let \(\varphi\) be the density of \(1/4+\sum_{j\ge1}U_j\), where
the independent variables \(U_j\) have densities \(q_j\), and put
\[
 v(s)=2\varphi'(s)-\varphi(s),\qquad
 F_g(z)=\int_0^\infty g(s)e^{-zs/2}\,ds.
 \tag{5}
\]
Because \(\sum_j\ell_j=1/2\), the density is supported in
\([1/4,3/4]\).  For every \(m\ge2\), it is the convolution of the first
\(m\) densities, a \(C_c^{m-2}\) function, with a tail probability
measure.  Hence \(\varphi\) and \(v\) are \(C_c^\infty\).
Integration by parts gives
\[
 F_v(z)=(z-1)F_\varphi(z),\qquad
 F_\varphi(z)=e^{-z/8}
 \prod_{j\ge1}
 \frac{1-e^{-(1+z/2)\ell_j}}
      {(1+z/2)(1-e^{-\ell_j})}.
 \tag{6}
\]
Each quotient has its removable value at \(z=-2\).  The product
converges locally uniformly and is nonzero for \(\Re z\ge0\): every
factor is nonzero there, and its difference from one is
\(O_z(\ell_j)\), with \(\sum_j\ell_j<\infty\).  Hence \(F_v\) has exactly
one zero in that half-plane, at \(z=1\).  In particular,
\(F_v(1)=\int e^{-s/2}v(s)ds=0\).

For \(a>3/4\), let \(u_a^0(x)=v(a-x)\) on \((0,a)\).  The pole moment is
\[
 \langle h,u_a^0\rangle
 =\frac{e^{a/2}}{\sqrt2}F_v(1)
  -\frac{e^{-a/2}}{\sqrt2}F_v(-1)
 =-\frac{e^{-a/2}}{\sqrt2}F_v(-1).
 \tag{7}
\]
Likewise \(\langle h,\varphi(a-\cdot)\rangle
=e^{a/2}F_\varphi(1)/\sqrt2+O(e^{-a/2})\), with
\(F_\varphi(1)>0\).  Set
\[
 c_a=\frac{\langle h,u_a^0\rangle}
          {\langle h,\varphi(a-\cdot)\rangle}=O(e^{-a}),
 \qquad u_a(x)=v(a-x)-c_a\varphi(a-x).
 \tag{8}
\]
Then \(u_a\) is exactly pole-null.  Translating these fixed compact
profiles only changes the phases of their sine transforms; their absolute
Fourier envelopes decay faster than any power.  The logarithmic and Suzuki
archimedean multipliers are \(O(1+\log(2+|t|))\), proving (2).

## Only one terminal prime band remains

The support of \(u_a^0\) has diameter \(1/2<\log2\), so no same-side
prime-power shift has a nonzero pairing.  The odd reflection formula gives
the **exact** identity
\[
 \langle u_a^0,P_a^{\rm odd}u_a^0\rangle
 =-K_v(a),\qquad
 K_v(a):=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
                     (v*v)(2a-\log n).
 \tag{9}
\]
The convolution support restricts (9) to
\(Xe^{-3/2}<n<Xe^{-1/2}\), entirely inside the admitted window.  Its
continuous-prime counterpart vanishes **exactly**:
\[
 \int_1^\infty x^{-1/2}(v*v)(\log(X/x))\,dx
 =e^aF_v(1)^2=0
 \qquad(a>3/4).
 \tag{10}
\]
Thus \(K_v\) is a signed, centered Chebyshev statistic even though its
definition (9) contains no explicit density subtraction.

Proper prime powers in this fixed multiplicative interval contribute
\(O(1)\) in absolute value.  For squares, the bases lie in an interval of
bounded logarithmic width around \(e^a\), and Chebyshev's bound
\(\vartheta(y)=O(y)\) gives
\(\sum (\log p)/p=O(1)\) there.  More precisely, the prime number
theorem and the substitution \(c=2a-2\log p\) give the square
contribution \(\tfrac12\int(v*v)(c)dc+o(1)=\tfrac12+o(1)\), since
\(\int\varphi=1\) and \(\int v=-1\).  The total weight
\(\sum_{p,r\ge3}(\log p)/p^{r/2}\) is finite, and its tail in the
moving interval tends to zero.  Consequently
\[
 K_v(a)=T_v(a)+\frac12+o(1).
 \tag{11}
\]
The full prime operator has \(\|P_a^{\rm odd}\|=O(e^a)\) by the
[weighted Schur bound](prime-shift-weighted-schur-window-asymptotic.md).
Since \(\|u_a-u_a^0\|_2=O(e^{-a})\), its quadratic pairing changes by
\(O(1)\).  Equations (9)--(11) prove (3), with every proper power paid.

## Why either one-sided estimate is RH-strength

The algebraic expression \(K_v(a)\) is defined for every \(a\ge0\);
the physical packet identity (9) is used only for \(a>3/4\).  For
\(\Re z>1\), termwise Laplace integration, followed by
\(s=2a-\log n\), gives
\[
 \boxed{\quad
 \int_0^\infty e^{-za}K_v(a)\,da
 =\frac12F_v(z)^2
     \left(-\frac{\zeta'}{\zeta}\right)
                    \left(\frac{z+1}{2}\right).
 \quad}
 \tag{12}
\]
The change of variables introduces no missing lower endpoint: the
convolution is supported in \((1/2,3/2)\), and \(n\ge2\).  At \(z=1\),
the zero \(F_v(1)=0\) cancels the zeta pole.  At every hypothetical zero
\(\rho\) with \(\Re\rho>1/2\), (12) has an uncanceled nonreal pole at
\(z_\rho=2\rho-1\): \(F_\varphi\) is zero-free on \(\Re z\ge0\), and
\(z_\rho\ne1\).

Suppose \(K_v(a)\) is eventually bounded on either one side.  After
adding a constant and choosing the sign, it gives an eventually
nonnegative function \(G(a)\).  Chebyshev's estimate gives
\(K_v(a)=O(e^a)\), so the Laplace transform of \(G\) has a finite
abscissa of convergence.  If an off-critical \(\rho\) existed, the
nonreal pole just identified would force this abscissa to be positive.
Landau's theorem for a nonnegative Laplace transform would then force a
singularity at that **positive real** abscissa.  But (12), after the
constant and finite-interval corrections, is analytic at every positive
real \(z\): its \(z=1\) pole is canceled, and \(\zeta(s)\) has no real
zero for \(s>1/2\).  This contradiction excludes zeros to the right of
the critical line; the functional equation excludes zeros to its left.
Equation (11) transfers either one-sided bound in (4) to \(K_v\), proving
the reverse implications.  This positive-Laplace method follows the
precedent of [Suzuki's weighted Chebyshev sign
criteria](https://arxiv.org/html/2411.07436v3), Theorem 1.

Conversely, assume RH.  The [zero side of Weil's formula](https://arxiv.org/html/2606.09096v2)
for the odd extension of \(u_a^0\) is uniformly \(O(1)\): its Fourier
transform is a sum of two phase multiples of the fixed rapidly decaying
transform \(F_v(2it)\), and the standard zero count makes the
sum of its squared values over all critical zeros convergent, uniformly
in \(a\).  Its archimedean form is \(O(1)\) and its pole form is
\(O(e^{-a})\) by (7).  The exact Weil identity therefore gives
\(K_v(a)=O(1)\) through (9).  Equation (11) gives \(T_v(a)=O(1)\),
and (3) gives the same bound for the exact pole-null pairing.  This
proves the forward implications.

The terminal primes in (1) have no admitted products, yet their signed
weighted count already carries an RH-equivalent one-sided condition.
Neither the [positive terminal edge-mass law](odd-prime-terminal-band-phase-transfer.md)
nor the local two-reflection overlap identity in
[two-prime mixed scattering](two-prime-mixed-scattering.md) supplies the
bounded signed Chebyshev remainder in (4).  The theorem identifies that
remaining arithmetic input; it does not establish it.
