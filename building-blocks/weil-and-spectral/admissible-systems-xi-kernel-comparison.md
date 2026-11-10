# Systems that satisfy Weil positivity compared with the primes, through kernels built from $\Xi^2$

**Status.** Theorems 1 and 2 and Corollaries 1 to 4 are **unconditional** and proved here in full from the classical explicit formula. They are statements about arbitrary "admissible systems" (Definition 1). The true primes form an admissible system if and only if the Riemann hypothesis holds, so nothing here proves or bounds anything about zeros of $\zeta$. Section 5 separates the numbers into those certified by interval arithmetic and those that are 50-digit computations with sign conditions imposed on a grid. Section 6 states two conjectures and what would follow from them. No Lean formalization. No literature search was done for Theorems 1 and 2; the method is the classical one of Odlyzko's discriminant bounds with one twist (test functions that vanish at every zero), and may well be known.

## 1. Admissible systems

Notation as in [the companion note](weil-positivity-forces-the-primes.md): $\hat g(z)=\int g(u)e^{izu}du$, $h_g(u)=\int g(v)\overline{g(v-u)}dv$, and

$$
W_0(h_g)=\int h_g(u)\,2\cosh(u/2)\,du+\frac1{2\pi}\int|\hat g(t)|^2\,\Omega(t)\,dt,\qquad \Omega(t)=\operatorname{Re}\psi\bigl(\tfrac14+\tfrac{it}2\bigr)-\log\pi ,
$$

the pole and archimedean part of Weil's explicit formula. Let $\mathcal G$ be the class of smooth $g:\mathbb R\to\mathbb C$ such that $e^{\beta|u|}g^{(k)}(u)$ is bounded for every $\beta>0$ and $k\ge0$. It contains $C_c^\infty$. For $g\in\mathcal G$ the explicit formula reads

$$
\sum_\rho\hat g(\gamma_\rho)\,\overline{\hat g(\bar\gamma_\rho)}=W_0(h_g)-\int\bigl(h_g(u)+h_g(-u)\bigr)\,d\mu_\Lambda(u),\qquad \mu_\Lambda=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}\,\delta_{\log n}, \tag{EF}
$$

where $\rho=\tfrac12+i\gamma_\rho$ runs over the nontrivial zeros.

**Definition 1.** An *admissible system of conductor $q>0$* is a pair $(m,\mu)$ where $m$ is a nonnegative even Borel measure on $\mathbb R$ with $\int(1+t^2)^{-N}dm<\infty$ for some $N$, $\mu$ is a nonnegative Borel measure on $(0,\infty)$ with $\int e^{-Au}d\mu(u)<\infty$ for some $A$, and for every $g\in\mathcal G$

$$
\int|\hat g(t)|^2\,dm(t)+\int\bigl(h_g(u)+h_g(-u)\bigr)\,d\mu(u)=W_0(h_g)+(\log q)\,h_g(0). \tag{ADM}
$$

In words: the functional $W_0+(\log q)h(0)$, which is the pole and archimedean part of the explicit formula for the factor $(q/\pi)^{s/2}\Gamma(s/2)$, minus the "prime measure" $\mu$, is a sum of squares against the "zero measure" $m$. No gap is assumed: $\mu$ may have mass arbitrarily close to $u=0$.

Three remarks.

1. There is $m$ with $(m,\mu_\Lambda)$ admissible of conductor $1$ if and only if RH holds. If RH holds take $m=\nu$, the counting measure of the ordinates. Conversely (ADM) with $\mu=\mu_\Lambda$ says $W(h_g)=\int|\hat g|^2dm\ge0$, which is Weil's criterion.
2. If $(m,\mu)$ is admissible of conductor $q$ and $q'\ge q$, then $(m+\frac{\log(q'/q)}{2\pi}dt,\ \mu)$ is admissible of conductor $q'$. So the set of conductors that admit a system is an up-set.
3. The definition does not mention the primes or the zeros of $\zeta$.

