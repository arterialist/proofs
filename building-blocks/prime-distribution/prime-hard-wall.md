# Prime occupation modes with an exact additive hard wall

The exact hard wall produces conditional repulsion but mixed marginal correlation signs. It fails the tested real-stability, Rayleigh and Lee-Yang conditions. This branch then repairs the factorization in two ways. A positive slack bath preserves the cutoff microcanonically; a logistic bath gives an explicit, quantitatively controlled soft wall. Neither repair supplies the positive inverse transformation needed for an RH argument.

The useful retained structure is an exact Laplace product and a bath multiplier that can be calculated independently of the primes. Its hard-wall limit requires complex inversion and loses a uniform absolute contour norm. This is a precise residual obligation, not a proof of RH. All proofs below are written mathematics. The accompanying script supplies exact rational finite checks and numerical diagnostics, not Lean verification.

## 1. The arithmetic model and its finite-size response

Let P be a finite set of distinct actual primes, let ell_p=log p, and put E_A=sum_{p in A}ell_p for A subset P. For an integer N>=1 define

$$
Z_{N,P}(z)=\sum_{A\subseteq P}\mathbf1_{\prod_{p\in A}p\le N}
\prod_{p\in A}z_p.
\tag{1}
$$

For the later Laplace formulas, use the same finite sum with a real cutoff in the indicator. Unique factorization gives one state for each squarefree P-smooth integer. This is the squarefree subspace of the integer basis, not the full integer Hilbert space. At z_p=-1 the polynomial is

$$
Z_{N,P}(-1)=\sum_{\substack{n\le N\\p\mid n\Rightarrow p\in P}}\mu(n).
\tag{2}
$$

If P contains every prime at most N, this is the actual Mertens sum M(N). The cutoff can equally be written E_A<L with L=log(N+1/2). This places the wall strictly between integer energies and avoids a half-weight convention at an inverse-transform discontinuity.

For positive activities z_p, divide the weights by Z to obtain a probability distribution and let X_p be the zero-or-one occupation. Then

$$
z_p\partial_{z_p}\log Z=\mathbb E X_p,\qquad
z_pz_q\partial_{z_p}\partial_{z_q}\log Z
=\operatorname{Cov}(X_p,X_q),\quad p\ne q.
\tag{3}
$$

The additive response is also exact. With P fixed, Z_{N,P}-Z_{N-1,P} is zero unless N is squarefree and P-smooth; in that case it is the single monomial for N. For N>=2 the previous ensemble is nonempty. If the new state has occupation vector x, positive weight w, and theta=w/Z_N, then

$$
\begin{aligned}
m_N&=(1-\theta)m_{N-1}+\theta x,\\
\Sigma_N&=(1-\theta)\Sigma_{N-1}
+\theta(1-\theta)(x-m_{N-1})(x-m_{N-1})^T.
\end{aligned}
\tag{4}
$$

Here m and Sigma are the occupation mean and covariance matrix. This is the covariance formula for adding one atom to a probability distribution. Its off-diagonal response can have either sign. The exact new integer, rather than a putative phase transition, determines that response.

## 2. Mixed correlations and the first discriminator

Fix distinct p,q in P. Let F(t) be the partition sum of all the remaining modes with energy at most t, with F(t)=0 for t<0. For wall energy L write

$$
Z=A+z_pB+z_qC+z_pz_qD,
\quad
A=F(L),\ B=F(L-\ell_p),\ C=F(L-\ell_q),\ D=F(L-\ell_p-\ell_q).
$$

Direct differentiation gives the Rayleigh difference and covariance:

$$
\partial_pZ\,\partial_qZ-Z\partial_p\partial_qZ=BC-AD,
\quad
\boxed{\operatorname{Cov}(X_p,X_q)=z_pz_q(AD-BC)/Z^2.}
\tag{5}
$$

Thus the sign depends on a finite difference of log F. Positivity and monotonicity of F alone do not control it.

Take P={2,3,5}, N=6. The five states are 1,2,3,5,6, and

$$
Z=(1+z_2)(1+z_3)+z_5.
\tag{6}
$$

