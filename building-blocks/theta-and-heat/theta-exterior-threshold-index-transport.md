# Every far tail retains the full theta threshold index

This is a written form-index theorem, not a Lean formalization. It uses the established full-space negative-index theorem with its exact multiplicity convention.

The full theta form has a translation-invariant physical defect at the threshold. It follows that every nonempty far half-line retains the *entire* negative index of that defect, even though the exterior localization estimate makes every fixed Rayleigh deficit disappear far enough out. This gives an exact constraint on killed-core elimination. It is not a negative Weil witness or a proof of RH.

Use the actual generator and form from [theta-weil-jump-form](theta-weil-jump-form.md), with
$\lambda=1/2$, $b(u)=2\cosh(u/2)$, $d\nu=b\Phi\,du$. Its full form domain has the compact smooth core proved in the linked regularity chapter. The hard-interval domain split is justified in [theta-killed-core-return-comparison](theta-killed-core-return-comparison.md). The full negative-index and zero-count identities invoked below are the established equations (12.3)–(12.5) of the [jump-form chapter](theta-weil-jump-form.md), not newly assumed zero information.

## Exact transport of the threshold quadratic form

For a compact smooth physical test $f$, put
$$
 k(f,g)=\langle Af,g\rangle
 -\sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
   \bigl(\langle T_{\log q}f,g\rangle+
         \langle T_{-\log q}f,g\rangle\bigr),
\tag{1}
$$
where $A$ is the complete archimedean multiplier and $T_af(u)=f(u+a)$. For each fixed pair of compact supports only finitely many prime-power correlations in (1) are nonzero; the full form, rather than a selected finite prime set, is being evaluated.

The exact theta identity says
$$
 k(f,g)=E(f/\Phi,g/\Phi)
             -\lambda\langle f/\Phi,g/\Phi\rangle_\nu.
\tag{2}
$$
Let $D_tf(u)=f(u-t)$. Translation invariance of the Fourier multiplier and every prime-power correlation gives
$$
 \boxed{k(D_tf,D_tg)=k(f,g)\quad(t\in\mathbb R).}
\tag{3}
$$
The theta norm is not translation invariant. Every compact $D_tf/\Phi$ is nevertheless in the actual compact smooth theta core, regardless of how large its norm becomes.

## Equality of full and exterior negative indices

Let $\Omega$ be either $(R,\infty)$, $( -\infty,-R)$, or $\{|u|>R\}$, for a finite $R>0$. Let $E_\Omega$ be the actual killed restriction and $L_\Omega$ its generator. In each case $D(E_\Omega)$ is the full form domain restricted to functions vanishing outside $\Omega$. All boundary departures remain in this restriction.

Then
$$
 \boxed{
 \operatorname{ind}_{-}(E_\Omega-\lambda\|\cdot\|_\nu^2)
 =\operatorname{ind}_{-}(E-\lambda\|\cdot\|_\nu^2).
 }
\tag{4}
$$
The indices are dimensions of maximal strictly negative subspaces and may be infinite. The inequality from left to right follows by inclusion of form domains.

For the reverse inequality, choose any finite-dimensional strictly negative subspace of the full form, with basis $h_1,\ldots,h_n$. Approximate each basis vector in form norm by $\widetilde h_j\in C_c^\infty$. The Hermitian Gram matrix of $E-\lambda\|\cdot\|^2$ varies continuously under these approximations, so sufficiently accurate choices preserve strict negative definiteness and independence. Set $f_j=\Phi\widetilde h_j$; their supports have a common compact enclosure. A single translation $D_t$ puts all of them into the chosen far half-line. Formula (3) preserves the complete negative Gram matrix on the vectors
$$
 h_{j,t}=D_tf_j/\Phi\in C_c^\infty(\Omega).
$$
Thus every finite negative dimension of the full form occurs in the exterior. This proves (4), including the infinite-index case. No uniform bound on the translated theta norms or on the transported Rayleigh deficits was used.

The same argument works inside any measurable region containing translations of every compact interval. It does not apply to a fixed bounded interval.

## The exterior has an unconditional subthreshold eigenvalue

