# Double-scale obstruction in the terminal-compensated actual prime row

Written mathematical result, 17 September 2026. The literal compact
centered source \(\sigma_N\) and every von Mangoldt prime power are as in
the [terminal heat prime trace](actual-terminal-heat-prime-trace-phase.md).
This note gives a uniform late-prime estimate when the prime cutoff
grows with the packet, and proves that an absolute critical-scale
remainder for its fixed-packet first-moment expansion fails at the
natural lag \(k=N\). It does not sign the complete
Weil form or prove RH.
The integrated error \(J_N\) is the Goldbach \(H\) signal of
[Matsumoto–Suzuki, Proposition 6.1](https://arxiv.org/pdf/2409.00888v2)
after their explicit elementary correction; no screw property of \(H\)
is assumed.

## A uniform actual-prime tail estimate

Let \(N\ge2\) be an integer, \(E(x)=\psi(x)-x\), and let
\(q_N(k)=q_{\sigma_N}(k)\) be equation (7) of the terminal trace note,
extended by the same autocorrelation formula to real \(k>0\).
Write
\[
 J_N=\int_1^N E(x)dx,\qquad
 T_N=2\int_1^N\frac{E(x)}{x^3}dx
     =\mathcal T_{\sigma_N}(N),\qquad
 S_j(Y)=\sum_{k>Y}\frac{\Lambda(k)}{k^j}.
\]
For \(t\ge0\), put
\[
 K_N(t)=2\int_1^N\frac{E(x)}{(x+t)^3}dx.
\]
The exact cumulative-source formula (7) becomes
\[
 k^2q_N(k)=\int_1^N E(y)K_N(y/k)dy,\qquad
 T_N=K_N(0).                                             \tag{1}
\]
Chebyshev's \(\psi(x)\ll x\) gives \(|E(x)|\le Cx\). Consequently
\[
 \sup_{N\ge2,\ t\ge0}|K_N'(t)|
 \le6C\int_1^\infty x^{-3}dx<\infty,\qquad
 \int_1^N y|E(y)|dy=O(N^3).
\]
The mean-value theorem in (1) proves the uniform pointwise bound
\[
 \boxed{\quad
 \left|q_N(k)-\frac{J_NT_N}{k^2}\right|
 \le \frac{C_1N^3}{k^3}\qquad(N\ge2,\ k>0).
 \quad}                                                   \tag{2}
\]
This keeps the source's terminal atom and the complete prime-power
coefficient system; the bound uses only the unconditional Chebyshev
estimate.

Let \(\mathcal P_{>Y}(\sigma_N)=-2\sum_{k>Y}\Lambda(k)q_N(k)\)
be the actual late-prime part of the Weil trace. Every \(\Lambda(k)\)
in the sum is retained. Since \(\Lambda(k)\le\log k\), (2) gives
\[
 \boxed{\quad
 \mathcal P_{>Y}(\sigma_N)
   =-2J_NT_NS_2(Y)
     +O\!\left(N^3S_3(Y)\right),\qquad
 S_3(Y)\ll\frac{1+\log Y}{Y^2}.
 \quad}                                                   \tag{3}
\]
The prime number theorem gives \(S_2(Y)\sim1/Y\).
The [Landau argument](actual-terminal-heat-prime-trace-phase.md)
proves \(J_N=\Omega_\pm(N^{3/2-\delta})\) for every
\(0<\delta<1/2\), while \(T_N\to T_\infty<0\).
Choose \(Y_N=\lfloor N^{3/2+2\delta}\rfloor\). Along each of the
positive and negative Landau subsequences,
\[
 \frac{N^3S_3(Y_N)}
      {|J_NT_N|S_2(Y_N)}
 \ll N^{-\delta}\log N\longrightarrow0.
\]
Therefore
\[
 \boxed{\quad
 \mathcal P_{>Y_N}(\sigma_N)
    =-\frac{2J_NT_\infty}{Y_N}(1+o(1))
    =\Omega_\pm(N^{-3\delta}).
 \quad}                                                   \tag{4}
\]
The \(\Omega_+\) and \(\Omega_-\) signs occur on possibly different
integer subsequences as \(N\) and \(Y_N\) grow together. In particular the actual late-prime row is
neither eventually nonnegative nor eventually nonpositive at this
growing cutoff. Equation (4) concerns the tail only; it makes no
claim about the rest of the prime row, gamma term or poles.

## The correction at the natural lag

At \(k=N\), the first-moment expansion has no uniform absolute
remainder below the critical scale proved below. Define its exact
scaled correction
\[
 D_N=N^2q_N(N)-J_NT_N
    =\int_1^N E(y)\,[K_N(y/N)-K_N(0)]dy.              \tag{5}
\]
The argument \(k=N\) is a real-lag diagnostic. It is an actual
prime-power atom only when \(N\) itself is a prime power.

The full-source kernel
\[
 K(t)=2\int_1^\infty\frac{E(x)}{(x+t)^3}dx
     =\sum_{n\ge2}\frac{\Lambda(n)}{(n+t)^2}
       -\frac1{1+t}-\frac1{(1+t)^2},\qquad t\ge0,        \tag{6}
\]
converges absolutely, together with its derivatives on compact
\(t\)-intervals. The equality follows by Stieltjes integration by
parts from \(dE=d\psi-dx-\delta_1\), including the atom at one.
Set \(h(t)=K(t)-K(0)\) on \(0\le t\le1\), and
\[
 L(X)=\int_1^X E(y)h(y/X)dy.
\]
For \(0\le t\le1\), the same Chebyshev bound gives
\[
 |[K_N(t)-K_N(0)]-h(t)|
 \le6C t\int_N^\infty x^{-3}dx
 \ll t/N^2.
\]
Inserting \(t=y/N\) in (5) shows the unusually small uniform error
\[
 \boxed{\quad D_N=L(N)+O(1).\quad}                      \tag{7}
\]

The endpoint value of \(h\) is strictly positive by an elementary
actual-prime bound. From (6),
\[
 h(1)=\frac54-
   \sum_{n\ge2}\Lambda(n)
      \left(\frac1{n^2}-\frac1{(n+1)^2}\right).
\]
For \(n\ge2\), \(\Lambda(n)\le\log n\le n/2\) and
\((n/2)(n^{-2}-(n+1)^{-2})\le n^{-2}\). Since
\(\sum_{n\ge2}n^{-2}<1\),
\[
 \boxed{h(1)>\frac14.}                                \tag{8}
\]

For \(\Re s>1\), absolute Fubini and \(t=y/X\) give
\[
 \int_1^\infty L(X)X^{-s-2}dX
 =m_h(s)\left(\frac{-\zeta'(s)}{s\zeta(s)}
                     -\frac1{s-1}\right),\qquad
 m_h(s)=\int_0^1t^sh(t)dt.                              \tag{9}
\]
Here \(m_h\) is holomorphic around the closed strip
\(1/2\le\Re s\le1\). Integration by parts and the
Riemann–Lebesgue lemma on the logarithmic coordinate show
\[
 m_h(1/2+i\gamma)
   =\frac{h(1)+o(1)}{3/2+i\gamma}
       \qquad(|\gamma|\to\infty).                       \tag{10}
\]
Hardy's theorem supplies critical-line zeta zeros at arbitrarily
large \(|\gamma|\), so at least one of their poles in (9) is not
cancelled by \(m_h\). The apparent pole at \(s=1\) cancels, and
\(\zeta(s)\ne0\) for real \(1/2\le s<1\).
Also \(L(X)=O(X^2)\). If \(L(X)+C X^{3/2-\delta}\) were eventually
nonnegative, its Mellin convergence abscissa would lie in
\([1/2,1]\): the nonreal critical-zero pole enforces the lower
endpoint and the \(O(X^2)\) bound enforces the upper. The
positive-Mellin Landau principle would require a singularity at that
*real* abscissa, but (9) and the added pole at \(s=1/2-\delta\)
have none in \([1/2,1]\). Apply the same argument to \(-L\).
This is the argument used in (14)–(15) of the terminal trace note and yields
\[
 L(X)=\Omega_\pm(X^{3/2-\delta})
 \qquad(0<\delta<1/2).
\]
Chebyshev and bounded \(h,h'\) give
\(|L(X)-L(\lfloor X\rfloor)|=O(X)\) on unit intervals.
Since \(3/2-\delta>1\), (7) transfers both excursions to integers:
\[
 \boxed{\quad
 N^2q_{\sigma_N}(N)-J_NT_N
   =\Omega_\pm(N^{3/2-\delta})
 \quad\text{for every }0<\delta<1/2.
 \quad}                                                   \tag{11}
\]
Thus an \(o(N^{3/2-\delta})\) first-moment remainder uniformly down
to \(k=N\) is false for the actual centered source. The obstruction
is a fixed nonconstant kernel acting on the complete Chebyshev error,
not a freely chosen signal. This is an absolute remainder statement;
it does not rule out a relative asymptotic on selected subsequences
where \(J_NT_N\) is larger.

## Consequence for a geometric positivity route

Equations (3)–(4) prove that the full actual late-prime tail has
both signs at polynomially growing cutoffs where its first-moment
expansion is uniform. Equation (11) shows why that expansion cannot
simply be pushed to the packet-scale lag. This excludes a
one-sided late-tail sign as the missing compensation for the Weil
gamma and pole terms. It does not exclude a joint signed inequality
using the early prime row, gamma multiplier and both pole moments.
The complete Weil form on \(b_{\sigma_N}\) remains
\[
 Q_W(b_{\sigma_N})=
 2M_+(\sigma_N)M_-(\sigma_N)
 +\frac1{2\pi}\int_{\mathbb R}
     [\Re\psi(1/4+i\xi/2)-\log\pi]
        |\widehat b_{\sigma_N}(\xi)|^2d\xi
 +\mathcal P(\sigma_N),
 \]
with \(M_-(\sigma_N)=-F(N)\). No unconditional coercive comparison
among these three complete terms follows from the tail estimates.
For each fixed \(N\), this extension from compact tests is justified
by cutting off \(b_{\sigma_N}\) smoothly: its \(e^{-3v/2}\) positive
tail makes both pole moments converge, convergence in \(H^1\) handles
the logarithmic gamma multiplier, and
\(|C_{b_{\sigma_N}}(\log k)|\ll_N k^{-3/2}\) dominates the prime sum.

The arithmetic inputs are the prime number theorem, Chebyshev's
bound, Hardy's critical-line zeros and the standard positive-Mellin
Landau principle. The source and normalization are those of
[Suzuki's full localized Weil form](../weil-and-spectral/suzuki-prime-power-support-spectral-flow.md)
and the [terminal trace](actual-terminal-heat-prime-trace-phase.md).
This is written mathematics; no Lean formalization is claimed.
