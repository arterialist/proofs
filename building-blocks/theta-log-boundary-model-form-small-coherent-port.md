# Log-boundary model and form-smallness of the coherent theta port

This note tests oscillatory and multiscale concentration at the two hard
boundaries of the radius-two core. Unlike the pulled Jensen weight, the
original coherent port is compact relative to the killed core form. Its
boundary model has a Carleman convolution for the continuous crossing and a
bounded diagonal for the full prime comb. The killed supply has a confining
logarithmic position weight and logarithmic frequency growth. No boundary
counterexample survives these two costs.

The conclusion is local to the boundary mechanism. It does not prove the
global coefficient-one inequality on the remaining compact phase-space
block, and therefore does not prove RH.

## 1. Exact adjacent continuous model

At the positive endpoint write

\[
 d=2-v>0,\qquad y=u-2>0,\qquad
 s=\log(1/d),\qquad t=\log(1/y).                         \tag{1}
\]

The conjugated continuous crossing kernel from core \(L^2(\nu)\) to
exterior \(L^2(\nu)\) is

\[
 \omega(u)\omega(v)r(u-v),\qquad
 \omega^2=\frac{\Phi}{b}.                                \tag{2}
\]

Since \(r(d+y)\sim[2(d+y)]^{-1}\), its endpoint principal part is

\[
 \frac{c_*}{d+y},\qquad
 c_*=\frac{\Phi(2)}{2b(2)}.                              \tag{3}
\]

Use the exact logarithmic unitaries
\(f(s)=e^{-s/2}x(2-e^{-s})\) and
\(g(t)=e^{-t/2}h(2+e^{-t})\), with the smooth density factors from
\(d\nu\) included as in the preceding note. The principal crossing becomes

\[
 (\mathcal Kf)(t)
 =c_*\int_{\mathbb R}
   \frac{f(s)}{2\cosh((t-s)/2)}\,ds.                     \tag{4}
\]

The omitted coefficient errors tend to zero on translated collars and give
compact operators after fixed collar cutoffs. With the Fourier convention
\(\widehat f(\xi)=\int e^{-i\xi s}f(s)ds\),

\[
 \boxed{\quad
 \widehat{\mathcal Kf}(\xi)
 =c_*\frac{\pi}{\cosh(\pi\xi)}\widehat f(\xi).
 \quad}                                                  \tag{5}
\]

Thus the adjacent continuous port smooths Mellin oscillations
exponentially. This is stronger than the \(L^2\) Carleman norm bound
\(\|\mathcal K\|\le c_*\pi\).

The port measure contributes the ground factor

\[
 \frac{\psi _2(2+e^{-t})}{\rho(2+e^{-t})}
 \asymp t^{-1/2}.                                       \tag{6}
\]

Consequently the continuous boundary port is modeled by

\[
 q_{\rm c}[f]
 \asymp \int_{t\gg1}t^{-1/2}|(\mathcal Kf)(t)|^2dt.      \tag{7}
\]

The operator \(M_{t^{-1/4}}\mathcal K\) is compact on the boundary
half-line. To see this directly, truncate the output to \(t\le T\). The
resulting kernel is square-integrable because
\((2\cosh((t-s)/2))^{-1}\in L^2(ds)\). On \(t>T\), its operator norm is at
most \(T^{-1/4}\|\mathcal K\|\), which tends to zero. This proves compactness
without assigning a pointwise bound to the input.

The negative endpoint gives the reflected copy of (4). Continuous maps
between opposite endpoints have a smooth separated kernel and are compact.
Thus the two-endpoint principal continuous model is block diagonal.

## 2. Killed supply in position and Mellin frequency

The killed continuous core form contains the positive boundary potential

\[
 \kappa_C(2-d)\ge c_0\log(1/d)-C_0.                      \tag{8}
\]

Under (1), this gives

\[
 E_C[x]\ge
 c_0\int_{s\gg1}s|f(s)|^2ds-C_0\|f\|^2.                 \tag{9}
\]

The internal archimedean kernel has physical singularity
\(|v-w|^{-1}\). Its high-frequency symbol is
\(\log(2+|\zeta|)+O(1)\). A Mellin wave
\(e^{i\xi s}\) localized near \(s=S\) has physical frequency of size
\(e^S(1+|\xi|)\). Its supply therefore has the phase-space lower order

\[
 S+\log(1+|\xi|).                                       \tag{10}
\]

Equation (10) has two consequences.

First, translating a fixed profile to \(s=S\) costs at least \(cS\), even
without oscillation. Second, keeping \(S\) fixed and sending the Mellin
frequency to infinity costs \(\log(1+|\xi|)\). The continuous port multiplier
in (5) decays exponentially in that frequency. There is no \(H^{1/2}\)
boundary derivative here; logarithmic frequency growth and the position
potential together supply compactness.

## 3. Boundary model of the complete prime comb

Each prime branch translates a core boundary collar to a neighborhood of

\[
 u_{\sigma,n}=2+\sigma\log n,
 \qquad \sigma=\pm1,\quad |u_{\sigma,n}|>2.              \tag{11}
\]

