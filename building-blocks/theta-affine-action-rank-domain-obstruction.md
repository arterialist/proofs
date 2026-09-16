# Why a further affine action rank needs an operator-domain theorem

The actual conditional-edge formula gives a finite, strictly positive residual at the bounded comparison optimizer. A tempting next step is to match the action of the full ground clock on that optimizer by another positive rank. The form-domain theorem alone does not permit this step. This note gives the exact domain criterion and identifies the missing regularity in the actual theta profiles. It does not estimate the residual or the Suzuki allowance.

Use the notation of [conditional edge energy](theta-affine-comparison-conditional-edge-energy.md): on the real Hilbert space \(H=L^2(\gamma)\), the full selfadjoint clock is \(K\), the bounded positive comparison is \(M=\widehat M\), and
\[
 K\ge M\ge aI>0,\qquad V=D(K^{1/2}),\qquad
 n[x,z]=k(x,z)-\langle Mx,z\rangle\quad(x,z\in V).
\tag{1}
\]
The nonnegative form \(n\) is closed because subtracting the bounded form of \(M\) from the closed form of \(K\) preserves closedness. Its operator is \(A=K-M\), with \(D(A)=D(K)\). Let \(v=v_U\in V\) be the actual affine comparison optimizer. The strictness theorem gives \(d=n[v]>0\).

## Exact criterion for the proposed rank

The formal form rank is
\[
 q_v[x,z]=\frac{n[x,v]n[v,z]}{d},\qquad x,z\in V.
\tag{2}
\]
Nonnegative-form Cauchy–Schwarz proves \(0\le q_v[x]\le n[x]\), so \(k\ge m+q_v\) **on \(V\)**. That inequality does not make \(m+q_v\) a closed comparison form. In fact
\[
 \boxed{\quad q_v\text{ is closable on }H
 \quad\Longleftrightarrow\quad v\in D(K).\quad}
\tag{3}
\]
The same equivalence holds for \(m+q_v\), where \(m[x]=\langle Mx,x\rangle\).

To prove (3), put \(\ell(x)=n[x,v]\). If \(v\in D(K)\), then \(\ell(x)=\langle x,(K-M)v\rangle\), so (2) extends to the bounded rank \(((K-M)v\otimes(K-M)v)/d\) on all of \(H\). Conversely, if \(v\notin D(K)\), the representation theorem for the closed form \(n\) says that \(\ell\) is unbounded in the \(H\) norm. Choose \(x_j\in V\) with \(\|x_j\|_H\to0\) and \(\ell(x_j)=1\). Then \(q_v[x_j-x_i]=0\) for every pair, but \(q_v[x_j]=1/d\). This violates the closability criterion. Since \(m\) is bounded, \((m+q_v)[x_j-x_i]\to0\) while \((m+q_v)[x_j]\to1/d\), proving the last assertion.

Likewise, any bounded operator rank \(B\) claimed to match the action at \(v\), in the weak sense
\[
 k(v,x)=\langle(M+B)v,x\rangle\qquad(x\in V),
\tag{4}
\]
already implies \(v\in D(K)\) by the operator representation theorem. Thus replacing (2) by a different bounded finite-rank formula cannot bypass the missing domain step. None of this rules out approximating \(v\) by resolvent-smoothed vectors in \(D(K)\); each such approximation still needs its own residual and affine-optimizer estimate.

## What the actual theta regularity proves

The [prime-profile full-form proof](theta-prime-profile-full-form-domain.md) establishes \(w_p\in V\) and \(v_U\in V\), which is exactly what the conditional-edge estimator needs. It does not establish \(w_p\in D(K)\) or \(v_U\in D(K)\). There is a useful exact test for the first upgrade. The actual sign action and the continuous-profile domain theorem give
\[
 K\varepsilon=a\varepsilon+w_c+w_p,
 \qquad \varepsilon,w_c\in D(K).
\]
Consequently
\[
 \boxed{\quad w_p\in D(K)
 \quad\Longleftrightarrow\quad \varepsilon\in D(K^2).\quad}
\tag{5}
\]
Neither side of (5) follows from the proved \(\varepsilon\in D(K^{3/2})\).

The physical form proof explains why simply repeating its estimates does not give (5). After conjugation, the original theta operator has the form \(\omega A\omega-K_p\), where \(\omega=\sqrt{\Phi/(2\cosh(u/2))}\), \(K_p\) is bounded, and \(A\) is the logarithmic Fourier multiplier. For \(g=\Phi\psi\), the original operator-domain equation controls \(\omega Ag\in L^2(du)\); the physical form theorem controls \(g\in D(A^{1/2})\). Neither statement alone controls \(Ag\in L^2(du)\), since \(\omega\) vanishes rapidly at infinity. Hard cutoffs and bounded smooth multipliers preserve the physical form domain, but do not supply a derivative of logarithmic order. The full-eigenvector smoothness theorem in [jump eigenfunction regularity](theta-jump-eigenfunction-regularity.md#16-weighted-translations-give-smoothness-and-strip-schwartz-decay) uses a homogeneous equation across the whole line. The killed ground has a hard boundary and a nonzero core-arrival source, so that theorem cannot be applied to it unchanged.

An action-matched affine rank therefore requires a new actual-theta theorem proving \(v_U\in D(K)\), or a different quantitative bound for \(n[v_U]\) that stays within the known form domain. Criterion (3) is a domain obstruction to the proposed rank, not a claim that the actual optimizer lies outside \(D(K)\). The remaining conditional variance and its arithmetic size are open.
