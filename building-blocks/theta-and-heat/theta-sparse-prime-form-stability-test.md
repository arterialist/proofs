# Sparse prime downweighting is small in the theta jump norm

The [sparse Suzuki--Goldbach countermodel](../weil-and-spectral/suzuki-pole-normalized-sparse-prime-countermodel.md) changes high prime-base weights by factors \(\lambda_p=1-\varepsilon_j\) on disjoint bands \((X_j/2,X_j]\), and applies the same factor to every power of \(p\). Its completed first prime-clock variation has excursions below every negative \(x^\delta\) scale with \(\delta<1/2\). The deformation is also arbitrarily small as a bounded perturbation of the **original theta jump form**. This strengthens the stress test of estimates that use only positive edges and coarse operator norms; it does not give the deformed Euler product the actual zeta functional equation.

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

## The exact radical identity sees the missing weight

The actual theta form has a pointwise constraint stronger than positive edges and norm closeness. The [radical identity](theta-weil-jump-form.md#11-exact-tail-cancellation-without-a-pnt-remainder) reads
\[
 \sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 [\Phi(u+\log n)+\Phi(u-\log n)]
 =A\Phi(u)+\cosh(u/2),
\tag{9}
\]
where \(A\) is the physical archimedean operator. If the left side uses \(\Lambda_*\), its defect is the positive function
\[
 \mathcal R_*(u)
 :=A\Phi(u)+\cosh(u/2)
 -\sum_{n\ge2}\frac{\Lambda_*(n)}{\sqrt n}
 [\Phi(u+\log n)+\Phi(u-\log n)]
 =\sum_{n\ge2}\frac{\Lambda(n)-\Lambda_*(n)}{\sqrt n}
 [\Phi(u+\log n)+\Phi(u-\log n)].
\tag{10}
\]
It is strictly positive at every real \(u\) because some prime base is downweighted and \(\Phi>0\). Put \(u_j=\log X_j\). For primes \(p\in(X_j/2,X_j]\), the argument \(u_j-\log p\) lies in \([0,\log2]\), where \(\Phi\) has a positive minimum \(m_\Phi\). The ordinary PNT calculation in the countermodel therefore gives
\[
 \mathcal R_*(u_j)
 \ge m_\Phi\varepsilon_j
       \sum_{X_j/2<p\le X_j}\frac{\log p}{\sqrt p}
 \ge c_\Phi\varepsilon_j\sqrt{X_j}.
\tag{11}
\]
Dividing by \(b(u_j)=\sqrt{X_j}+X_j^{-1/2}\) shows that the prime departure-rate deficit there is at least \(c'_\Phi\varepsilon_j\). The original radical relation (9) cancels this entire defect exactly; the deformed positive form does not. The theta measure is extremely small at \(u_j\), so a bounded-operator estimate such as (6) does not encode the moving pointwise cancellation in (9).

Meanwhile the [completed first-variation calculation](../weil-and-spectral/suzuki-pole-normalized-sparse-prime-countermodel.md#construction-and-the-completed-prime-clock) gives, at \(x_j=X_j+1/2\),
\[
 r_{1,*}(x_j)\le-c_0\varepsilon_j\sqrt{X_j},
 \qquad
 r_{1,*}(x_j)/x_j^\delta\longrightarrow-\infty
 \quad(\delta<1/2).
\tag{12}
\]
Hence even a positive theta form with the same domain, all prime-power shifts, and arbitrarily small bounded-operator distance from the actual theta form need not control that Suzuki first-variation scale. The exact radical identity is one actual-zeta constraint that excludes this deformation; using it quantitatively in the signed covariance argument remains open. The deformed form is a comparison object, not an alternative representation of the actual completed zeta function. These operator estimates are written mathematics; no new Lean theorem or RH claim is made here.
