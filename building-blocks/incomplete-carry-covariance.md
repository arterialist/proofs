# Exact incomplete-box carry covariance

For independent uniform integers A,B in $\{1,\ldots,H\}$, incomplete-box carry covariance reduces to two one-dimensional sawtooth correlations and an explicit endpoint correction. The correction is bounded by $(d+e)/(8H)$, with no lcm-period assumption. The two remaining correlations need not be close to their complete-period values. An exact finite Fourier formula identifies the frequencies responsible.

## 1. Bernoulli conventions and an exact discrete primitive

For an integer $d\ge2$, put
```math
f_d(x)=\{x/d\}-\frac{d-1}{2d},\qquad
c_d=\frac{d-1}{2d},\qquad x\in\mathbb Z.
```
Then
```math
\kappa_d(a,b)=c_d+f_d(a)+f_d(b)-f_d(a+b).
\tag{1}
```
The mean of $f_d$ over a full period is zero. The mean of $\kappa_d$ on a complete square of periods is $c_d$.

The Dedekind sawtooth convention is different at multiples of d. If $\overline B_1(t)=\{t\}-1/2$ off integers and zero at integers, then exactly
```math
f_d(x)=\overline B_1(x/d)+\frac1{2d}-\frac12\mathbf1_{d\mid x}.
\tag{2}
```
The last term must be retained in a Bernoulli or cotangent formula.

Let $r_d(x)\in\{0,\ldots,d-1\}$ be the residue of x and define
```math
P_d(x)=\frac{r_d(x)(r_d(x)-d)}{2d}
=\frac d2\left(B_2(\{x/d\})-\frac16\right).
```
Direct subtraction, including the wrap from residue d−1 to zero, proves
```math
P_d(x+1)-P_d(x)=f_d(x),\qquad -\frac d8\le P_d(x)\le0.
\tag{3}
```
Thus the exact conditional average is
```math
s_d(a):=\mathbb E_B f_d(a+B)
=\frac{P_d(a+H+1)-P_d(a+1)}H,
\qquad |s_d(a)|\le\frac d{8H}.
\tag{4}
```
This keeps the sampling convention A,B=1,…,H. There is no assumption that H is a period.

## 2. Two-dimensional covariance reduced to one dimension

Put S=A+B. Define
```math
C^{\mathrm{flat}}_{d,e}=\operatorname{Cov}(f_d(A),f_e(A)),
\qquad
C^{\mathrm{tri}}_{d,e}=\operatorname{Cov}(f_d(S),f_e(S)),
```
```math
M_{d,e}=\operatorname{Cov}_A(f_d(A),s_e(A)).
```
The triangular law is explicit:
```math
\mathbb P(S=s)=\frac{\nu_H(s)}{H^2},\qquad
\nu_H(s)=\min(s-1,2H+1-s),\quad 2\le s\le2H.
```
Expanding (1), using independence of A and B and symmetry between them, gives
```math
\boxed{
\operatorname{Cov}(\kappa_d,\kappa_e)
=2C^{\mathrm{flat}}_{d,e}+C^{\mathrm{tri}}_{d,e}
-2M_{d,e}-2M_{e,d}.}
\tag{5}
```
Every term on the right is a one-dimensional finite sum. In particular,
```math
M_{d,e}=
\frac1{H^2}\sum_{a=1}^H f_d(a)
\bigl(P_e(a+H+1)-P_e(a+1)\bigr)
-\mathbb E f_d(A)\,\mathbb E f_e(S).
\tag{6}
```
The marginal means are also explicit:
```math
\mathbb E f_d(A)=\frac{P_d(H+1)-P_d(1)}H,
\qquad
\mathbb E f_d(S)=\frac1H\sum_{a=1}^Hs_d(a).
```
Hence the actual incomplete carry mean is
$c_d+2\mathbb E f_d(A)-\mathbb E f_d(S)$, rather than necessarily $c_d$.

A bounded real random variable whose values lie in an interval of length L has variance at most $L^2/4$: subtract the midpoint, bound the second moment, and then subtract the squared mean. The values of $f_d$ lie in an interval of length $(d-1)/d<1$. By (4), those of $s_e$ lie in an interval of length at most $e/(4H)$. Cauchy–Schwarz therefore gives
```math
|M_{d,e}|\le\frac e{16H}.
```
Consequently
```math
\boxed{
\left|\operatorname{Cov}(\kappa_d,\kappa_e)
-2C^{\mathrm{flat}}_{d,e}-C^{\mathrm{tri}}_{d,e}\right|
\le\frac{d+e}{8H}.}
\tag{7}
```
This bound controls the mixed A versus A+B terms. It does not bound either remaining sawtooth correlation by its complete-period mean.

For any finite real coefficients $w_d$, (7) also gives
```math
\left|\operatorname{Var}\!\left(\sum_dw_d\kappa_d\right)
-2\operatorname{Var}\!\left(\sum_dw_df_d(A)\right)
-\operatorname{Var}\!\left(\sum_dw_df_d(S)\right)\right|
\le\frac{(\sum_d|w_d|)(\sum_dd|w_d|)}{4H}.
\tag{8}
```
The exact version is obtained by summing (5). For prime-power weights $w_{p^j}=\log p$, take precisely the finite set $p^j\le2H$; all carries with larger modulus vanish on this box. Legendre’s factorial formula then gives $\sum_{p^j\le2H}(\log p)\kappa_{p^j}(A,B)=\log\binom{A+B}{A}$. The sawtooth sums in (8) use that same finite cutoff; they must not be replaced by untruncated infinite sums. The right side of (8) is not asserted small when moduli extend to the size of H.

