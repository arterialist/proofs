# Bost–Connes local occupations and the signed Weil diagonal

Written operator calculation for the actual Riemann zeta factors, 17 September
2026. It identifies a necessary signed term in a natural positive-square
realization of the prime trace. It does not prove Weil positivity or RH, and
does not construct a Hilbert-space map from the Bost–Connes system to adelic
cyclic cohomology.

## Exact Euler occupation data

For a prime \(p\), put \(H_p e_j=j(\log p)e_j\) on
\(\ell^2(\mathbb N_0)\). Its local partition function and thermal mean are

\[
 Z_p(\beta)=\operatorname{Tr}e^{-\beta H_p}
   =(1-p^{-\beta})^{-1},\qquad
 \frac{\operatorname{Tr}(H_p e^{-\beta H_p})}{Z_p(\beta)}
   =-\partial_\beta\log Z_p(\beta)
   =\sum_{k\ge1}(\log p)p^{-k\beta}.                         \tag{1}
\]

For finitely many primes these are ordinary positive trace-class Gibbs
operators at every \(\beta>0\). For \(\beta>1\), summing over all primes gives
\(-\zeta'(\beta)/\zeta(\beta)=\sum_{n\ge2}\Lambda(n)n^{-\beta}\).
The global [Bost–Connes](https://alainconnes.org/wp-content/uploads/bostconnesscan.pdf)
partition function is \(\zeta(\beta)\) in its Gibbs range \(\beta>1\).
At \(\beta=1/2\), (1) remains a valid *local*
identity, but there is no global trace-class Gibbs operator with partition
function \(\zeta(1/2)\): its literal trace \(\sum_{n\ge1}n^{-1/2}\)
diverges. The coefficients

\[
 u_n=\log n,\qquad w_n=\frac{\Lambda(n)}{\sqrt n}
 =\begin{cases}(\log p)p^{-k/2},&n=p^k,\\0,&\text{otherwise}
 \end{cases}                                                   \tag{2}
\]

are precisely the coefficientwise \(\beta=1/2\) local occupation tower.
This retains every proper prime power. Unlike the Epstein example in the
[Poisson–Epstein obstruction](adelic-poisson-epstein-euler-obstruction.md),
there is one geometric factor \((1-p^{-s})^{-1}\) at *every* prime.

## Candidate operator and exact full trace

Let \(a>0\), let \(\mathcal D_a=C_c^\infty(-a,a;\mathbb C)\), and extend
its elements by zero to \(L^2(\mathbb R)\). Write
\((R_u f)(x)=f(x-u)\), \(C_f(u)=\langle f,R_u f\rangle
=\int f(x+u)\overline{f(x)}\,dx\), and

\[
 \mathcal N_a=\{n\ge2:\log n<2a,\ \Lambda(n)>0\},\qquad
 M_a=\sum_{n\in\mathcal N_a}w_n.
\]

The endpoint choice is immaterial: \(C_f(2a)=0\). The finite direct-sum
operator

\[
 J_a f=\bigl(\sqrt{w_n}(I-R_{u_n})f\bigr)_{n\in\mathcal N_a},
 \qquad
 D_a(f)=\|J_a f\|^2
       =\sum_{n\in\mathcal N_a}w_n\|f-R_{u_n}f\|_2^2\ge0        \tag{3}
\]

is a concrete positive candidate built only from the actual Euler
occupations. Expanding each square gives the exact identity

\[
 D_a(f)-2M_a\|f\|_2^2
 =-2\sum_{n\in\mathcal N_a}w_n\Re C_f(u_n).                \tag{4}
\]

With Fourier convention
\(\widehat f(\xi)=\int_{\mathbb R}f(x)e^{i\xi x}dx\), put

\[
 \begin{aligned}
 L_\pm(f)&=\int_{\mathbb R}e^{\pm x/2}f(x)dx,\\
 P(f)&=2\Re\bigl(L_+(f)\overline{L_-(f)}\bigr),\\
 m(\xi)&=\Re\psi(1/4+i\xi/2)-\log\pi,\\
 \Gamma(f)&=\frac1{2\pi}\int_{\mathbb R}m(\xi)
                          |\widehat f(\xi)|^2d\xi.
 \end{aligned}                                                   \tag{5}
\]

The [full localized Weil formula](suzuki-prime-power-support-spectral-flow.md)
and (4) then give, on the dense test space \(\mathcal D_a\),

\[
 \boxed{Q_W(f)=P(f)+\Gamma(f)+\|J_a f\|^2
                    -2M_a\|f\|_2^2.}                          \tag{6}
\]

Thus (6) matches *both* zeta-pole evaluations, the complete gamma factor,
and the complete set of prime powers allowed by support. Parseval gives
the equivalent Fourier check

\[
 D_a(f)=\frac1{2\pi}\int_{\mathbb R}
 2\sum_{n\in\mathcal N_a}w_n(1-\cos(u_n\xi))
  |\widehat f(\xi)|^2d\xi,
\]

so the multiplier after the diagonal subtraction is exactly
\(-2\sum w_n\cos(u_n\xi)\), as in Suzuki's formula. Equation (6) is a
quadratic-form match with the adelic/Weil trace, not an identification of
\(J_a\) with the trace-class operator or cyclic-homology representation in
Connes–Consani–Marcolli. The pole form is signed as well: for a real odd
test \(L_-(f)=-L_+(f)\), so \(P(f)=-2|L_+(f)|^2\); for a real even test
it is \(+2|L_+(f)|^2\). Equations (3)–(7) are asserted on this compact
core; a noncompact centered heat packet requires separate pole and
endpoint control.

## The counterterm is forced

**Proposition.** If a scalar \(c_a\) makes
\(D_a(f)+c_a\|f\|_2^2\) equal the Weil prime contribution for every
\(f\in\mathcal D_a\), then \(c_a=-2M_a\). For any fixed nonzero
\(f\in C_c^\infty(\mathbb R)\) with support diameter below \(\log2\),
embedded into every sufficiently large window, \(D_a(f)=2M_a\|f\|_2^2\)
while its exact Weil prime contribution is zero. Moreover

\[
 M_a\sim2e^a\qquad(a\to\infty).                            \tag{7}
\]

**Proof.** Every \(u_n\ge\log2\), so such a narrow \(f\) is orthogonal
to every \(R_{u_n}f\). The right side of (4) is zero, while each square
in (3) equals \(2w_n\|f\|_2^2\). This forces the stated scalar for any
window with nonempty \(\mathcal N_a\); it is also zero when
\(\mathcal N_a=\varnothing\). For (7), let
\(\Psi(X)=\sum_{n\le X}\Lambda(n)\). The prime number theorem and partial
summation yield

\[
 \sum_{n\le X}\frac{\Lambda(n)}{\sqrt n}
 =\frac{\Psi(X)}{\sqrt X}
  +\frac12\int_1^X\Psi(t)t^{-3/2}dt
 \sim 2\sqrt X.
\]

Take \(X=e^{2a}\). Endpoint inclusion changes no asymptotic. \(\square\)

The pole and gamma terms in (5) depend only on the fixed \(f\), not on
which larger window contains it. Consequently the positive-square-only
candidate \(P(f)+\Gamma(f)+D_a(f)\) diverges like
\(4e^a\|f\|_2^2\), although the true \(Q_W(f)=P(f)+\Gamma(f)\) is
fixed. This remains true with both pole moments exactly zero: choose a
nonzero \(\eta\in C_c^\infty\) of support diameter below \(\log2\) and
\(f=(\partial_x^2-1/4)\eta\). Integration by parts gives
\(L_\pm(f)=0\), while \(f\ne0\). Thus the missing diagonal cannot be
assigned to the poles or hidden by the archimedean multiplier.

There is also an immediate sign check at the first actual Euler atom.
Choose \((\log2)/2<a<(\log3)/2\). Take a small real smooth
\(\eta\) and put \(g=(\partial_x^2-1/4)\eta\). Place \(g\) and its
translate \(R_{\log2}g\) inside \((-a,a)\), with disjoint supports.
For \(f_\pm=g\pm R_{\log2}g\), only \(n=2\) is
admitted and \(C_{f_\pm}(\log2)=\pm\|g\|_2^2\). Hence the prime
piece of the *actual* Weil trace is respectively
\(\mp2(\log2)/\sqrt2\,\|g\|_2^2\). The local occupation weight is
positive, but the trace of its translation is signed even on pole-null
tests. This statement concerns the prime piece; the full \(Q_W\) also
contains \(\Gamma\).

## Where geometric positivity would have to enter

Connes–Consani–Marcolli compare the Bost–Connes cooling sum with the
adelic reduction map in their equations (3.14)–(3.16), then express the
explicit formula as a trace on an adelic cyclic-homology cokernel in
Theorem 6.1. For \(K=\mathbb Q\), its discriminant term vanishes
because the discriminant is \(1\); (5) omits no conductor term.
Their Proposition 6.2 states that positivity of the
resulting trace pairing for all tests is equivalent to RH for the
corresponding Hecke \(L\)-functions. The positive local Gibbs traces
in (1) therefore do not provide positivity of that quotient pairing:
the signed diagonal in (6), the two-pole term, and the archimedean
distribution remain to be compensated *together*.

This does not conflict with [Zhu's certified positivity on
\([-0.8,0.8]\)](https://arxiv.org/abs/2608.24827): the counterterm is
already present when the first prime enters at \(a=(\log2)/2\), and
the complete form can still be positive on a fixed window. It also
does not contradict the [theta ground-state identity](../theta-and-heat/theta-weil-jump-form.md)

\[
 Q_W(\Phi h)=E_{\rm arch}(h)+E_{\rm prime}(h)-E_{\rm pole}(h).
\]

There the radical identity \(Q_W(\Phi,\Phi|h|^2)=0\) cancels diagonal
terms across the *complete* form; the positive prime jumps are paid
against a signed pole energy. The sharp comparison
\(E_{\rm arch}+E_{\rm prime}\ge E_{\rm pole}\) on every compact smooth
\(h\) remains RH-equivalent and unproved. A successful Bost–Connes to
adelic positivity argument would need a source-specific operator or
intersection inequality controlling that complete compensation. The
Euler occupation signs alone are insufficient.

Primary sources: [Bost–Connes, *Hecke algebras, type III factors and
phase transitions*](https://alainconnes.org/wp-content/uploads/bostconnesscan.pdf);
[Connes–Consani–Marcolli, *The Weil proof and the geometry of the
adeles class space*, §§3, 6](https://arxiv.org/pdf/math/0703392);
[Suzuki, *Weil's quadratic form via the screw function*, §2](https://arxiv.org/pdf/2606.09096);
[Zhu, *Weil positivity in compact windows*](https://arxiv.org/abs/2608.24827).
