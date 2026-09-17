# Exact pole cancellation and the arithmetic residual at the packet scale

Written mathematical result, 17 September 2026. This note specializes the
known continuum-prime/Green-kernel cancellation to the literal terminal
source of the [actual heat prime trace](actual-terminal-heat-prime-trace-phase.md).
It retains every von Mangoldt prime power in the residual. At the natural
cutoff \(Y=N\), the continuous late-prime term has both signs at square-root
scale, while the available unconditional bound on its discrete correction
does not transfer those signs to the actual late-prime term. No positivity
of the complete Weil form or RH conclusion is claimed.

## A complete, exact cancellation

Let \(N\ge2\) be an integer, \(E(x)=\psi(x)-x\) for \(x\ge1\), and
\(d\sigma_N\) the zero-charge source in equation (1) of the terminal
trace. Write

\[
 M_+=\int_1^N\frac{E(x)}x\,dx,\qquad
 M_-=\int_1^N\frac{E(x)}{x^2}\,dx,\qquad
 q_N(t)=2t\int_1^N\!\int_1^N
       \frac{E(x)E(y)}{(tx+y)^3}\,dx\,dy\quad(t\ge1).
 \tag{1}
\]

The real-lag extension \(q_N(t)\) agrees with the literal prime
autocorrelation at every integer \(t\ge2\). Its \(O_N(t^{-2})\) decay
makes both the continuous and actual late-prime integrals absolutely
convergent. Direct integration gives

\[
 I(x,y):=\int_1^\infty\frac{t}{(tx+y)^3}\,dt
       =\frac{x+y/2}{x^2(x+y)^2}.
 \tag{2}
\]

Since the \(x,y\) integral is symmetric, the pole kernel and the two
orientations of (2) obey the pointwise identity

\[
 \frac1{xy^2}+\frac1{x^2y}-2I(x,y)-2I(y,x)
       =\frac1{xy(x+y)}.
 \tag{3}
\]

Therefore, with \(R_N(u)=\int_1^N E(x)e^{-ux}x^{-1}dx\),

\[
 \boxed{\quad
 2M_+M_- -2\int_1^\infty q_N(t)dt
  =\int_1^N\!\int_1^N\frac{E(x)E(y)}{xy(x+y)}dxdy
  =\int_0^\infty |R_N(u)|^2du\ge0.
 \quad} \tag{4}
\]

This is the source-coordinate version of the continuum Green term
already proved for the odd Weil operator in the
[continuum-prime square note](../weil-and-spectral/suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md).
It does not assert that the actual discrete prime row has this sign.

For \(Y\ge1\), interpret \(dE=d\psi-dt\) on the open interval
\((Y,\infty)\), so a prime-power atom at \(Y\) is excluded. Define

\[
 \mathcal D_{N,>Y}:=-2\int_{(Y,\infty)}q_N(t)\,dE(t),\qquad
 \mathcal P^{\rm cont}_{N,>Y}:=-2\int_Y^\infty q_N(t)dt.
 \tag{5}
\]

The actual complete Weil form consequently has the exact identity

\[
 \boxed{\quad
 Q_W(b_{\sigma_N})
   =\int_0^\infty |R_N(u)|^2du
     +\Gamma(b_{\sigma_N})+\mathcal D_{N,>1}.
 \quad} \tag{6}
\]

Equivalently, the Fourier multiplier of the first two terms is

\[
 \frac1{2\pi}\int_{\mathbb R}
 \left[\Re\psi\left(\frac54+\frac{i\xi}{2}\right)-\log\pi\right]
 |\widehat b_{\sigma_N}(\xi)|^2d\xi.
 \tag{7}
\]

Indeed the Laplace square in (4) has multiplier
\((\xi^2+1/4)^{-1}\), and the digamma recurrence shifts \(1/4\)
to \(5/4\). As the [rational pole-factor note](../weil-and-spectral/rational-scattering-pole-factor.md)
records, the shifted multiplier is still negative at \(\xi=0\).
Thus (6) is an exact localization of the remaining arithmetic
comparison, rather than a positive decomposition of the full form.

## The late residual carries another prime-error factor

Set

\[
 J_N=\int_1^N E(y)dy,\qquad
 B_N=\int_1^N y|E(y)|dy,\qquad
 U_N=\int_1^N\frac{|E(x)|}{x^4}dx,\qquad
 \varepsilon(Y)=\sup_{t\ge Y}\frac{|E(t)|}{t}.
 \tag{8}
\]

