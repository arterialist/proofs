# A rational radius-two gap and its barrier propagation

This note continues `compact-triangular-rayleigh-trial-at-radius-two.md`.
It turns the pointwise factor \(J(3)\) into a concrete integer bound, obtains
a rational lower bound for the actual killed spectral gap, and propagates it
through the parts of the existing ground barrier that do not require a new
effective prime-return calculation.  Every prime power remains in the form
used to obtain the Rayleigh numerator.

## 1. The normalization quantity

For clarity, \(J(3)\) is the point value

\[
 J(3)=\frac{b(3)}{\Phi(3)},\qquad b(t)=2\cosh(t/2),
\]

whereas the trial normalization is the integral

\[
 N=2\int_0^1J\!\left(\frac{x+5}{2}\right)\eta(x)^2\,dx.
                                                               \tag{1}
\]

Monotonicity of \(J\) on \([5/2,3]\), together with
\(\int_0^1\eta^2=1\), gives

\[
                         N\le2J(3).                            \tag{2}
\]

No normalization direction is reversed here: an upper bound for \(N\) is
what converts a fixed negative physical numerator into a lower bound for the
spectral gap.

## 2. A complete-theta lower bound for \(\Phi(3)\)

For \(u\ge1\), the actual positive theta series is

\[
 \Phi(u)=\sum_{n\ge1}2\pi n^2e^{5u/2}
       (2\pi n^2e^{2u}-3)e^{-\pi n^2e^{2u}}.                  \tag{3}
\]

All its terms are positive.  Retaining the first term at \(u=3\) gives

\[
 \Phi(3)\ge
 2\pi e^{15/2}(2\pi e^6-3)e^{-\pi e^6}.                      \tag{4}
\]

Also \(b(3)=2\cosh(3/2)<2e^{3/2}\).  Hence

\[
 J(3)
 \le\frac{e^{-6}e^{\pi e^6}}{\pi(2\pi e^6-3)}
 <e^{\pi e^6}.                                                \tag{5}
\]

The last inequality uses \(\pi>3\), \(e>2\), so the omitted denominator is
greater than one.  The [rational enclosure audit](theta-radius-two-J3-rational-upper.md)
uses short rational intervals for \(e\) and \(\pi\), followed by one exact
integer comparison, to sharpen (5) to

\[
                   \boxed{J(3)<10^{544},\qquad
                          N<2\cdot10^{544}.}                  \tag{6}
\]

The finite rational comparisons are independently executable in
`verification/theta_radius_two_J3_rational_upper_check.py`.

This estimate uses a lower bound for \(\Phi\), not the frequently used
upper theta envelope.  Using the latter would give the wrong direction for
\(J=b/\Phi\).

## 3. Concrete rational spectral gap

The triangular trial proved

\[
 \mathscr K[f]<-\frac{143}{2560},
 \qquad
 E_{O_2}[h]=\frac12N+\mathscr K[f].                           \tag{7}
\]

This numerator retained the full prime-power sum; the proof merely kept the
single positive \(n=241\) summand when taking a lower bound.  From (6)--(7),

\[
 \frac{E_{O_2}[h]}{N}
 <\frac12-\frac{143}{5120\,10^{544}}
 <\frac12-10^{-546}.                                         \tag{8}
\]

The second strict inequality is exact integer arithmetic because
\(143/5120>1/100\).  By the variational principle,

\[
 \boxed{
 d:=\frac12-\alpha_2>d_0,
 \qquad d_0:=10^{-546}.}                                     \tag{9}
\]

This is coarse but fully explicit.  It complements the existing opposite
bound \(d<10^{-20}\).

## 4. Explicit early barrier choices

The established barrier has coercivity

\[
 (A_\varepsilon-\alpha_2)w\ge\delta w,
 \qquad \delta=\frac d8.                                    \tag{10}
\]

Equations (9)--(10) give the rational bound

\[
                         \boxed{\delta>10^{-547}.}           \tag{11}
\]

The theta tail estimate already proved at radius two extends, for \(T\ge2\),
to

\[
 \nu(O_T)\le\frac{512}{5}
                   \exp\!\left[-\frac52e^{2T}\right].      \tag{12}
\]

Take \(S_0=5\).  Since \(e^5>100\), one has \(e^{10}>10^4\),
and therefore

\[
 \nu(O_5)<\frac{512}{5}e^{-25000}
          <\frac12\,10^{-546}=\frac{d_0}{2}.                 \tag{13}
\]

For the barrier amplitude requirement

\[
 M>\max\left(1,\frac{2\nu(O_2)}{d_0}\right),                \tag{14}
\]

use the established \(\nu(O_2)<10^{-47}\).  The integer choice

\[
                         \boxed{M=10^{500}}                   \tag{15}
\]

satisfies (14), since \(2\nu(O_2)/d_0<2\cdot10^{499}\).

Thus the spectral, tail, and amplitude inputs to the fixed-core barrier are
now all effective rational data:

\[
 d_0=10^{-546},\qquad \delta_0=10^{-547},
 \qquad S_0=5,\qquad M=10^{500}.                              \tag{16}
\]

## 5. Where numerical propagation presently stops

Once the barrier inequality has been completed for one explicit
\(\varepsilon\), its proved resolvent step is

\[
 \|\psi_2\|_\infty
 \le\frac{8MC_\varepsilon}{d}
 <8\cdot10^{1046}C_\varepsilon
 <10^{1047}C_\varepsilon.                                    \tag{17}
\]

The direction in (17) uses \(d>d_0\), hence \(1/d<1/d_0\).
It does not substitute the existing upper bound \(d<10^{-20}\).

The current written barrier proof still uses a qualitative prime-return
limit to choose its outer strip and then chooses \(\varepsilon\) to pay the
bounded-strip negative part.  To turn (17) into a number, two constants must
still be evaluated in this order:

1. an effective full-Chebyshev partial-summation remainder for the fixed
   barrier \(w\), producing a finite strip endpoint \(U\) and a rational
   lower bound for \((D-\alpha_2)w\) outside it;
2. a rational \(\varepsilon>0\) whose continuous logarithmic rate pays the
   negative part on \(2<|u|\le U\), followed by the explicit Schur integral
   defining \(C_\varepsilon\).

Both calculations must retain all prime powers.  They are not consequences
of the spectral gap alone, and no value of \(C_\varepsilon\) is claimed
here.  What has changed is that the previously first missing datum is now
proved: all remaining non-effectivity lies in this fixed-function
prime-return and continuous-rate calculation.

Subject only to that last calculation, (17) would feed the already proved
ground-tail estimate

\[
 \|\Phi\psi_2 1_{u<-T}\|_{\mathcal H}
 \le
 \left[C_\theta\{(\alpha_2+1)\|\psi_2\|_\infty^2\nu(O_T)
 +b_T\|\psi_2\|_\infty\sqrt{\nu(O_T)}\}\right]^{1/2}.       \tag{18}
\]

An entirely numerical version of (18) additionally needs the written
constant \(C_\theta\) and the chosen \(C_\varepsilon\).  The rational gap,
the tail cutoff, and the barrier amplitude no longer block it.

This is reviewed written analysis. The rational spectral gap and barrier substitutions remain Lean formalization obligations; the final fixed-barrier prime-return and Schur constants remain open.
