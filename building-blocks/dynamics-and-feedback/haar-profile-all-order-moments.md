# Exact Haar profile moments and the finite geometric-pole transition

Let $X\ge2$, $A=\log X$, and let theta_p be independent uniform angles for all primes p<=X. Retain the complete local scattering expansion

$$
 u_p(\theta)=-r_p e^{i\theta}+(1-r_p^2)\sum_{j\ge0}r_p^j e^{-ij\theta},
 \qquad r_p=p^{-1/2}.
$$

Write U(theta)=product u_p(theta_p). This is unimodular. For a multi-index nu with each nu_p in {1,0,-1,-2,...}, let c_nu be the product Fourier coefficient and

$$
 \lambda_\nu=\frac1A\sum_{p\le X}(\log p)\nu_p.
$$

These are written proofs using the exact [finite geometric history law](../prime-history/complete-prime-history-entropy.md), ordinary Haar orthogonality and exponential-moment estimates; no Lean formalization or priority claim is made.

At this fixed finite X, the coefficients are absolutely summable with every polynomial weight in lambda_nu. Their squared moduli define independent full histories

$$
 \mathbb P(\nu_p=1)=q_p,\qquad
 \mathbb P(\nu_p=-j)=(1-q_p)^2q_p^j\quad(j\ge0),\qquad q_p=1/p.
$$

Their means are zero. Let Y_X=sum (log p)nu_p and Z_X=Y_X/A. None of these laws truncates the proper powers.

## 1. The exact all-order identity

Use the plus-exponential physical convention and define the profile

$$
 F_X(v;\theta)=\overline{U(\theta)}
 \sum_\nu c_\nu e^{i\nu\cdot\theta}\mathbf1_{\{v<\lambda_\nu\}}.
$$

Because the coefficients sum to U(theta), its centered profile is

$$
 Q_X(v;\theta):=F_X(v;\theta)-\mathbf1_{\{v<0\}}
 =\overline{U(\theta)}\sum_\nu c_\nu e^{i\nu\cdot\theta}
 [\mathbf1_{\{v<\lambda_\nu\}}-\mathbf1_{\{v<0\}}].
 \tag{1}
$$

The endpoint convention does not affect any integral. Multiplication by conjugate U has modulus one. Haar orthogonality in (1), followed by Tonelli, therefore gives for every integer $m\ge0$

$$
 \begin{aligned}
 \mathbb E_{\rm Haar}\int_{\mathbb R}v^{2m}|Q_X(v)|^2dv
 &=\sum_\nu |c_\nu|^2\int_{\min(0,\lambda_\nu)}^{\max(0,\lambda_\nu)}v^{2m}dv\\
 &=\boxed{\frac{\mathbb E|Z_X|^{2m+1}}{2m+1}.}
 \end{aligned}
 \tag{2}
$$

This retains all mixed coefficients until orthogonality is actually applied. It is not a pointwise incoherent replacement. Absolute polynomial summability justifies the infinite Fourier series at fixed X; alternatively apply Parseval first at each v and use nonnegative Tonelli.

Set

$$
 E_X(a;\theta)=\overline{U(\theta)}U(\theta_p+a\log p/A),\qquad
 f_X(a;\theta)=\frac{E_X(a;\theta)-1}{a}.
$$

The elementary signed-interval identity gives

$$
 f_X(a;\theta)=i\int_{\mathbb R}Q_X(v;\theta)e^{iav}dv.
$$

Polynomial absolute coefficient summability ensures Q_X has every polynomially weighted L2 norm, for example by Minkowski applied to the intervals in (1). Plancherel thus proves, with the exact normalization,

$$
 \boxed{\mathbb E_{\rm Haar}\|f_X^{(m)}\|_2^2
 =\frac{2\pi}{2m+1}\mathbb E|Z_X|^{2m+1}.}
 \tag{3}
$$

A reflected Fourier convention changes lambda to minus lambda and leaves (2)-(3) unchanged.

## 2. Exact exponential-moment domain

For v_p=log p/A and real z, direct summation of the full geometric law gives

