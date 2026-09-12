# Fixed-observation prime covariance is the actual successor-seed Gram

These are written proofs; no Lean formalization or publication-priority claim is made. This is an exact finite-prime identity and a fixed-observation convergence theorem. It uses the complete critical prime factors, including every proper power. The boundary profile is the actual initial-seed response established in [successor/source compatibility theorem](successor-collective-prime-compatibility.md); its longer memory is analyzed in [long-memory theorem](collective-successor-seed-long-memory.md). The Cauchy characteristic function, Fourier uniqueness, Plancherel, and the elementary one-pole causal all-pass isometry are classical tools. No novelty claim is made for those tools or their general abstract transform; the stated arithmetic specialization retains the actual complete prime coefficients and successor boundary seed.

## 1. Normalization and the complete signed coefficient measure

For a prime p put $r=p^{-1/2}$, $L=\log p$, and

$$
 U_p(t)=\frac{1-r e^{itL}}{1-r e^{-itL}},\qquad
 \ell_p(t)=|U_p(t)-1|^2.
$$

The reciprocal convention gives the same real symbol. The absolutely convergent Fourier series is

$$
 \ell_p(t)=2r^2+r^3(e^{itL}+e^{-itL})
 -(1-r^2)\sum_{j\ge2}r^j(e^{ijtL}+e^{-ijtL}).                 \tag{1}
$$

Define the finite signed measure on positive displacements

$$
 \mu_p=r^3\delta_L-(1-r^2)\sum_{j\ge2}r^j\delta_{jL},
 \qquad X_p(t)=\ell_p(t)-2/p
 =\int(e^{iat}+e^{-iat})\mu_p(da).                          \tag{2}
$$

In particular,

$$
 \int e^{-a/2}\mu_p(da)
 =r^4-(1-r^2)\sum_{j\ge2}r^{2j}=0.                         \tag{3}
$$

This cancellation uses the full proper-power series. Truncating it would change the identity below.

Use the fixed probability observation

$$
 d\mathsf C(t)=\frac{dt}{2\pi(1/4+t^2)},\qquad
 \int e^{iat}d\mathsf C(t)=e^{-|a|/2}.                     \tag{4}
$$

It follows at once from (3) that

$$
 \mathbb E_{\mathsf C}X_p=0,\qquad
 \mathbb E_{\mathsf C}\ell_p=2/p.                         \tag{5}
$$

## 2. The exact tail is the actual initial-boundary profile

Let $T_p(v)=\int_{[v,\infty)}e^{-a/2}\mu_p(da)$, for $v>0$. At the countably many endpoints, either one-sided convention can be used in the integrals that follow. Away from them, (3) gives $T_p(v)=0$ for $0<v<L$. For $k\ge1$ and $kL<v<(k+1)L$,

$$
 T_p(v)=-(1-r^2)\sum_{j\ge k+1}r^{2j}=-p^{-k-1}.
$$

Thus, almost everywhere,

$$
 T_p(v)=-e^{-v/2}B_p(v),\qquad
 B_p(v)=e^{v/2}p^{-\lfloor v/\log p\rfloor-1}
             1_{v\ge\log p}.                            \tag{6}
$$

This $B_p$ is exactly the initial-boundary response of the actual causal successor commutator with the complete paired prime generator. In particular it is nonnegative, and direct geometric integration gives

$$
 \|B_p\|_2^2
 =\sum_{k\ge1}p^{-2k-2}\int_{kL}^{(k+1)L}e^v\,dv
 =p^{-2}.                                                \tag{7}
$$

## 3. Covariance identity, including distinct primes and the diagonal

For a,b>0,

$$
 e^{-|a-b|/2}-e^{-(a+b)/2}
 =e^{-(a+b)/2}\int_0^{\min(a,b)}e^v\,dv.                 \tag{8}
$$

Expanding (2) and using (4) gives