For the pair 2,3 the Rayleigh difference is -z_5; for 2,5 it is 1+z_3. At all activities equal to 1,

$$
\operatorname{Cov}(X_2,X_3)=1/25,
\qquad
\operatorname{Cov}(X_2,X_5)=-2/25.
\tag{7}
$$

Equation 4 makes the change in the first sign explicit. At N=5 the four states have Cov(X_2,X_3)=-1/16. Admitting the actual integer 6 adds x=(1,1,0) with theta=1/5 and changes that covariance to

$$
\frac45\left(-\frac1{16}\right)
+\frac15\frac45\left(\frac34\right)^2=\frac1{25}.
$$

The usual multiaffine Rayleigh condition requires BC-AD>=0 at positive activities, so it fails. Real stability means that the polynomial is nonzero whenever every variable has strictly positive imaginary part. It fails directly, without appealing to an equivalence theorem:

$$
z_2=z_3=-2+i,\quad z_5=2i\quad\Longrightarrow\quad Z=0.
\tag{8}
$$

The natural Lee-Yang tests also fail. The equal-fugacity polynomial is 1+3z+z^2, with roots (-3 plus or minus sqrt(5))/2, of different moduli. They cannot both lie on one circle centered at zero, even after a common positive fugacity rescaling. Multivariate zeros occur both strictly inside the unit polydisc, at (-1/2,-1/2,-1/4), and strictly outside it, at (-3,-3,-4).

These tests concern the stated occupation variables. They do not exclude every possible engineered change of variables. Any replacement would need to preserve the integer coefficients and the signed specialization separately.

The ferromagnetic lattice inequality also fails. Feasible sets {2} and {5} have positive weights, but their union is forbidden. Therefore

$$
w(\{2,5\})w(\varnothing)<w(\{2\})w(\{5\}).
$$

There is a retained reverse lattice inequality. Since the feasible sets form a down-set,

$$
w(A)w(B)\ge w(A\cup B)w(A\cap B)
\tag{9}
$$

for all A,B at positive activities. If the right side is nonzero, the union is feasible, so all four sets are feasible and the multiplicative activities give equality. Otherwise the inequality is immediate.

Equivalently, conditioning on every other occupation leaves a two-mode hard wall whose covariance is nonpositive. Both single occupations can be allowed while their joint occupation is forbidden, producing repulsion; if the joint occupation is allowed, the two modes are independent. But marginalizing the other occupations need not preserve that sign. Equation 7 is the explicit counterexample. Conditional repulsion is the structure retained, and it is weaker than the desired Rayleigh property.

At signed activities there is no positive Gibbs probability measure. Even the path z_p=-t from t=0 to t=1 crosses a zero of equation 6 at t=(3-sqrt(5))/2. Bounds on a positive-activity logarithm cannot be continued to the Möbius specialization by assuming a zero-free path.

## 3. Exact repair by an energy-slack bath

Introduce one nonnegative real slack variable y. In the distributional sense,

$$
\mathbf1_{E<L}=\int_0^\infty\delta(L-E-y)\,dy
$$

away from E=L. Thus the hard wall has an exact positive microcanonical representation. Each integer configuration receives total bath weight one if it is allowed and zero otherwise. This construction adds no integer-state multiplicity. The constraint still couples the occupations through their shared total energy.

Laplace transformation in L removes that constraint. For Re s>0,

$$
\boxed{\int_0^\infty e^{-sL}Z_{e^L,P}(z)\,dL
=\frac1s\prod_{p\in P}(1+z_pp^{-s}).}
\tag{10}
$$

Indeed, each configuration contributes integral_{E_A}^infinity e^{-sL}dL=e^{-sE_A}/s, and the finite sum factors. The factor 1/s is the exact slack-bath transform. For real s>0 and positive activities the transformed ensemble has independent occupations with mean z_pp^{-s}/(1+z_pp^{-s}).

The fixed wall is recovered by the inverse transform

$$
Z_{N,P}(z)=\lim_{T\to\infty}\frac1{2\pi i}
\int_{\sigma-iT}^{\sigma+iT}
\frac{e^{sL}}s\prod_{p\in P}(1+z_pp^{-s})\,ds,
\quad L=\log(N+1/2),\quad \sigma>0.
\tag{11}
$$

