# Explicit short-interval bounds for the complete Weil form

The complete actual-zeta Weil form has a positive lower bound on every
complex smooth test supported in one interval of width at most \(1/6\).
Both pole moments are retained; no moment-null condition is imposed.
At width \(1/28\), the estimate also improves the repository's previous
gamma constant from \(4/3\) to \(19/12\). Consequently its existing
prime-power two-window theorem improves from \(23/42\) to \(67/84\).
These are restricted support estimates, with written analytic proofs
and separate Lean lemmas. They do not imply RH or improve an established
global zero-free region. No literature priority claim is made.

## Full form and parameter range

For \(f\in C_c^\infty(\mathbb R;\mathbb C)\), use
\[
\widehat f(\xi)=\int_{\mathbb R}f(x)e^{-i\xi x}\,dx,\qquad
C_f(r)=\int_{\mathbb R}\overline{f(x)}f(x+r)\,dx,
\qquad M_\pm(f)=\int_{\mathbb R}e^{\pm x/2}f(x)\,dx.
\]
The [actual full Weil form](three-window-global-pole-null-weil-bound.md) is
\[
Q(f)=\Gamma(f)+2\operatorname{Re}(M_+(f)\overline{M_-(f)})
-2\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}\operatorname{Re}C_f(\log n),
\qquad
\Gamma(f)=\frac1{2\pi}\int_{\mathbb R}
\left[\operatorname{Re}\psi(1/4+i\xi/2)-\log\pi\right]
|\widehat f(\xi)|^2\,d\xi. \tag{1}
\]
Here \(\Lambda\) is the actual von Mangoldt function, including every
proper prime power. Only finitely many integers can contribute for a
fixed compact support.

Fix **any** \(b\in\mathbb R\), \(0<w\le1/6\), and a test supported in
\(J=(b,b+w)\). Write
\[
N=\|f\|_2^2,\qquad
V_J(f)=N-\frac1w\left|\int_J f(x)\,dx\right|^2\ge0.
\]
Equivalently, \(g(t)=\sqrt w\,f(b+wt)\) on \((0,1)\) has
\(N=\|g\|_2^2\) and \(V_J=\|g-\int_0^1g\|_2^2\).
The parameter-dependent estimates are
\[
\boxed{\ \Gamma(f)\ge
\left[\log\frac1{\pi w}-\gamma_E-\frac{5w}{16}\right]N
+\frac12V_J(f),\ } \tag{2}
\]
\[
\boxed{\ Q(f)\ge
\left[\log\frac1{\pi w}-\gamma_E-\frac{5w}{16}
-2\sinh(w/2)+w\right]N+\frac12V_J(f).\ } \tag{3}
\]
In particular, for \(f\ne0\),
\[
\Gamma(f)>\frac{31}{2400}N+\frac12V_J(f),\qquad
Q(f)>\frac{143}{12000}N+\frac12V_J(f)>\frac1{100}N.
\tag{4}
\]
For \(w\le1/28\), both \(\Gamma(f)\) and \(Q(f)\) are strictly greater
than \(\frac{19}{12}N+\frac12V_J(f)\) when \(f\ne0\). All weak
inequalities also hold for the zero test. Position, phase, and profile
are unrestricted within the stated support class.

## Exact archimedean compression