The Chebyshev estimate makes \(\varepsilon(Y)\) finite; the prime
number theorem makes it tend to zero. From the kernel identity in
the [double-scale note](terminal-heat-double-scale-prime-lag-obstruction.md),

\[
 q_N(t)=\frac{J_NT_N+L_N(t)}{t^2},\quad
 T_N=2\int_1^N\frac{E(x)}{x^3}dx,\quad
 L_N(t)=\int_1^N E(y)
  [K_N(y/t)-K_N(0)]dy,
 \tag{9}
\]

where \(K_N(s)=2\int_1^N E(x)(x+s)^{-3}dx\). Differentiation gives
\(\|K_N'\|_{L^\infty[0,1]}\le6U_N\), and hence

\[
 |T_N|\le C,\qquad
 |L_N(t)|\le\frac{6U_NB_N}{t},\qquad
 |L_N'(t)|\le\frac{6U_NB_N}{t^2}
 \quad(t\ge Y\ge N).
 \tag{10}
\]

Stieltjes integration by parts, using right-continuous \(E(Y)\) and
\(q_N(t)E(t)\to0\), is exact:

\[
 \mathcal D_{N,>Y}
 =2E(Y)q_N(Y)+2\int_Y^\infty E(t)q_N'(t)dt.
 \tag{11}
\]

Combining (9)--(11) with \(|E(t)|\le\varepsilon(Y)t\) proves the
source-sensitive estimate

\[
 \boxed{\quad
 |\mathcal D_{N,>Y}|
 \le C\varepsilon(Y)
 \left(\frac{|J_NT_N|}{Y}+\frac{U_NB_N}{Y^2}\right)
 \le C'\varepsilon(Y)
 \left(\frac{|J_N|}{Y}+\frac{B_N}{Y^2}\right)
 \qquad(Y\ge N).
 \quad} \tag{12}
\]

At \(Y=N\), Chebyshev gives \(|J_N|=O(N^2)\) and
\(B_N=O(N^3)\), so (12) is \(O(N\varepsilon(N))=o(N)\)
unconditionally by the prime number theorem. Assuming RH only
for comparison, the standard bound \(E(t)\ll t^{1/2}\log^2(2t)\)
would make (12) \(O(\log^4(2N))\). Neither statement supplies an
unconditional square-root-scale bound for this signed residual.

## The continuous tail at \(Y=N\) still oscillates

Let \(K(s)=2\int_1^\infty E(x)(x+s)^{-3}dx\), and for
\(0\le r\le1\) put

\[
 \Phi_N(r)=\frac1r\int_0^rK_N(s)ds,\qquad
 \Phi(r)=\frac1r\int_0^rK(s)ds,
 \tag{13}
\]

with their continuous values at \(r=0\). Changing variables
\(s=y/t\) in the continuous tail gives

\[
 \mathcal P^{\rm cont}_{N,>N}
   =-\frac2N\int_1^N E(y)\Phi_N(y/N)dy
   =-\frac2N\int_1^N E(y)\Phi(y/N)dy+O(1).
 \tag{14}
\]

The error follows from \(\|K_N-K\|_{C[0,1]}=O(N^{-1})\) and
\(\int_1^N|E(y)|dy=O(N^2)\). The endpoint of the fixed kernel is
strictly negative. Chebyshev's bound also makes \(\Phi\) continuously
differentiable on \([0,1]\), including at zero. With the positive
factorial potential \(F\)
from equation (13a) of the terminal trace, \(E(x)=-x^2F'(x)\)
almost everywhere, \(F(1)=0\), and \(F(x)>0\) for \(x>1\). Hence

\[
 \begin{aligned}
 \Phi(1)
 &=\int_1^\infty E(x)
        \left(\frac1{x^2}-\frac1{(x+1)^2}\right)dx\\
 &=-2\int_1^\infty\frac{xF(x)}{(x+1)^3}dx<0.
 \end{aligned}
 \tag{15}
\]

For \(L_\Phi(X)=\int_1^X E(y)\Phi(y/X)dy\), Fubini gives, for
\(\Re s>1\),

\[
 \int_1^\infty L_\Phi(X)X^{-s-2}dX
 =m_\Phi(s)\left(
   \frac{-\zeta'(s)}{s\zeta(s)}-\frac1{s-1}\right),
 \qquad m_\Phi(s)=\int_0^1r^s\Phi(r)dr.
 \tag{16}
\]

The same positive-Mellin Landau argument as equations (9)--(11) of
the [double-scale note](terminal-heat-double-scale-prime-lag-obstruction.md)
applies. Integration by parts and the Riemann--Lebesgue lemma give

\[
 m_\Phi(1/2+i\gamma)
 =\frac{\Phi(1)+o(1)}{3/2+i\gamma}
 \quad(|\gamma|\to\infty),
 \tag{17}
\]

so high Hardy zeros are not cancelled. As before, real-axis
regularity of the Mellin transform and
\(|L_\Phi(X)-L_\Phi(\lfloor X\rfloor)|=O(X)\) yield

\[
 \boxed{\quad
 \mathcal P^{\rm cont}_{N,>N}
   =\Omega_\pm(N^{1/2-\delta})
   \quad\text{for every }0<\delta<1/2.
 \quad} \tag{18}
\]

Equation (18) concerns only the continuous-density part. Equation
(12) is too weak unconditionally to transfer its signs to the
actual prime tail at \(Y=N\). Under RH, its \(O(\log^4N)\) bound
would transfer (18), giving the conditional actual-tail assertion
\(\mathcal P_{>N}(\sigma_N)=\Omega_\pm(N^{1/2-\delta})\).
This conditional diagnostic cannot prove RH. The complete form still
contains the early arithmetic residual and the shifted gamma term
in (6), both of which are required for a signed comparison.

## The actual arithmetic residual has no fixed late sign

There is an unconditional sign obstruction for the isolated residual
when the packet \(N\) is fixed and the cutoff \(Y\) tends to infinity.
Define

\[
 \Delta_2(Y)
 :=\int_{(Y,\infty)}t^{-2}dE(t)
 =\sum_{k>Y}\frac{\Lambda(k)}{k^2}-\frac1Y.
 \tag{19}
\]

For \(\Re s>1\), absolute Fubini gives its exact Mellin transform

\[
 \int_1^\infty\Delta_2(Y)Y^{1-s}dY
 =\frac{D(s)-D(2)}{2-s},\qquad
 D(s)=\frac{-\zeta'(s)}{\zeta(s)}-\frac1{s-1}.
 \tag{20}
\]

The apparent singularities at \(s=1,2\) are removable.
At every nonreal critical-line zeta zero \(\rho\), the right side
has a pole with nonzero residue; its denominator \(2-\rho\) cannot
cancel that pole. It is holomorphic on the real interval
\([1/2,1]\). Also \(\Delta_2(Y)=O(Y^{-1})\) by Chebyshev.
The positive-Mellin Landau argument used above, now adding
\(C Y^{-3/2-\delta}\) to either sign, proves

\[
 \Delta_2(Y)=\Omega_\pm(Y^{-3/2-\delta})
 \qquad(0<\delta<1/2).
 \tag{21}
\]

The variation between neighboring integer cutoffs is
\(O(\log(2Y)/Y^2)\): between integers only the continuous density
changes, and crossing a prime-power endpoint changes (19) by
\(\Lambda(k)/k^2\). Thus both signs in (21) occur along integer
cutoffs as well.

For each fixed integer \(N\ge2\), the first-moment expansion in the
[terminal trace](actual-terminal-heat-prime-trace-phase.md) gives
\(q_N(t)=J_NT_Nt^{-2}+O_N(t^{-3})\). The same note proves
\(J_N\ne0\) and \(T_N<0\) at every such \(N\). Since the total
variation of \(dE\) against \(t^{-3}\) beyond \(Y\) is
\(O(\log(2Y)/Y^2)\), equation (5) yields

\[
 \boxed{\quad
 \mathcal D_{N,>Y}
 =-2J_NT_N\Delta_2(Y)
   +O_N\!\left(\frac{\log(2Y)}{Y^2}\right)
 =\Omega_\pm(Y^{-3/2-\delta})
 \quad(N\text{ fixed},\ 0<\delta<1/2).
 \quad} \tag{22}
\]

This is an actual complete-von-Mangoldt sign oscillation after
continuous-density subtraction, not a modeled prime measure.
The order of limits is fixed packet first, then late cutoff; it
does not prove an actual-tail sign at the coupled cutoff \(Y=N\)
or a sign for (6).

The source, full prime normalization, and compact-to-decaying-form
extension are justified in the linked terminal trace and double-scale
notes. This is written mathematics; no Lean formalization is claimed.