Constants satisfy $E(1)=0$, $\|1\|_\nu=1$. Hence
$E(1)-\lambda\|1\|^2=-\lambda<0$. Smooth compact cutoffs of the constant converge in norm and energy. Equivalently there is a real nonnegative compact $g$ with $k(g)<0$, obtained by cutting off $\Phi$. Translating that fixed $g$ into $\Omega$ produces the literal strict inequality
$$
 \frac{E_\Omega(D_tg/\Phi)}{\|D_tg/\Phi\|_\nu^2}
 =\lambda+\frac{k(g)}{\|D_tg/\Phi\|_\nu^2}<\lambda.
\tag{5}
$$

These are actual uncentered killed tests. By restriction and the full essential-spectrum lower bound, every spectral subspace of $L_\Omega$ below $\lambda-\epsilon$ is finite dimensional. Indeed a negative subspace there would be a negative subspace of the same full shifted form, and its dimension is bounded by the full finite spectral count. Thus $\inf\sigma_{\rm ess}(L_\Omega)\ge\lambda$. The strict trial value in (5) implies at least one discrete eigenvalue below $\lambda$, for every finite core radius.

Zero is not an exterior eigenvalue: zero full jump energy forces a constant, and a nonzero constant cannot vanish on the complementary interval. Therefore this is a strictly positive killed eigenvalue below $1/2$. Such a killed eigenvalue is present even if RH holds; it must not be confused with a nonconstant full-space eigenvalue.

In particular selecting a larger but finite core never makes the entire killed exterior operator bounded below by $1/2$. For the two-sided exterior, the companion source [theta-killed-return-compact-infinite-rank](theta-killed-return-compact-infinite-rank.md) additionally proves $1/2\in\sigma_{\rm ess}(L_\Omega)$. Both conclusions are consistent with the justified inverse at $z=1/2-\epsilon$ after choosing $\delta_R<\epsilon$.

## Exact arithmetic index count and the retained pole channels

The full zero eigenspace consists precisely of constants. The public theta index theorem gives
$$
 \dim 1_{(0,1/2)}(L)
 =N_{\rm off},\qquad
 N_{\rm off}=\#\{\text{distinct nonreal conjugate pairs of zeros of }\Xi\}.
$$
Combining this with (4),
$$
 \boxed{
 \dim 1_{[0,1/2)}(L_\Omega)=1+N_{\rm off}.
 }
\tag{6}
$$
Multiplicity of a zero is treated exactly as in the public index theorem: it does not increase the count of distinct conjugate pairs. The left side contains no zero eigenvector, but the interval notation includes the full negative index uniformly. Infinite dimensions are allowed. Thus RH is equivalent to *exactly one* killed eigenvalue below $1/2$, counting its eigenspace dimension, in any one of these far tails. Formula (6) supplies no unconditional upper bound of one.

The pole behavior of the transported tests explains why (5) alone is harmless. For a real nonnegative seed $g$, let
$$
 a_\pm=\int e^{\pm u/2}g(u)\,du>0,\qquad h_t=D_tg/\Phi.
$$
The exact moments are
$$
 \nu h_t=e^{t/2}a_++e^{-t/2}a_-,\qquad
 \beta(h_t)=\nu(\tau h_t)=e^{t/2}a_+-e^{-t/2}a_-.
\tag{7}
$$
Centering alone changes its threshold defect to
$$
 E(h_t-\nu h_t)-\lambda\|h_t-\nu h_t\|^2
 =k(g)+\lambda|\nu h_t|^2,
\tag{8}
$$
which is positive for sufficiently large $|t|$. Centering also destroys exterior support. The full mean/score projection has instead the exact readout
$$
 E(\Pi h_t)-\lambda\|\Pi h_t\|^2
 =Q(D_tg)=k(g)+2a_+a_-.
\tag{9}
$$
Both half-poles are retained: $\lambda(|\nu h_t|^2-|\beta(h_t)|^2)=2a_+a_-$. Their growing individual moments cancel in this full combination. No negative sign for (9) follows from $k(g)<0$.

## Consequence for the global return construction

Equation (4) preserves the dimension of negative subspaces at the exact threshold. It does not preserve a gap below it. The established exterior estimate gives
$$
 E_\Omega(h)-\lambda\|h\|^2\ge-\delta_R\|h\|^2,
 \qquad\delta_R\to0,
