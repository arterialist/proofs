# Semilocal scattering, compact negative parts and weighted traces

This note uses Connes-Consani, *BC-system, absolute cyclotomy and the quantized calculus*, [DOI 10.4171/EMSS/64](https://doi.org/10.4171/EMSS/64), Lemma 4.4, Theorem 4.6, equation (24), and section 4.5. The leading minus sign in Lemma 4.4 fixes the sign in the trace identification.


This is a written proof using classical two-projection calculus and the cited semilocal construction. It is not a Lean theorem. The estimates concern the full finite product, with no priority claim for the operator identities.

We use $\mathcal K=L^2(\mathbb R,dt)$, the unitary Fourier transform with exponent $-it\xi$, and the projection $P$ onto negative Fourier frequencies. This choice fixes the positive sign in the diagonal trace formula below. Replacing $P$ by $1-P$ reverses every signed defect and preserves all Schatten norms.

For a real cutoff $X\ge2$, the actual multiplier is

$$
u_X(t)=\pi^{-it}\frac{\Gamma(1/4+it/2)}{\Gamma(1/4-it/2)}
\prod_{p\le X}\frac{1-p^{-1/2}e^{it\log p}}{1-p^{-1/2}e^{-it\log p}},
\qquad U_X=M_{u_X}.
$$

Every admitted prime contributes its full local factor. For $f\in C_c^\infty(\mathbb R)$, write $F(t)=\int f(u)e^{itu}du$, $C_f(a)=\int f(u+a)\overline{f(u)}du$, and $M_\pm(f)=\int e^{\pm u/2}f(u)du$. In this normalization the complete Weil form is

$$
Q(f)=2\Re(M_+(f)\overline{M_-(f)})
+\frac1{2\pi}\int |F(t)|^2[\Re\psi_{\rm digamma}(1/4+it/2)-\log\pi]dt
-2\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}\Re C_f(\log n).
$$

The sum is finite by support, and includes all prime powers. A pole-null test has $M_+(f)=M_-(f)=0$. Once $\log X$ exceeds the support diameter, its trace below is exactly $Q(f)$. For general compact tests it equals $Q(f)-2\Re(M_+\overline{M_-})$.

## 1. Sign and normalization

For the projection $P$ defining the quantized calculus, set
$$
\Delta=P-U^*PU=-\tfrac12U^*\bar dU.
\tag{1}
$$
If $U$ is exactly upper triangular relative to $(1-P)\mathcal K\oplus P\mathcal K$, Lemma 4.4 identifies $\Delta$ with the positive projection onto the kernel of its lower diagonal compression. With the paper's convention,
$$
-\tfrac12\operatorname{Tr}(fU^*\bar dU)
=\operatorname{Tr}(f\Delta)\ge0
\tag{2}
$$
for the positive operators in its trace domain.

For the actual finite-place local-factor product, Theorem 4.6 supplies triangularity only modulo compact operators. Throughout the semilocal application, the Hilbert space is the zeta-sector Mellin space $\mathcal K=L^2(\mathbb R,dt)$, with the source's Hardy projection. The elementary calculation below identifies the negative part left by its compact lower corner. It does not replace that corner by an arbitrary compact perturbation.

## 2. Exact block formula for the negative part

Write the actual unitary blocks as
$$
U=\begin{pmatrix}A&B\\C&D\end{pmatrix},
\qquad C=PU(1-P).
$$
Unitarity gives the exact formulas
$$
\Delta=
\begin{pmatrix}
-C^*C&-C^*D\\
-D^*C&B^*B
\end{pmatrix},\qquad
\Delta^2=
\begin{pmatrix}C^*C&0\\0&B^*B\end{pmatrix}.
\tag{3}
$$
For the second formula one can either multiply the blocks or use the fact that $\Delta$ is a difference of two orthogonal projections. Put $Y=C^*C$ and $X=B^*B$. Since $|\Delta|=(\Delta^2)^{1/2}$, its canonical negative part is
$$
\boxed{\Delta_-=
\frac12\begin{pmatrix}
\sqrt Y+Y&C^*D\\
D^*C&\sqrt X-X
\end{pmatrix}.}
\tag{4}
$$
There is no omitted off-diagonal term.