Set
\[
K(r)=\frac{e^{-r/2}}{1-e^{-2r}},\qquad
\rho(r)=K(r)-\frac1{2r}\quad(r>0),\qquad \rho(0)=\frac14.
\]
The [digamma integral](https://dlmf.nist.gov/5.9.E16), with its variable
replaced by \(2r\), and Plancherel give
\[
\Gamma(f)=\lim_{\varepsilon\downarrow0}
\left\{[-\gamma_E-\log\pi-\log(1-e^{-2\varepsilon})]N
-2\int_\varepsilon^w K(r)\operatorname{Re}C_f(r)\,dr\right\}. \tag{5}
\]
For smooth tests, \(\operatorname{Re}C_f(r)=N+O(r^2)\), so the singular
terms cancel. Truncation first justifies the Fourier interchange; the
digamma integral is bounded by a constant times \(1+\xi^2\), which
is integrable against the Schwartz density \(|\widehat f|^2\).

In the normalized cell, (5) becomes the exact identity
\[
\Gamma(f)=\mathfrak b[g]+[-\log w-\log(2\pi)-\gamma_E]N
-w\iint_{(0,1)^2}\rho(w|t-s|)\overline{g(t)}g(s)\,dt\,ds, \tag{6}
\]
where
\[
\mathfrak b[g]=\frac14\iint_{(0,1)^2}
\frac{|g(t)-g(s)|^2}{|t-s|}\,dt\,ds
-\frac12\int_0^1\log(t(1-t))|g(t)|^2\,dt. \tag{7}
\]
The regular-kernel integral is real by symmetry, including for complex
profiles. To check the endpoint term and constant in (6), expanding
the difference square in (7) gives
\[
\mathfrak b[g]=\lim_{\eta\downarrow0}
\left[-\log\eta\,N-\int_\eta^1
\frac{\operatorname{Re}C_g(r)}r\,dr\right].
\]
Use \(C_f(wr)=C_g(r)\) and \(\eta=\varepsilon/w\) in (5). The two
orientations of the regular integral produce exactly the double
integral in (6).

Since \(|t-s|\le1\) and \(t(1-t)\le1/4\),
\[
\mathfrak b[g]\ge\log2\,N
+\frac14\iint|g(t)-g(s)|^2\,dt\,ds
=\log2\,N+\frac12V_J(f). \tag{8}
\]
No sign is assigned to a complex cross product.

For \(0<r\le1/6\), elementary exponential bounds give
\[
\rho(r)\ge-\frac14,
\qquad
\rho(r)\le\frac{1/4+r/16}{1-r}\le\frac5{16}. \tag{9}
\]
For the lower bound use \(1-e^{-2r}\le2r\) and
\(e^{-r/2}\ge1-r/2>0\). For the upper bound use
\(1-e^{-2r}\ge2r-2r^2>0\) and
\(e^{-r/2}\le1-r/2+r^2/8\). Thus
\[
\left|w\iint\rho(w|t-s|)\overline{g(t)}g(s)\,dt\,ds\right|
\le\frac{5w}{16}\left(\int_0^1|g|\right)^2
\le\frac{5w}{16}N. \tag{10}
\]
Combining (6), (8), and (10) proves (2).

## Both poles and all arithmetic rows

If \(n\ge2\), then \(\log n\ge\log2>1/6\ge w\). Hence the two
supports in \(C_f(\log n)\) are disjoint and **every** arithmetic term
in (1) is zero. This argument uses integer spacing, not cancellation
among primes.

Translation leaves \(\Gamma\), the correlations, and the product
\(M_+\overline{M_-}\) invariant. Center the interval at zero and set
\(A=\int\cosh(x/2)f(x)\,dx\), \(B=\int\sinh(x/2)f(x)\,dx\).
For arbitrary complex \(f\), the complete polar term is exactly
\[
2\operatorname{Re}(M_+\overline{M_-})=2|A|^2-2|B|^2
\ge-2\left(\int_{-w/2}^{w/2}\sinh^2(x/2)\,dx\right)N
=-[2\sinh(w/2)-w]N. \tag{11}
\]
Equation (11) retains both moments before dropping a nonnegative
square. It proves (3) without a pole-null assumption.

## Rational constants and a two-window improvement

Use \(\pi<22/7\), \(\gamma_E<29/50\), and
\[
\log(21/11)>129/200,\qquad \log(98/11)>109/50.
\tag{12}
\]
The logarithm bounds follow from Taylor upper enclosures for the
exponential. The Euler-constant bound follows from
\(\gamma_E<H_{256}-\log256\) and
\[
\log2>2\sum_{j=0}^4\frac1{(2j+1)3^{2j+1}}.
\]
For \(x=w/2\le1/12\), the positive odd series gives
\[
2\sinh x-2x\le\frac{x^3}{3(1-x^2/20)}<\frac1{1000}. \tag{13}
\]
The last inequality applies to positive \(w\le1/6\); the weak upper
bound also covers \(w=0\). The successive ratios of the series after
\(x^3/3\) are at most \(x^2/20\).
At the wider corner the gamma coefficient exceeds
\[
\frac{129}{200}-\frac{29}{50}-\frac5{96}=\frac{31}{2400}.
\]
Subtracting \(1/1000\) proves (4). At the narrower corner,
\[
\frac{109}{50}-\frac{29}{50}-\frac5{448}-\frac1{1000}
>\frac{19}{12}. \tag{14}
\]
The [exact rational certificate](../../certificates/actual_weil_single_window_certificate.py)
checks all these numerical corners, with its
[stored output](../../certificates/actual-weil-single-window-certificate.json).
It uses no binary floating-point comparisons.

Now let \(q=p^j\ge8\), \(d=\log q\), \(w=1/(4q)\), and take arbitrary
complex \(u,v\in C_c^\infty((-w/2,w/2))\). Set
\(f(x)=u(x+d/2)+v(x-d/2)\), and require only the two **global**
conditions \(M_+(f)=M_-(f)=0\). For \(f\ne0\),
\[
\boxed{\quad Q(f)>\frac{67}{84}\|f\|_2^2
+\frac12[V_{(-w/2,w/2)}(u)+V_{(-w/2,w/2)}(v)].\quad} \tag{15}
\]
The [complete two-window calculation](actual-prime-power-two-window-uniform-coercivity.md)
admits exactly the integer \(n=q\) between the windows. Its actual
coefficient is \(c_q=\Lambda(q)/\sqrt q<3/4\), and the gamma cross
operator has norm at most \(\kappa=wK(d-w)<1/28\). Both facts keep
proper powers. Its argument applies to complex profiles after taking
real parts and absolute values: the total cross loss is at most
\((c_q+\kappa)(\|u\|^2+\|v\|^2)\). Applying the new \(19/12\) gamma
bound to each packet proves (15), because
\[
\frac{19}{12}-\frac34-\frac1{28}=\frac{67}{84}
=\frac{23}{42}+\frac14.
\]
Global pole nulls remain essential to this two-window argument. No
individual packet moment is set to zero, and their complete cross
terms are included.

## Scope and verification

Small-support positivity has established antecedents:
[Yoshida's Hermitian-form work](https://doi.org/10.2969/aspm/02110281),
[Bombieri's interval variational analysis](https://www.bdim.eu/item?id=RLIN_2000_9_11_3_183_0),
and [Connes--Consani's archimedean trace comparison](https://arxiv.org/abs/2006.13771)
under its transform-null conditions. More recently,
[Zhu v2, Theorem 1.2 and Corollary 6.3](https://arxiv.org/html/2608.24827v2)
give a complete-form lower bound \(8.9\times10^{-18}\|f\|^2\) for
arbitrary complex tests in \([-0.8,0.8]\), without pole nulls.
That theorem already supplies positivity on the present smaller
single-interval support class after translation. The estimates here give
an explicit width law, larger short-interval constants and a variance
term. The two-window support at \(q\ge8\) lies outside that fixed
central window. A bounded primary-source comparison through 1 October
2026 supports these distinctions, without establishing priority.

The single-interval theorem is an explicit local archimedean and pole
estimate; it is independent of the values of the prime coefficients
because no integer shift overlaps that interval. The two-window
corollary uses the actual prime-power coefficient and logarithmic
integer spacing. Those inputs also apply to some bounded coefficient
models; they do not isolate a new untwisted-prime cancellation.

[ActualWeilSingleWindowCoercivity.lean](../../formalization/BuildingBlocks/ActualWeilSingleWindowCoercivity.lean)
proves the literal kernel bound in `rho_bounds` and `rho_abs_bound`,
exclusion of both integer-shift orientations and their mixed integrals,
the complex polar algebra, and the logarithm, Euler-constant and polar
coefficient bounds. In particular, `gammaCoefficient_gt` proves the
width-dependent scalar coefficient exceeds \(31/2400\), while
`narrow_corner_budget` verifies the \(19/12\) corner after the pole
payment. These statements use only standard foundational axioms.

The `single_window_*_from_analytic_inputs` and
`two_window_scalar_improvement*` declarations give scalar consequences
with the unformalized analytic inputs explicit in their hypotheses.
They do not define or construct the Fourier Weil form. The
Fourier/digamma identity (5)--(7), integral estimates (8), (10), and
(11), continuity of the assigned kernel value at zero, and complete
analytic Weil identification remain written proofs. The Python
certificate checks its own Taylor and harmonic rational corners; its
series-tail method is not a Lean proof. The infinite-dimensional
theorems (2)--(4) and (15) are therefore written analytic results with
supporting kernel-checked components, rather than complete Lean proofs.

These bounds can calibrate local compressions and packet estimates.
They do not survive arbitrary gluing without the new cross rows; a
zero-extension compression does not bound a short over a free
complement. Positivity on all compact tests, the repository's stronger
prime-error bounds, and an unconditional kernel-checked RH proof
remain open.
