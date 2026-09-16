# The critical mean-square law for the centered Goldbach heat source

RH Proof, 17 September 2026. This sharpens the growth-exponent criterion in [the centered heat note](critical-heat-lyapunov-exponent.md) for the **actual** von Mangoldt sequence. It is a conditional exact mean law and an equivalent arithmetic test for RH, not an unconditional upper bound. All prime powers, the initial coefficient and the continuous centering remain present. No linear-independence or zero-simplicity hypothesis is used.

Put
\[
C(t)=\sum_{n\ge1}\Lambda(n)e^{-nt}-(1+t^{-1})e^{-t},\qquad
b(v)=e^{-v/2}C(e^{-v}),\qquad
\mathscr A(T)=1+\int_0^T|b(v)|^2\,dv.
\tag{1}
\]
Let \(\mathcal Z\) denote the **distinct** nontrivial zeros of \(\zeta\), and let \(m_\rho\) be the multiplicity of \(\rho\). Define the positive, absolutely convergent critical spectral mass (when RH holds)
\[
\mathcal M_{\rm crit}
 =\sum_{\rho\in\mathcal Z}m_\rho^2|\Gamma(\rho)|^2
 =\pi\sum_{\rho\in\mathcal Z}
     \frac{m_\rho^2}{\cosh(\pi\Im\rho)}.
\tag{2}
\]
The second equality uses RH and the [Gamma reflection value](https://dlmf.nist.gov/5.4.E4). The sum counts a multiple zero once, with its multiplicity squared; it does not assume simplicity. Classical zero counting and the exponential decay of \(\Gamma(1/2+i\gamma)\) make it finite. It is strictly positive because nontrivial zeros exist.

**Theorem.** For the source (1),
\[
\boxed{\quad\mathrm{RH}\quad\Longleftrightarrow\quad
       \mathscr A(T)=O(T)\quad(T\to\infty).\quad}
\tag{3}
\]
More precisely, under RH the full limit exists and is
\[
\boxed{\quad\lim_{T\to\infty}\frac{\mathscr A(T)}T
       =\mathcal M_{\rm crit}.\quad}
\tag{4}
\]
Consequently, without assuming RH, \(\limsup_{T\to\infty}\mathscr A(T)/T\) is either \(\mathcal M_{\rm crit}\) (when RH holds) or \(+\infty\) (when it fails). The second alternative follows from the contrapositive of (3); it does not assert pointwise exponential growth at every horizon.
In particular, any [rigorously verified](https://arxiv.org/html/2004.09765) critical zero \(1/2+i\gamma_0\) yields the unconditional lower bound
\(\limsup_{T\to\infty}\mathscr A(T)/T\ge2\pi/\cosh(\pi\gamma_0)>0\): under RH its conjugate pair is included in (2), and otherwise the limsup is infinite.

**Proof of the conditional limit.** The exact Mellin identity for this centering is
\[
\int_0^\infty C(t)t^{s-1}\,dt
=\Gamma(s)\left[-\frac{\zeta'(s)}{\zeta(s)}
                    -\frac{s}{s-1}\right],\qquad \Re s>1.
\tag{5}
\]
The apparent pole at \(s=1\) cancels: \(-\zeta'/\zeta\) and \(s/(s-1)\) have the same residue there. At a nontrivial zero \(\rho\), the right side instead has residue \(-m_\rho\Gamma(\rho)\), which is nonzero.

Assume RH. Mellin inversion on \(\Re s=c>1\), followed by a contour shift to \(\Re s=1/4\), crosses exactly the nontrivial zeros, all on \(\Re s=1/2\). There is no Gamma pole or trivial zeta zero in this strip. For completeness, [Riemann–von Mangoldt zero counting](https://dlmf.nist.gov/25.10) gives \(N(U+1)-N(U-1)=O(\log(U+2))\), counting multiplicity. Choose horizontal heights in successive bounded intervals a fixed inverse-logarithmic distance from every zero ordinate. The standard local-zero expression for \(\zeta'/\zeta\) then gives a polylogarithmic bound on those horizontal sides and on the zero-free line \(\Re s=1/4\); [Stirling's formula](https://dlmf.nist.gov/5.11) makes the horizontal integrals tend to zero and the new vertical integral absolutely convergent. Thus, uniformly for \(0<t\le1\),
\[
C(t)=-\sum_{\rho\in\mathcal Z}
             m_\rho\Gamma(\rho)t^{-\rho}
       +O(t^{-1/4}).
\tag{6}
\]
The zero series converges absolutely because its Gamma factors decay exponentially while the zero count grows polynomially. With \(t=e^{-v}\), (6) becomes
\[
b(v)=f(v)+O(e^{-v/4}),\qquad
f(v)=-\sum_{\rho\in\mathcal Z}
           m_\rho\Gamma(\rho)e^{i(\Im\rho)v}.
\tag{7}
\]
The series for \(f\) converges uniformly and absolutely on the whole real line. For any finite truncation, Cesàro orthogonality of distinct frequencies gives mean square equal to the sum of its squared coefficients. Uniform convergence passes this identity to \(f\), with no spacing or linear-independence assumption. The decaying remainder in (7) changes \(\int_0^T|b|^2\) by \(O(1)\): \(f\) is bounded and \(e^{-v/4}\) is integrable. Therefore \(\mathscr A(T)/T\to\sum_\rho m_\rho^2|\Gamma(\rho)|^2\), proving (4) and the forward direction of (3).

**Proof of the converse.** Suppose \(\mathscr A(T)=O(T)\). For every \(\sigma>0\), integration by parts against \(d\mathscr A(v)=|b(v)|^2dv\) gives \(\int_0^\infty |b(v)|^2e^{-\sigma v}dv<\infty\). Cauchy–Schwarz then makes \(\mathcal Lb(z)=\int_0^\infty b(v)e^{-zv}dv\) locally normally convergent and holomorphic for \(\Re z>0\). By changing variables in (5), \(\mathcal Lb(z)\) equals the Mellin expression at \(w=z+1/2\), minus the entire large-\(t\) tail \(\int_1^\infty C(t)t^{z-1/2}dt\), initially for \(\Re z>1/2\). Hence the Mellin expression continues holomorphically throughout \(\Re w>1/2\). A zeta zero in that half-plane would give its uncanceled pole \(-m_\rho\Gamma(\rho)\), a contradiction. The functional equation reflects zeros on the other side, proving RH. \(\square\)

Equation (3) strengthens the earlier polynomial \(O(T^5)\) consequence of RH for this smoothed source, and (4) identifies the exact surviving critical oscillation energy. The missing unconditional estimate is still the upper bound in (3); positivity of the centered heat square alone supplies no bound of that size. The contour argument and mean law are written mathematics, not Lean formalizations. The full RH proof and its Lean formalization remain open.