If $C$ is compact, every block in (4) is compact. To check the lower diagonal block, use
$$
X-X^2=D^*CC^*D.
\tag{5}
$$
Thus the image of $X$ in the Calkin algebra is a projection. Continuous functional calculus then makes $\sqrt X-X$ compact. This proves compactness of $\Delta_-$ directly from the actual lower corner.

There is an exact spectral statement beyond compactness:
$$
\boxed{\text{The nonzero eigenvalues of }\Delta_-
\text{ are the singular values of }C,
\text{ with the same multiplicities}.}
\tag{6}
$$
Here is a direct two-projection proof. Put $Q=U^*PU$. If $e\in\ker P$ is a unit vector with $C^*Ce=s^2e$, $0<s<1$, define
$$
f=\frac{PQe}{s\sqrt{1-s^2}}\in\operatorname{Ran}P.
$$
The projection identity $Q^2=Q$ gives $\|f\|=1$, and on their two-dimensional span
$$
Q=\begin{pmatrix}s^2&s\sqrt{1-s^2}\\s\sqrt{1-s^2}&1-s^2\end{pmatrix},
\qquad
\Delta=\begin{pmatrix}-s^2&-s\sqrt{1-s^2}\\-s\sqrt{1-s^2}&s^2\end{pmatrix}.
\tag{7}
$$
Hence this block has eigenvalues $-s,+s$. The construction respects multiplicity by choosing an orthonormal basis of the singular subspace. When $s=1$, the vector lies in $\ker P\cap\operatorname{Ran}Q$, and its $\Delta$-eigenvalue is $-1$. Conversely a negative eigenvector cannot lie entirely in $\operatorname{Ran}P$; its nonzero $1-P$ component, using (3), supplies the corresponding eigenvector of $C^*C$. For $-1$, the equality case of $\|Pv\|^2-\|Qv\|^2=-\|v\|^2$ gives the same intersection. Since (4) is compact, this accounts for its entire nonzero spectrum.

In particular
$$
\|\Delta_-\|=\|C\|,
\qquad \operatorname{Tr}(\Delta_-^p)=\operatorname{Tr}(|C|^p)
\tag{8}
$$
whenever those traces are finite, and with matching infinite values otherwise. The last equality is a spectral identity; it is not an assumption that the actual corner lies in any particular Schatten class. Also $\Delta\ge0$ holds if and only if $C=0$, as is already clear by testing (3) on $\ker P$.

The $\pm s$ blocks in (7) show why an unweighted scalar trace or index cannot settle positive weighted traces. Their signed trace is zero, while their positive and negative directions remain present. A scalar count/divide-boundary trace has not been identified with this actual corner, its singular vectors, or its test-weighted negative part.

## 3. Ordinary trace class and positive splitting for each finite place set

Let $\chi\in\mathcal S(\mathbb R)$, and fix a finite place set $\mathcal V$. In the specified zeta-sector Mellin space, $M_\chi\Delta_{\mathcal V}$ has kernel
$$
K_\chi(t,s)=-\frac{i}{2\pi}\chi(t)\overline{u_{\mathcal V}(t)}
\frac{u_{\mathcal V}(t)-u_{\mathcal V}(s)}{t-s}.
\tag{14}
$$
The divided difference extends smoothly to the diagonal. The finite local-factor product has modulus one, and every fixed derivative has polynomial growth on the real line. For the archimedean factor this follows from the gamma-ratio derivative bounds; the finitely many nonarchimedean factors have denominators bounded away from zero on the real axis.