## 2. Kernels that do not see the zeros

Let

$$
\Phi(u)=2\sum_{n\ge1}\bigl(2\pi^2n^4e^{9u/2}-3\pi n^2e^{5u/2}\bigr)e^{-\pi n^2e^{2u}} .
$$

Classical facts: $\Phi$ is even, $\Phi>0$ (for $u\ge0$ every term is positive because $2\pi n^2e^{2u}>3$), $\Phi\in\mathcal G$, and $\hat\Phi(z)=\Xi(z):=\xi(\tfrac12+iz)$, an entire function with $\Xi(\gamma_\rho)=0$ for every zero, on the line or off it. Put $\Psi=\Phi*\Phi$, so $\Psi>0$, $\Psi$ is even and $\hat\Psi=\Xi^2$.

Let $E$ be a finite sum of terms $c\,z^je^{iaz}$ with $j\ge0$, $a\in\mathbb R$, and let $g$ be the corresponding finite combination of translates of derivatives of $\Phi$, so that $g\in\mathcal G$ and $\hat g=E\,\Xi$. Then every term of the sum over zeros in (EF) vanishes, whether or not RH holds, and

$$
W_0(h_g)=\int\bigl(h_g(u)+h_g(-u)\bigr)\,d\mu_\Lambda(u). \tag{K}
$$

On the real line $\hat h_g=|E|^2\Xi^2$. Write $w=|E|^2$ and $h_w=h_g$. For $E=1$, $h_w=\Psi$. For $E$ a real polynomial in $z^2$ times powers of $z$, $w$ is an even polynomial, $h_w$ is real and even, and $h_w=\sum_r\alpha_rM_r$ with $w(t)=\sum_r\alpha_rt^{2r}$ and $M_r(u)=\int\Phi^{(r)}(v)\Phi^{(r)}(v-u)\,dv$.

For an even polynomial $w$, (K) can be written without primes on one side. Since $\Xi(\pm\tfrac i2)=\xi(0)=\tfrac12$, the pole term is $\tfrac12w(\tfrac i2)$ with $w(\tfrac i2)=\sum_r\alpha_r(-\tfrac14)^r$, so

