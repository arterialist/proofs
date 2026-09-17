# Sparse prime downweighting is small in the theta jump norm

The [sparse Suzuki--Goldbach countermodel](suzuki-pole-normalized-sparse-prime-countermodel.md) changes high prime-base weights by factors \(\lambda_p=1-\varepsilon_j\) on disjoint bands \((X_j/2,X_j]\), and applies the same factor to every power of \(p\). Its completed first prime-clock variation has excursions below every negative \(x^\delta\) scale with \(\delta<1/2\). The deformation is also arbitrarily small as a bounded perturbation of the **original theta jump form**. This strengthens the stress test of estimates that use only positive edges and coarse operator norms; it does not give the deformed Euler product the actual zeta functional equation.

Keep the actual even theta kernel \(\Phi\), the continuous kernel \(r\), and \(d\nu=b\Phi\,du\), with \(b(u)=2\cosh(u/2)\). Let \(q_{\rm p}\) be the complete original prime jump rate, so the atom from \(u\) to \(u\pm\log n\) has weight
\[
 \frac{\Lambda(n)}{b(u)\sqrt n}\Phi(u\pm\log n).
\tag{1}
\]
Write \(E_{\rm c},E_{\rm p}\) for the positive continuous and prime edge forms on \(L^2(\nu)\). In the deformed rate replace \(\Lambda(p^r)\) by \(\lambda_p\Lambda(p^r)\) for every \(r\ge1\). Define
\[
 \eta=\sup_p(1-\lambda_p)=\varepsilon_1<\tfrac12,\qquad
 E_*=E_{\rm c}+E_{{\rm p},*},\qquad
 E_\Delta=E_{\rm p}-E_{{\rm p},*}.
\tag{2}
\]
All these are positive edge forms. Edgewise comparison immediately gives
\[
 \boxed{\quad
 0\le E_\Delta\le\eta E_{\rm p},\qquad
 E_{\rm c}+(1-\eta)E_{\rm p}\le E_*\le E_{\rm c}+E_{\rm p}.
 \quad}
\tag{3}
\]
Thus the deformed and original full forms have the same domain and equivalent form norms. In particular the deformation does not remove the continuous diagonal singularity or any prime-power location.

The original complete prime departure rate has a finite uniform bound
\[
 B_{\rm p}:=\sup_u q_{\rm p}(u,\mathbb R)<\infty.
\tag{4}
\]
For any \(h\in L^2(\nu)\), symmetry of \(\nu(du)q_{\rm p}(u,dv)\) and
\(|h(u)-h(v)|^2\le2|h(u)|^2+2|h(v)|^2\) give
\[
 E_{\rm p}[h]
 =\frac12\int|h(u)-h(v)|^2\nu(du)q_{\rm p}(u,dv)
 \le2B_{\rm p}\|h\|_\nu^2.
\tag{5}
\]
The prime forms are therefore bounded. If \(L,L_*\) are the nonnegative selfadjoint operators of \(E_{\rm c}+E_{\rm p}\) and \(E_*\), the representation theorem gives the exact bounded positive difference
\[
 \boxed{\quad
 0\le L-L_*\le2\eta B_{\rm p}I,\qquad
 \|L-L_*\|\le2\eta B_{\rm p}.
 \quad}
\tag{6}
\]
Choosing the first sparse band sufficiently far out makes \(\eta\), and hence this full jump-operator difference, as small as desired. The same estimate holds after hard killing on a fixed exterior domain, by restricting both edge forms to functions zero on the core. At every fixed positive spectral parameter, the resolvent identity bounds the difference of the two resolvents by this same operator norm divided by the square of that parameter. None of these fixed-scale estimates controls the moving arithmetic scale \(x^{1/2}\).

The off-diagonal physical prime-shift difference is smaller still. Its shift by \(\log n\) has coefficient bounded by
\[
 \frac{\Lambda(n)}{\sqrt n}
 \frac{\sqrt{\Phi(u)\Phi(u+\log n)}}{\sqrt{b(u)b(u+\log n)}}.
\tag{7}
\]
At least one endpoint has absolute value at least \((\log n)/2\); the theta envelope at that endpoint makes the coefficient \(O((\log n)e^{-cn})\), after harmless polynomial factors are absorbed. Every affected \(n=p^r\) satisfies \(n>X_1/2\). Summing both shift orientations therefore gives
\[
 \|K_{\rm p}-K_{{\rm p},*}\|
 \le C e^{-cX_1}.
\tag{8}
\]
The departure-multiplier change, rather than this off-diagonal term, sets the less sharp uniform bound (6).

Nevertheless the [completed first-variation calculation](suzuki-pole-normalized-sparse-prime-countermodel.md#construction-and-the-completed-prime-clock) gives, at \(x_j=X_j+1/2\),
\[
 r_{1,*}(x_j)\le-c_0\varepsilon_j\sqrt{X_j},
 \qquad
 r_{1,*}(x_j)/x_j^\delta\longrightarrow-\infty
 \quad(\delta<1/2).
\tag{9}
\]
Hence even a positive theta form with the same domain, all prime-power shifts, and arbitrarily small bounded-operator distance from the actual theta form need not control that Suzuki first-variation scale. A successful actual-zeta argument must use a constraint sensitive to the exact Mangoldt amplitudes or their completed functional equation. The deformed form is a comparison object, not an alternative representation of the actual completed zeta function. These operator estimates are written mathematics; no new Lean theorem or RH claim is made here.