## 3. Finite Fourier inversion, including the incomplete frequencies

A directly applicable primary input is [Rassias and Tóth, *Trigonometric representations of generalized Dedekind and Hardy sums via the discrete Fourier transform*, Lemma 2.1(i)](https://arxiv.org/pdf/1512.01466). It gives the unnormalized DFT of the endpoint-zero Dedekind sawtooth as $(i/2)\cot(\pi j/d)$ at nonzero frequencies. The correction (2), followed by division by d, gives
```math
\widehat f_d(j)= -\frac1{d(1-e^{-2\pi ij/d})},\quad 1\le j<d,
\qquad\widehat f_d(0)=0.
\tag{9}
```
The same formula follows independently from
$\sum_{r=0}^{d-1}r z^r=-d/(1-z)$ when $z^d=1,z\ne1$. Thus no unproved reciprocity hypothesis is needed to apply the DFT to these carries.

Write $\mathrm e(t)=e^{2\pi it}$ and
```math
\beta_d(j)=\frac1{d(1-\mathrm e(-j/d))}.
```
Since $\sum_{j=1}^{d-1}\widehat f_d(j)=f_d(0)=-c_d$, Fourier inversion and (1) give the exact carry identity
```math
\boxed{
\kappa_d(a,b)=\sum_{j=1}^{d-1}\beta_d(j)
(1-\mathrm e(ja/d))(1-\mathrm e(jb/d)).}
\tag{10}
```
It is valid at every integer pair, including residue-zero endpoints. Although written with complex coefficients, the sum is real and equals the actual 0-or-1 carry.

Define the finite averaging kernel
```math
R_H(\theta)=\frac1H\sum_{a=1}^H\mathrm e(a\theta).
```
For x,y real, put
```math
\mathcal C_H(x,y)=
[1-R_H(x)-R_H(y)+R_H(x+y)]^2
-(1-R_H(x))^2(1-R_H(y))^2.
```
Independence of A and B in (10) now proves the explicit incomplete covariance formula
```math
\boxed{
\operatorname{Cov}(\kappa_d,\kappa_e)
=\sum_{j=1}^{d-1}\sum_{k=1}^{e-1}
\beta_d(j)\beta_e(k)\,
\mathcal C_H(j/d,k/e).}
\tag{11}
```
This is a bilinear Fourier expansion of real covariance; there is no omitted complex conjugation. Pairing opposite frequencies makes its reality explicit.

To verify the formula, set $V_x=(1-\mathrm e(xA))(1-\mathrm e(xB))$. Its mean is $(1-R_H(x))^2$, and
$\mathbb E V_xV_y=[1-R_H(x)-R_H(y)+R_H(x+y)]^2$. This proves (11) by expansion.

When H is a common multiple of d and e, $R_H(j/d)=R_H(k/e)=0$, while $R_H(j/d+k/e)$ is 1 exactly at resonances and zero otherwise. Then $\mathcal C_H=3\mathbf1_{j/d+k/e\in\mathbb Z}$, recovering the complete-period reduction to three times the sawtooth covariance. For incomplete H, the same terms remain weighted by exact finite sums instead of being set to zero.

For nonintegral $\theta$,
```math
R_H(\theta)=\frac{\mathrm e(\theta)(1-\mathrm e(H\theta))}{H(1-\mathrm e(\theta))},
\qquad
|R_H(\theta)|\le\min\left(1,\frac1{2H\|\theta\|}\right).
\tag{12}
```
Thus a frequency near an integer on the scale $1/H$ need not be small. Cross-modulus frequencies can be spaced by $1/\operatorname{lcm}(d,e)$. Equation (12) explains why the endpoint estimate (7) cannot justify replacing the remaining one-dimensional sums by complete-period averages.

## 4. Exact small-box distinction and source limits

Direct rational evaluation on the box H=6 gives

| d,e | $C^{\mathrm{flat}}$ | $C^{\mathrm{tri}}$ | $M_{d,e}$ | $M_{e,d}$ | Carry covariance |
|---|---:|---:|---:|---:|---:|
| 3,5 | $-1/45$ | $-1/54$ | $-1/270$ | 0 | $-1/18$ |
| 2,5 | $-1/40$ | 0 | $1/360$ | 0 | $-1/18$ |

For example, the first row gives
$-2/45-1/54+1/135=-1/18$. The endpoint corrections have opposite signs in these two cases. At H=15,d=3,e=5, every term in (5) is zero, as the complete-period law requires. These are finite rational calculations, not asymptotic or stochastic approximations.

[Beck and Chavez, *Bernoulli–Dedekind sums*, equations (1), (4) and Theorem 2](https://arxiv.org/pdf/1008.0038) give the Bernoulli conventions and the complete-residue framework for products of shifted Bernoulli functions. Their stated main reciprocity theorem additionally requires pairwise coprime moduli and noncoincident shifts. Arbitrary d,e and finite intervals here do not automatically satisfy those conditions. Equations (3), (5) and (11) retain the exact endpoint and interval factors instead of importing a complete-sum reciprocity formula without its hypotheses.

The useful next input for the prime-power calculation is therefore the actual weighted sum of the nonresonant terms in (11), or equivalently the two one-dimensional correlations in (5), with (6) retained. Fixed-base Markov carry results do not estimate these cross-modulus frequency interactions. No prime-error estimate is supplied by this reduction alone.

These are written mathematical deductions using the cited classical identities, with exact priority unresolved. No Lean formalization or RH conclusion is claimed.
