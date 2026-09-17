# Local Möbius signs and dense divisor-history energy

The exact divisor forcing and a growing set of local prime-division sign rules do not, by themselves, force the required history-energy bound. The construction below retains the actual forcing function and both chronological primitives. Its weights are auxiliary partial Möbius weights, not the actual Möbius function.

Fix any real exponent $0<\alpha<2$. For each sufficiently large dyadic $X$, set $Y=(\log X)^\alpha$, and keep this $Y$ fixed throughout $[X,2X]$. Define
```math
a_Y(n)=
\begin{cases}
(-1)^{\#\{p\mid n:p\le Y\}},&n\text{ squarefree},\\
0,&n\text{ not squarefree}.
\end{cases}
```
Then $a_Y(1)=1$, $|a_Y|\le1$, and for every prime $p\le Y$ and integer $n$ with $p\nmid n$,
```math
a_Y(pn)=-a_Y(n).
\tag{1}
```
The source is exactly the established arithmetic forcing
```math
H(q)=\log(q!)-\sum_{k\le q}\lfloor q/k\rfloor+2\gamma q,
\qquad H(0)=0,\qquad |H(q)|\le13\sqrt q.
\tag{2}
```
The bound in (2) is proved in [HyperbolaMertens.lean](../../formalization/BuildingBlocks/HyperbolaMertens.lean), theorem `centeredDivisorForcing_sqrt_bound_all`, using the explicit hyperbola estimate in [DivisorForcingBound.lean](../../formalization/BuildingBlocks/DivisorForcingBound.lean). For the actual weights $\mu$, the finite Möbius inverse identity gives
```math
\sum_{d\le u}\mu(d)H(\lfloor u/d\rfloor)-2\gamma-\{u\}
=\psi(\lfloor u\rfloor)-u.
\tag{3}
```
For the auxiliary weights define the distinct readout
```math
F_Y(u)=\sum_{d\le u}a_Y(d)H(\lfloor u/d\rfloor),
\qquad e_{X,Y}(u)=F_Y(u)-2\gamma-\{u\}.
```
Its complete two-sided primitive energy satisfies
```math
\boxed{
\int_X^{2X}\left[
\left(\int_X^t e_{X,Y}(u)\,du\right)^2+
\left(\int_t^{2X}e_{X,Y}(u)\,du\right)^2\right]dt
\sim\frac{91}{60}K^2c_Y^2X^5,}
\tag{4}
```
where
```math
c_Y=\frac1{\zeta(2)}\prod_{p\le Y}\frac{p-1}{p+1},
\qquad K=\gamma^2+3\gamma_1>0.
\tag{5}
```
In particular, this energy is not $O(X^{4+\varepsilon})$ for any fixed $0<\varepsilon<1$. The complete ordered cross energy still has the leading term in (4) after removing every edge corresponding to division by a prime at most $Y$.

Here is a uniform proof. Let $b_Y$ be multiplicative, supported on integers with all prime factors at most $Y$, with
```math
b_Y(p^k)=2(-1)^k\quad(p\le Y,\ k\ge1).
```
Its local power series gives the exact Dirichlet-convolution identity
```math
a_Y=\mu^2*b_Y,
\qquad (1+z)\frac{1-z}{1+z}=1-z.
```
The ordinary squarefree count is $Q(t)=t/\zeta(2)+O(\sqrt t)$, with an absolute constant. This follows directly from
$Q(t)=\sum_{r\le\sqrt t}\mu(r)\lfloor t/r^2\rfloor$.
Put
```math
B_Y=\sum_{d\ge1}\frac{|b_Y(d)|}{\sqrt d}
=\prod_{p\le Y}\frac{\sqrt p+1}{\sqrt p-1}.
```
Both the convolution error and the tail of its main term are bounded by a constant times $B_Y\sqrt t$. Indeed,
```math
t\sum_{d>t}\frac{|b_Y(d)|}{d}
\le\sqrt t\sum_{d>t}\frac{|b_Y(d)|}{\sqrt d}.
```
Consequently, with an absolute implied constant,
```math
A_Y(t):=\sum_{n\le t}a_Y(n)
=c_Yt+O(B_Y\sqrt t).
\tag{6}
```
No fixed-$Y$ asymptotic is being used to infer a growing-$Y$ statement.

