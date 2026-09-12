# A finite fusion mechanism for the actual selected arithmetic response

Throughout, $\Phi_n$ denotes the $n$th cyclotomic polynomial, including $\Phi_1(z)=z-1$, and $F_N=\prod_{n=1}^N\Phi_n$. Its roots are simple. The weight $w_N(a/n)$ is half the sum of the two neighboring gaps of $a/n$ in the circular Farey set of order $N$; thus the weights sum to one. The clipped deficit is $[-\log|F_N'(e^{2\pi ia/n})|]_+$. These are the same actual histories used in the [weighted-orbit obstructions](cyclotomic-weighted-orbit-obstructions.md).


This construction replaces the failed q/r cancellation hypothesis with a different, testable mechanism. It gives a uniform sign law for the actual old updates at the phases selected by Farey weight changes when the cutoff has at most two distinct prime factors. The law comes from an exact identification with finite path fusion matrices. It does not give an RH estimate, and its proposed extension to all multiplicative histories fails at a three-prime cutoff.

## Arithmetic states and the proposed mechanism

Keep the full prefix F_K=∏_{j≤K}Φ_j, including Φ₁. Its state at an existing root α=ζ_n^a is

$$
L_{n,K}(a)=\log|F_K'(\alpha)|,\qquad
b_{n,K}(a)=[-L_{n,K}(a)]_+.
$$

Additive time K→K+1 multiplies the old derivative by Φ_{K+1}(α). The exact division-history coefficients remain

$$
c_{K,d}=M(\lfloor K/d\rfloor),\quad
L_{n,K}(a)=\sum_{d\le K}c_{K,d}h_{n,a}(d),\quad
h_{n,a}(d)=\begin{cases}\log d,&n\mid d,\\
\log|1-\zeta_n^{ad}|,&n\nmid d.
\end{cases}
\tag{1}
$$

Every scalar at a removable zero is retained. Formula (1) is the established exact full-history readout, not a substitute observable.

At cutoff N, an old Farey weight at a root of order n≥2 changes precisely when aN≡±1 mod n. These phases require (n,N)=1. We call them selected phases only to specify this exact arithmetic condition. This note makes no assertion about every other old phase. The root of order one is handled separately below.

The proposed mechanism is that the selected cyclotomic multiplier can be an eigenvalue modulus of a stochastic matrix derived from the finite path graph. A stochastic eigenvalue cannot exceed one in modulus. This is a testable claim about the original multiplier, rather than a freely chosen positive matrix with a different readout.

## Exact selected multiplier as a multiplicative finite difference

Fix 2≤n<N, (n,N)=1 and aN≡1 mod n. The minus-one selection is its conjugate and has the same modulus. For 1≤u<n define

$$
D_n(u)=\frac{|\sin(\pi u/n)|}{\sin(\pi/n)},\qquad
\delta_n(u)=\log D_n(u).
$$

These expressions are well defined on nonzero residues modulo sign, D_n(1)=1, and δ_n(u)≥0. Arithmetic products and inverses below are taken in the unit group modulo n, so their logarithms are finite. In the Möbius product for Φ_N, write d=N/e. Then α^{N/e}=ζ_n^{e^{-1}} for each divisor e of N. No factor vanishes, because (n,N)=1. Consequently

$$
\boxed{v_{n,N}:=\log|\Phi_N(\alpha)|
=\sum_{e\mid N}\mu(e)\delta_n(e^{-1}).}
\tag{2}
$$

The constant log(2sin(π/n)) cancels because Σ_{e|N}μ(e)=0. The nonzero terms of (2) are exactly the squarefree division subsets of the distinct primes of N. At this selected phase the instantaneous multiplier depends on those prime residues; the previous state (1), its cutoff and its prime-power scalars are still present in the clipped response. Selection changes with N, so (2) is not a claim that one fixed root has a periodic full history.

## The classical finite matrix and a self-contained inequality

The matrices used here are the SU(2) fusion matrices at level n−2, built from the path A_{n−1}. Their Chebyshev recurrence and nonnegative entries are classical; see [Coquereaux and Zuber, *On some properties of SU(3) fusion coefficients*, §3, equations (4)–(5)](https://www.lpthe.jussieu.fr/~zuber/MesPapiers/cz_NP16.pdf), which reviews the SU(2) case. Their $N_\lambda$ is $B_{\lambda+1}$ here, with level $k=n-2$. No novelty is claimed for that construction or for the spectral inequality. The arithmetic identification (2) and its precise consequence below are what this branch tests.

For 1≤u≤n−1 define the real symmetric (n−1)×(n−1) matrix B_u by

$$
(B_u)_{ij}=1
\quad\text{if}\quad
|i-j|+1\le u\le\min(i+j-1,2n-i-j-1),\quad i+j+u\text{ odd},
\tag{3}
$$

and zero otherwise. Thus B₁=I; when n≥3, B₂ is the path adjacency matrix. At n=2 only B₁=[1] occurs. Nonnegativity is explicit in (3), rather than an assumed positivity property of an arithmetic operator.

Put θ=π/n. For v=1,…,n−1, the vector s_v(i)=sin(ivθ) satisfies

$$
B_us_v=\lambda_u(v)s_v,
\qquad\lambda_u(v)=\frac{\sin(uv\theta)}{\sin(v\theta)}.
\tag{4}
$$

Here is a direct verification. In row i the allowed j form the progression |i−u|+1, |i−u|+3,… up to min(i+u−1,2n−i−u−1). Without the upper reflection truncation, the sine sum on this progression equals sin(ivθ)sin(uvθ)/sin(vθ), by summing a finite geometric progression. When i+u>n, the removed part cancels in pairs j and 2n−j, since sin((2n−j)vθ)=−sin(jvθ), while j=n contributes zero. This proves (4) with the actual truncated matrix.

The vector s₁ is strictly positive and its eigenvalue is d_u=D_n(u)>0. For any v, choose i maximizing |s_v(i)|/s₁(i). Apply (3) to the eigenvector equation in that row. The triangle inequality gives |λ_u(v)|≤d_u. Therefore

$$
\boxed{D_n(uv)\le D_n(u)D_n(v),
\qquad\delta_n(uv)\le\delta_n(u)+\delta_n(v).}
\tag{5}
$$

The logarithmic inequality in (5) is asserted for units u,v modulo n. This proof is finite and does not use RH, an infinite operator domain, or a guessed inner product. Its state space is R^{n−1} with the usual inner product.

For a precise stochastic form let H=diag(s₁(1),…,s₁(n−1)) and

$$
Q_u=d_u^{-1}H^{-1}B_uH.
\tag{6}
$$

Every entry is nonnegative and every row sums to one, because B_us₁=d_us₁. Its eigenvector H^{-1}s_v has eigenvalue λ_u(v)/d_u. Thus (5) is the ordinary finite stochastic spectral bound, with the normalization forced by (3)–(4).

## A proved law for the actual signed history response

If N=p^k, equation (2) is

$$
v_{n,N}=-\delta_n(p^{-1})\le0.
\tag{7}
$$

If N=p^k\ell^j for two distinct primes, let u=p^{-1} mod n and v=ℓ^{-1} mod n. Then

$$
v_{n,N}=\delta_n(uv)-\delta_n(u)-\delta_n(v)\le0.
\tag{8}
$$

In fact the actual multiplier has the exact matrix readout

$$
\boxed{|\Phi_N(\zeta_n^a)|
=\left|\frac{\lambda_u(v)}{d_u}\right|,}
\tag{9}
$$

the modulus of the indicated eigenvalue of Q_u. Prime powers in N, phase selection and the number of primitive embeddings have not been changed to achieve this equality.

For every actual previous state L_{n,N−1}(a), inequalities (7)–(8) imply

$$
\boxed{\omega(N)\le2,\quad 2\le n<N,\quad aN\equiv\pm1\pmod n
\quad\Longrightarrow\quad
b_{n,N}(a)-b_{n,N-1}(a)\ge0.}
\tag{10}
$$

Multiplication by the actual positive w_N(a/n) preserves this sign. When the previous full log is already negative, the change is exactly −v_{n,N}; otherwise it is max(0,−L_{n,N−1}−v_{n,N}). Thus (10) concerns the clipped, full-history response without discarding its correlation with the previous log. It says that these selected updates can create or enlarge deficits; it is not a dissipation estimate.

At n=1, Φ_{p^k}(1)=p, so the factor-log statement (7) does not apply. Its actual full derivative is a nonzero integer and its deficit remains zero. The order-two root is included in (10), with both Farey gaps counted. At a g=1 parent pair ar−cq=1, N=q+r, both parent phases meet the selection condition, so both have nonnegative clipped response when ω(N)≤2. This includes the independently certified strictly positive paired response at N=199. For g>1 there is no assertion that arbitrary lifted parent labels are selected phases.

## The three-prime discrimination

A proposed uniform extension of (9) would represent every selected multiplier as an eigenvalue modulus of a stochastic matrix while keeping its value unchanged. This extension is false.

At N=105=3·5·7, n=13, a=1, one has aN≡1 mod 13. Grouping the eight divisor terms in (2) into residues modulo sign gives coefficients +1 at 3 and 6, −1 at 2 and 4, and zero elsewhere. Therefore

$$
\boxed{|\Phi_{105}(\zeta_{13})|
=\frac{\sin(3\pi/13)\sin(6\pi/13)}
{\sin(2\pi/13)\sin(4\pi/13)}>1.}
\tag{11}
$$

Both numerator sines are strictly larger than their corresponding denominator sines: all four angles are between zero and π/2. This is an exact sign proof, not a numerical fit. It rules out the unchanged stochastic-eigenvalue readout at this composite, even though every individual fusion matrix is nonnegative. A product containing inverses of contractions need not be a contraction; the actual Möbius third difference contains precisely such alternating terms.

Equation (11) alone does not show a negative clipped response, since a positive factor log may occur while the previous full log is positive. A separate bounded test of that possible rescue was therefore made on the actual coefficients (1). It found a selected recovery at N=1533=3·7·73, n=145, a=7, where aN=1 mod145. Rational interval arithmetic proves

$$
L_{145,1532}(7)\in(-6.760829797,-6.760829796),\qquad
L_{145,1533}(7)\in(-6.350406430,-6.350406429),
$$

and independently v∈(0.410423366,0.410423367)>0. The full scalar is 365400 at both cutoffs. Since both logs are negative and the actual new weight is 1/220752, the signed old response equals −v/220752<0. The mathematical derivation is in [cyclotomic selected recovery](cyclotomic-selected-recovery.md). This rejects the additional history-correlation hypothesis, rather than treating clipping as linear in (11).

## Scope: a sparse contribution and the complete phase orbit

The selected sign law is not control of the remaining RH-relevant interaction. There are at most two selected phases per old conductor, and each has

$$
w_N(a/n)\le\frac1{n(N-n)}.
$$

Thus their combined mass at N is at most 4H_{N−1}/N. Clipping is one-Lipschitz and the full regularized factor satisfies |Δb|≤τ(N)log N. Therefore, for every prime count,

$$
\sum_{N=3}^X\sum_{\mathrm{selected}}w_N|\Delta b|
\le4H_X\log X\sum_{N\le X}\frac{\tau(N)}N
\le4H_X^3\log X.
\tag{12}
$$

This elementary estimate controls the entire selected contribution irrespective of its signs. Where (10) applies, the sign is nonnegative and provides no dissipative cancellation for the required upper bound.

There is an exact extension of the matrix readout to every primitive phase when (n,N)=1 and N=p^kℓ^j. Put t=aN mod n, u=p^{-1} and v=ℓ^{-1}. Then

$$
|\Phi_N(\zeta_n^a)|
=\frac{D_n(t)D_n(tuv)}{D_n(tu)D_n(tv)}
=\left|\frac{\lambda_u(tv)}{\lambda_u(t)}\right|.
\tag{13}
$$

All denominators are nonzero because the residues are units. These are ratios of eigenvalues of the same matrix; dividing both by d_u gives the identical ratio for Q_u. Selected t=±1 is precisely the Perron-denominator case. A ratio of two contraction eigenvalues can exceed one. Along each t→tv orbit the multiplier moduli telescope to product one, but only in an unweighted logarithmic sum. Changing Farey weights and the actual previous logs prevent this from implying a clipped response law. The [fixed history certificate](certificates/cyclotomic_adjacent_history.py) at $n=19,a=8,N=34$ gives $L_{33}<0<L_{34}$ and $\Delta b<0$, rejecting an all-phase extension of (10) even for two primes.

There is also an exact polynomial statement of what does and does not move in the actual history. For N=p^kℓ^j, set

$$
A(z)=\Phi_{\ell^j}(z^{p^{k-1}})
=\prod_{i=0}^{k-1}\Phi_{p^i\ell^j}(z),\qquad
G(z)=F_{N-1}(z)/A(z).
$$

Every factor of A occurs before N, so G is an actual polynomial. The prime-dilation identity gives

$$
F_{N-1}(z)=G(z)A(z),\qquad F_N(z)=G(z)A(z^p).
\tag{14}
$$

If α is an old root whose order does not divide N, then A(α)≠0 and G(α)=0. Differentiating (14) therefore yields

$$
F_{N-1}'(\alpha)=G'(\alpha)A(\alpha),\qquad
F_N'(\alpha)=G'(\alpha)A(\alpha^p).
\tag{15}
$$

The replacement transports one complete earlier prime-power column. The rest of the actual history, G'(α), stays at the original phase. Hence (15) alone is not a transport of the full state and does not give a sign for its clipped response. At N=33 one can take A=Φ₁₁; the already computed deficit entry at 8/19 is compatible with this exact identity.

A Doob transform based on a non-Perron sine mode has row sums one but need not be nonnegative. In the N=33,n=19,a=8 representation, t=17,u=13 and λ₁₃(17)<0, while (B₁₃)₇₇=1. The corresponding diagonal entry of diag(s₁₇)⁻¹B₁₃diag(s₁₇)/λ₁₃(17) is negative. Since t is a unit there are no zero entries in s₁₇; its signs, not undefined divisions, obstruct the proposed stochastic transport.

## Scope of the construction

The Euclidean reciprocal-cancellation mechanism is rejected by the exact history and response fixtures in [cyclotomic adjacent history correction](cyclotomic-adjacent-history-correction.md). The different finite fusion construction proves (10), an arithmetic-specific sign law for the actual observable on its stated cutoffs and phases. Its unchanged global stochastic interpretation is rejected by (11). It therefore cannot provide the proposed global positivity mechanism simply by invoking more Hilbert-space structure.

No full-history transport theorem, all-cutoff cancellation bound, or RH conclusion follows. A uniform theorem would still have to control the genuinely signed higher division differences together with the actual earlier logs, all other phases, the cutoff weights and prime-power scalars. This note does not name that uncontrolled correlation as a new RH principle or assume its desired bound. The verified low-order law is retained as a discriminating constraint on future models; the failed universal positivity extension is retired. The separate [reduced-coordinate bounds](cyclotomic-activity-quadrature.md) remain available; this finite-matrix argument does not improve them.

The finite matrix proof and arithmetic identification above received independent mathematical review. Equation (11) has the displayed direct exact sign proof. The full-history recovery uses the separate rational argument specified above. There is no Lean kernel verification of these new statements yet.
