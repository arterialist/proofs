# Exact incomplete-box carry covariance

For independent uniform integers A,B in $\{1,\ldots,H\}$, incomplete-box carry covariance reduces to two one-dimensional sawtooth correlations and an explicit endpoint correction. The correction is bounded by $(d+e)/(8H)$, with no lcm-period assumption. The two remaining correlations need not be close to their complete-period values. An exact finite Fourier formula identifies the frequencies responsible.

Throughout $H\ge1$ is an integer and the actual carry is

```math
\kappa_d(a,b)=\left\lfloor\frac{a+b}{d}\right\rfloor
-\left\lfloor\frac a d\right\rfloor-\left\lfloor\frac b d\right\rfloor.
```

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

## 5. The arithmetic carry cocycle and positive box arrivals

The following exact identities retain the von Mangoldt weights at every level. Define, for nonnegative integers $a,b$,

$$
C_H(a,b)=\sum_{d\le H}\Lambda(d)\kappa_d(a,b),\qquad
J_H=\sum_{1\le a,b\le H}C_H(a,b).
\tag{13}
$$

Writing $a=dq+r$ and $b=ds+t$, with $0\le r,t<d$, gives $\kappa_d(a,b)=\mathbf1_{r+t\ge d}$. In particular each carry is zero or one. Cancellation of the intermediate floors also proves, for every modulus separately,

$$
\kappa_d(a,b)+\kappa_d(a+b,c)
=\kappa_d(b,c)+\kappa_d(a,b+c).
\tag{14}
$$

