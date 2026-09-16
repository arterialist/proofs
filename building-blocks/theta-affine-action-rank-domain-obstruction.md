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

## Resolvent ranks and their exact constrained gain

The last qualification has a sharp quantitative form. Put
\[
 v_\eta=(I+\eta K)^{-1}v,\quad
 r_\eta=(K-M)v_\eta,\quad
 d_\eta=n[v_\eta],\qquad \eta>0.
\tag{5}
\]
The spectral theorem gives \(v_\eta\to v\) in \(V\). Thus \(d_\eta\to d>0\), and for all sufficiently small \(\eta\) the bounded positive rank
\[
 B_\eta=\frac{r_\eta\otimes r_\eta}{d_\eta}
\]
satisfies \(K\ge M+B_\eta\) in form order and \((M+B_\eta)v_\eta=Kv_\eta\). Its residual at the **old** optimizer does tend to zero:
\[
 n[v]-\langle B_\eta v,v\rangle
 =d-\frac{|n(v_\eta,v)|^2}{d_\eta}\longrightarrow0.
\tag{6}
\]
This does not measure the gain of the affine comparison, because the optimizer changes when the rank is added.

Here is that gain exactly. Write \(q=S_q\ne0\), \(s=S_f\), and let \(v\) minimize \(\langle Mx,x\rangle-2\langle s,x\rangle\) under \(\langle x,q\rangle=-m\). Define the bounded positive constrained inverse
\[
 T=M^{-1}-\frac{(M^{-1}q)\otimes(M^{-1}q)}{\langle M^{-1}q,q\rangle},
 \qquad Tq=0.
\tag{7}
\]
If \(F_M\) and \(F_{M+B_\eta}\) are the two constrained minimum values, completing the square on the tangent space \(q^\perp\) gives
\[
 \boxed{\quad
 F_{M+B_\eta}-F_M
 =\frac{|\langle r_\eta,v\rangle|^2}
 {d_\eta+\langle r_\eta,T r_\eta\rangle}
 =\frac{|n(v_\eta,v)|^2}
 {d_\eta+\langle r_\eta,T r_\eta\rangle}.
 \quad}
\tag{8}
\]
In detail, write a feasible vector as \(v+h\) with \(h\perp q\). The old quadratic increases by \(\langle Mh,h\rangle\), and the new rank adds \(|\langle r_\eta,v+h\rangle|^2/d_\eta\). Minimizing this one-dimensional perturbation of the tangent quadratic proves (8). It retains the actual affine score constraint; replacing \(T\) by \(M^{-1}\) would be wrong.

There is a dichotomy. Since \(q\in V\),
\(\langle r_\eta,q\rangle=n(v_\eta,q)\to n(v,q)\), so the component of \(r_\eta\) parallel to \(q\) remains bounded. The variational characterization of \(T\) gives
\[
 \langle r,T r\rangle
 =\sup_{h\perp q}\{2\langle r,h\rangle-\langle Mh,h\rangle\}
 \ge\frac{\|P_{q^\perp}r\|^2}{\|M\|}.
\tag{9}
\]
If \(v\notin D(K)\), spectral monotone convergence shows \(\|Kv_\eta\|\to\infty\). Since \(M\) is bounded, \(\|r_\eta\|\to\infty\), hence (9) forces \(\langle r_\eta,T r_\eta\rangle\to\infty\). The numerator of (8) tends to \(d^2\). Therefore
\[
 \boxed{\quad v\notin D(K)
 \quad\Longrightarrow\quad
 F_{M+B_\eta}-F_M\longrightarrow0,\quad}
\tag{10}
\]
even though (6) tends to zero. If \(v\in D(K)\), then \(r_\eta\to(K-M)v\) in \(H\), and (8) tends to the finite positive gain
\[
 \frac{d^2}{d+\langle(K-M)v,T(K-M)v\rangle}.
\tag{11}
\]
The zero-gain conclusion is not specific to the resolvent. If \(u_j\in D(K)\) converges to \(v\) in \(V\), put \(r_j=(K-M)u_j\), \(d_j=n[u_j]\), and form the single rank \(r_j\otimes r_j/d_j\). The numerator in (8) again tends to \(d^2\). If \(v\notin D(K)\), the operator graph forces \(\|r_j\|\to\infty\): any bounded subsequence would have a weakly convergent action subsequence and would represent \(n(v,\cdot)\) in \(H\). As above, \(\langle r_j,q\rangle=n(u_j,q)\) remains bounded, so (9) makes the constrained denominator diverge. Every such single-rank form approximation has vanishing affine gain.