$$
 \mathbb Ee^{zv_p\nu_p}
 =q_pe^{zv_p}+\frac{(1-q_p)^2}{1-q_pe^{-zv_p}}
 =\frac{1-2q_p+q_pe^{zv_p}}{1-q_pe^{-zv_p}},
 \qquad z>-A.
 \tag{4}
$$

The expectation is infinite when $z\le-A$. In particular, for $t\ge0$,

$$
 \mathbb Ee^{-tZ_X}
 =\prod_{p\le X}\frac{1-2/p+p^{-1}e^{-tv_p}}{1-p^{-1}e^{tv_p}}
 \quad\text{is finite exactly when }t<A.
 \tag{5}
$$

The positive exponential moment is finite for every $t\ge0$, since each positive history is bounded by 1 and only finitely many primes occur. It follows that E exp(t|Z_X|) is finite exactly for 0<=t<A. Already p=2 forces divergence at t=A. Analytic continuation of the rational product beyond this boundary is not an exponential moment.

## 3. Uniform logarithmic MGF bound away from the pole

Only the elementary Chebyshev upper estimate theta(x)<=C x is used below. Partial summation yields

$$
 \sum_{p\le X}\frac{v_p^2}{p}
 =A^{-2}\sum_{p\le X}\frac{(\log p)^2}{p}\le C_0
 \tag{6}
$$

with an absolute C_0, uniformly for $X\ge2$.

For 0<=t<=A/2 put w=p^{-1}e^{tv_p}. Then w<=p^{-1/2}<=rho=2^{-1/2}. The exact local law gives

$$
 \mathbb E[\nu_p^2e^{tv_p|\nu_p|}]
 =w+(1-q_p)^2\sum_{j\ge1}j^2w^j
 \le B w,
 \qquad B=1+\frac{1+\rho}{(1-\rho)^3}.
$$

Use E nu_p=0 and e^x-1-x<=x^2e^{|x|}/2. Independence, log(1+y)<=y, and (6) imply the two signed bounds

$$
 \boxed{\log\mathbb Ee^{\pm tZ_X}
 \le\frac B2t^2\sum_{p\le X}\frac{v_p^2e^{tv_p}}p
 \le C_1t^2e^t,\qquad 0\le t\le A/2,}
 \tag{7}
$$

where C_1=BC_0/2 is absolute. This estimate includes p=2 without a small-prime exception and includes every geometric depth.

## 4. All-order uniform moment growth

Let $k\ge1$ be any real number and put

$$
 d=\min\{\log(2+k),A\},\qquad t=d/2.
$$

Then t<=A/2. Since t<=log(2+k)/2,

$$
 \frac{t^2e^t}{k}
 \le\frac{\log^2(2+k)\sqrt{2+k}}{4k}\le\frac{12}{e^2}.
$$

For the last inequality use log z<=4z^{1/4}/e and (2+k)/k<=3. The elementary bound y^k<= (k/(et))^k exp(ty), together with exp(t|z|)<=exp(tz)+exp(-tz), now proves

$$
 \boxed{\|Z_X\|_k\le C\frac{k}{\min\{\log(2+k),A\}},\qquad X\ge2,\ k\ge1,}
 \tag{8}
$$

where one adequate explicit constant is C=(4/e) exp(12 C_1/e^2). Its size is not optimized.

Combining (8) with the exact identity (3), and absorbing universal constants, gives for every integer $m\ge1$

$$
 \boxed{\mathbb E_{\rm Haar}\|f_X^{(m)}\|_2^2
 \le\left[\frac{C_*m}{\min\{\log(2+m),\log X\}}\right]^{2m}.}
 \tag{9}
$$

Indeed use k=2m+1<=3m, divide its kth-moment bound by k as in (3), and note that the remaining factor C/min{log(2+m),A} is uniformly bounded because A>=log 2.

For 1<=m<=X, log(2+m)<=2 log X, so (9) gives the moderate-order regime