$$
2\sum_n\frac{\Lambda(n)}{\sqrt n}\,h_w(\log n)=h_w(0)\cdot\frac{\pi\,w(\tfrac i2)+\int w\,\Xi^2\,\Omega\,dt}{\int w\,\Xi^2\,dt}. \tag{K'}
$$

[xi_kernel_identity_check.py](../../certificates/prime-birth/xi_kernel_identity_check.py) evaluates the right side of (K') by quadrature for $w=1$ and for the kernels of degree $8$ and $12$ used in section 5, and it agrees with the left side, computed separately from a kernel table and a list of prime powers, to nine digits.

The script [xi_kernel_check_conventions.py](../../certificates/prime-birth/xi_kernel_check_conventions.py) checks the normalisations on $g$ with $\hat g=\Xi$: the two sides of the linear analogue of (K), $W_0(\Phi)$ and $2\sum_n\Lambda(n)n^{-1/2}\Phi(\log n)$, both equal $0.00268921591077$.

## 3. The comparison theorem

**Theorem 1 (unconditional).** Let $(m,\mu)$ be an admissible system of conductor $q$, and let $w=|E|^2$, $h_w$ be as in section 2. Then

$$
\int w\,\Xi^2\,dm+\int\bigl(h_w(u)+h_w(-u)\bigr)\,d\mu(u)=\int\bigl(h_w(u)+h_w(-u)\bigr)\,d\mu_\Lambda(u)+(\log q)\,h_w(0). \tag{1}
$$

*Proof.* (ADM) for $g$ with $\hat g=E\Xi$, and (K). $\qquad\blacksquare$

The left side belongs to the unknown system. The right side is computed from the true primes. The zeros of $\zeta$ have dropped out without any hypothesis on them. For real even $w$ the two integrands are $2h_w$.

**Corollary 1 (a lower bound for the conductor).** If $w$ is real and even, $w\not\equiv0$, and $h_w\ge0$ on the support of $\mu$, then

$$
\log\frac1q\ \le\ B(w):=\frac{2\int h_w\,d\mu_\Lambda}{h_w(0)}=\frac{2\sum_n\Lambda(n)n^{-1/2}h_w(\log n)}{h_w(0)} .
$$

With $w=1$ the hypothesis holds for every $\mu$ because $\Psi>0$. So every admissible system, with no condition on the support of its prime measure, has conductor $q\ge\exp(-\varepsilon_\Psi/\Psi(0))$, where $\varepsilon_\Psi=2\sum_n\Lambda(n)n^{-1/2}\Psi(\log n)$.

*Proof.* In (1) the first term is $\ge0$ and the second is $\ge0$, and $h_w(0)=\frac1{2\pi}\int w\Xi^2>0$. $\qquad\blacksquare$

**Corollary 2 (domination).** If $q\le1$ then $\int h_w\,d\mu\le\int h_w\,d\mu_\Lambda$ for every real even $w=|E|^2$, with no sign condition on $h_w$.

**Corollary 3 (the zero side).** If $q\le1$ and $h_w\ge0$ on the support of $\mu$, then $\int w\,\Xi^2\,dm\le2\int h_w\,d\mu_\Lambda$.

**Corollary 4 (uniform closeness at the resolution of $\Psi$).** Let $q=1$ and $R(a)=\int\bigl(\Psi(u-a)+\Psi(u+a)\bigr)\,d(\mu_\Lambda-\mu)(u)$. Then $R(a)=\int\Xi(t)^2e^{ita}\,dm(t)$ for every real $a$. So $R$ is the Fourier transform of the finite nonnegative measure $\Xi^2m$, and

$$
\sup_a|R(a)|=R(0)=\int\Xi^2\,dm=2\int\Psi\,d(\mu_\Lambda-\mu)\le\varepsilon_\Psi .
$$

*Proof.* Apply (1) to $E(z)=1+ce^{iaz}$ for $c=1,-1,i,-i$ and combine. For $E=1+ce^{iaz}$, $h_g(u)=(1+|c|^2)\Psi(u)+c\,\Psi(u-a)+\bar c\,\Psi(u+a)$ and $|E|^2=1+|c|^2+ce^{iat}+\bar ce^{-iat}$. $\qquad\blacksquare$

Corollary 4 says that the prime measure of any admissible system of conductor $1$, smoothed by the fixed bump $\Psi$, differs from the smoothed true prime measure by at most the absolute constant $\varepsilon_\Psi$, at every position.

## 4. A finite change of the primes, without assuming RH

**Theorem 2 (unconditional).** Let $(m,\mu)$ be an admissible system of conductor $q\le1$ such that $\mu-\mu_\Lambda$ is a finite signed measure. Then $q=1$, $\mu=\mu_\Lambda$, the Riemann hypothesis holds, and $m$ is the counting measure of the ordinates.

Equivalently: if RH fails, no admissible system of conductor at most $1$ differs from the true primes by a finite amount. This strengthens Proposition 1 of the companion note, which assumed RH.

*Proof.* Put $\rho=\mu_\Lambda-\mu$ and let $\rho_s$ be its even extension to $\mathbb R\setminus\{0\}$, a finite signed measure. Let $\theta=\log(1/q)\ge0$. Theorem 1 with $E=1+ce^{iaz}$, as in Corollary 4, gives that $R-\theta\Psi$ is the Fourier transform of the finite nonnegative measure $M=\Xi^2m$, where $R=\Psi*\rho_s$. Since $\Psi\in L^1$ and $\rho_s$ is finite, $R-\theta\Psi$ is continuous and integrable, so $M$ is absolutely continuous with density $\frac1{2\pi}\Xi(t)^2\bigl(\hat\rho_s(t)-\theta\bigr)$, where $\hat\rho_s(t)=2\int\cos(tu)\,d\rho(u)$ is continuous. Hence $\hat\rho_s\ge\theta$ wherever $\Xi\ne0$, and so everywhere, because the real zeros of $\Xi$ are isolated.

On $(0,\log2)$ the measure $\mu_\Lambda$ vanishes, so $\rho=-\mu\le0$ there. Take $\psi\in C_c^\infty$ real, even, nonnegative, not zero, supported in $(-\tfrac12\log2,\tfrac12\log2)$, and $\varphi=\psi*\psi$. Then $\int\hat\varphi\,\hat\rho_s\,dt=2\pi\int\varphi\,d\rho_s\le0$, while $\int\hat\varphi\,\hat\rho_s\ge\theta\int\hat\varphi=2\pi\theta\varphi(0)\ge0$. So $\theta\varphi(0)=0$, which gives $\theta=0$, and then $\hat\varphi\hat\rho_s\equiv0$ with $\hat\varphi=\hat\psi^2$, whose zeros are isolated. So $\hat\rho_s\equiv0$ and $\rho=0$.

Now (ADM) with $\mu=\mu_\Lambda$ and $q=1$ says $W(h_g)=\int|\hat g|^2dm\ge0$ for all $g\in C_c^\infty$, which is Weil's criterion. Then (EF) gives $\int|\hat g|^2dm=\int|\hat g|^2d\nu$ for all such $g$, and by polarisation and density $m=\nu$. $\qquad\blacksquare$

## 5. Numbers

### 5.1 Certified

At the time of this commit no number in this note is certified by interval arithmetic; a certificate for the constants below and for one explicit kernel of degree $8$ is in preparation. Computed at 50 digits by ordinary quadrature: $\Psi(0)=0.319751811962$ and $\varepsilon_\Psi=0.02404441943$, so Corollary 1 with $w=1$ gives $q\ge\exp(-0.07519713)=0.92756$ for every admissible system, with no condition on the support of its prime measure. Since $\Psi>0$ is a classical fact, this bound needs no sign verification, only those two numbers.

### 5.2 Computed, not certified: the conductor bound by degree

Here $w$ is an even polynomial of the stated degree, nonnegative on $\mathbb R$, and $h_w\ge0$ is imposed on a grid of step $0.004$ in $u$ (plus the points $\log n$) for $\log1.05\le u\le3.2$, that is for $x=e^u$ up to $24.5$. The linear program minimises $B(w)$. Kernels are tabulated at 50 digits ([xi_kernel_table.py](../../certificates/prime-birth/xi_kernel_table.py)), the linear program runs in double precision on rescaled rows, and the vertex it finds is then recomputed at 50 digits ([xi_kernel_conductor_lp.py](../../certificates/prime-birth/xi_kernel_conductor_lp.py)). The sign of $h_w$ between grid points and beyond $x=24.5$ is not checked.

| degree of $w$ | $B(w)$, so that $q\ge e^{-B}$ | $h_w$ vanishes on the grid near $x=$ |
|---|---|---|
| $0$ | $7.52\cdot10^{-2}$ | |
| $4$ | $6.19\cdot10^{-3}$ | $2.07$ |
| $8$ | $3.70\cdot10^{-4}$ | $2.01,\ 3.08$ |
| $12$ | $4.59\cdot10^{-5}$ | $2.00,\ 3.02,\ 4.35$ |
| $16$ | $3.52\cdot10^{-6}$ | $2.00,\ 3.00,\ 4.05,\ 5.08$ |
| $20$ | $4.25\cdot10^{-8}$ | $2,\ 3,\ 4,\ 5,\ 7.06$ |
| $24$ | $1.62\cdot10^{-9}$ | $2,\ 3,\ 4,\ 5,\ 7,\ 8.35$ |
| $28$ | $1.28\cdot10^{-10}$ | $2,\ 3,\ 4,\ 5,\ 7,\ 8.09,\ 9.34$ |

The bound barely changes when the lower end $1.05$ of the grid is replaced by $1.001$, $1.2$, $1.5$ or $1.9$. The optimal kernels place their zeros at the prime powers, in order. Degree $32$ exceeded what the double-precision solver could resolve.

### 5.3 Computed, not certified: prime mass in windows

For conductor $1$, with kernels of degree $28$ and the same grid conditions ([xi_kernel_window_bounds.py](../../certificates/prime-birth/xi_kernel_window_bounds.py)). The upper bound for $\mu(J)$ is $\min\int h_w\,d\mu_\Lambda$ over $w\ge0$ with $h_w\ge1$ on $J$ and $h_w\ge0$ elsewhere (Corollary 2). Identity (1) extends by linearity to every real even polynomial $v$, since $v$ is a difference of two nonnegative even polynomials. The lower bound uses such a $v$, not necessarily nonnegative, with $|v|\le\kappa w_1$ where $w_1$ is the degree-$28$ kernel of section 5.2: then $\int\Xi^2v\,dm\le\kappa B(w_1)$ by Corollary 3, and Theorem 1 gives $\mu(J)\ge\int h_v\,d\mu_\Lambda-\tfrac12\kappa B(w_1)$ whenever $h_v\le1$ on $J$ and $h_v\le0$ elsewhere.

| window of $x$ | true mass | lower bound | upper bound |
|---|---|---|---|
| $[1.05,\,1.90]$ | $0$ | $0$ | $2.8\cdot10^{-8}$ |
| $[1.90,\,2.10]$ | $0.4901291$ | $0.4901289$ | $0.4901291$ |
| $[1.99,\,2.01]$ | $0.4901291$ | $0.490122$ | $0.4901291$ |
| $[2.10,\,2.90]$ | $0$ | $0$ | $1.8\cdot10^{-6}$ |
| $[2.90,\,3.10]$ | $0.6342841$ | $0.634278$ | $0.634285$ |
| $[3.10,\,3.90]$ | $0$ | $0$ | $4.3\cdot10^{-5}$ |
| $[3.90,\,4.10]$ | $0.3465736$ | $0.34644$ | $0.34658$ |
| $[4.10,\,4.90]$ | $0$ | $0$ | $4.0\cdot10^{-4}$ |
| $[4.90,\,5.10]$ | $0.7197625$ | $0.71882$ | $0.71979$ |
| $[5.10,\,6.90]$ | $0$ | $0$ | $0.048$ |
| $[6.90,\,7.10]$ | $0.7354849$ | $0.5637$ | $0.7516$ |
| $[7.90,\,8.10]$ | $0.2450645$ | $0$ | $0.2889$ |

Read as a statement, subject to the certification caveats: any system that satisfies Weil positivity with Riemann's archimedean factor, a simple pole and a nonnegative prime measure supported in $x\ge1.05$ has prime mass between $0.4901289$ and $0.4901291$ in $[1.9,2.1]$, at most $2\cdot10^{-6}$ in $[2.1,2.9]$, and between $0.634278$ and $0.634285$ in $[2.9,3.1]$. This uses no hypothesis on the zeros of $\zeta$ and does not assume that the earlier primes are known. The companion note's Propositions 3 and 4 assumed the earlier primes exactly and gave lower bounds near $0.1$ to $0.2$.

### 5.4 Computed, not certified: the zero measure away from the zeta zeros

By Corollary 3, if $w\ge0$, $h_w\ge0$ on the support of $\mu$, and $\Xi(t)^2w(t)\ge1$ on an interval $I$ of the $t$ axis, then $m(I)\le2\int h_w\,d\mu_\Lambda$. With kernels of degree $28$ and the same grid conditions ([xi_kernel_zero_side_bounds.py](../../certificates/prime-birth/xi_kernel_zero_side_bounds.py)):

| interval $I$ of $t$ (no zeta zero inside) | upper bound for $m(I)$ |
|---|---|
| $[0,\,10]$ | $3.4\cdot10^{-9}$ |
| $[0,\,13]$ | $1.1\cdot10^{-7}$ |
| $[0,\,13.9]$ | $3.8\cdot10^{-6}$ |
| $[14.4,\,15]$ | $3.8\cdot10^{-6}$ |
| $[15,\,20]$ | $4.3\cdot10^{-6}$ |
| $[15,\,20.8]$ | $1.4\cdot10^{-4}$ |
| $[22,\,24]$ | $4.6\cdot10^{-5}$ |
| $[26,\,29]$ | $2.9\cdot10^{-4}$ |

The first zeta zeros are at $14.1347$, $21.0220$, $25.0109$, $30.4249$. So in this computation the zero measure of any admissible system of conductor $1$ has almost no mass below $13.9$, between $14.4$ and $20.8$, and so on: it can only sit near the ordinates of the zeta zeros. As noted in section 7, the method gives no lower bound for the mass at those ordinates.

## 6. Two conjectures and what they would give

**Conjecture A (completeness).** If $(m,\mu)$ is an admissible system of conductor $1$, then $\mu=\mu_\Lambda$.

**Conjecture B (extremal conductor).** There is no admissible system of conductor $q<1$.

Evidence: the tables in section 5, where the allowed room shrinks by about a factor ten for every four degrees, and Theorem 2, which proves both conjectures for systems that differ from the true primes by a finite amount. By the argument that ends the proof of Theorem 2, Conjecture A implies

$$
\text{RH}\iff\text{there exists an admissible system of conductor }1 .
$$

The right side does not mention the primes. It says that the explicit distribution $W_0$ built from the pole and the Gamma factor can be written as the Fourier transform of a nonnegative measure plus a nonnegative measure. Conjecture B says that the rational field sits at the extreme point of this problem in the conductor, in the way Odlyzko's bounds place a number field relative to its discriminant.

Two cautions.

1. Neither conjecture is a general principle about archimedean data. For the data of a cubic field (two Gamma factors of one kind and one of the other, conductor $|d|$, a simple pole) uniqueness fails under GRH whenever two non-isomorphic cubic fields share the discriminant and signature, for example the four complex cubic fields of discriminant $-3299$: their zeta functions differ (arithmetically equivalent fields have degree at least $7$, by Perlis) and each gives an admissible system for the same data. So a proof of Conjecture A would have to use something specific to conductor $1$ and degree $1$.
2. The equivalence above does not make RH easier in any way I can see. It moves the question to the existence of a nonnegative completion. The linear program of the companion note, section 4, is the finite version of that existence question.

## 7. Relation to earlier work and limits

The method of Corollary 1 is Odlyzko's: apply the explicit formula to a test function $h\ge0$ with $\hat h\ge0$ and drop nonnegative terms. Odlyzko's discriminant bounds need GRH to make the zero sum nonnegative. Here the test functions are multiples of $\Xi^2$, so the zero sum of $\zeta$ is zero and no hypothesis is needed; the price is that the conclusion is about hypothetical systems and not about $\zeta$. Carneiro, Milinovich and Soundararajan use the same kind of positivity argument under RH to bound gaps between primes. Certified positivity of Weil's form for the true primes at fixed support length is a different question, treated by Zhu ([arXiv 2608.24827](https://arxiv.org/abs/2608.24827)), who certifies support length $1.6$.

Limits. The theorems compare hypothetical systems with the true primes; they do not show that any admissible system exists. The tables in sections 5.2 and 5.3 are computations: the kernels' signs are imposed on a grid and are not verified between grid points or beyond $x=24.5$, and the far tail is not bounded there. The kernels cannot see atoms of $m$ located at real zeros of $\Xi$, so this method gives no lower bound for the zero measure at the true zeros.