Resolvent smoothing does produce legal comparisons, but a small residual at the old trial vector is not itself a payment certificate. In the unresolved domain case these approximating single ranks become increasingly expensive in the constrained inverse denominator and yield no limiting improvement. Several ranks must instead be analyzed through their joint Gram matrix.

## Several action ranks: an exact finite lower-gap certificate

Here is the coordinated formula, which has the opposite inequality direction from the upper estimator \(n[v_U]\). Choose \(u_1,\ldots,u_N\in D(K)\) whose images under \(A^{1/2}\) are linearly independent. Put
\[
 G_{ij}=n(u_i,u_j),\qquad r_i=Au_i,\qquad
 R c=\sum_{i=1}^N c_i r_i,\qquad
 a_i=\langle r_i,v\rangle=n(u_i,v).
\tag{12}
\]
Then \(G>0\), and the bounded rank \(B_N=RG^{-1}R^*\) satisfies
\[
 0\le B_N[x]\le n[x]\quad(x\in V),
 \qquad B_N[x]=\|P_{A^{1/2}\operatorname{span}\{u_i\}}A^{1/2}x\|^2.
\tag{13}
\]
Thus \(M+B_N\le K\) in form order. The exact affine improvement is the finite positive scalar
\[
 \boxed{\quad
 F_{M+B_N}-F_M
 =a^T(G+R^*TR)^{-1}a.
 \quad}
\tag{14}
\]
The one-rank formula (8) is its \(N=1\) case. To derive (14), minimize
\(\langle Mh,h\rangle+(a+R^*h)^TG^{-1}(a+R^*h)\)
over \(h\perp q\), then use the constrained inverse \(T\) from (7). All mixed action entries \(\langle r_i,T r_j\rangle\) remain in the matrix. Dropping them would change the gain.

Take a nested sequence of these spans whose union is dense in the form domain of \(A^{1/2}\). Then \(B_N[x]\uparrow n[x]\) on \(V\). For \(x\notin V\), the supremum is infinite: a finite supremum would make \(u\mapsto\langle Au,x\rangle\) bounded in the \(A^{1/2}\)-energy norm on the core, placing \(x\) in \(D(A^{1/2})=V\) by the adjoint characterization. Hence the increasing closed forms \(m+B_N\) have supremum exactly \(k\), including its domain. Monotone convergence of closed forms gives \((M+B_N)^{-1}\to K^{-1}\) strongly; applying the exact affine minimum formula, whose score denominator stays positive, shows
\[
 F_{M+B_N}-F_M\uparrow F_K-F_M.
\tag{15}
\]
Hence a finite matrix (14) can certify a **lower** bound on the true-versus-comparison affine gap and may test failure of a proposed allowance. It does not upper-bound \(n[v_U]\), and (15) is not a shortcut to the signed arithmetic estimate needed for RH.

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
\tag{16}
\]
Neither side of (16) follows from the proved \(\varepsilon\in D(K^{3/2})\).

The physical form proof explains why simply repeating its estimates does not give (16). After conjugation, the original theta operator has the form \(\omega A\omega-K_p\), where \(\omega=\sqrt{\Phi/(2\cosh(u/2))}\), \(K_p\) is bounded, and \(A\) is the logarithmic Fourier multiplier. For \(g=\Phi\psi\), the original operator-domain equation controls \(\omega Ag\in L^2(du)\); the physical form theorem controls \(g\in D(A^{1/2})\). Neither statement alone controls \(Ag\in L^2(du)\), since \(\omega\) vanishes rapidly at infinity. Hard cutoffs and bounded smooth multipliers preserve the physical form domain, but do not supply a derivative of logarithmic order. The full-eigenvector smoothness theorem in [jump eigenfunction regularity](theta-jump-eigenfunction-regularity.md#16-weighted-translations-give-smoothness-and-strip-schwartz-decay) uses a homogeneous equation across the whole line. The killed ground has a hard boundary and a nonzero core-arrival source, so that theorem cannot be applied to it unchanged.

An action-matched affine rank at \(v_U\) therefore requires a new actual-theta theorem proving \(v_U\in D(K)\), or a different quantitative bound for \(n[v_U]\) that stays within the known form domain. Criterion (3) is a domain obstruction to that proposed rank, not a claim that the actual optimizer lies outside \(D(K)\). The remaining conditional variance and its arithmetic size are open.