$$
 \mathbb E_{\rm Haar}\|f_X^{(m)}\|_2^2
 \le\left[\frac{C_{**}m}{\log(2+m)}\right]^{2m}.
 \tag{10}
$$

For m>=X, (9) instead has the finite-geometric bound [C_*m/log X]^{2m}. This is a uniform bound, not an assertion of a sharp crossover constant or a relative approximation by the limiting Dickman distribution.

## 5. The repeated-power obstruction is genuine

The finite pole is also visible directly in high moments. Write Z_X=(log 2/A)nu_2+R_X, where R_X is independent and has mean zero. Conditional Jensen gives for every real $k\ge1$

$$
 \mathbb E|Z_X|^k\ge
 \left(\frac{\log2}{A}\right)^k
 \left[\frac12+\frac14\sum_{j\ge1}j^k2^{-j}\right].
 \tag{11}
$$

This retains all the other histories through their exact zero mean; it does not condition them to vanish. Taking only j=floor(k/log 2) gives the uniform lower bound

$$
 \|Z_X\|_k\ge\frac{k}{8eA}.
 \tag{12}
$$

At each fixed X, a sharper exact asymptotic follows. For the same j, j log 2/k tends to 1, so (11) gives

$$
 \liminf_{k\to\infty}\frac A k\|Z_X\|_k\ge e^{-1}.
$$

For any fixed 0<t<A, the finite absolute exponential moment and the same elementary moment inequality give

$$
 \limsup_{k\to\infty}\frac1k\|Z_X\|_k\le\frac1{et}.
$$

Letting t increase to A proves

$$
 \boxed{\|Z_X\|_k\sim\frac{k}{e\log X}\quad(k\to\infty),\qquad X\text{ fixed}.}
 \tag{13}
$$

In particular

$$
 \lim_{m\to\infty}\frac{\log X}{2m}
 \left(\mathbb E_{\rm Haar}\|f_X^{(m)}\|_2^2\right)^{1/(2m)}=e^{-1}.
$$

Thus a bound with m/log m at every order and an absolute constant is false at fixed X. The exact coefficient law supplies both the moderate-order bound and the obstruction to extending it through the finite geometric poles. These Haar identities and order bounds do not themselves replace the separate real-window estimates.


## 6. The continuous limiting law and thin fixed bands

For each fixed real $t$, the exact local characteristic factor (4) has logarithm

$$
\log\mathbb E e^{itv_p\nu_p}
=\frac2p(\cos(tv_p)-1)+O_t(p^{-2}v_p^2).
$$

For large $A$ the finitely many small primes have $tv_p$ small; for the remaining primes expansion in $1/p$ is uniform. The centered first derivative vanishes, giving the stated $v_p^2$ remainder. Its sum is $O_t(A^{-2})$. Partial summation from the classical PNT then gives

$$
\mathbb E e^{itZ_X}\longrightarrow
\exp\left(2\int_0^1\frac{\cos(tv)-1}{v}\,dv\right).
\tag{14}
$$

For clarity, the PNT step applies first on $v\in[\delta,1]$; the integrand's quadratic zero and Chebyshev's bound make the omitted part $O_t(\delta^2)$ uniformly in $X$. Thus $Z_X$ converges in law to the difference of two independent positive Poisson integrals with intensity $dv/v$ on $(0,1]$. This is the parameter-one instance of the law explicitly constructed in the [prime-heat profile](../prime-distribution/fixed-observation-prime-heat.md#11-the-actual-large-age-heat-profile).

The limiting characteristic function is $O((1+|t|)^{-2})$, by the cosine-integral formula, so its law has a bounded continuous density. Consequently, for each fixed $c$,

$$
\lim_{\varepsilon\downarrow0}\limsup_{X\to\infty}
\Pr\{|Z_X+c|\le\varepsilon\}=0.
\tag{15}
$$

This is a statement for fixed shrinking bands after the large-$X$ limit. It does not bound coherent off-diagonal sums over an arbitrary actual observation window. The [signed divisor-band identity](../prime-distribution/signed-divisor-band-correlations.md) retains those terms explicitly.