For finite P this follows term by term from the elementary inverse Laplace formula for the step function. The limit is a symmetric improper integral. It is not an integral against a positive probability distribution in s.

This distinction cannot be repaired by a nonnegative mixture of ordinary scalar-temperature Gibbs weights. If

$$
g(E)=\int e^{-\beta E}\,d\nu(\beta),\qquad \nu\ge0,
\tag{12}
$$

with real finite beta and a nonzero finite value at the relevant energies, then g(E)>0 at every such energy. A nontrivial hard wall is positive on allowed states and exactly zero on forbidden states. Equation 12 cannot equal it. A possible atom at beta=+infinity only adds weight at the zero-energy state and does not solve the problem.

There is also a robust approximation obstruction. Normalize g(0)=1. Hölder's inequality implies log convexity:

$$
g(tE)\le g(E)^t,\qquad 0<t<1.
\tag{13}
$$

Use the actual squarefree energies log2 and log10 with N=6. Here t=log2/log10>1/4. If a normalized positive thermal mixture approximated both hard-wall coefficients within 1/4, it would satisfy g(log2)>=3/4 and g(log10)<=1/4. But equation 13 would give

$$
g(\log2)\le(1/4)^t<(1/4)^{1/4}=1/\sqrt2<3/4,
$$

a contradiction. This excludes even arbitrarily accurate approximation by this positive scalar bath. It does not exclude arbitrary mixtures of degenerate product distributions.

In fact, an exact positive decomposition into such sectors exists. In equation 6 one sector has 5 absent and 2,3 free; the other has 5 present and 2,3 absent. The sectors are disjoint and determined by the integer configuration, so no state is counted twice. More generally, a binary decision tree on the primes partitions the feasible configurations into disjoint subcubes. Within each subcube the unfixed occupations factor. This is an exact positive bookkeeping repair, but mixing the sectors recreates the observed positive correlations. No uniform bound on the number of sectors or on the signed sum follows from it.

## 4. Controlled soft-wall repair

For kappa>0 set

$$
h_\kappa(u)=\frac1{1+e^{-\kappa u}},\qquad
Z_{\kappa,L,P}(z)=\sum_{A\subseteq P}z_Ah_\kappa(L-E_A).
\tag{14}
$$

This is a positive finite ensemble at positive activities. At a wall separated from every E_A by delta>0, each coefficient differs from the exact hard-wall coefficient by at most exp(-kappa delta). Consequently

$$
|Z_{\kappa,L,P}(z)-Z_{N,P}(z)|
\le e^{-\kappa\delta}\prod_{p\in P}(1+|z_p|).
\tag{15}
$$

The product representation is again exact after transforming the bath. For 0<Re s<kappa, substitution v=exp(kappa u) gives

$$
\int_{-\infty}^\infty e^{-su}h_\kappa(u)\,du
=\frac1\kappa\int_0^\infty\frac{v^{-s/\kappa}}{1+v}\,dv
=\frac{\pi}{\kappa\sin(\pi s/\kappa)}=:b_\kappa(s).
\tag{16}
$$