Elementary bounds suffice for uniformity. For $m=\lfloor Y\rfloor\ge2$,
```math
c_Y\ge\frac1{\zeta(2)}\prod_{n=2}^m\frac{n-1}{n+1}
=\frac{2}{\zeta(2)m(m+1)}\ge\frac1{\zeta(2)Y^2}.
\tag{7}
```
Also $\log((1+r)/(1-r))\le2r/(1-r^2)$ for $0<r<1$, so
```math
\log B_Y\le4\sum_{p\le Y}p^{-1/2}\le8\sqrt Y.
\tag{8}
```
Thus $B_Y=X^{o(1)}$ for the stated range of $\alpha$.

Exact floor shells, including their endpoints, give
```math
F_Y(u)=\sum_{q\le u}H(q)
\left[A_Y(u/q)-A_Y(u/(q+1))\right].
\tag{9}
```
Truncate this sum at $Q=\lfloor X^{1/3}\rfloor$. For $X\le u\le2X$, equation (6) gives accumulated error $O(B_YQ\sqrt X)$. The omitted actual terms obey
```math
\left|\sum_{d\le u/(Q+1)}a_Y(d)H(\lfloor u/d\rfloor)\right|
\le13\sqrt u\sum_{d\le u/(Q+1)}d^{-1/2}
\le\frac{26u}{\sqrt{Q+1}}.
```
The absolutely convergent tail of $\sum H(q)/(q(q+1))$ has the same order after multiplication by $c_Yu$. Therefore
```math
F_Y(u)=c_YKu+O(B_YX^{5/6})
\quad\text{uniformly on }[X,2X],
\tag{10}
```
provided $K=\sum_{q\ge1}H(q)/(q(q+1))$. Equations (7) and (8) imply
```math
\frac{B_YX^{-1/6}}{c_Y}\longrightarrow0.
\tag{11}
```