The same cocycle identity holds for $C_H$. The connection to binomial valuations is classical: Kummer's carry theorem is recalled in Granville's [*Arithmetic Properties of Binomial Coefficients I*, introduction](https://www.cecm.sfu.ca/organics/papers/granville/paper/binomial/html/node2.html). In the present normalization it can also be checked directly. Prime factorization gives $\sum_{d\mid m}\Lambda(d)=\log m$, hence

$$
\sum_{d\le n}\Lambda(d)\lfloor n/d\rfloor=\log(n!).
$$

Subtracting three such identities proves
$\sum_{d\le a+b}\Lambda(d)\kappa_d(a,b)=\log\binom{a+b}{a}$.
The cutoff in (13) remains $H$; replacing it by $a+b$ would change its arithmetic arrival law.

For every integer $H\ge2$, the exact increment is

$$
J_H-J_{H-1}
=\frac{H(H-1)}2\Lambda(H)
 +\sum_{d<H}\Lambda(d)B_d(H),
\tag{15}
$$

where, with $r=H\bmod d$ and $k=\lfloor(H-1)/d\rfloor$,

$$
B_d(H)=
\begin{cases}
2kr+2(2r-d)_++\mathbf1_{2r\ge d},&r>0,\\
0,&r=0.
\end{cases}
\tag{16}
$$

Here $x_+=\max(x,0)$. To prove (15), first admit the new modulus $d=H$. On the full square its number of carries is $H(H-1)/2$: the residue zero contributes none, and the remaining residues give $1+2+\cdots+(H-1)$. Each old modulus gains the row $(H,b)$ for $1\le b<H$, its transposed column, and the corner $(H,H)$. If $r=0$, all these carries vanish. If $r>0$, the row has $k$ full blocks of residues, each contributing $r$ carries, followed by residues $1,\ldots,r-1$. The latter contribute $(2r-d)_+$. The corner contributes $\mathbf1_{2r\ge d}$. This proves (16), including every boundary and the once-counted corner.

All terms in (15) are nonnegative. Nevertheless, composite arrivals can have a nonzero response with no new von Mangoldt mass. At $H=6$, $\Lambda(6)=0$, the old levels $d=4,5$ have $B_4(6)=5$, $B_5(6)=2$, and the other old prime-power levels have zero increment. Thus

$$
J_6-J_5=5\log2+2\log5.
\tag{17}
$$

This is a positive law for the growing carry box. Its old-level boundary contribution is essential.

## 6. A distinct CRT proof of the complete-period covariance

Suppose $d,e\ge1$ divide an integer $L$, and let $A,B$ be independent uniform integers in $\{1,\ldots,L\}$. Then

$$
\operatorname{Cov}(\kappa_d(A,B),\kappa_e(A,B))
=\frac{\gcd(d,e)^2-1}{4de}.
\tag{18}
$$

This proof uses residue conditioning rather than the Fourier inversion of section 3. Put $h=\gcd(d,e)$, $d=hu$, $e=hv$, with $(u,v)=1$. Condition on the residues of $A,B$ modulo $h$, and let $\epsilon=\kappa_h(A,B)\in\{0,1\}$. Since $L$ is a multiple of $\operatorname{lcm}(d,e)=huv$, CRT makes the higher residues modulo $u$ and $v$ independent and uniform under this conditioning. Consequently the two carries are conditionally independent. Their conditional means are

$$
\mathbb E(\kappa_d\mid A\bmod h,B\bmod h)
=\frac{u-1+2\epsilon}{2u},\qquad
\mathbb E(\kappa_e\mid A\bmod h,B\bmod h)
=\frac{v-1+2\epsilon}{2v}.
\tag{19}
$$

Indeed, the higher residues $i,j\in\{0,\ldots,u-1\}$ must satisfy $i+j\ge u$ if $\epsilon=0$, and $i+j\ge u-1$ if $\epsilon=1$. These possibilities have respectively $u(u-1)/2$ and $u(u+1)/2$ pairs. The same count applies to $v$.

The law of total covariance now gives $\operatorname{Cov}(\kappa_d,\kappa_e)=\operatorname{Var}(\epsilon)/(uv)$. Its Bernoulli mean is $(h-1)/(2h)$, so its variance is $(h^2-1)/(4h^2)$. This proves (18), also when a modulus is one. The agreement with the Fourier proof is exact; neither argument transfers to an incomplete period without additional terms.

If $L$ is a common multiple of all moduli through $H$, the weighted field (13) therefore obeys

$$
\mathbb E C_H=\frac12\left(\psi(H)-\sum_{d\le H}\frac{\Lambda(d)}d\right),
\qquad
\operatorname{Var}C_H\le\frac34\psi(H)\log H.
\tag{20}
$$

For the variance bound, distinct prime bases have covariance zero by (18). For powers of one prime,

$$
0\le\operatorname{Cov}(\kappa_{p^i},\kappa_{p^j})
\le\frac14p^{-|i-j|}.
$$

With $a_p=\lfloor\log H/\log p\rfloor$, summing the complete same-prime square gives

$$
\begin{aligned}
\operatorname{Var}C_H
&\le\frac14\sum_{p\le H}(\log p)^2
 \left[a_p+2\sum_{j=1}^{a_p-1}(a_p-j)p^{-j}\right]\\
&\le\frac34\sum_{p\le H}a_p(\log p)^2
\le\frac34\psi(H)\log H.
\end{aligned}
$$

The bound is around the actual mean in (20). It does not estimate $\psi(H)-H$.

## 7. Positive boundary covariance for actual prime levels

In contrast to (18), for independent $A,B$ uniform on $\{1,\ldots,H\}$ and $H\ge7$,

$$
\operatorname{Cov}(\kappa_{H-2},\kappa_H)
=\frac{(H-9)(H^2-3H-2)}{4H^3}.
\tag{21}
$$

Here is a complete finite count. Put $d=H-2\ge5$. Modulo $d$, the sampling list contains each residue once and the residues $1,2$ one additional time. The base carry count is $d(d-1)/2$. The two added residues give $2(1+2)=6$ additional carries; pairs involving two added residues give none because $d\ge5$. Thus

$$
\sum_{a,b\le H}\kappa_d(a,b)=\frac{H^2-5H+18}{2},\qquad
\sum_{a,b\le H}\kappa_H(a,b)=\frac{H(H-1)}2.
\tag{22}
$$

For the joint count, first restrict to $1\le a,b\le d-1$. Both carries occur precisely when $a+b\ge d+2$, giving $(d-3)(d-2)/2$ pairs. A coordinate equal to $d$ cannot carry modulo $d$; a coordinate equal to $H=d+2$ cannot carry modulo $H$. The remaining extra coordinate $d+1$ contributes only the pair with $d-1$, in either order. Therefore

$$
\sum_{a,b\le H}\kappa_d(a,b)\kappa_H(a,b)
=\frac{(H-5)(H-4)}2+2
=\frac{H^2-9H+24}{2}.
\tag{23}
$$

Divide (22)–(23) by $H^2$ and subtract the product of means to obtain (21). It is positive for every $H\ge10$ and tends to $1/4$. In particular, the actual distinct prime levels $11,13$ at $H=13$ give

$$
\operatorname{Cov}(\kappa_{11},\kappa_{13})
=\frac{38}{169}-\frac{61\cdot78}{169^2}
=\frac{128}{2197}>0.
\tag{24}
$$

Thus distinct-prime orthogonality over a complete period cannot be transferred to the growing integer box by assuming nonpositive boundary correlations. Together with the negative examples in section 4, this establishes both signs for actual incomplete-box carry covariance. It is a refutation of that proposed boundary-sign repair, not a sign result for the full weighted arithmetic error or a restriction on every possible use of the complete carry family. The proofs in sections 5–7 are written; `CarryWindowVariance.lean` formalizes a separate general finite-variance lemma, not these carry identities.