Put $L_t=1+t^2-\partial_t^2$. Then
$$
L_tK_\chi\in L^2(\mathbb R^2).
\tag{15}
$$
On $|t-s|\le1$, the integral formula for a divided difference controls the required derivatives by polynomial bounds for derivatives of $u_{\mathcal V}$ near $t$. The Schwartz factors in the output variable absorb those polynomials. On $|t-s|\ge1$, derivatives in $t$ give a sum of terms bounded by Schwartz functions of $t$ times $|t-s|^{-j}$, $j\ge1$, using $|u_{\mathcal V}(s)|=1$. Their squares are integrable in $s$. This proves (15).

The harmonic-oscillator inverse $L_t^{-1}$ is Hilbert-Schmidt, with eigenvalues $(2n+2)^{-1}$, $n\ge0$. The operator with kernel (15) is Hilbert-Schmidt. Their product is $M_\chi\Delta_{\mathcal V}$, hence
$$
\boxed{M_\chi\Delta_{\mathcal V}\in\mathcal S_1.}
\tag{16}
$$
This is an ordinary trace-class statement for each finite set. Its bound depends on that set; it is not uniform as more primes are included.

Compact smooth cutoffs in both kernel variables converge in trace norm to this operator. For the compact smooth kernels, the ordinary diagonal trace identity follows, for example, from an absolutely convergent Fourier-series expansion on a containing interval. Dominated convergence on the diagonal then yields
$$
\operatorname{Tr}(M_\chi\Delta_{\mathcal V})
=\frac1{2\pi}\int_{\mathbb R}\chi(t)\,a_{\mathcal V}(t)\,dt,
\tag{17}
$$
where
$$
a_{\mathcal V}(t)=a(t)-2\sum_{p\in\mathcal V\setminus\{\infty\}}
\sum_{k\ge1}(\log p)p^{-k/2}\cos(tk\log p),
\qquad a(t)=\Re\psi(1/4+it/2)-\log\pi.
\tag{18}
$$
The sign follows from $-i\overline{u_{\mathcal V}}u_{\mathcal V}'=a_{\mathcal V}$. The series over powers is absolutely convergent for each fixed finite prime set. No additional regularization term is introduced.

There is now a valid finite-place positive/negative splitting. Right multiplication of the trace-class operator in (16) by the bounded operator $\operatorname{sgn}\Delta_{\mathcal V}$ gives
$M_\chi|\Delta_{\mathcal V}|\in\mathcal S_1$. Consequently
$$
M_\chi\Delta_{\mathcal V,+},\quad
M_\chi\Delta_{\mathcal V,-}\in\mathcal S_1.
\tag{19}
$$
When $\chi\ge0$, both traces are nonnegative, by positivity of the trace of a trace-class product of positive operators. If $s_j$ are the nonzero singular values of the actual lower corner and $v_j^-$ are the corresponding orthonormal negative eigenvectors of $\Delta_{\mathcal V}$, then
$$
\boxed{
\operatorname{Tr}(M_\chi\Delta_{\mathcal V,-})
=\sum_j s_j\int_{\mathbb R}\chi(t)|v_j^-(t)|^2dt<\infty.
}
\tag{20}
$$
This is the actual weighted negative contribution. For an actual pole-null test weight, the desired domination is
$$
\operatorname{Tr}(M_\chi\Delta_{\mathcal V,+})
\ \ge\ \operatorname{Tr}(M_\chi\Delta_{\mathcal V,-}).
\tag{21}
$$
Finite trace class establishes the meaning of (21), not its sign.

## 4. The two weighted traces can diverge while their difference stabilizes