The last step uses the classical [Euler beta integral](https://dlmf.nist.gov/5.12.E3) and [reflection formula](https://dlmf.nist.gov/5.5.E3), with both beta parameters having positive real part. Therefore

$$
\boxed{Z_{\kappa,L,P}(z)=\frac1{2\pi i}
\int_{\sigma-i\infty}^{\sigma+i\infty}
e^{sL}b_\kappa(s)\prod_{p\in P}(1+z_pp^{-s})\,ds,}
\quad0<\sigma<\kappa.
\tag{17}
$$

Unlike equation 11, this integral is absolutely convergent for fixed finite P. The bath multiplier decays exponentially when |Im s| is much larger than kappa.

The repair does not restore Rayleigh positivity near the sharp wall. For P={2,3,5} and L=log6.5, let epsilon=exp(-kappa log(13/12)). Every coefficient of the eight-state soft polynomial is within epsilon of its hard counterpart. At z_5=1 the four coefficients in equation 5 are within 2epsilon of A=2,B=C=D=1. Hence

$$
BC-AD\le-1+10\epsilon+8\epsilon^2<0
\quad\hbox{if }\epsilon\le1/16.
\tag{18}
$$

Thus all kappa>=log16/log(13/12) retain the failed Rayleigh inequality. At kappa=36 the numerical value is about -0.8937773. The obstruction survives a controlled approximation; it is not an artifact of the discontinuous wall.

There is a second explicit limiting defect. With fixed sigma>0 and kappa/sigma tending to infinity,

$$
\int_{-\infty}^\infty|b_\kappa(\sigma+it)|\,dt
=\Theta(\log(\kappa/\sigma)).
\tag{19}
$$

Indeed,

$$
|\sin(\pi(\sigma+it)/\kappa)|^2
=\sin^2(\pi\sigma/\kappa)+\sinh^2(\pi t/\kappa).
$$

For |t|<=kappa this makes |b_kappa| comparable to 1/sqrt(sigma^2+t^2), with constants uniform once kappa>=2sigma. Beyond that range the exponential tail has bounded integral. This proves equation 19. Pointwise b_kappa(s) tends to 1/s, whose absolute integral on a vertical line diverges. The exact wall is recovered, but a uniform absolute bath norm is lost.

## 5. Quantitative recovery of the actual signed cutoff

The crude finite-product error in equation 15 is not needed for the actual Möbius specialization. Put x=N+1/2 and kappa>1. Define the absolutely convergent soft sum over all integers

$$
M_\kappa(x)=\sum_{n\ge1}\frac{\mu(n)}{1+(n/x)^\kappa}.
$$

Using |mu(n)|<=1 and comparing the two monotone tails with integrals gives

$$
\begin{aligned}
|M_\kappa(x)-M(N)|
&\le\sum_{n\le N}(n/x)^\kappa+\sum_{n\ge N+1}(x/n)^\kappa\\
&\le\boxed{(N/x)^\kappa\left(1+\frac N{\kappa+1}\right)
+(x/(N+1))^\kappa\left(1+\frac{N+1}{\kappa-1}\right).}
\end{aligned}
\tag{20}
$$

For example, kappa at least 2(N+1)(A+1)log N makes the error O(N^{-A-1}) for fixed A>0 and N>=2. This follows from log(1+1/(2N))>=1/(2N+1) and log(1+1/(2N+1))>=1/(2N+2). The wall can therefore be recovered to arbitrarily high algebraic accuracy without altering any integer coefficient in the limit.

For 1<sigma<kappa, absolute convergence of the Euler product and the bath integral gives

$$
\boxed{M_\kappa(x)=\frac1{2\pi i}\int_{\sigma-i\infty}^{\sigma+i\infty}
\frac{x^s b_\kappa(s)}{\zeta(s)}\,ds.}
\tag{21}
$$

Here zeta(s)=sum n^{-s} on Re s>1, and the reciprocal product follows directly by expanding the absolutely convergent product of 1-p^{-s}. Equation 21 is an exact arithmetic repair. It has not moved the integration line into the critical strip or bounded that integral at square-root size.

For finite P, one can place a contour to the left of 1 without encountering a pole of the finite squarefree product. That does not give a uniform estimate when P grows to include the actual primes. The elementary bound becomes

$$
\left|\prod_{p\in P}(1-p^{-\sigma-it})\right|
\le\prod_{p\in P}(1+p^{-\sigma}),
$$

which supplies no required uniform prime cancellation. In the infinite product, obtaining the relevant continuation and contour estimates for 1/zeta is precisely the missing arithmetic work. Equations 19 and 20 quantify the bath cost; they do not pay the prime-product cost.

## 6. Full prime-power occupations are a different model

The full occupation model has a_p in the nonnegative integers and energy sum_p a_p log p. Its hard-wall partition is

$$
\mathcal Z_{N,P}(z)=\sum_{\prod p^{a_p}\le N}\prod_{p\in P}z_p^{a_p}.
\tag{22}
$$

It has one state per P-smooth integer, including prime powers. If P contains every prime up to N, then mathcal Z_{N,P}(1)=N, with the original simple integer spectrum. The exact Laplace product is

$$
\int_0^\infty e^{-sL}\mathcal Z_{e^L,P}(z)\,dL
=\frac1s\prod_{p\in P}(1-z_pp^{-s})^{-1},
\tag{23}
$$

provided Re s>0 and |z_p|p^{-Re s}<1 for every p. The occupation sum is now geometric rather than multiaffine.

The loss of uniform marginal sign persists over positive activities. For P={2,3,5}, N=6,

$$
\mathcal Z=1+z_2+z_2^2+z_3+z_5+z_2z_3.
$$

At z_2=z_3=1 and z_5=t>0, direct occupation moments give

$$
\operatorname{Cov}(a_2,a_3)=\frac{t-3}{(5+t)^2}.
\tag{24}
$$

It is negative at t=1 and positive at t=4. This statement concerns positive fugacities as a family; it does not assert a sign change at the uniform integer measure.

In the infinite-prime canonical model at z_p=1 and real s>1, the product is zeta(s), and independent geometric occupations give

$$
-\frac{d}{ds}\log\zeta(s)
=\sum_p\frac{\log p}{p^s-1}
=\sum_{m\ge1}\frac{\Lambda(m)}{m^s}.
\tag{25}
$$

This is the precise connection to actual prime powers. For the logistic wall it yields, on 1<sigma<kappa,

$$
\sum_{m\ge1}\frac{\Lambda(m)}{1+(m/x)^\kappa}
=\frac1{2\pi i}\int_{\sigma-i\infty}^{\sigma+i\infty}
x^s b_\kappa(s)\left(-\frac{\zeta'}\zeta(s)\right)ds.
\tag{26}
$$

The soft prime sum also recovers the actual sharp psi cutoff quantitatively. For x=N+1/2, b=N+1 and kappa>=2, use Lambda(n)<=log n and the same tail comparison as in equation 20. The resulting error is at most

$$
\log N\,(N/x)^\kappa\left(1+\frac N{\kappa+1}\right)
+(x/b)^\kappa\left[\log b\left(1+\frac b{\kappa-1}\right)
+\frac b{(\kappa-1)^2}\right].
\tag{27}
$$

For the upper tail, the needed integral is integral_b^infinity (log t)t^{-kappa}dt, and its integrand is decreasing under these hypotheses. Thus equation 27 requires no prime-error premise.

Moving the contour in equation 26 past s=1 produces the prospective volume residue x b_kappa(1). Its difference from x is O(x/kappa^2) as kappa grows. Further motion requires control of the poles at actual zeta zeros and of the remainder. Positivity of the occupations establishes none of those analytic facts in the critical strip.

Finally, assigning z_p=-1 in the full occupation model yields (-1)^{Omega(n)}, the Liouville function, not mu(n). Its absolutely convergent canonical product on Re s>1 is zeta(2s)/zeta(s). The squarefree Möbius test, full integer counting, and von Mangoldt energy derivative must remain distinct.

## 7. Residual obligation and checked scope

The branch supplies two concrete repairs. The positive slack bath preserves the exact cutoff but retains a microcanonical coupling. The logistic bath restores an absolutely convergent factorized contour formula and approximates the actual signed cutoff with the explicit error in equation 20. Returning to the sharp wall requires complex inversion, while every sufficiently sharp logistic approximation still fails the actual Rayleigh test.

A viable next theorem would have to bound the compensated, actual-prime contour in equation 21 or 26 uniformly as the wall sharpens and the prime set grows, or prove a new correlation inequality strong enough to supply that bound. Conditional repulsion, a positive sector decomposition, and canonical independence are all proved here and do not provide it. No Lee-Yang or zero-free property is assumed for a repaired model.

The [finite check](../../certificates/prime_hard_wall.py) verifies the covariance fractions and Gaussian-integer stability zero exactly. It also retains explicitly labeled floating-point diagnostics for the soft Rayleigh expression and the soft Möbius cutoff. The analytic inequalities above, rather than those diagnostics, prove the infinite-tail statements. No Lean claim is made.
