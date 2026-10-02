# A long Gaussian average of the complete critical numerator

A long logarithmic Gaussian average of the actual complete numerator has
an unconditional main term of order \(x^{3/2}\) and a strictly negative
first correction. The result holds for every real cutoff \(x\ge2\).
It uses the exact ordinary-integer clock, all von Mangoldt prime powers,
the complete cofactor sum and the original unit seed.

This is a bound for a long, tilted average. The signed bound for the
original numerator needed by the RH criterion remains unproved. The
asymptotic below is independently checked written mathematics; the
linked Lean leaf verifies finite clock and contour algebra.

## Object, bound and full range

Let \(F=N_{\rm full}\), with \(F(y)=0\) for \(y\le1\), be the literal
complete row in the [Gaussian recovery note](gaussian-recovery-complete-critical-numerator.md).
Its Mellin transform, initially on \(\Re s>2\), is
\[
 H_1(s)=\frac{\zeta(s-\tfrac12)}{s(s-1)}
 \left[1+\frac1{s-2}+\frac{\zeta'}{\zeta}(s-1)\right]^2.
 \tag{1}
\]
The apparent pole at \(s=2\) is removable. Every proper prime power and
the unit-origin term are included in (1).

For real \(x\ge2\), put \(L=\log x\), \(\tau=3L/2\), and let
\(G\) be a centered Gaussian with variance \(2\tau=3L\). Define
\[
 B(x)=\mathbb E\!\left[e^{-3G/2}F(xe^G)\right]
 =\frac1{\sqrt{6\pi L}}\int_{\mathbb R}
       e^{-u^2/(6L)-3u/2}F(xe^u)\,du.
 \tag{2}
\]
Equivalently, this is \(x^{3/2}\) times ordinary heat averaging of
\(v\mapsto e^{-3v/2}F(e^v)\) at \(v=L\). The weight in (2) is
not normalized to have mass one. Both earlier and later cutoffs are
averaged; \(\tau\) is a regularization parameter.

The elementary bound \(|F(y)|\ll y^2\log(2y)\) gives only
\[
 |B(x)|\ll x^{19/8}\log(2x).
 \tag{3}
\]
It also proves absolute convergence of (2).

**Theorem.** With \(q=\zeta'/\zeta\) and
\[
 A=\frac43[q(\tfrac12)-1]^2,\qquad
 C_1=\frac{H_1(7/6)}{\sqrt{6\pi}},
\]
there is an absolute implied constant such that, for every real \(x\ge2\),
\[
 \boxed{
 B(x)=Ax^{3/2}
      +C_1\frac{x^{4/3}}{\sqrt{\log x}}
      +O\!\left(\frac{x^{4/3}}{(\log x)^{3/2}}\right).}
 \tag{4}
\]
The coefficients satisfy the explicit bounds
\[
 A\ge\frac{784}{243}>0,\qquad
 H_1(7/6)\le-\frac{570807}{16807}<0.
 \tag{5}
\]
Thus \(|B(x)-Ax^{3/2}|\ll x^{4/3}/\sqrt{\log x}\), and
\(0<B(x)<Ax^{3/2}\) for all sufficiently large real \(x\).
No exceptional integer cutoffs are removed. No explicit numerical
remainder constant or starting threshold for the last strict inequalities
is supplied.

## The ordinary clock supplies the low-height region

For \(\Re s=\sigma>0\), \(s\ne1\), Euler summation gives
\[
 \zeta(s)=\frac{s}{s-1}-sI(s),\qquad
 I(s)=\int_1^\infty\{t\}t^{-s-1}\,dt.
 \tag{6}
\]
Here \(\{t\}=t-\lfloor t\rfloor\).
This is the \(a=1\) specialization of the standard
[Euler-summation formula, DLMF 25.11.5](https://dlmf.nist.gov/25.11.E5).

Inside each unit cell, the real weight \(w(t)=t^{-\sigma-1}\) decreases.
Pairing the positions \(n+u\) and \(n+1-u\), \(0<u\le1/2\), gives
\[
 (u-\tfrac12)w(n+u)+(\tfrac12-u)w(n+1-u)\le0.
\]
At \(u=0\), the actual fractional part at the next integer is zero;
the endpoint still satisfies the corresponding inequality. Integration
over the cells and summation therefore give
\[
 |I(s)|\le I(\sigma)\le\frac1{2\sigma}.
 \tag{7}
\]
The sums converge absolutely for \(\sigma>0\).

For \(\sigma\ge1/2\), \(|\Im s|\le6/7\),
\[
 4\sigma^2-|s-1|^2\ge\frac34-\frac{36}{49}
                         =\frac3{196}>0.
\]
A zero in this region would require \(I(s)=1/(s-1)\), contradicting
(7). The pole at \(s=1\) is treated separately. Functional reflection,
whose multiplier is nonzero in the open critical strip, covers
\(0<\sigma<1/2\). Hence the open critical strip contains no zero at
\(|\Im s|\le6/7\).

The input here is the exact counting identity \(N(t)=\lfloor t\rfloor\).
An arbitrary positive Euler product does not supply that clock.
This elementary low-height region is used only for the contour below;
it is not a new zero-free frontier estimate.

## Elementary signs of both coefficients

Use the actual continuous periodic primitive
\[
 P(t)=\frac{\{t\}(1-\{t\})}{2},\qquad 0\le P(t)\le\frac18.
\]
It vanishes at every integer and has
\(P'(t)=1/2-\{t\}\) off the integer endpoints. Integration by parts
in (6) gives
\[
 \zeta(s)=\frac1{s-1}+\frac12+sJ(s),\qquad
 J(s)=(s+1)\int_1^\infty P(t)t^{-s-2}\,dt.
 \tag{8}
\]
Equation (8) is also the corrected
[Bernoulli-integral formula, DLMF 25.11.6](https://dlmf.nist.gov/25.11.E6):
the periodic Bernoulli numerator is
\((\widetilde B_2-B_2)/2=-P\).
The endpoint values of \(P\) remove the boundary terms.

For real \(r>0\), boundedness of \(P\) gives
\[
 0\le J(r)\le\frac18,\qquad
 J'(r)\le\frac1{8(r+1)}.
 \tag{9}
\]
For the second inequality, differentiate under the integral and discard
the nonpositive logarithmic term. On every compact set of \(r>0\),
an integrable multiple of \(t^{-r_0-2}(1+\log t)\) justifies the
differentiation. In particular,
\[
 \zeta'(r)\le-\frac1{(1-r)^2}
                  +\frac18\left(1+\frac r{r+1}\right)
 \quad(0<r<1).
 \tag{10}
\]

At \(r=1/2\), (8)--(10) give
\[
 -\frac32\le\zeta(\tfrac12)\le-\frac{23}{16},
 \qquad \zeta'(\tfrac12)\le-\frac{23}{6}.
\]
The quotient of these negative values obeys \(q(1/2)\ge23/9\),
which proves the first inequality in (5).

At \(r=1/6\), the corresponding bounds are
\[
 -\frac7{10}\le\zeta(\tfrac16)\le-\frac{163}{240},
 \qquad \zeta'(\tfrac16)\le-\frac{227}{175}.
\]
Thus \(q(1/6)\ge454/245\) and
\(q(1/6)-1/5\ge81/49\). Also (8) gives
\(\zeta(2/3)\le-29/12\). Since \((7/6)(1/6)=7/36\),
\[
 H_1(7/6)
 =\frac{36}{7}\zeta(\tfrac23)[q(\tfrac16)-\tfrac15]^2
 \le-\frac{29}{12}\frac{36}{7}
                   \left(\frac{81}{49}\right)^2
 =-\frac{570807}{16807}.
\]
No computed zeta values or zero table enters these signs.

## Pointwise Mellin contour and every tail

Take \(\sigma_x=2+1/L\). The initial Mellin inversion is absolutely
convergent and gives the canonical zero extension for all positive
arguments. At each fixed \(x\), its interchange with the Gaussian
expectation is justified by the finite exponential Gaussian moment and
\(\int_{\mathbb R}|H_1(\sigma_x+it)|\,dt<\infty\).
Consequently
\[
 B(x)=\frac1{2\pi i}\int_{(\sigma_x)}
 H_1(s)\exp\!\left(Ls+\frac{3L}{2}(s-\tfrac32)^2\right)\,ds.
 \tag{11}
\]
This is a pointwise identity at the stated \(x\); no global Mellin
multiplier for a varying-time operator is asserted.

Shift only the part \(|\Im s|\le T\), \(T=6/7\), to
\(a=7/6\). The low-height region above makes \(q(s-1)\)
holomorphic in this rectangle apart from its pole at \(s=2\),
which cancels in (1). The only crossed pole is \(s=3/2\).
Its residue is \(A\), and its exponential factor is \(x^{3/2}\).
The pole at \(s=1\) remains below the shifted line.

Put \(Q(v)=v+\tfrac32(v-\tfrac32)^2\). On the left segment,
\[
 L(a+it)+\frac{3L}{2}(a+it-\tfrac32)^2
       =\frac{4L}{3}-\frac{3L}{2}t^2.
 \tag{12}
\]
Thus there is no remaining linear oscillatory phase at the saddle.
Near \(t=0\), expanding the analytic function \(H_1(a+it)\) gives
\(H_1(a)+itH_1'(a)+O(t^2)\). The odd term integrates to zero;
the Gaussian mass and second moment give
\[
 \frac{x^{4/3}}{2\pi}\int_{-T}^T
       H_1(a+it)e^{-3Lt^2/2}\,dt
 =\frac{H_1(a)x^{4/3}}{\sqrt{6\pi L}}
      +O(x^{4/3}L^{-3/2}).
 \tag{13}
\]
Extending the Gaussian mass to the whole line costs an exponentially
small error; the rest of the finite segment is bounded uniformly.

Both high vertical tails stay on the original right line.
The actual Dirichlet series bounds
\[
 |H_1(\sigma_x+it)|\ll
             \frac{(1+L)^2}{1+t^2},\qquad |t|\ge T.
\]
The right-line displacement has exactly the bounded correction
\[
 LQ(2+1/L)=\frac{19L}{8}+\frac52+\frac3{2L}.
\]
The two tails are therefore
\[
 O\!\left(Lx^{19/8-(3/2)(6/7)^2}\right)
       =O(Lx^{499/392}).
 \tag{14}
\]
On each horizontal segment \(H_1\) is bounded on a fixed compact
zero-free region. Convexity of \(Q\) bounds these segments by the
same power. Since
\[
 \frac43-\frac{499}{392}=\frac{71}{1176}>0,
\]
their logarithmic factors are absorbed in the remainder in (13).
Only the finite low rectangle is shifted. Combining the residue,
(13) and (14) proves (4). The estimates are uniform for
\(L\ge\log2\), after increasing an absolute constant.

## The unit boundary and the RH limit

The zero extension is essential to the saddle term. For example,
replacing the source by the test function
\(y\,\mathbf1_{y>1}\) gives exactly
\[
 B_{\rm test}(x)=x^{11/8}
       \Phi\!\left(-\frac{\sqrt{\log x}}{2\sqrt3}\right)
 \sim\sqrt{\frac6\pi}\frac{x^{4/3}}{\sqrt{\log x}},
\]
where \(\Phi\) is the standard Gaussian distribution function.
The whole-monomial contribution changes because its unconstrained tilted
saddle lies below \(y=1\). This calculation checks the boundary
normalization; it is not a prime-error experiment.

For \(x\ge2\), the time \(\tau=3\log x/2\) exceeds one. The
[short-time recovery theorem](gaussian-recovery-complete-critical-numerator.md)
does not apply to (2), and a backward transfer to the original \(F\)
has not been proved.
The long average suppresses high-frequency zero contributions below the
error term. For a hypothetical zero \(\rho=\beta+i\gamma\), its
exponential factor has real power
\[
 1+\beta+\frac32[(\beta-\tfrac12)^2-\gamma^2]
 \le\frac{499}{392}<\frac43
 \quad(|\gamma|>6/7,\ 0<\beta<1).
\]
The contour proof already accommodates these real parts. It does not
exclude an off-critical zero. The required signed upper for the original
numerator, and the complete RH proof chain, remain open.

The [Lean leaf](../../formalization/BuildingBlocks/LongGaussianSourceAlgebra.lean)
checks the literal fractional-part pairing and primitive bounds, the
low-band gap, complex saddle and rational exponents. Its coefficient
transfers have explicit Bernoulli-integral value and derivative
hypotheses. The infinite Euler-summation identities, integrability and
derivative interchange, functional reflection, actual Mellin realization,
Gaussian interchange, contour deformation and asymptotic remainder
remain written analysis. The theorem (4) has not been kernel checked.

The audited finite declarations use only propext, Classical.choice and
Quot.sound, with no placeholders or custom axioms. Check the leaf with
lake build BuildingBlocks.LongGaussianSourceAlgebra.
Euler summation, Mellin contours and Gaussian saddle estimates are
established methods; this note makes no priority claim for them or
for a global RH-frontier improvement.
