# Stretched-exponential smoothing of the actual signed terminal-prime score

This note gives an unconditional cancellation estimate for one fixed,
exactly pole-null odd boundary packet using the **actual** von Mangoldt
coefficients. It also gives a quantitative two-sided oscillation law for
its centered prime score. The proof uses the zeta zero-free region and a
rapidly decaying half-Laplace filter. It does not establish a one-sided
bound at the archimedean scale or positivity of the full Weil form.

The packet has the same terminal geometry as the [smooth pole-null
filter](odd-pole-null-terminal-prime-rh-filter.md): ordinary primes lie
in one multiplicative band above \(\sqrt X\), and all proper powers
are retained before their bounded contribution is evaluated. The new
choice of convolution lengths improves the unconditional cancellation
available for this fixed score.

## Statement and the successor-clock readout

Put \(b=3/\pi^2\), \(\ell_j=bj^{-2}\) for \(j\ge1\), and
\[
 q_j(s)=\frac{e^{-s}{\bf1}_{(0,\ell_j)}(s)}{1-e^{-\ell_j}}.
 \tag{1}
\]
Let \(\varphi\) be the density of \(1/4+\sum_{j\ge1}U_j\), where the
\(U_j\) are independent with densities \(q_j\), and set
\[
 v=2\varphi'-\varphi,\qquad
 F_g(z)=\int_0^\infty g(s)e^{-zs/2}\,ds.
 \tag{2}
\]
Since \(\sum_j\ell_j=1/2\), both \(\varphi\) and \(v\) are real,
compactly supported in \([1/4,3/4]\), and smooth. Also
\(\int\varphi=1\), \(\int v=-1\), and
\[
 F_v(z)=(z-1)F_\varphi(z),\quad
 F_\varphi(z)=e^{-z/8}\prod_{j\ge1}
 \frac{1-e^{-(1+z/2)\ell_j}}
 {(1+z/2)(1-e^{-\ell_j})}.
 \tag{3}
\]
The quotient has its removable value at \(z=-2\). The product is
nonzero on \(\Re z\ge0\), so \(F_v\) vanishes there only at \(z=1\).

For \(X=e^{2a}\), write \(g=v*v\) and define the full prime-power
and ordinary-prime scores
\[
 K_v(a)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
                   g(\log(X/n)),\qquad
 T_v(a)=\sum_{Xe^{-3/2}<p<Xe^{-1/2}}
           \frac{\log p}{\sqrt p}g(\log(X/p)).
 \tag{4}
\]
Both sums are finite. The support of \(g\) is contained in
\([1/2,3/2]\), and for large \(a\) every ordinary prime in the band
exceeds \(\sqrt X\).

**Theorem.** There are constants \(c,C>0\) such that, for all
sufficiently large \(a\),
\[
 \boxed{\quad |K_v(a)|+|T_v(a)|
 \le C\exp\!\left(a-c\frac{a}
 {(\log a)^{2/3}(\log\log a)^{1/3}}\right).\quad}
 \tag{5}
\]
The proper-power contribution is
\[
 K_v(a)=T_v(a)+\tfrac12+o(1).
 \tag{6}
\]
For the translated odd packet \(u_a^0(x)=v(a-x)\) on \((0,a)\),
the same-side prime shifts vanish because the support diameter is
\(1/2<\log2\), and its full prime pairing is exactly \(-K_v(a)\).
Subtracting \(c_a\varphi(a-x)\), with \(c_a=O(e^{-a})\), makes the
packet exactly pole-null, keeps its logarithmic archimedean form
\(O(1)\), and changes the prime pairing by \(O(1)\). Thus (5) is a
signed estimate for an exact pole-null Weil test, though it remains
far larger than its bounded archimedean energy.