$$
 \mathbb E_{\mathsf C}(X_pX_q)
 =2\iint\big[e^{-|a-b|/2}+e^{-(a+b)/2}\big]
                          \mu_p(da)\mu_q(db).
$$

The integral of the second exponential is zero by (3), so its plus sign can also be replaced by a minus sign. Apply (8), then (6):

$$
 \boxed{\operatorname{Cov}_{\mathsf C}(\ell_p,\ell_q)
       =2\int_0^\infty B_p(v)B_q(v)\,dv.}                 \tag{9}
$$

All exchanges are justified by the finite total variation of $\mu_p$ and $\mu_q$: the kernel in (8) is bounded by 1. This proof also covers $p=q$. For example $\operatorname{Var}_{\mathsf C}(\ell_p)=2/p^2$ and $\mathbb E_{\mathsf C}\ell_p^2=6/p^2$.

For any finite coefficient family (c_p), real or complex, polarization yields

$$
 \boxed{\left\|\sum_p c_p X_p\right\|_{L^2(\mathsf C)}^2
       =2\left\|\sum_p c_p B_p\right\|_{L^2(0,\infty)}^2.} \tag{10}
$$

Consequently $X_p\mapsto\sqrt2 B_p$ extends to a linear isometry between the closed spans of these two families. This is an identity between the actual signed prime symbols and actual boundary responses, not a claim that the prime phases are independent. All distinct-prime covariances in (9) are nonnegative and retain their full overlap.

## 4. Fixed-observation convergence, with an elementary tail bound

For completeness, Chebyshev's prime-counting bound already proves

$$
 B(v):=\sum_p B_p(v)\le C/(1+v),                         \tag{11}
$$

where the sum is pointwise finite because $p\le e^v$. Indeed the floor-one sector is

$$
 e^{v/2}\sum_{e^{v/2}<p\le e^v}p^{-2}\le C/v
$$

for v large, by partial summation from $\pi(y)\le Cy/\log y$. In each floor-j sector $j\ge2$, comparison with all integers gives

$$
 e^{v/2}\sum_{n>e^{v/(j+1)}}n^{-j-1}
 \le e^{-v/2}+j^{-1}e^{v/2-jv/(j+1)}.
$$

Summing at most $v/\log2$ nonempty sectors bounds the remainder by
$Cv e^{-v/2}+C(1+\log v)e^{-v/6}$. On bounded v the assertion follows from pointwise finiteness and boundedness. Thus B belongs to $L^2$, without invoking a stronger PNT remainder.

Put $B_P=\sum_{p\le P}B_p$ and $L_P=\sum_{p\le P}\ell_p$. Positivity gives $0\le B-B_P\le B$, and the difference vanishes for $v<\log P$. Therefore

$$
 \|B-B_P\|_2^2\le C/(1+\log P).                          \tag{12}
$$

By (10), the centered full generator

$$
 Z_P(t)=L_P(t)-2\sum_{p\le P}1/p
$$

converges to a real, mean-zero Z in the fixed space $L^2(\mathsf C)$, with

$$
 \|Z-Z_P\|_{L^2(\mathsf C)}^2
 =2\|B-B_P\|_2^2\le C/(1+\log P),\qquad
 \|Z\|_{L^2(\mathsf C)}^2=2\|B\|_2^2.                   \tag{13}
$$

The same convergence holds in $L^2(\chi(t)\,dt)$ for every fixed nonnegative observation satisfying $\chi(t)\le C_\chi/(1+t^2)$, including every fixed nonnegative Schwartz observation. This follows by domination by (4); it requires no expanding observation window. No exponential moment follows from $L^2$ convergence alone.

## 5. Actual ground-profile interpretation

With the unitary Fourier convention, $a_0(v)=e^{-v/2}1_{v\ge0}$ has norm 1 and

$$
 |\widehat a_0(t)|^2=\frac1{2\pi(1/4+t^2)}.
$$

Thus (10) is also the ordinary physical-space $L^2$ identity

