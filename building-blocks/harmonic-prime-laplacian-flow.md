# Harmonic phase resolution and the actual weighted prime flow

This proof converts a lower bound for the complete harmonic phase defect into a finite-prime divergence for the actual mean-zero line-one periodization. It uses the physical generator amplitudes $p^{-1/2}$ from the start. The analytic statements below are written proofs. The finite factorization inequality has the Lean formalization specified at the end.

Write $\psi(x)=\sum_{n\le x}\Lambda(n)$, $H_m=\sum_{n=1}^m1/n$, $H_0=0$, and $\Omega(n)=\sum_pv_p(n)$. Throughout, $p$ and $q$ range over primes, and integer sums start at $1$.

Let $P\ge2$, $H=H_{\lfloor P\rfloor}$, and put
$$
\mathfrak d_P(\tau)=\frac1H\sum_{n\le P}\frac{|1-n^{i\tau}|^2}{n},\qquad
\lambda_P(\tau)=\sum_{p\le P}\frac{|1-p^{i\tau}|^2}{p}.
\tag{1}
$$
The harmonic-resolution input is used with its full dependence on the band exponent: for each fixed admitted exponent $C>0$, there are $K_C,\delta_C>0$ and $P_C$ such that
$$
P\ge P_C,\qquad K_C/\log P\le|\tau|\le P^C
\quad\Longrightarrow\quad \mathfrak d_P(\tau)\ge\delta_C.
\tag{2}
$$
The input is equation (8) under “An exponential variation bound also suffices” in [the harmonic-convolution theorem](harmonic-convolution.md). In its notation, for fixed $C,K>0$ and $0<\varepsilon<1/2$,
$$
\sup_{K/t\le|\tau|\le e^{Ct}}|M_t(\tau)|
\le(2\varepsilon+2/K)t+D_0(1+t e^{-ct}).
$$
Here $c,D_0$ depend on $C,\varepsilon$, and the threshold for $t$ may also depend on $K$. Take $\varepsilon=1/16$, $K=16$, and $t=\log P$. Since $H_{\lfloor P\rfloor}\sim\log P$, the normalized modulus is eventually at most $1/2$. Thus (2) holds with $K_C=16$ and $\delta_C=1$, with a threshold depending on $C$. The sign convention in $M_t$ is immaterial because its modulus is unchanged by conjugation. The arithmetic coefficient estimate and the flow construction below do not reprove this harmonic theorem.

## Full prime multiplicities and the phase Laplacian

For $n>1$, factoring the actual integer and telescoping unit complex factors gives
$$
|1-n^{i\tau}|\le\sum_{p\mid n}v_p(n)|1-p^{i\tau}|.
$$
Weighted Cauchy therefore gives
$$
|1-n^{i\tau}|^2\le\Omega(n)\sum_{p\mid n}v_p(n)|1-p^{i\tau}|^2.
$$
At $n=1$ both sides vanish. Consequently
$$
\mathfrak d_P(\tau)\le\sum_{p\le P}b_p(P)|1-p^{i\tau}|^2,
\quad
b_p(P)=\frac1H\sum_{n\le P}\frac{\Omega(n)v_p(n)}n.
\tag{3}
$$

The coefficient bound keeps all prime powers. Expanding both valuations gives the exact finite expression
$$
b_p(P)=\frac1H\sum_{q\le P}\sum_{a,b\ge1}
\frac{H_{\lfloor P/\operatorname{lcm}(p^a,q^b)\rfloor}}
{\operatorname{lcm}(p^a,q^b)},
\tag{4}
$$
where $H_0=0$, so only finitely many summands are nonzero. For $q\ne p$, the lcm is $p^a q^b$. For $q=p$, it is $p^{\max(a,b)}$. Using $H_m\le H$ on the nonzero terms and then extending the positive sums yields
$$
b_p(P)\le\sum_{j\ge1}(2j-1)p^{-j}
+\frac1{p-1}\sum_{q\le P,\ q\ne p}\frac1{q-1}
=\frac{p+1}{(p-1)^2}
+\frac1{p-1}\sum_{q\le P,\ q\ne p}\frac1{q-1}.
\tag{5}
$$
For an explicit elementary upper bound set $\sigma=1+1/\log P$. Since $q^{\sigma-1}\le e$ for $q\le P$, the absolutely convergent Euler product gives
$$
\sum_{q\le P}\frac1q\le e\sum_q q^{-\sigma}
\le e\log\zeta(\sigma)
\le e\log(1+\log P).
$$
The last inequality follows from the integral bound $\zeta(\sigma)\le1+1/(\sigma-1)$. Also
$\sum_q 1/[q(q-1)]\le\sum_{n\ge2}1/[n(n-1)]=1$.
As $(p+1)/(p-1)^2\le6/p$ and $1/(p-1)\le2/p$,
$$
\boxed{b_p(P)\le\frac{D(P)}p,
\qquad D(P)=8+2e\log(1+\log P).}
\tag{6}
$$
Equations (2), (3), and (6) give the physical Laplacian lower bound
$$
\boxed{\lambda_P(\tau)\ge\delta_C/D(P)}
\tag{7}
$$
on exactly the band in (2).

