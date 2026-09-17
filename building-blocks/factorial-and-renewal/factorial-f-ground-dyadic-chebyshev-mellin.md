# Dyadic Chebyshev discrepancy: exact Mellin poles versus moving F-ground weighting

**Status:** Written analytic implication and model obstruction; no RH proof or Lean formalization.

RH Agent3 implication audit, 2026-09-16. Let \(D(x)=2\psi(x)-\psi(2x)=2E(x)-E(2x)\), \(E=\psi-x\). This note preserves the lower endpoint \(x\ge1\), every prime power, and the exact factorial \(F\)-correction in the moving weighted correlation of the checked actual spatial-jump calculation. It proves no new bound or RH claim.

## Mellin transform and the lower endpoint

For \(\Re z>1\), \(\psi(x)=\sum_{p^k\le x}\log p\), including all proper prime powers, and termwise integration gives
\[
\int_1^\infty\psi(x)x^{-z-1}dx
=\frac1z\sum_{n\ge2}\frac{\Lambda(n)}{n^z}
=-\frac1z\frac{\zeta'(z)}{\zeta(z)}. \tag{1}
\]
On \(1\le u<2\), \(\psi(u)=0\). Thus the change of variables \(u=2x\) loses no ordinary integral at the lower endpoint: the value \(\psi(2)=\log2\) at the single point \(u=2\) has measure zero. Consequently
\[
\boxed{\displaystyle
\mathcal M D(z):=\int_1^\infty D(x)x^{-z-1}dx
=\frac{2-2^z}{z}\left(-\frac{\zeta'(z)}{\zeta(z)}\right),
\qquad \Re z>1.} \tag{2}
\]
The \(n=2\) term is included correctly: in the direct indicator proof its negative interval starts at \(x=n/2=1\). More explicitly,
\(D(x)=\sum_{n\ge2}\Lambda(n)[2\mathbf1_{x\ge n}-\mathbf1_{x\ge n/2}]\) for \(x\ge1\), with the usual harmless convention at isolated endpoints; each \(n\) contributes \((2-2^z)\Lambda(n)n^{-z}/z\).

One must **not** obtain (2) by multiplying the Mellin transform of \(E\) by \(2-2^z\) without a boundary correction. Indeed \(E(u)=-u\) on \([1,2)\), and
\[
\int_1^\infty E(x)x^{-z-1}dx
=-\frac{\zeta'(z)}{z\zeta(z)}-\frac1{z-1},\quad
\int_1^2 E(u)u^{-z-1}du
=-\frac{1-2^{1-z}}{z-1}. \tag{3}
\]
The dilation formula is
\(\int_1^\infty E(2x)x^{-z-1}dx
=2^z[\mathcal M E(z)-\int_1^2E(u)u^{-z-1}du]\); substituting (3) cancels its apparent extra \((z-1)^{-1}\) term and recovers (2). This records the pole/archimedean subtraction and the \(x=1\) endpoint exactly.

The factor \(2-2^z\) has a simple zero at \(z=1\), canceling the simple pole of \(-\zeta'/\zeta\) there; (2) continues to the finite value \(\mathcal M D(1)=-2\log2\). Its other zeros are \(z=1+2\pi i k/\log2\), all on \(\Re z=1\). At a nontrivial zero \(\rho\) of \(\zeta\), of multiplicity \(m_\rho\), the meromorphic continuation of (2) has residue
\[
\operatorname*{Res}_{z=\rho}\mathcal M D(z)
=-\frac{m_\rho(2-2^\rho)}{\rho}\ne0, \tag{4}
\]
because \(0<\Re\rho<1\) makes \(2^\rho\ne2\). Thus **no off-line or critical-line nontrivial zero pole is canceled**. Trivial-zero poles at \(-2,-4,\ldots\) are likewise not canceled. The factor \(1/z\) introduces a separate continuation singularity at \(z=0\), which is not a zeta-zero pole.

## Pointwise bounds are already zero-free statements

If \(D(x)=O(x^\theta)\) for some \(\theta<1\), the integral in (2) is holomorphic on \(\Re z>\theta\); by (4), \(\zeta\) has no zeros in that half-plane. In particular, the family \(D(x)=O_\epsilon(x^{1/2+\epsilon})\) for every \(\epsilon>0\) implies RH. There is also an exact real-variable inversion, requiring no Mellin continuation. Iterating \(D(x)=2E(x)-E(2x)\) gives
\[
E(x)=\sum_{j=0}^{K-1}2^{-j-1}D(2^jx)
+2^{-K}E(2^Kx). \tag{5}
\]
The ordinary PNT makes the final term tend to zero as \(K\to\infty\), so
\[
\boxed{\displaystyle E(x)=\sum_{j\ge0}2^{-j-1}D(2^jx).} \tag{6}
\]
For \(\theta<1\), a pointwise \(O(x^\theta)\) bound on \(D\) transfers through the convergent geometric series to the same bound on \(E\). Conversely \(E=O(x^\theta)\) immediately bounds \(D\). Hence the all-\(\epsilon\) pointwise RH-scale bound for \(D\) is **equivalent to RH**, not an independent shortcut. The exact same equivalence holds for any fixed exponent \(\theta<1\) as a Chebyshev-error statement.

## The complete moving weighted correlation is different

For the actual shared later clock \(s=c\log(2Y-1)\), the fixed-clock spatial jump is
\(J_Y=\mathcal G_{Y,s}-\mathcal G_{2Y,s}\). Put \(x=Ye^t\), \(r_i=E(2^{i-1}x)/(2^{i-1}xF(2^{i-1}x))\), \(e_i=E(2^{i-1}x)/(2^{i-1}x)\), \(F_i=F(2^{i-1}x)\), and \(\kappa_F=\lim_{x\to\infty}F(x)=1+\gamma\). The **exact** original-ground correlation is
\[
\boxed{\displaystyle
J_Y=\int_0^\infty(r_1-r_2)
\{[1-r_1-r_2]j_s(t)^2-2j_s(t)j_s'(t)\}dt.} \tag{7}
\]
Here \(j_s=\eta_s*(t e^{-t/2}1_{t\ge0})\) contains every age history. Since \(D(x)/(2x)=e_1-e_2\), (7) can be written, without dropping the factorial correction, as
\[
J_Y=\frac1{2\kappa_F}\int_0^\infty
\frac{D(Ye^t)}{Ye^t}[j_s^2-2j_sj_s']dt+\mathcal R_Y, \tag{8}
\]
\[
\boxed{\begin{aligned}
\mathcal R_Y=\int_0^\infty\Big\{&
\big[e_1(F_1^{-1}-\kappa_F^{-1})
-e_2(F_2^{-1}-\kappa_F^{-1})\big](j_s^2-2j_sj_s')\\
&-(r_1-r_2)(r_1+r_2)j_s^2\Big\}dt.
\end{aligned}} \tag{9}
\]
The PNT-only estimate \(|\mathcal R_Y|\ll\delta_Y^2/s\) can be larger than the heavy-age target, so a sharp theorem must retain (7) or control (9) with the **same moving weight**. The correlation is signed and nonlocal; a power bound for this one complete moving observable is not a pointwise bound on \(D\).

Even its leading linear part attenuates a potential power mode. If \(D(x)\) has a term \(a_\rho x^\rho\) with \(\Re\rho<1\), its contribution to the first integral of (8), after integrating \(-2j_sj_s'=-(j_s^2)'\) by parts, is
\[
\frac{a_\rho\rho}{2\kappa_F}Y^{\rho-1}
\int_0^\infty e^{(\rho-1)t}j_s(t)^2dt. \tag{10}
\]
For an explicit-formula zero term, \(a_\rho=-(2-2^\rho)/\rho\), so the coefficient simplifies to \(-(2-2^\rho)/(2\kappa_F)\) times the weighted Laplace integral. The factor \(2-2^\rho\) is nonzero, but the **kernel** Laplace integral can be small or vanish at complex frequencies, and \(s\) grows with \(Y\). Neither nonvanishing nor an inverse estimate is supplied by the positivity of the clock law or by (7). Equation (9) adds a nonlinear ground correction. Thus a bound \(|J_Y|\ll Y^{-\eta}s^{-2}\) for one fixed \(\eta>0\), although independently useful for the signed block calculation, does not by itself yield a stated zero-free strip or RH.

There is a structural model showing why an unspecified power \(\eta>0\) is too weak. Choose \(1/2<\beta<1\), a small \(a>0\), and
\[
E_*(x)=a x^\beta,\quad
F_*(x)=F_\infty+\frac{a}{1-\beta}x^{\beta-1}>0,
\quad F_*'=-E_*/x^2. \tag{11}
\]
Its dyadic discrepancy is \(D_*(x)=a(2-2^\beta)x^\beta\), with a Mellin pole at \(z=\beta>1/2\). Yet its exact ground score has \(|r_*(x)|\ll a x^{-(1-\beta)}\). Put \(\delta=1-\beta>0\). Weighted Young convolution for the complete law gives
\[
\|e^{-\delta t/2}j_s\|_2
+\|e^{-\delta t/2}j_s'\|_2
\ll_\delta e^{-s\Phi(\delta/2)}, \tag{12}
\]
since \(j_s=\eta_s*j_0\), \(j_s'=\eta_s*j_0'\), and \(\int e^{-\delta v/2}\eta_s(dv)=e^{-s\Phi(\delta/2)}\). Applying (12) directly to the exact score (7) yields
\[
|J_Y^*|\ll_{a,\beta,c}
Y^{-\delta}e^{-2s\Phi(\delta/2)}
\ll Y^{-\delta-2c\Phi(\delta/2)}, \tag{13}
\]
and hence \(|J_Y^*|\ll Y^{-\eta}s^{-2}\) for every fixed \(\eta<\delta+2c\Phi(\delta/2)\). This is **not** an arithmetic counterexample: \(dE_*\) is not \(d\psi-dx\). It proves that a generic ground-coupled moving-weight power bound can coexist with an off-critical power pole. For the actual primes, a zero-free deduction would require an additional nonvanishing/inversion theorem for the complete moving kernel, with (9) controlled, or a strong enough family of weights to recover pointwise \(D\). No such theorem is supplied here.