$$
 \left\|\sum_p c_p(L_p-2/p) a_0\right\|_2^2
 =2\left\|\sum_p c_p B_p\right\|_2^2,                   \tag{14}
$$

where $L_p$ on the left denotes the convolution operator with symbol $\ell_p$. In particular the centered complete-prime generator converges on the actual ground profile in ordinary $L^2$. It commutes with fixed translations in v, hence the same conclusion holds for each fixed translated ground profile and each finite linear combination. The additive birth $h_n(x)=1_{x\ge n}/x$ is such a profile after the standard critical change of coordinates, up to its explicit $n^{-1/2}$ factor. Passing from finite arrival combinations to the full arithmetic source requires a separate joint completion estimate.

## 6. Scope and the next consumer

This construction gives an exact fixed-observation covariance and a deterministic $L^2$ limit. The observation scale 1/2 in (4) matches the retained geometric amplitudes in (3); it was not inferred from an RH statement. The full infinite generator itself has divergent mean $2\sum_p1/p$, which remains explicit.

The independent next test is the normalized heat $e^{-zZ_P}$, including its possible concentration at frequency zero. The coefficient decomposition singles out the prime-square oscillation $-2\sum_{p\le P}\cos(2t\log p)/p$ plus an absolutely convergent correction. The [fixed-observation heat theorem](fixed-observation-prime-heat.md) identifies its line-one zeta limit and proves uniform integrability in the exact subcritical range. Those results use estimates beyond (13), and no assertion about the sign of the Weil readout or RH follows here.

## 7. The complete rational-history functional survives nonlinear heat composition

The same calculation supplies a nonlinear consumer without asserting a strip-invariant cone. Let

$$
 F(t)=c_0+\int_{(0,\infty)}(e^{iat}+e^{-iat})\mu(da),
 \qquad |\mu|((0,\infty))<\infty,                       \tag{15}
$$

where $\mu$ and $c_0$ may be complex. Set

$$
 m_F=\mathbb E_{\mathsf C}F
     =c_0+2\int e^{-a/2}\mu(da),\qquad
 b_F(v)=e^{v/2}\int_{[v,\infty)}e^{-a/2}\mu(da).
$$

There is no requirement that the weighted integral of $\mu$ vanish. On centering, the same-sign terms subtract exactly as in (8). For two such symbols F,G, the resulting identity is

$$
 \boxed{\langle F-m_F,G-m_G\rangle_{L^2(\mathsf C)}
       =2\langle b_F,b_G\rangle_{L^2(0,\infty)}.}        \tag{16}
$$

Here either common convention for complex inner products gives the corresponding polarized identity. Absolute integrability follows from the bounded kernel (8), so the formula first proves that $b_F$ is in $L^2$ rather than presupposing it.

In physical coordinates, F(D) acts as $c_0$ times the identity plus the sum of advances and delays with measure $\mu$. At v=-u<0 only the advances can see $a_0$, and consequently

$$
 [F(D)a_0](-u)=b_F(u)\quad\hbox{a.e.},\qquad
 \boxed{\|(F(D)-m_F)a_0\|_2^2
       =2\|1_{v<0}F(D)a_0\|_2^2.}                      \tag{17}
$$

The uncentered negative port is unchanged by subtraction of $m_Fa_0$ because $a_0$ is causal. This is an exact centered ground-profile energy identity, not an identity for every arithmetic input.

In particular, for every finite admitted prime set S and every complex heat time z, the symbol

$$
 F(t)=\exp[-z\sum_{p\in S}\ell_p(t)]
$$

is even and lies in the Wiener algebra. Its coefficient measure is the absolutely convergent convolution exponential of the full signed generator measure. All assertions (15)--(17) therefore hold for every complex z, locally uniformly on compact z sets. Distinct-prime compositions create rational displacements, which remain inside the same measure; their signs are retained before taking the squared norm. Writing its coefficient at $\log q$ as $\kappa(q)$, $q>0$ rational with prime factors in S, the exact aggregate on positive output age is