$$
for the two-sided exterior, and hence for either half-line. All transported strict deficits must lie within that shrinking window after normalization. This reconciles complete index transport with compact localization below every fixed $1/2-\epsilon$.

The killed-core Schur method remains valid at its stated $z<\inf\sigma(L_\Omega)$, with the core chosen depending on $\epsilon$. Its complete return metric and pole corrections are still useful. A fixed-core replacement of the exterior inverse by a positive inverse at the threshold, however, is impossible: the exterior always contains the negative index in (6). Any threshold construction must retain or remove its actual spectral and pole channels by a justified global operation. Two asymptotic incoming laws do not accomplish that removal.

## Exact index after imposing the actual pole constraints

Use the actual theta generator $L$, form $E$, probability measure $\nu$, and threshold $\lambda=1/2$. Let
$$
 \beta(h)=\nu(\tau h),\qquad \tau=\tanh(u/2).
$$
The [actual jump-form theorem](theta-weil-jump-form.md), equations (12.3)--(12.5), identifies
$$
 N_{\rm off}
 =\dim_{\mathbb C}1_{(0,\lambda)}(L)
 =\#\{\text{distinct nonreal conjugate pairs of zeros of }\Xi\}.
 \tag{C1}
$$
This count can be infinite. The argument below consumes this established index theorem; it supplies no unconditional bound on $N_{\rm off}$.

Let $\Omega$ be $(R,\infty)$, $(-\infty,-R)$, or their union, for any finite $R$. Use the actual killed restriction $E_\Omega$, including all departures across its boundary. Define
$$
 \mathcal D_\Omega^0
 =\{h\in D(E_\Omega):\nu(h)=0\},\qquad
 \mathcal D_\Omega^{00}
 =\{h\in\mathcal D_\Omega^0:\beta(h)=0\}.
 \tag{C2}
$$
Functions are extended by zero when their full moments are taken.

Then the sharp constrained form-index equalities are
$$
 \boxed{
 \operatorname{ind}_-\bigl((E_\Omega-\lambda\|\cdot\|_\nu^2)
                         |_{\mathcal D_\Omega^{00}}\bigr)
 =
 \operatorname{ind}_-\bigl((E_\Omega-\lambda\|\cdot\|_\nu^2)
                         |_{\mathcal D_\Omega^{0}}\bigr)
 =N_{\rm off}.}
 \tag{C3}
$$
By comparison, the uncentered exterior index is $1+N_{\rm off}$, as proved above. The moment subspaces in (C2) need not be invariant under the killed operator. Equation (C3) concerns restricted quadratic forms, not a claim that individual killed eigenfunctions already satisfy the constraints.

### The upper bounds

The full constants are the kernel of $L$. On their orthogonal complement the threshold form has negative index $N_{\rm off}$, by (C1). The killed form agrees with the full form on functions supported in $\Omega$. Inclusion therefore gives
$$
 \operatorname{ind}_-(\mathcal D_\Omega^{00})
 \le\operatorname{ind}_-(\mathcal D_\Omega^0)
 \le N_{\rm off}.
 \tag{C4}
$$
Both moments are bounded linear functionals on $L^2(\nu)$, so these are closed constraints in the form domain.

### Compact approximation with both moments exactly zero

Write $s=\Phi'/\Phi$. The exact projection is
$$
 \Pi h=h-\nu(h)+2\beta(h)s.
 \tag{C5}
$$
The identities $\nu(s)=0$, $\beta(s)=-1/2$ imply $\nu(\Pi h)=\beta(\Pi h)=0$. The full pole and score identity gives
$$
 E(\Pi h)-\lambda\|\Pi h\|_\nu^2=Q(\Phi h).
 \tag{C6}
$$
It holds as a polarized identity on the actual form domain. In particular a finite-dimensional compact negative Weil space maps injectively under $\Pi$ to a doubly constrained negative threshold space. Injectivity on that space follows from strict negativity and (C6).

Choose any finite $d\le N_{\rm off}$ and such a projected negative space with basis $h_1,\ldots,h_d$. The [compact-test index theorem](theta-weil-jump-form.md) supplies every such finite dimension, including when the index is infinite.