There is a finite \(+1\)-clock version of the same cancellation. Set
\(\psi(0)=0\), \(\Lambda(1)=0\), and let
\(e_n=\psi(n)-\psi(n-1)-1=\Lambda(n)-1\) and
\(w_a(x)=x^{-1/2}g(\log(X/x))\). For \(a>3/4\), the full support of
\(w_a\) lies above \(x=1\). Since
\(\int_1^\infty w_a(x)dx=e^aF_v(1)^2=0\), Euler summation gives
\[
 \boxed{\quad K_v(a)=\sum_{n\ge1}e_nw_a(n)+O_v(e^{-a}).\quad}
 \tag{7}
\]
Here the sum is supported on the integer band
\(Xe^{-3/2}<n<Xe^{-1/2}\), and the error follows from
\(\int|w_a'(x)|dx=O_v(e^{-a})\). If
\(I_g=\int_{1/2}^{3/2}e^{-s/2}|g(s)|ds>0\), then the prime number
theorem and ordinary Riemann summation give
\[
 \sum_{n\ge1}|e_nw_a(n)|=(2I_g+o(1))e^a.
 \tag{8}
\]
One \(I_ge^a\) comes from the prime arrivals with weight \(\log p\),
and one from the negative unit innovations at the remaining integers;
proper powers are negligible at this scale. Thus (5) is cancellation
of a signed successor sum whose absolute mass is of order \(e^a\).

## Vertical decay and the zero expansion

The filter's extra regularity is quantitative. For
\(-1\le\sigma\le2\), \(z=\sigma+it\), each factor \(Q_j(z)\) in
(3) satisfies
\[
 |Q_j(z)|\le e^{\ell_j/2},\qquad
 |Q_j(z)|\le\frac{8j^2}{b|t|}\quad(t\ne0).
 \tag{9}
\]
The first bound follows by viewing the factor as the half-Laplace
transform of the probability density \(q_j\); the second uses
\(1-e^{-\ell_j}\ge\ell_j/2\). For
\(J=\lfloor\sqrt{b|t|/16}\rfloor\), the first \(J\) factors are at
most \(1/2\), and the product of the others is at most
\(e^{\sum_j\ell_j/2}=e^{1/4}\). The factor \(z-1\) is absorbed by
slightly reducing the exponent. Consequently, for some \(c_0,C_0>0\),
\[
 |F_v(\sigma+it)|\le C_0e^{-c_0\sqrt{|t|}}
 \qquad(-1\le\sigma\le2).
 \tag{10}
\]
The infinite convolution is \(C_c^\infty\): for every desired
derivative order, split off sufficiently many \(q_j\) factors; their
finite convolution has that order of continuous derivatives, and
convolution with the remaining probability measure preserves it.
Each factor of (3) has no zero on \(\Re z\ge0\); local uniform
convergence to a nonzero product follows from
\(Q_j(z)=1+O_z(\ell_j)\) and \(\sum_j\ell_j<\infty\).

As in the linked pole-null criterion, direct Laplace integration gives
for \(\Re z>1\)
\[
 \int_0^\infty e^{-za}K_v(a)da
 =\frac12F_v(z)^2
   \left(-\frac{\zeta'}{\zeta}\right)
              \left(\frac{z+1}{2}\right).
 \tag{11}
\]
The \(z=1\) zeta pole is canceled by \(F_v(1)=0\). Move the inverse
Laplace line from \(\Re z=2\) to \(\Re z=-1\). The trivial zeta zeros
map to \(z=-5,-9,\ldots\), so this crosses precisely the nontrivial
zeros. The standard local partial-fraction estimate for the zeta
logarithmic derivative expresses it, uniformly in a fixed vertical
strip, as the sum of \(1/(s-\rho)\) over zeros with
\(|\Im s-\Im\rho|\le1\), plus \(O(\log(|\Im s|+2))\). Zero counting
gives \(O(\log T)\) such zeros near height \(T\). Thus one can choose
heights \(T_k\in[k,k+1]\), at distance \(\gg1/\log k\) from their
ordinates, for which \(\zeta'/\zeta(\sigma+iT_k)=O(\log^2 k)\)
uniformly across the fixed strip. Use horizontal lines
\(\Im z=\pm2T_k\); (10) then kills their integrals. On \(\Re z=-1\),
the functional equation and the zero-free line \(\Re s=1\) give
polylogarithmic growth of \(\zeta'/\zeta((z+1)/2)\), so the remaining
integral is \(O_v(e^{-a})\). The result is the absolutely convergent
identity
\[
 \boxed{\quad K_v(a)=-\sum_{\rho}m_\rho
 F_v(2\rho-1)^2e^{(2\rho-1)a}+O_v(e^{-a}),\quad}
 \tag{12}
\]
where the sum runs over distinct nontrivial zeros and \(m_\rho\)
denotes multiplicity. The residue is \(-m_\rho F_v(2\rho-1)^2\),
without an absolute-value square; conjugate zeros combine to make
the result real.

By the [Korobov–Vinogradov zero-free
region](https://arxiv.org/abs/2306.10680), all zeros with
\(|\Im\rho|\le a^4\) satisfy, for large \(a\),
\[
 2\Re\rho-1\le1-
 \frac{c_1}{(\log a)^{2/3}(\log\log a)^{1/3}}.
 \tag{13}
\]
Finitely many small zeros are absorbed by reducing \(c_1\). Since
the zero-count estimate \(N(T)=O(T\log T)\) and (10) give
\(\sum_\rho m_\rho|F_v(2\rho-1)|^2<\infty\), the low part of
(12) is bounded by the right side of (5). The high part satisfies
\[
 \sum_{|\Im\rho|>a^4}m_\rho
 |F_v(2\rho-1)|^2e^{(2\Re\rho-1)a}
 \ll e^{a-c_2a^2}
 \tag{14}
\]
for some \(c_2>0\), again by (10) and zero counting. This proves
(5), with (6) following from the prime number theorem for squares and
absolute convergence for higher powers.

## A finite space of coupled terminal histories

The estimate is uniform on a fixed finite-dimensional family, including
its cross terms. Fix distinct shifts
\(0\le h_1<\cdots<h_d\le1/10\) and put
\[
 v_{\boldsymbol c}(s)=\sum_{j=1}^d c_jv(s-h_j),
 \qquad \boldsymbol c\in\mathbb R^d.
 \tag{15}
\]
Define \(K_{\boldsymbol c}\) by the full prime-power sum in (4) with
\(v_{\boldsymbol c}\) in place of \(v\), and let
\(T_{\boldsymbol c}\) be its ordinary-prime part, summed over the
full support band \(Xe^{-17/10}<p<Xe^{-1/2}\). There are constants
\(c_d,C_d>0\), depending on the chosen shifts, such that for every
\(\boldsymbol c\) and all sufficiently large \(a\),
\[
 |K_{\boldsymbol c}(a)|+|T_{\boldsymbol c}(a)|
 \le C_d\exp\!\left(a-c_d\frac{a}
 {(\log a)^{2/3}(\log\log a)^{1/3}}\right)
 \|v_{\boldsymbol c}\|_2^2.
 \tag{16}
\]
Indeed,
\(F_{v_{\boldsymbol c}}(z)=F_v(z)
\sum_jc_je^{-zh_j/2}\); on \(-1\le\Re z\le2\) its decay in
(10) is bounded uniformly by a constant times
\(\sum_j|c_j|\). The contour and zero-free-region proof then bounds
\(K_{\boldsymbol c}\) by the right side of (16) with
\((\sum_j|c_j|)^2\) in place of \(\|v_{\boldsymbol c}\|_2^2\).
Distinct translates of a nonzero compactly supported function are
linearly independent, so norm equivalence on this fixed finite space
gives (16). Its support diameter is at most \(3/5<\log2\), so the
same-side prime shifts still vanish. The square-power term tends to
\(\tfrac12(\sum_jc_j)^2\), with an
\(o(\|\boldsymbol c\|^2)\) error uniform over nonzero coefficient
vectors by homogeneity and compactness of the unit sphere.
Thus (16) controls the actual signed prime quadratic form for all
linear combinations in this finite family, including the interactions
between different translated histories. It does not control a family
whose dimension or shifts change with \(a\).
The exact pole correction applies linearly to this family: its
coefficient is \(O_d(e^{-a}\|v_{\boldsymbol c}\|_2)\), and the prime
pairing changes by \(O_d(\|v_{\boldsymbol c}\|_2^2)\), which is absorbed
in (16). The resulting odd tests have archimedean form
\(O_d(\|v_{\boldsymbol c}\|_2^2)\).

## An unconditional oscillation floor

The same score cannot settle to one sign. Choose any critical-line
zero \(\rho=1/2+i\gamma\) of multiplicity \(m_\rho\), and put
\(R_\rho=m_\rho|F_v(2i\gamma)|^2>0\). Such zeros exist, and the
half-Laplace factor in (3) does not vanish at them. Then
\[
 \boxed{\quad
 \limsup_{a\to\infty}K_v(a)\ge R_\rho,
 \qquad \liminf_{a\to\infty}K_v(a)\le-R_\rho.\quad}
\tag{17}
\]
By (6), the centered ordinary-prime score \(T_v(a)+1/2\) has the
same two inequalities. Those ordinary-prime inequalities also hold with
\(a=\tfrac12\log N\)
along integer \(N\to\infty\), because the compact smooth kernel and
Chebyshev's bound give
\(|T_v(\tfrac12\log X)-T_v(\tfrac12\log N)|=O_v(N^{-1/2})\)
for \(N\le X\le N+1\).

Here is the residue argument for (17). If \(K_v\) were eventually
bounded below, the linked one-sided Landau proof, using the zero-free
factor (3), would force RH. Under RH, the odd Weil formula gives
\(K_v=O_v(1)\), so (11) is the ordinary Laplace transform throughout
\(\Re z>0\). Suppose more strongly that \(K_v(a)\ge-c\) eventually
for some \(0<c<R_\rho\). For large \(A\), the function
\(G(a)={\bf1}_{a\ge A}(K_v(a)+c)\) is nonnegative. Therefore
\(|\mathcal L G(\sigma+2i\gamma)|\le\mathcal L G(\sigma)\)
for \(\sigma>0\). Multiplying by \(\sigma\) and letting it decrease
to zero gives \(R_\rho\le c\): the complex limit is the residue
\(-m_\rho F_v(2i\gamma)^2\), while the real limit is \(c\), since
(11) is analytic at \(z=0\) because \(\zeta(1/2)\ne0\). This is a
contradiction. The upper bound is identical with
\(G(a)={\bf1}_{a\ge A}(c-K_v(a))\). This positivity-and-residue
argument is a standard oscillation method; no priority claim is made
for it. The existence of critical zeros is classical and is also
covered by rigorous [zero verification](https://arxiv.org/html/2004.09765).

## Functional-equation pairing cannot cancel an off-line zero's power

The functional equation pairs every hypothetical off-line zero
\(\rho=\beta+i\gamma\), \(\beta>1/2\), with
\(1-\rho\), and conjugation supplies \(\overline\rho\) and
\(1-\overline\rho\).
Set \(\delta=2\beta-1>0\), \(\tau=2\gamma\), and
\[
 A=F_v(\delta+i\tau)^2,\qquad
 B=F_v(-\delta+i\tau)^2.
 \tag{18}
\]
The contribution of this quartet to the zero sum (12), counting its
common multiplicity \(m\), is exactly
\[
 Q_\rho(a)=-2m\operatorname{Re}\!\left(
 A e^{(\delta+i\tau)a}+B e^{(-\delta+i\tau)a}\right).
 \tag{19}
\]
Because \(F_v\) has no zero in \(\Re z>0\), \(A\ne0\). Therefore
\[
 \limsup_{a\to\infty}e^{-\delta a}|Q_\rho(a)|=2m|A|>0.
 \tag{20}
\]
The reflected term is smaller by \(e^{-2\delta a}\) after this
normalization. It cannot cancel the growing member of its own
quartet. The elementary polynomial
\(\bigl((s-\beta)^2+\gamma^2\bigr)
\bigl((s-(1-\beta))^2+\gamma^2\bigr)\) has both real symmetry and
\(s\mapsto1-s\) symmetry while retaining this off-line quartet. It is
strictly positive for real \(s\) and on \(\Re s=1/2\); thus even these
axis signs together with the symmetries cannot rule the quartet out.
This polynomial is
only a symmetry model, with no Euler product or arithmetic assertion.

Other zero terms might cancel \(Q_\rho(a)\) at individual values of
\(a\). They cannot erase its power from the entire signed score.
Every actual off-line zero would force, with
\(R_\rho^{\rm off}=m|F_v(\delta+i\tau)|^2>0\),
\[
 \boxed{\quad
 \limsup_{a\to\infty}e^{-\delta a}K_v(a)
 \ge R_\rho^{\rm off},\qquad
 \liminf_{a\to\infty}e^{-\delta a}K_v(a)
 \le-R_\rho^{\rm off}.\quad}
 \tag{21}
\]
In particular, for every \(0\le\kappa<\delta\),
\[
 \limsup_{a\to\infty}e^{-\kappa a}|K_v(a)|=\infty.
 \tag{22}
\]
Here is a proof of (21) that retains every other zero term. If its
lower assertion failed, choose \(0<c<R_\rho^{\rm off}\) and \(A\) so
that \(G(a)={\bf1}_{a\ge A}(K_v(a)+ce^{\delta a})\ge0\).
Chebyshev's bound gives \(G(a)=O(e^a)\), hence its Laplace abscissa
\(\sigma_G\le1\). The nonzero pole of (11) at
\(z_\rho=\delta+i\tau\) forces \(\sigma_G\ge\delta\). If
\(\sigma_G>\delta\), Landau's theorem for nonnegative Laplace
transforms forces a singularity at the real point \(z=\sigma_G\).
But the meromorphic continuation
\[
 \mathcal LG(z)=\mathcal LK_v(z)
 +\frac{ce^{-(z-\delta)A}}{z-\delta}
 -\int_0^A e^{-za}K_v(a)\,da
 \tag{23}
\]
is analytic at every real \(z>\delta\): the pole at \(z=1\) is
canceled, and \(\zeta(s)\) has no real zero for \(0<s<1\).
Thus \(\sigma_G=\delta\). For \(\sigma>\delta\), positivity gives
\(|\mathcal LG(\sigma+i\tau)|\le\mathcal LG(\sigma)\).
After multiplication by \(\sigma-\delta\) and passage to
\(\sigma\downarrow\delta\), the left side tends to
\(R_\rho^{\rm off}\) while the right side tends to \(c\): (11)
has residue \(-mF_v(z_\rho)^2\) at \(z_\rho\), and is analytic at
real \(z=\delta\), where its zeta argument is
\(\beta\in(1/2,1)\). This contradicts \(c<R_\rho^{\rm off}\).
Applying the same argument to
\({\bf1}_{a\ge A}(ce^{\delta a}-K_v(a))\) proves the upper assertion.
This is a conditional obstruction to a proposed cancellation method,
not evidence that an off-line zero exists. In particular, proving a
fixed-power bound \(|K_v(a)|\ll e^{(1-\eta)a}\), \(0<\eta<1\),
would already exclude
zeros with \(\beta>1-\eta/2\); the functional equation supplies no
such exclusion. The argument allows improvements within the present
\(e^{a-o(a)}\) scale by methods that use more arithmetic information.
[Han's smooth weighted-prime theorem](https://arxiv.org/html/2505.23795)
likewise relates errors for the different exponential kernel
\(e^{-n/x}\) to zeta zero-free regions, and its Goldbach theorem
concerns the exponentially smoothed additive convolution
\(\Lambda*\Lambda\). That additive count supplies no cancellation
for the multiplicative terminal score (4) by itself. The general link
between smooth error bounds and zero-free regions is established
literature; the compact terminal packet, its exact pole nullity, and
the fixed-family cancellation bound above are the specific features
proved here.

The cancellation in (5) is far from the \(O(1)\) one-sided bound that
would settle RH for this profile. It uses the actual zeta zero-free
region, which is absent from the [coherent prime-weight
countermodel](sparse-prime-weight-ground-positive-terminal-sign-countermodel.md):
that model preserves integer successors, prime-power support, PNT,
and a positive factorial ground while making the same kind of fixed
signed score unbounded. In that construction, taking this \(v\) as the
fixed packet and choosing \(a_j\ge j^2\) gives perturbation size
\(2^{-j}e^{a_j}\), which eventually exceeds the right side of (5).
Thus the exact von Mangoldt amplitudes do essential work here. The
result is specific to this fixed finite family;
it gives no all-test coercive inequality. In particular, it does not
extend [Zhu's certified fixed-window positivity](https://arxiv.org/html/2608.24827)
or resolve the all-window problem in
[Suzuki's localized form](https://arxiv.org/html/2606.09096v2).
[Connes–Consani](https://arxiv.org/abs/2106.01715) analyze small
eigenvalues of fixed-support Weil forms through prolate modes, while
[Connes–Consani–Moscovici](https://arxiv.org/abs/2511.22755) propose a
spectral-limit route to RH. The scalar estimate (5) establishes neither
positivity for their test spaces nor the proposed spectral convergence.