$$
 b_F(v)=e^{v/2}\sum_{q\ge e^v}q^{-1/2}\kappa(q)
 \quad\hbox{a.e. }v>0.                                 \tag{18}
$$

The series is absolutely convergent. The measure is grouped by its exact rational displacement, including coincidences and the full atom at zero in $c_0$. No truncation by path length or substitution of absolute coefficients is made. Dense displacement sets cause no difficulty: finite total variation justifies the tail and the regulated limit, while (16) controls its $L^2$ norm.

There is also a complete coordinate interpretation. The map

$$
 F\longmapsto (m_F,\sqrt2\,b_F)                         \tag{19}
$$

extends to a unitary map from the even subspace of $L^2(\mathsf C)$ onto $\mathbb C\oplus L^2(0,\infty)$. Indeed constants and $\cos(at)$, $a>0$, span a dense subspace of even $L^2(\mathsf C)$, by uniqueness of the Fourier transform of a finite measure. For $\cos(at)$, the second coordinate is

$$
 2^{-1/2}e^{(v-a)/2}1_{0<v<a},
$$

whose linear span is dense in $L^2(0,\infty)$. Identity (16) gives the isometry and hence the claimed extension. The actual prime generator is especially simple in these coordinates: its centered action on the constant has boundary coordinate $-\sqrt2 B_P$, whose infinite-prime convergence is (13). The action on arbitrary boundary coordinates, or on the full arithmetic arrival sum, is not bounded by that single column.

Equations (16)–(19) retain every signed rational birth jump as a complete centered ground-state coordinate. Further heat-moment or actual-source estimates must use its coefficients or evolution; positivity of its squared norm by itself imposes no arithmetic sign.

## 8. A fixed causal isometry reconstructs the missing interior

The completeness assertion has an explicit physical form. On $L^2(0,\infty)$, define

$$
 (\mathcal V b)(v)=-b(v)+\int_0^v e^{-(v-u)/2}b(u)\,du. \tag{20}
$$

Then, for every F in (15),

$$
 [(F(D)-m_F)a_0](v)=
 \begin{cases}
 b_F(-v),&v<0,\\
 (\mathcal V b_F)(v),&v>0.
 \end{cases}                                            \tag{21}
$$

To verify the positive half, write b=$b_F$ and $b(0)=\int e^{-a/2}\mu(da)$. Direct evaluation gives

$$
 [(F(D)-m_F)a_0](v)
 =e^{-v/2}\left[\int_{(0,v]}e^{a/2}\mu(da)-b(0)\right].
$$

In distributions on the positive half-line, $\mu=(b/2)\,dv-db$. Integration by parts therefore turns the last expression into (20), almost everywhere; endpoint atoms have no effect on the $L^2$ identity. The integration by parts can first be performed for finite measures on compact intervals and then passed to the finite-variation limit.

The causal operator V is an isometry. Its Laplace multiplier is

$$
 -1+\frac1{s+1/2}=\frac{1/2-s}{1/2+s},
$$

which has modulus one on the imaginary axis; extend b by zero and use Plancherel. Its range is the codimension-one subspace orthogonal to $a_0$ on the positive half-line: the adjoint annihilates $a_0$, and solving V* f=0 gives $f'+f/2=0$. Thus (21) gives an isometric graph with equal energy on its two sides, and the removed mean is precisely the remaining $a_0$ coordinate.

This supplies a concrete compatibility condition beyond an arbitrary port Gram. For the entire even-multiplier orbit of the ground state, the interior is forced by the same fixed V, independently of the admitted primes and heat time. A fixed ground-centered port cannot be altered while its interior changes freely inside this constrained orbit. General inputs need not lie in this graph. Translated birth profiles obey the corresponding translated graph, including their explicit amplitudes; summing the actual infinitely many births and density contributions still requires their signed compatibility and convergence. No interchange of that sum is implied here.