To identify $K$, write $h(n)=H(n)-H(n-1)=\log n-\tau(n)+2\gamma$. Summation by parts and (2) imply that $\sum h(n)/n$ converges and equals $K$. More generally, $\sum h(n)n^{-s}$ is holomorphic for $\Re s>1/2$, represented there by the convergent integral of the partial sums $H$. For $\Re s>1$, its value is
```math
-\zeta'(s)-\zeta(s)^2+2\gamma\zeta(s).
```
The Laurent convention is
$\zeta(1+z)=z^{-1}+\gamma-\gamma_1z+O(z^2)$.
The double and simple poles cancel, leaving $K=\gamma^2+3\gamma_1$. The convention and Euler–Maclaurin expansion are recorded in [DLMF 25.2](https://dlmf.nist.gov/25.2).

The positivity can be certified without assuming a decimal value of either constant. At $N=100$, put $\ell=\log N$ and
```math
g_0=\sum_{n=1}^N\frac1n-\ell-\frac1{2N}
+\frac1{12N^2}-\frac1{120N^4},
```
```math
g_1=\sum_{n=1}^N\frac{\log n}{n}-\frac{\ell^2}{2}
-\frac{\ell}{2N}+\frac{\ell-1}{12N^2}
+\frac{11-6\ell}{720N^4}.
```
The periodic fourth-Bernoulli remainder for the Euler–Maclaurin formula is
```math
R_N(s)=-\frac{s(s+1)(s+2)(s+3)}{24}
\int_N^\infty\widetilde B_4(t)t^{-s-4}dt.
```
It gives $\gamma=g_0+R_N(1)$ and $\gamma_1=g_1-R_N'(1)$. Since $\|\widetilde B_4\|_\infty\le1/30$,
```math
|\gamma-g_0|\le e_0=\frac1{120N^4},\qquad
|\gamma_1-g_1|\le e_1=\frac{14+6\log N}{720N^4}.
```
Finite interval evaluation gives
```math
0.5772156649015<g_0<0.5772156649016,
\qquad
-0.0728158454838<g_1<-0.0728158454835.
```
These finite inequalities can be checked using rational bounds from
$\log n=2\sum_{k=0}^{M-1}r_n^{2k+1}/(2k+1)+E$, where
$r_n=(n-1)/(n+1)$ and
$0\le E\le2r_n^{2M+1}/((2M+1)(1-r_n^2))$; $M=1000$ suffices for $1\le n\le100$. Finally,
```math
|K-(g_0^2+3g_1)|\le2|g_0|e_0+e_0^2+3e_1
<1.831\cdot10^{-9}.
```
Together these prove the strict enclosure
```math
\boxed{0.114730385<K<0.114730390.}
```

For clarity, the full endpoint correction is retained in the primitives. If $\beta(v)=(v^2-v)/2$, its pair is
```math
C_X(t)=\begin{pmatrix}
(2\gamma+\tfrac12)(t-X)+\beta(\{t\})-\beta(\{X\})\\
(2\gamma+\tfrac12)(2X-t)+\beta(\{2X\})-\beta(\{t\})
\end{pmatrix}.
\tag{12}
```
It has squared norm at most $\tfrac23(2\gamma+1)^2X^3$. Integrating (10) and subtracting (12) gives
```math
\begin{pmatrix}\int_X^t e_{X,Y}\\\int_t^{2X} e_{X,Y}\end{pmatrix}
=\frac{c_YK}{2}\begin{pmatrix}t^2-X^2\\4X^2-t^2\end{pmatrix}
+O(B_YX^{11/6}),
```
uniformly in $t$. The error contributes
```math
O_K\left(c_YB_YX^{29/6}+B_Y^2X^{14/3}\right)
=o(c_Y^2X^5)
```
to the squared norm. The leading coefficient is exactly
```math
\frac14\int_1^2[(v^2-1)^2+(4-v^2)^2]dv=\frac{91}{60},
```
proving (4). From (7), the leading scale is at least a positive constant times $X^5/(\log X)^{4\alpha}$, which exceeds every $X^{4+\varepsilon}$ with $\varepsilon<1$.

The location of this excess in the history pairing is also explicit. In $L^2([X,2X];\mathbb R^2)$, put
```math
W_d(t)=a_Y(d)\begin{pmatrix}
\int_X^tH(\lfloor u/d\rfloor)du\\
\int_t^{2X}H(\lfloor u/d\rfloor)du
\end{pmatrix},\quad 1\le d\le\lfloor2X\rfloor.
```
Equation (2), followed by Cauchy–Schwarz inside each primitive, gives
```math
D_X:=\sum_d\|W_d\|^2
\le169X^4\sum_{d\le2X}\frac1d.
\tag{13}
```
The constant follows from
```math
\frac12\int_1^2[(v-1)(v^2-1)+(2-v)(4-v^2)]dv=1.
```
The complete ordered cross energy is
```math
\mathcal C_X=\sum_{d\ne e}\langle W_d,W_e\rangle
=\left\|\sum_dW_d\right\|^2-D_X.
\tag{14}
```
The diagonal and the correction (12) are lower order, so (14) has the same leading term as (4).

For any fixed prime $p$, the nonzero edges $d\leftrightarrow pd$ form a matching on squarefree labels. Each label is in at most one such edge for that $p$. Hence
```math
2\sum_{d:\,pd\le2X}|\langle W_d,W_{pd}\rangle|
\le D_X.
\tag{15}
```
Removing both ordered orientations for every $p\le Y$ changes (14) by at most $\pi(Y)D_X$. Equations (7), (13), and $\pi(Y)\le Y$ imply
```math
\pi(Y)D_X=o(c_Y^2X^5).
```
Thus the remaining dense set of ordered pairs still contributes
```math
\boxed{\frac{91}{60}K^2c_Y^2X^5(1+o(1)).}
\tag{16}
```
No pairwise positivity or negativity was presumed in this deletion argument.

The conclusion has specific quantifiers. These are block-dependent models with the actual source $H$, all squarefree history labels, the exact endpoint correction, and an increasing small-prime horizon. They do not satisfy the full Möbius sign law at primes above that horizon. Each fixed integer eventually has its correct Möbius coefficient, but the energy still fails at the moving cutoff. This excludes an inference based only on those local constraints. It does not exclude propagation using every prime, identify the auxiliary readout with (3), or establish anything contrary to RH. The missing bound for the complete actual signed history remains unproved.

The auxiliary weight is established in the literature: it is exactly the function $\mu_y$ in [Mangerel, Theorem 1.2 and Remark 1.3](https://arxiv.org/html/1612.09544#S1.SS1), which also discusses earlier work by Daboussi and Sárközy. Those results study shifted arithmetic correlations. The theorem above instead estimates the two integrated divisor-history observables with their exact common correction. Its proof uses elementary squarefree counting, finite Euler factors and partial summation; it does not use Mangerel’s correlation theorem, whose stated range is different. This is a useful specialization, with exact priority unresolved. No originality or Lean-formalization claim is made for the energy asymptotic.