For a fixed finite branch set, these neighborhoods are disjoint on a
sufficiently deep collar. Branches from opposite endpoints are also
disjoint: equality of their centers would force a rational number to equal
\(e^4\).

The weighted prime crossing tail converges in operator norm with every prime
power retained. Taking a finite branch set first and then removing its tail
shows that the prime Gram on the positive and negative boundary sectors has
the operator-norm asymptotic

\[
 B_{\rm p}^*Q B_{\rm p}
 =P_{\rm edge}I+o(1)                                    \tag{12}
\]

as the collar moves to \(s>S\). Here

\[
 P_{\rm edge}
 =\frac{\Phi(2)}{a\,b(2)}
 \sum_{n\ge2}\frac{\Lambda(n)^2}{n}
 \sum_{\substack{\sigma=\pm1\\|2+\sigma\log n|>2}}
 e^{|2+\sigma\log n|/2}G(2+\sigma\log n)>0.              \tag{13}
\]

This is the same complete diagonal obtained from one-scale packets. It
contains both orientations and all proper prime powers. The prime boundary
model does not smooth Mellin oscillations, but it is bounded. The supply
symbols (9)--(10) make this bounded identity compact relative to the form.

Mixed continuous-prime terms are controlled by their two positive
diagonals. Opposite-endpoint prime terms vanish in the deep-collar finite
truncations and remain small after the uniform tail is restored.

## 4. Endpoint form-smallness theorem

Let \(\mathcal H_S\) consist of even core form vectors supported in

\[
 2-|v|<e^{-S}.                                          \tag{14}
\]

The complete weighted crossing theorem supplies a fixed port ceiling

\[
 Q(Bx,Bx)\le P_0\|x\|^2,\qquad x\in L^2(C,\nu),          \tag{15}
\]

where \(P_0<\infty\) retains the continuous crossing and the full prime
series. From (8),

\[
 E_C[x]-\alpha _2\|x\|^2
 \ge(c_0S-C_1)\|x\|^2,\qquad x\in\mathcal H_S.           \tag{16}
\]

Therefore, for every \(\eta>0\), choosing

\[
 S\ge\frac{C_1+P_0/\eta}{c_0}                            \tag{17}
\]

gives the explicit tail estimate

\[
 \boxed{\quad
 Q(Bx,Bx)\le
 \eta\bigl(E_C[x]-\alpha _2\|x\|^2\bigr),
 \qquad x\in\mathcal H_S.
 \quad}                                                  \tag{18}
\]

This estimate handles arbitrary oscillation and arbitrary superpositions of
scales inside the deep collar. It does not use a packet ansatz.

For general form vectors, combine a smooth boundary cutoff with its interior
complement. The interior form embedding is compact by the established
fixed-core logarithmic Fourier estimate. The cutoff commutator is bounded,
and the port mixed block obeys Cauchy-Schwarz. Equations (17)--(18), followed
by the standard two-block Young estimate, give

\[
 \boxed{\quad
 Q(Bx,Bx)\le\eta E_C[x]+C_\eta\|x\|^2
 \qquad(x\in D(E_C)).
 \quad}                                                  \tag{19}
\]

Equivalently, the coherent port form is infinitesimally form-bounded. The
same localization proves that

\[
 x\longmapsto Bx/\rho:
 (D(E_C),\|\cdot\|_{E_C})\longrightarrow L^2(\gamma)     \tag{20}
\]

is compact. This recovers the previously established compact weighted
crossing theorem while identifying its boundary mechanism:

* the continuous block is a weighted compact Carleman convolution;
* the prime block is bounded but is confined by the \(s\)-potential;
* local logarithmic frequency control supplies compactness on fixed
  \(s\)-intervals.

## 5. Finite common constraints and spectral consequence

Restricting (18)--(20) to

\[
 \mathcal K_{\rm ev}
 =\ker\langle\cdot,1_C\rangle
  \cap\ker\langle\cdot,a_c\rangle
  \cap\ker J
\]

does not change any constant. Finite biorthogonal corrections also preserve
compactness because they are finite rank. Thus no oscillatory or multiscale
endpoint sequence in \(\mathcal K_{\rm ev}\) can have bounded killed supply
and a nonvanishing port norm.

The remaining coefficient-one comparison is consequently a compact
spectral problem. Any failure

\[
 Q(Bx,Bx)>E_C[x]-\alpha _2\|x\|^2                       \tag{21}
\]

must occur in a bounded position-frequency block. Endpoint escape,
Mellin-frequency escape, and prime-index escape are excluded by
(9)--(20). A validated finite Gram computation plus an explicit compact
tail estimate can decide that block. Compactness alone does not determine
its sign.

## 6. Lean artifact

lean/BoundaryFormSmallness.lean formalizes:

* conversion of a bounded port ceiling and logarithmically growing tail
  coercivity into a relative tail bound;
* an explicit cutoff condition for any prescribed relative coefficient;
* the two-block Young upper estimate; and
* preservation of form-smallness under restriction to a joint kernel.

The module compiles with Lean 4.24 and contains no sorry or new axiom. The
Carleman Fourier transform, theta ground boundary law, uniform full-prime
tail, cutoff commutator, and local compact embedding are analytic inputs
proved in the cited theta notes and the calculations above.