Take the actual increasing place sets
$\mathcal V_X=\{\infty\}\cup\{p:p\le X\}$. On the interval $|t|\le1/\log X$, the first-power contribution in (18) satisfies
$$
\sum_{p\le X}\frac{\log p}{\sqrt p}\cos(t\log p)
\ge(\cos1)\sum_{p\le X}\frac{\log p}{\sqrt p}
\ge c\sqrt X
\tag{22}
$$
for large $X$. The last inequality uses only the classical Chebyshev lower bound $\vartheta(X)=\sum_{p\le X}\log p\ge c_0X$, since $p^{-1/2}\ge X^{-1/2}$. All higher prime powers are retained and bounded by
$$
\sum_{p\le X}\sum_{k\ge2}(\log p)p^{-k/2}
\le C\sum_{p\le X}\frac{\log p}{p}=O(\log X),
\tag{23}
$$
using the Chebyshev upper bound and partial summation. The archimedean term is bounded on this shrinking interval. Thus
$$
\boxed{a_{\mathcal V_X}(t)\le-c_1\sqrt X
\qquad(|t|\le1/\log X),}
\tag{24}
$$
for sufficiently large $X$.

Let $\varphi$ be any nonzero compact smooth physical test, $F=\widehat\varphi$, and $\chi=|F|^2$. Its entire transform has some finite zero order $m\ge0$ at zero. Therefore $\chi(t)\ge c_F|t|^{2m}$ for small real $t$. Choose a smooth function $0\le\eta\le1$, supported in $[-1,1]$, equal to one on $[-1/2,1/2]$, and set
$$
\chi_X(t)=\chi(t)\eta(t\log X).
$$
This is a Schwartz weight with $0\le\chi_X\le\chi$. It is used only to estimate the negative contribution of the actual test $\chi$. It need not itself be a Weil test, and its negative trace is not a counterexample to Weil positivity.

Finite-place positive splitting, (17), and (24) give
$$
\begin{aligned}
\operatorname{Tr}(M_\chi\Delta_{\mathcal V_X,-})
&\ge\operatorname{Tr}(M_{\chi_X}\Delta_{\mathcal V_X,-})\\
&\ge-\operatorname{Tr}(M_{\chi_X}\Delta_{\mathcal V_X})\\
&\ge c\sqrt X\int\chi_X(t)dt
\ge c_\varphi\frac{\sqrt X}{(\log X)^{2m+1}}.
\end{aligned}
\tag{25}
$$
Every trace here is finite for each fixed $X$, by section 3. In particular its canonical negative weighted trace diverges as $X\to\infty$.

In contrast, $\operatorname{Tr}(M_\chi\Delta_{\mathcal V_X})$ becomes exactly constant once $X$ exceeds the exponential of the support diameter of $\varphi$. To see this directly from (18),
$$
\frac1{2\pi}\int|F(t)|^2\cos(at)dt
=\Re\int\varphi(u+a)\overline{\varphi(u)}du
$$
vanishes when $a$ exceeds that diameter. Every additional prime and all of its powers then contribute exactly zero. It follows that
$$
\operatorname{Tr}(M_\chi\Delta_{\mathcal V_X,+})\to\infty,
\qquad
\operatorname{Tr}(M_\chi\Delta_{\mathcal V_X,-})\to\infty,
\tag{26}
$$
while their difference is eventually constant. This holds in particular for nonzero pole-free compact tests.

The [continuum counterphase](continuum-scattering-counterphase.md) restores the exact pole form while preserving the signed cancellation. The growing positive and negative traces above do not determine the sign of their finite difference.

For the [actual theta jump form](theta-weil-jump-form.md), an even compact smooth $h$ with $\nu h=0$ gives $f=\Phi h$, both pole moments zero, and the exact identification

$$
E_{\rm jump}(h)-\tfrac12\|h\|_{L^2(\nu)}^2
=Q(\Phi h)=\operatorname{Tr}(M_{|\widehat{\Phi h}|^2}\Delta_S)
$$

whenever $S$ includes every prime up to the exponential of the support diameter. This is an equality of a form value and an ordinary weighted trace. It asserts no unitary equivalence between the theta jump generator and the semilocal defect.