## The actual line-one input and finite flows

Now let $L=\log3$, $t_k=2\pi k/L$, and let $f$ be the actual mean-zero periodization of
$$
\beta(v)=\psi(e^v)e^{-v}-1\quad(v\ge0),\qquad \beta(v)=0\quad(v<0).
$$
Explicitly, on $0\le s<L$ put
$$
f(s)=\sum_{j\ge0}\beta(s+jL)+\frac{1+\gamma}{L}.
$$
The classical quantitative prime number theorem gives $\beta(v)=O(e^{-c\sqrt v})$ for large $v$. Thus the periodization converges absolutely with a uniform tail on this interval and defines a bounded measurable periodic function. Integrating and taking its Fourier coefficients term by term is justified. For $\Re z>0$, absolute convergence gives
$$
\int_0^\infty\beta(v)e^{-zv}\,dv
=-\frac{\zeta'(1+z)}{(1+z)\zeta(1+z)}-\frac1z.
$$
Since $\beta\in L^1(0,\infty)$, dominated convergence extends the integral continuously to the imaginary axis. At $z=0$, the Laurent expansion $\zeta(1+z)=z^{-1}+\gamma+O(z)$ gives the removable value $-(1+\gamma)$. This proves both the stated mean and the coefficient formula below. Endpoint choices at the jumps do not change these integrals; the displayed definition retains $\psi(1)=0$.

Use circle measure $ds/L$ and translation $T_hG(s)=G(s+h)$. The initial value $\beta(0)=-1$, density subtraction and every prime power remain in this definition. The mean removed from the periodization is $-(1+\gamma)/L$. For $k\ne0$,
$$
\widehat f(k)=\frac1L\left[-\frac{\zeta'(1+it_k)}{(1+it_k)\zeta(1+it_k)}-\frac1{it_k}\right].
\tag{8}
$$
[Nicol Leong, arXiv:2405.04869v5, Corollary 2](https://arxiv.org/html/2405.04869v5) gives the unconditional estimate $|\zeta'/\zeta(\sigma+it)|\le24.303\log t$ for $\sigma\ge1,t\ge13$. Conjugation and the finitely many remaining nonzero modes give
$$
|\widehat f(k)|\ll\frac{\log(2+|k|)}{|k|}.
\tag{9}
$$

Take $P\ge P_C$ large enough that $K_C/\log P\le2\pi/L$, and define
$$
M=\left\lfloor\frac{LP^C}{2\pi}\right\rfloor,
\qquad f^{\mathrm{low}}_P(s)=\sum_{0<|k|\le M}\widehat f(k)e^{it_ks}.
$$
Write $A_p(k)=1-e^{it_k\log p}$. For each prime $p\le P$, define the trigonometric polynomial $G_{p,P}$ by
$$
\widehat G_{p,P}(k)=
\begin{cases}
\displaystyle\frac{p^{-1/2}\overline{A_p(k)}\widehat f(k)}{\lambda_P(t_k)},&0<|k|\le M,\\
0,&\text{otherwise}.
\end{cases}
\tag{10}
$$
These are already the flows for the physical amplitude $p^{-1/2}$; no additional $\sqrt p$ rescaling is applied. Their coefficients have conjugate symmetry, so the flows are real. The prime 3 has $A_3(k)=0$, hence contributes the zero flow automatically. Direct substitution gives
$$
\boxed{f^{\mathrm{low}}_P=\sum_{p\le P}p^{-1/2}(I-T_{\log p})G_{p,P}.}
\tag{11}
$$
Parseval gives the exact energy
$$
\sum_{p\le P}\|G_{p,P}\|_2^2
=\sum_{0<|k|\le M}\frac{|\widehat f(k)|^2}{\lambda_P(t_k)}
\le\frac{D(P)}{\delta_C}\|f^{\mathrm{low}}_P\|_2^2
\le\frac{D(P)}{\delta_C}\|f\|_2^2.
\tag{12}
$$
This energy is minimal among all finite-prime flows with the same prescribed divergence. Indeed, for each Fourier mode, Cauchy gives
$$
\left|\sum_{p\le P}p^{-1/2}A_p(k)g_p(k)\right|^2
\le\lambda_P(t_k)\sum_{p\le P}|g_p(k)|^2,
$$
and (10) attains equality. Extra modes can only increase the energy.

Finally (9) gives the exact cutoff residual estimate
$$
\|f-f^{\mathrm{low}}_P\|_2^2
\ll\frac{\log^2(2+M)}{1+M}
\ll_C\frac{\log^2(2+P)}{P^C},
\tag{13}
$$
so the residual norm is $O_C(\log(2+P)P^{-C/2})$, while the admitted physical flow energy is $O_C(1+\log\log P)$. Each fixed exponent uses the corresponding constants and threshold from (2). This does not provide a uniform assertion as $C$ grows.

The finite-band result concerns the actual line-one periodic input. A compatible infinite-prime construction is available by assigning an admission scale to each dyadic frequency block, as follows.

## Completion across dyadic frequency blocks

Fix the harmonic theorem with $C=1$. Choose one constant $B\ge2$ large enough that every $P_j=B2^j$, $j\ge0$, exceeds its threshold, satisfies $16/\log P_j\le2\pi/L$, and satisfies $P_j\ge(2\pi/L)2^{j+1}$. Let $f_j$ contain exactly the modes
$$
2^j\le|k|<2^{j+1}.
$$
These real blocks are orthogonal and sum to $f$. Equation (9) gives
$$
\|f_j\|_2\ll(1+j)2^{-j/2}.
\tag{14}
$$
Apply (10) on this block with admission $P_j$, and denote the resulting flow by $G_{p,j}$, setting it to zero for $p>P_j$. The exact divergence and energy are
$$
f_j=\sum_p p^{-1/2}(I-T_{\log p})G_{p,j},\qquad
E_j:=\sum_p\|G_{p,j}\|_2^2
\le D(P_j)\|f_j\|_2^2.
\tag{15}
$$
The choice of $B$ is now fixed. Hence $D(P_j)\ll_B\log(2+j)$. Define
$$
G_p=\sum_{j\ge0}G_{p,j}\quad\hbox{in }L^2.
$$
For each prime the summands have disjoint Fourier support. Tonelli and Parseval therefore give
$$
\boxed{\sum_p\|G_p\|_2^2
=\sum_jE_j
\ll_B\sum_j\log(2+j)(1+j)^2 2^{-j}<\infty.}
\tag{16}
$$
This is finite energy for the physical amplitudes $p^{-1/2}$, without any rescaling of the completed flows.

The construction also has an explicit domain property stronger than finite edge energy. Using the triangle inequality, finite-dimensional Cauchy, and the prime harmonic bound proved above,
$$
\begin{aligned}
\sum_p p^{-1/2}\|G_p\|_2
&\le\sum_j\sum_{p\le P_j}p^{-1/2}\|G_{p,j}\|_2\\
&\le\sum_j\left(\sum_{p\le P_j}\frac1p\right)^{1/2}E_j^{1/2}\\
&\ll_B\sum_j\log(2+j)\|f_j\|_2<\infty.
\end{aligned}
\tag{17}
$$
Because every translation is unitary, the output series is absolutely convergent in $L^2$. The double series may therefore be regrouped, proving
$$
\boxed{f=\sum_p p^{-1/2}(I-T_{\log p})G_p,
\qquad
\sum_p p^{-1/2}\|(I-T_{\log p})G_p\|_2<\infty.}
\tag{18}
$$
Every flow remains real and has zero mean; $G_3=0$.

Finite prime admission for these completed flows is especially simple. Put
$F_P=\sum_{p\le P}p^{-1/2}(I-T_{\log p})G_p$.
For a mode in block $j$,
$$
\widehat F_P(k)=\widehat f(k)
\frac{\lambda_{\min(P,P_j)}(t_k)}{\lambda_{P_j}(t_k)}.
\tag{19}
$$
The ratio lies in $[0,1]$ and equals one when $P_j\le P$. Thus $F_P$ is a contraction applied diagonally to the actual Fourier coefficients, with increasing multipliers as more primes are admitted. In particular,
$$
\|f-F_P\|_2^2\le\sum_{j:P_j>P}\|f_j\|_2^2
\ll_B\frac{\log^2(2+P)}{1+P}.
\tag{20}
$$
The omitted edge energy has the corresponding bound
$$
\sum_{p>P}\|G_p\|_2^2
\le\sum_{j:P_j>P}E_j
\ll_B\frac{\log^2(2+P)\log(2+\log(2+P))}{1+P}.
\tag{21}
$$
These estimates include every higher frequency in the admitted flow, rather than discarding its tail during prime admission.

The completed construction is an unconditional finite-energy, absolutely convergent physical prime divergence for this actual line-one periodization. Its domain is explicit: the flows belong both to the Hilbert direct sum in (16) and to the weighted absolute-sum space in (17). Since $\sum_p1/p$ diverges, edge energy alone does not justify a bounded global divergence map on arbitrary flows. No such operator extension, bounded or regulated flow representation, critical scattering-norm bound, or implication of RH is asserted. Translation differences cannot absorb the nonzero constant mean that was removed explicitly.


## Formalized factorization and scope

[PrimePhaseFactorization.lean](BuildingBlocks/PrimePhaseFactorization.lean) proves the following declarations in the namespace `ArithmeticDynamics`:

- `unit_phase_product_bound`: the squared telescoping bound for any finite family of unit complex phases with arbitrary natural multiplicities.
- `primePhaseProduct_bound`: the same bound for the complete prime factorization of an integer.
- `norm_logarithmicPrimePhase` and `logarithmicPrimePhase_eq_product`: the unit norm and exact factorization of $\exp(it\log n)$.
- `logarithmicPrimePhase_bound`: the actual arithmetic inequality preceding (3), with no hypothesis on the zeros of zeta.

The formal statements use mathlib's total conventions at $n=0$: $\log0=0$, and the prime-factorization sums are empty. The arithmetic application uses positive integers, with the $n=1$ term vanishing. The source imports only mathlib and its checked theorems depend only on `propext`, `Classical.choice` and `Quot.sound`.

[HarmonicPrimePhase.lean](BuildingBlocks/HarmonicPrimePhase.lean) continues the same definitions and proves `harmonicPhaseDefect_le_prime_sum`, the exact normalized inequality (3), for every integer cutoff $N\ge1$ and real frequency. Its `valuation_overlap_eq_lcm_sum` counts $v_p(n)v_q(n)$ by common prime-power divisibility. The theorem `same_prime_valuation_sq_eq_max_sum` uses $p^{\max(i,j)}$, rather than $p^{i+j}$, with the explicit hypothesis $n\ne0$.

[HarmonicPrimeWeights.lean](BuildingBlocks/HarmonicPrimeWeights.lean) proves `harmonic_multiples_sum`, `harmonic_valuation_overlap`, and `harmonicPrimeWeight_eq_lcm_sum`. The last theorem is (4) at integer cutoff $N$, written with the finite exponent ranges $1\le i,j<N$. These ranges contain every nonzero contribution. It requires that $p$ is prime and includes $N=0,1$ using the total inverse convention $0^{-1}=0$. At $N=0$ the harmonic mass and both sides are zero. The modules also prove the nonnegative weights, positive harmonic mass for $N\ge1$, and the common-cutoff support identities used by these theorems.

Thus the finite factorization, harmonic averaging and exact coefficient formula are formalized. The harmonic frequency estimate, the upper estimate $b_p\le D(P)/p$, periodization, infinite-flow construction and its absolute-flux domain remain written mathematics. The factorization and minimum-energy arguments use the classical triangle and Cauchy inequalities; the analytic inputs are the linked harmonic theorem, the classical quantitative prime number theorem and Leong's explicit logarithmic-derivative bound. No priority or first-formalization claim is made.