Fix one nonzero even function $\eta\in C_c^\infty$, with $\eta\ge0$, and set
$$
 \rho_0=\eta,\qquad \rho_1=\tau\eta.
$$
Their moment matrix is exactly
$$
 \begin{pmatrix}
 \nu(\rho_0)&\nu(\rho_1)\\
 \beta(\rho_0)&\beta(\rho_1)
 \end{pmatrix}
 =
 \begin{pmatrix}
 \nu(\eta)&0\\0&\nu(\tau^2\eta)
 \end{pmatrix},
 \tag{C7}
$$
with both diagonal entries strictly positive. The second is positive because a nonzero smooth nonnegative bump has positive measure away from the single zero of $\tau$.

Approximate each $h_j$ in form norm by compact smooth $v_j$. Correct it by
$$
 \widetilde v_j
 =v_j-\frac{\nu(v_j)}{\nu(\eta)}\eta
       -\frac{\beta(v_j)}{\nu(\tau^2\eta)}\tau\eta.
 \tag{C8}
$$
Both moments now vanish exactly. Since the original $h_j$ has both moments zero, the two coefficients in (C8) tend to zero. The reference functions are fixed elements of the compact form core, so the correction tends to zero in form norm. Thus $\widetilde v_j\to h_j$ in form norm.

The finite Hermitian threshold Gram matrix varies continuously under this approximation. For sufficiently accurate simultaneous choices, the corrected vectors remain independent and strictly negative definite. Their supports have a common compact enclosure, including the two reference functions.

### One common physical translation preserves both constraints and the full negative matrix

Put $f_j=\Phi\widetilde v_j$. These are compact smooth physical tests. Define their two half-exponential moments by
$$
 I_\pm(f)=\int_{\mathbb R}e^{\pm u/2}f(u)\,du.
$$
The exact relations are
$$
 \nu(\widetilde v_j)=I_+(f_j)+I_-(f_j),\qquad
 \beta(\widetilde v_j)=I_+(f_j)-I_-(f_j).
$$
Hence both $I_+(f_j)$ and $I_-(f_j)$ vanish.

For the physical translation $D_tf(u)=f(u-t)$,
$$
 I_\pm(D_tf)=e^{\pm t/2}I_\pm(f).
 \tag{C9}
$$
Therefore both moments remain zero under every common translation. Choose $t$ sufficiently positive or negative to put all the translated compact supports strictly inside the desired half-line. The vectors
$$
 h_{j,t}=D_tf_j/\Phi
$$
belong to $C_c^\infty(\Omega)\cap\mathcal D_\Omega^{00}$.

The full physical threshold form
$$
 k(f,g)=E(f/\Phi,g/\Phi)
       -\lambda\langle f/\Phi,g/\Phi\rangle_\nu
$$
is exactly translation invariant, retaining the complete archimedean multiplier and every prime-power correlation. Consequently
$$
 k(D_tf_j,D_tf_\ell)=k(f_j,f_\ell).
 \tag{C10}
$$
The entire strictly negative Hermitian matrix survives in the far half-line. Thus $\mathcal D_\Omega^{00}$ has negative index at least $d$. Since every finite $d\le N_{\rm off}$ is available, this proves the lower bound in (C3), including infinite index.

The construction corrects both half-poles before translating. Correcting only the mean would not work: equation (C9) rescales the two halves differently. Nor is a subsequent global centering used, since that would destroy exterior support.

### Relation to the killed-core construction

The proof uses no uniform bound on the translated theta norms. Common physical translation preserves the exact negative matrix, but its Rayleigh deficits may shrink to zero. This is consistent with the exterior estimate $E_\Omega-\lambda\|\cdot\|^2\ge-\delta_R\|\cdot\|^2$, with $\delta_R\to0$.

Thus imposing the actual mean constraint removes precisely the unconditional extra negative direction in the uncentered threshold index; imposing the odd pole constraint as well removes no further index. Any remaining constrained negative directions have the exact count $N_{\rm off}$. This is an index and pole-compatibility statement for the full return construction. It neither assumes that count is zero nor supplies the missing sharp comparison.
