# Systems that satisfy Weil positivity compared with the primes, through kernels built from $\Xi^2$

**Status.** Theorems 1 and 2 and Corollaries 1 to 6 are **unconditional**. Theorems 1 and 2 and Corollaries 1 to 4 are proved here in full from the classical explicit formula; Corollaries 5 and 6 add interval-arithmetic certificates of explicit kernels (Python, not a proof assistant). They are statements about arbitrary "admissible systems" (Definition 1). The true primes form an admissible system if and only if the Riemann hypothesis holds, so nothing here proves or bounds anything about zeros of $\zeta$. Section 5.1 holds the numbers certified by interval arithmetic. Sections 5.2 to 5.4 are 50-digit computations whose sign conditions are imposed at finitely many points; they are not certified. An independent review on 10 November 2026 rederived Theorems 1 and 2, Corollaries 1 to 4 and the derivations in section 5, and a separate audit examined the certificate script and the proof of Corollary 5; their corrections are incorporated. The degree-16 kernel of Proposition 5(b) and Corollary 6 were added after those reviews and use the audited code. Section 6 states two conjectures and what would follow from them. No Lean formalization. No literature search was done for Theorems 1 and 2; the method is the classical one of Odlyzko's discriminant bounds with one twist (test functions that vanish at every zero), and may well be known.

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
4. Asking for a measure $m$ is the same as asking for positivity. If the functional $h_g\mapsto W_0(h_g)+(\log q)h_g(0)-\int(h_g+h_g(-\cdot))\,d\mu$ is nonnegative for all $g\in C_c^\infty$, then by the Bochner-Schwartz theorem it is given by a tempered nonnegative measure $m$, and (ADM) extends from $C_c^\infty$ to $\mathcal G$ by truncating $g$ and dominated convergence. So "admissible system" and "a nonnegative prime measure for which Weil's functional is nonnegative" mean the same thing. The measure $m$ is determined by $(\mu,q)$ and is automatically even.
5. Admissible systems exist for large conductor, unconditionally: $m=\frac1{2\pi}(\Omega(t)+\log q)\,dt$ and $\mu=2\cosh(u/2)\,du$ satisfy (ADM) identically, and $m\ge0$ as soon as $\log q\ge-\Omega(0)=\log\pi-\psi(\tfrac14)$, that is $q\ge8\pi e^{\gamma_E+\pi/2}=215.33$. With Remark 2 and Corollary 5 below, the set of conductors that admit a system is a half-line whose left end lies between $0.999984$ and $215.33$, and under RH it is at most $1$. Admissible triples $(m,\mu,\log q)$ form a convex set.

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

On the real line $\hat h_g=|E|^2\Xi^2$. Write $w=|E|^2$ and $h_w=h_g$. For $E=1$, $h_w=\Psi$. Every even polynomial $w$ that is nonnegative on $\mathbb R$ is $|E|^2$ for a complex polynomial $E$ (pair the conjugate roots), so it is covered; then $h_w$ is real and even, and $h_w=\sum_r\alpha_rM_r$ with $w(t)=\sum_r\alpha_rt^{2r}$ and $M_r(u)=\int\Phi^{(r)}(v)\Phi^{(r)}(v-u)\,dv$.

Identity (K) carries no information about the zeros: it is the explicit formula applied to a function whose transform has no mass at them. Its use here is to compute $W_0(h_g)$, which belongs to the archimedean data, in terms of the true primes.

For an even polynomial $w$, (K) can be written without primes on one side. Since $\Xi(\pm\tfrac i2)=\xi(0)=\tfrac12$, the pole term is $\tfrac12w(\tfrac i2)$ with $w(\tfrac i2)=\sum_r\alpha_r(-\tfrac14)^r$, so

$$
2\sum_n\frac{\Lambda(n)}{\sqrt n}\,h_w(\log n)=h_w(0)\cdot\frac{\pi\,w(\tfrac i2)+\int w\,\Xi^2\,\Omega\,dt}{\int w\,\Xi^2\,dt}. \tag{K'}
$$

[xi_kernel_identity_check.py](../../certificates/prime-birth/xi_kernel_identity_check.py) evaluates both sides of (K') by ordinary quadrature for $w=1$ and for the two rounded kernels of degree $8$ and $12$ from [xi_kernel_explicit_kernel.py](../../certificates/prime-birth/xi_kernel_explicit_kernel.py); they agree to twelve digits ($0.0751971326975$, $0.000669855513265$, $8.3460965877\cdot10^{-5}$).

The script [xi_kernel_check_conventions.py](../../certificates/prime-birth/xi_kernel_check_conventions.py) checks the normalisations on $g$ with $\hat g=\Xi$: the two sides of the linear analogue of (K), $W_0(\Phi)$ and $2\sum_n\Lambda(n)n^{-1/2}\Phi(\log n)$, both equal $0.00268921591077$.

## 3. The comparison theorem

**Theorem 1 (unconditional).** Let $(m,\mu)$ be an admissible system of conductor $q$, and let $w=|E|^2$, $h_w$ be as in section 2. Then

$$
\int w\,\Xi^2\,dm+\int\bigl(h_w(u)+h_w(-u)\bigr)\,d\mu(u)=\int\bigl(h_w(u)+h_w(-u)\bigr)\,d\mu_\Lambda(u)+(\log q)\,h_w(0). \tag{1}
$$

*Proof.* (ADM) for $g$ with $\hat g=E\Xi$, and (K). $\qquad\blacksquare$

The left side belongs to the unknown system. The right side is computed from the true primes. The zeros of $\zeta$ do not appear, by the choice of test functions and not by any hypothesis. For real even $w$ the two integrands are $2h_w$.

**Corollary 1 (a lower bound for the conductor).** If $w=|E|^2$ is real and even, $w\not\equiv0$, and $h_w\ge0$ on the support of $\mu$, then

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

**Theorem 2 (unconditional).** Let $(m,\mu)$ be an admissible system of conductor $q\le1$ such that $\mu-\mu_\Lambda$, defined on bounded sets, has finite total variation. Then $q=1$, $\mu=\mu_\Lambda$, the Riemann hypothesis holds, and $m$ is the counting measure of the ordinates, with multiplicity.

In particular, if RH fails, no admissible system of conductor at most $1$ differs from the true primes by a finite amount. For nonnegative prime measures this strengthens Proposition 1 of the companion note, which assumed RH. The proof below uses $\mu\ge0$ only on $(0,\log2)$.

*Proof.* Put $\rho=\mu_\Lambda-\mu$ and let $\rho_s$ be its even extension to $\mathbb R\setminus\{0\}$, a finite signed measure. Let $\theta=\log(1/q)\ge0$. Theorem 1 with $E=1+ce^{iaz}$, as in Corollary 4, gives that $R-\theta\Psi$ is the Fourier transform of the finite nonnegative measure $M=\Xi^2m$, where $R=\Psi*\rho_s$. Since $\Psi\in L^1$ and $\rho_s$ is finite, $R-\theta\Psi$ is continuous and integrable, so $M$ is absolutely continuous with density $\frac1{2\pi}\Xi(t)^2\bigl(\hat\rho_s(t)-\theta\bigr)$, where $\hat\rho_s(t)=2\int\cos(tu)\,d\rho(u)$ is continuous. Hence $\hat\rho_s\ge\theta$ wherever $\Xi\ne0$, and so everywhere, because the real zeros of $\Xi$ are isolated.

On $(0,\log2)$ the measure $\mu_\Lambda$ vanishes, so $\rho=-\mu\le0$ there. Take $\psi\in C_c^\infty$ real, even, nonnegative, not zero, supported in $(-\tfrac12\log2,\tfrac12\log2)$, and $\varphi=\psi*\psi$. Then $\int\hat\varphi\,\hat\rho_s\,dt=2\pi\int\varphi\,d\rho_s\le0$, while $\int\hat\varphi\,\hat\rho_s\ge\theta\int\hat\varphi=2\pi\theta\varphi(0)\ge0$. So $\theta\varphi(0)=0$, which gives $\theta=0$, and then $\hat\varphi\hat\rho_s\equiv0$ with $\hat\varphi=\hat\psi^2$, whose zeros are isolated. So $\hat\rho_s\equiv0$ and $\rho=0$.

Now (ADM) with $\mu=\mu_\Lambda$ and $q=1$ says $W(h_g)=\int|\hat g|^2dm\ge0$ for all $g\in C_c^\infty$, which is Weil's criterion. Then (EF) gives $\int|\hat g|^2dm=\int|\hat g|^2d\nu$ for all such $g$, and by polarisation and density $m=\nu$. $\qquad\blacksquare$

## 5. Numbers

### 5.1 Certified by interval arithmetic

The script [xi_kernel_conductor_certificate.py](../../certificates/prime-birth/xi_kernel_conductor_certificate.py) encloses the quantities below with interval arithmetic: series tails bounded in closed form, composite Simpson with a rigorous error term on a lattice of step $2^{-12}$, a chord bound with local curvature between lattice points, and explicit padding for the floating-point sums. A separate agent wrote it from a specification, and another audited it on 10 November 2026: the audit rederived every bound, traced the indices, compared about 4000 internal enclosures with independently computed values, rechecked the proof of Corollary 5 below, and found no error. The script uses the evenness of $\Phi$ as an input. Nothing here is machine-checked in a proof assistant.

**Proposition 5 (certified constants).**

(a) $\Psi(0)\ge0.3197518119$ and $\varepsilon_\Psi\le0.0240444325$. Hence, by Corollary 1 with $w=1$, every admissible system has conductor $q\ge\exp(-0.0751971736)>0.92756$.

(b) Let
$$w_{16}(t)=2.25482059+0.0524395214\,t^2+6.98139727\cdot10^{-4}t^4+5.51936758\cdot10^{-6}t^6+3.87866857\cdot10^{-8}t^8+1.31919267\cdot10^{-10}t^{10}+9.53422988\cdot10^{-13}t^{12}+1.16486515\cdot10^{-17}t^{16}$$
and $h=h_{w_{16}}$. All coefficients are nonnegative, so $w_{16}\ge2.25482059$ on $\mathbb R$. The script certifies: $h(u)>0$ for $0\le u\le4$; $0.99999999950\le h(0)\le0.99999999954$; $2\int h\,d\mu_\Lambda\le1.5566428\cdot10^{-5}$; $h\ge0.19524$ on $[0,0.4]$, $h\ge0.061994$ on $[0,0.5]$, $h\ge0.0088836$ on $[0,0.6]$, $h\ge0.0019933$ on $[0.8,0.9]$, $h\ge0.00048511$ on $[0.8,1]$; $\sup|h|$ on $[3+0.1k,\,3.1+0.1k]$ is at most $T_k$ with $T_{10}=1.74\cdot10^{-116}$, $T_{11}=7.54\cdot10^{-115}$ and $T_k$ decreasing from there to $k=29$; and for $u\ge2$, $|h(u)|\le b(u)$ with
$$b(u)=\sum_r\alpha_rD_r^2\,e^{(2r+4.5)u}\,e^{-2\pi e^u}\Bigl(u+\frac1{2\pi e^u-2r-4.5}\Bigr),$$
$D_r$ the constants of the script, $b$ decreasing, $b(6)\le5.7\cdot10^{-1034}$.

(c) The same statements hold for the kernel of degree $8$, $w_8(t)=2.27942+0.0506854\,t^2+0.000783157\,t^4+2.13792\cdot10^{-6}t^6+7.48483\cdot10^{-8}t^8$, with $2\int h\,d\mu_\Lambda\le6.6991458\cdot10^{-4}$. This is the kernel the audit examined in detail; the kernel of (b) was added afterwards and goes through the same code.

**Corollary 5 (unconditional, certified).** For every admissible system $(m,\mu)$ of conductor $q$:

1. $q\ge\exp(-1.5567\cdot10^{-5})>0.999984$.
2. If $q\le1$: $\int w_{16}\,\Xi^2\,dm\le1.5567\cdot10^{-5}$ and $\int\Xi^2\,dm\le6.91\cdot10^{-6}$. For $q=1$, by Corollary 4, $|R(a)|\le6.91\cdot10^{-6}$ for every $a$, where $R(a)=\int(\Psi(u-a)+\Psi(u+a))\,d(\mu_\Lambda-\mu)(u)$ is the symmetrised difference of the two prime measures smoothed by $\Psi$. For scale, $\Psi(0)=0.3198$.
3. If $q\le1$: the prime measure has mass at most $3.99\cdot10^{-5}$ on $x\le e^{0.4}=1.4918$, at most $1.26\cdot10^{-4}$ on $x\le e^{0.5}=1.6487$, at most $8.77\cdot10^{-4}$ on $x\le e^{0.6}=1.8221$, at most $0.00391$ on $2.2256\le x\le2.4596$, and at most $0.0161$ on $2.2256\le x\le2.7182$.

With the degree-$8$ kernel alone the corresponding numbers are $q>0.99933$, $\int\Xi^2dm\le2.94\cdot10^{-4}$, and mass at most $0.00167$, $0.00506$, $0.0314$ on $x\le1.4918$, $1.6487$, $1.8221$.

*Proof.* Part 1 is trivial if $q>1$, so let $q\le1$ and $\theta=\log(1/q)\ge0$. Write $w$ for $w_{16}$ or $w_8$ and $h=h_w$, $w(t)=\sum_r\alpha_rt^{2r}$. Identity (1) reads $\int w\Xi^2dm+2\int h\,d\mu=2\int h\,d\mu_\Lambda-\theta h(0)$. Since $h>0$ on $[0,4]$,

$$
\theta\,h(0)+\int w\,\Xi^2\,dm+2\int_{(0,4]}h\,d\mu\ \le\ 2\int h\,d\mu_\Lambda+2\int_{(4,\infty)}|h|\,d\mu. \tag{2}
$$

*The last term.* By Corollary 2 with $E=1+e^{iaz}$, whose kernel is $2\Psi+\Psi(\cdot-a)+\Psi(\cdot+a)\ge\Psi(\cdot-a)$, for every real $a$

$$
\int\Psi(u-a)\,d\mu(u)\le C(a):=\varepsilon_\Psi+\int\bigl(\Psi(u-a)+\Psi(u+a)\bigr)\,d\mu_\Lambda(u).
$$

Since $\Psi''=-M_1$, $|M_1|\le M_1(0)$ and $\alpha_1M_1(0)\le h(0)$ (all $\alpha_r\ge0$ and $M_r(0)=\|\Phi^{(r)}\|_2^2\ge0$), we get $M_1(0)\le19.74$ for either kernel and $\Psi(v)\ge\Psi(0)-19.74\,v^2/2\ge0.295$ for $|v|\le0.05$. So $\mu([a-0.05,a+0.05])\le C(a)/0.295$.

To bound $C(a)$ for $a\ge4$ use $\Psi\le\Psi(0)$ and, for $|v|\ge2$, $\Psi(v)\le2\,\Xi(0)\sup_{s\ge|v|/2}\Phi(s)\le40\,e^{9|v|/4}e^{-\pi e^{|v|}}$, which follows from $\Phi(s)\le4\pi^2e^{9s/2}\sum_nn^4e^{-\pi n^2e^{2s}}\le39.5\,e^{9s/2}e^{-\pi e^{2s}}$ for $s\ge1$, a decreasing bound. The terms of $\int\Psi(u-a)\,d\mu_\Lambda$ with $|\log n-a|<2$ contribute at most $\Psi(0)\sum_{n<e^{a+2}}(\log n)n^{-1/2}\le\Psi(0)(a+2)\,2e^{(a+2)/2}\le1.7384\,(a+2)e^{a/2}$. The terms with $n\le e^{a-2}$ contribute at most $40e^{4.5}e^{-\pi e^2}\cdot2a\,e^{(a-2)/2}\le2.2\cdot10^{-7}(a+2)e^{a/2}$. The terms with $n\ge e^{a+2}$ have a decreasing summand and, by comparison with an integral, contribute at most $4\cdot10^{-8}(a+2)e^{a/2}$. The terms of $\int\Psi(u+a)\,d\mu_\Lambda$ are below $e^{-300}$. With $\varepsilon_\Psi\le0.0241\le0.00055\,(a+2)e^{a/2}$ this gives $C(a)\le1.75\,(a+2)e^{a/2}$ and $\mu([a-0.05,a+0.05])\le6\,(a+2)e^{a/2}$ for $a\ge4$.

Now sum over the cells $[3+0.1k,3.1+0.1k]$, $k\ge10$, whose centres are $a_k=3.05+0.1k$. For $10\le k\le29$ use $T_k$: the sum is at most $6\cdot7.95\cdot e^{2.975}\sum_{k\ge10}T_k\le10^{-110}$. Beyond $u=6$ use $b$: since $2r+4.5\le20.5$, $b(u+0.1)/b(u)\le e^{2.05}\cdot1.02\cdot\exp(-2\pi e^6(e^{0.1}-1))\le e^{-260}$ for $u\ge6$, so the cells beyond $6$ contribute at most $10^3\,b(6)$. Hence $\int_{(4,\infty)}|h|\,d\mu\le10^{-109}$.

*Conclusions.* For $w_{16}$: drop the second and third terms on the left of (2) to get $\theta\le(1.5566428\cdot10^{-5}+10^{-108})/0.9999999995<1.5567\cdot10^{-5}$. Drop the first and third: $\int w_{16}\Xi^2dm<1.5567\cdot10^{-5}$, and $w_{16}\ge2.25482059$ gives $\int\Xi^2dm<6.91\cdot10^{-6}$. Drop the first two and restrict to $J\subset(0,4]$: $\mu(J)\le7.7833\cdot10^{-6}/\min_Jh$, which gives part 3. The numbers for $w_8$ follow in the same way from (c). $\qquad\blacksquare$

Part 3 says, rigorously and with no hypothesis on the zeros of $\zeta$, that a system satisfying Weil positivity with Riemann's archimedean factor and conductor at most $1$ has almost no generalized primes below $1.8$ or between $2.23$ and $2.72$. Part 1 says its conductor cannot be smaller than $1$ by more than $1.6\cdot10^{-5}$.

**Corollary 6 (the primes 2 and 3 are forced with their weights; unconditional, certified).** For every admissible system $(m,\mu)$ of conductor $q\le1$, with $x=e^u$:

1. the prime measure has mass at most $0.49120$ on $1.8777\le x\le2.1382$;
2. the prime measure has mass at least $0.48717$ on $1.8586\le x\le2.1601$;
3. the prime measure has mass at most $0.01401$ on $2.2256\le x\le2.7182$;
4. the prime measure has mass at most $0.66171$ on $2.8293\le x\le3.1899$;
5. the prime measure has mass at least $0.57562$ on $2.8004\le x\le3.2226$.

The true prime measure has mass $\log2/\sqrt2=0.490129$ at $x=2$, mass $\log3/\sqrt3=0.634284$ at $x=3$, and no other mass in these intervals. No gap is assumed and nothing is assumed about other primes.

*Proof of parts 1 and 2.* Two more kernels with nonnegative coefficients, of degree $16$, with coefficients of $t^{2i}$, $i=0,\dots,8$:

- $w_U$: $192.7779014$, $3.959614914$, $0.06592039741$, $5.995292912\cdot10^{-4}$, $4.954190381\cdot10^{-6}$, $1.738108178\cdot10^{-8}$, $1.390956481\cdot10^{-10}$, $0$, $1.762076328\cdot10^{-15}$;
- $w_L$: $1220.800154$, $28.93268369$, $0.3723188798$, $2.872879735\cdot10^{-3}$, $1.940677066\cdot10^{-5}$, $6.551462272\cdot10^{-8}$, $4.621451718\cdot10^{-10}$, $0$, $5.605901241\cdot10^{-15}$.

The script certifies, for $h_U=h_{w_U}$: $h_U>0$ on $[0,4]$, $h_U\ge1$ on $[0.63,0.76]$, and $\int h_U\,d\mu_\Lambda\le0.4911979$. For $k=h_{w_L}$: $k\ge-1$ on $[0.619873,\,0.770020]$, $k>0$ on the rest of $[0,4]$, and $\int k\,d\mu_\Lambda\le-0.4871783$. Both have tails beyond $u=4$ bounded as in Proposition 5, with $T_{10}+T_{11}\le4\cdot10^{-112}$, so $\int_{(4,\infty)}|h|\,d\mu\le10^{-108}$ by the estimate in the proof of Corollary 5.

By Corollary 2, $\int h_U\,d\mu\le\int h_U\,d\mu_\Lambda$ and $\int k\,d\mu\le\int k\,d\mu_\Lambda$. For the first, $\int h_U\,d\mu\ge\mu([0.63,0.76])-10^{-108}$ because $h_U\ge1$ on the window and $h_U\ge0$ on the rest of $(0,4]$. For the second, $\int k\,d\mu\ge-\mu([0.619873,0.770020])-10^{-108}$ because $k\ge-1$ on that interval and $k\ge0$ on the rest of $(0,4]$. Finally $e^{0.63}=1.87761$, $e^{0.76}=2.13828$, $e^{0.619873}=1.85869$, $e^{0.770020}=2.16003$.

*Proof of parts 3 to 5.* The same argument with three more kernels of the same kind, whose coefficients are listed in the script under the names G23, U3, L3. Certified: $h_{G23}>0$ on $[0,4]$, $h_{G23}\ge1$ on $[0.8,1]$, $\int h_{G23}\,d\mu_\Lambda\le0.0140074$; $h_{U3}>0$ on $[0,4]$, $h_{U3}\ge1$ on $[1.04,1.16]$, $\int h_{U3}\,d\mu_\Lambda\le0.6617082$; $h_{L3}\ge-1$ on $[1.029785,\,1.170166]$, $h_{L3}>0$ on the rest of $[0,4]$, $\int h_{L3}\,d\mu_\Lambda\le-0.5756241$. The tails beyond $u=4$ contribute less than $10^{-100}$. And $e^{0.8}=2.22554$, $e^{1}=2.71828$, $e^{1.04}=2.82922$, $e^{1.16}=3.18993$, $e^{1.029785}=2.80047$, $e^{1.170166}=3.22253$. $\qquad\blacksquare$

The lower bound uses only Corollary 2: a kernel $h_{w}$ with $w\ge0$ that is negative only inside a window, where it is at least $-1$, gives $\mu(\text{window})\ge-\int h_w\,d\mu_\Lambda$. The kernels were designed by [xi_kernel_window_design.py](../../certificates/prime-birth/xi_kernel_window_design.py) and [xi_kernel_window_design_lower.py](../../certificates/prime-birth/xi_kernel_window_design_lower.py) and were added to the certificate script after its audit; they go through the audited code, plus a short block that reports cell bounds inside and outside a window.

Together with Corollary 5, part 3: a system satisfying Weil positivity with Riemann's archimedean factor and conductor at most $1$ has prime mass at most $9\cdot10^{-4}$ below $1.82$, between $0.48717$ and $0.49120$ near $2$, at most $0.0141$ between $2.23$ and $2.72$, and between $0.57562$ and $0.66171$ near $3$. This is proved without any hypothesis on the zeros of $\zeta$. The bounds near $3$ are looser because all five kernels are restricted to degree $16$ with nonnegative coefficients and wide safety margins; the uncertified optimisation of section 5.3 suggests the true ranges are far narrower.

**A warning from the same script.** It also examined a kernel of degree $12$ that I had obtained from a linear program with sign conditions on a grid of step $0.004$, and it certified that this kernel is negative, by about $10^{-9}$, on an interval of length $0.0015$ near $u=1.4712$ that the grid stepped over. The tables in sections 5.2 to 5.4 were first computed on that fixed grid. Section 5.2 is now recomputed with constraints added adaptively where the kernel dips (a cutting-plane method), and the two sets of values are shown side by side. Sections 5.3 and 5.4 still use the fixed grid.

### 5.2 Computed, not certified: the conductor bound by degree

Here $w$ is an even polynomial of the stated degree with $h_w(0)=1$, and the linear program minimises $B(w)$ subject to $w\ge0$ and $h_w\ge0$ for $\log1.05\le u\le3.2$, that is for $x=e^u$ between $1.05$ and $24.5$ (for degrees $0$ and $4$ only up to $u=2.5$, because beyond that those kernels fall below the $10^{-50}$ noise floor of the table). The condition $w\ge0$ is imposed only on a grid of $t$ with step $0.1$ up to $t=70$. Only degrees divisible by $4$ are used: for large $u$ the sign of $h_w$ is that of $(-1)^{\deg w/2}$ times the leading coefficient, so a nonnegative $w$ whose degree is $2$ modulo $4$ gives a kernel that is eventually negative. Kernels are tabulated at 50 digits ([xi_kernel_table.py](../../certificates/prime-birth/xi_kernel_table.py)) and each linear program is refined at 50 digits. Two versions:

- fixed grid: $h_w\ge0$ only at grid points of step $0.004$ in $u$ and at the points $\log n$ ([xi_kernel_conductor_lp.py](../../certificates/prime-birth/xi_kernel_conductor_lp.py), [xi_kernel_conductor_lp_refined.py](../../certificates/prime-birth/xi_kernel_conductor_lp_refined.py)). These kernels dip to about $-10^{-6}$ between grid points near $u=\log2$, so the fixed-grid values are not valid bounds.
- cutting planes: constraint points are added where the kernel dips until no sampled value is below $-10^{-3}B$ ([xi_kernel_conductor_cutting_plane.py](../../certificates/prime-birth/xi_kernel_conductor_cutting_plane.py)).

| degree of $w$ | $B(w)$, cutting planes | $B(w)$, fixed grid | $h_w$ vanishes near $x=$ |
|---|---|---|---|
| $0$ | $7.52\cdot10^{-2}$ | $7.52\cdot10^{-2}$ | |
| $4$ | $6.19\cdot10^{-3}$ | $6.19\cdot10^{-3}$ | $2.07$ |
| $8$ | $3.707\cdot10^{-4}$ | $3.704\cdot10^{-4}$ | $2.01,\ 3.08$ |
| $12$ | $4.65\cdot10^{-5}$ | $4.59\cdot10^{-5}$ | $2.00,\ 3.02,\ 4.35$ |
| $16$ | $3.59\cdot10^{-6}$ | $3.52\cdot10^{-6}$ | $2.00,\ 3.00,\ 4.05,\ 5.08$ |
| $20$ | $4.44\cdot10^{-8}$ | $4.25\cdot10^{-8}$ | $2,\ 3,\ 4,\ 5,\ 7.06$ |
| $24$ | $1.70\cdot10^{-9}$ | $1.62\cdot10^{-9}$ | $2,\ 3,\ 4,\ 5,\ 7,\ 8.35$ |
| $28$ | $1.35\cdot10^{-10}$ | $1.28\cdot10^{-10}$ | $2,\ 3,\ 4,\ 5,\ 7,\ 8.09,\ 9.34$ |
| $32$ | $1.08\cdot10^{-12}$ | $1.00\cdot10^{-12}$ | |

The cutting-plane values are a few percent above the fixed-grid ones. They are still computations: the sign of $h_w$ beyond $x=24.5$ and below $x=1.05$ is not checked, $w\ge0$ is checked only on the grid of $t$, and the final kernels have sampled values as low as $-10^{-3}B$. On the grid the kernels are close to $1$ below $x=1.05$, so the restriction to prime measures supported in $x\ge1.05$ is probably not needed, but it is a hypothesis of these rows. Three kernels are certified in section 5.1: degree $0$, a degree-$8$ kernel with a safety margin ($B\le6.7\cdot10^{-4}$), and a degree-$16$ kernel with nonnegative coefficients and a safety margin ($B\le1.56\cdot10^{-5}$, against the uncertified optimum $3.59\cdot10^{-6}$ for that degree). The bound barely changes when the lower end $1.05$ is replaced by $1.001$, $1.2$, $1.5$ or $1.9$ (fixed-grid runs). The optimal kernels place their zeros at the prime powers, in order.

In every row $w\ge2.25$ on the grid of $t$ and $h_w(0)=1$, so Corollary 3 also bounds the total mass of $\Xi^2m$: for conductor $1$, $\int\Xi^2\,dm\le B(w)/2.25$, about $5\cdot10^{-13}$ at degree $32$. By Corollary 4 this is also a bound for $\sup_a|R(a)|$: in this computation the prime measure of any admissible system of conductor $1$, smoothed by $\Psi$, agrees with the smoothed true prime measure to within $5\cdot10^{-13}$ at every position.

### 5.3 Computed, not certified: prime mass in windows

For conductor $1$, with kernels of degree $28$ and sign conditions on the fixed grid of step $0.004$ ([xi_kernel_window_bounds.py](../../certificates/prime-birth/xi_kernel_window_bounds.py)). By the warning in section 5.1 these kernels can dip slightly below zero between grid points, and in section 5.2 correcting for that moved the values by a few percent. Treat the last digits below as indicative. The prime measure is assumed supported in $x\ge1.05$. The upper bound for $\mu(J)$ is $\min\int h_w\,d\mu_\Lambda$ over $w\ge0$ with $h_w\ge1$ on $J$ and $h_w\ge0$ elsewhere (Corollary 2). Identity (1) extends by linearity to every real even polynomial $v$, since $v$ is a difference of two nonnegative even polynomials. The lower bound uses such a $v$, not necessarily nonnegative, with $|v|\le\kappa w_1$ (imposed on the grid of $t$) where $w_1$ is the fixed-grid degree-$28$ kernel of section 5.2, normalised by $h_{w_1}(0)=1$: then $\int\Xi^2v\,dm\le\kappa B(w_1)$ by Corollary 3, and Theorem 1 gives $\mu(J)\ge\int h_v\,d\mu_\Lambda-\tfrac12\kappa B(w_1)$ whenever $h_v\le1$ on $J$ and $h_v\le0$ elsewhere.

| window of $x$ | true mass | lower bound | upper bound |
|---|---|---|---|
| $[1.05,\,1.90]$ | $0$ | $0$ | $2.8\cdot10^{-8}$ |
| $[1.90,\,2.10]$ | $0.4901291$ | $0.4901289$ | $0.4901291$ |
| $[1.99,\,2.01]$ | $0.4901291$ | $0.490122$ | $0.4901291$ |
| $[2.10,\,2.90]$ | $0$ | $0$ | $1.8\cdot10^{-6}$ |
| $[2.90,\,3.10]$ | $0.6342841$ | $0.634277$ | $0.634285$ |
| $[3.10,\,3.90]$ | $0$ | $0$ | $4.4\cdot10^{-5}$ |
| $[3.90,\,4.10]$ | $0.3465736$ | $0.34643$ | $0.34658$ |
| $[4.10,\,4.90]$ | $0$ | $0$ | $4.1\cdot10^{-4}$ |
| $[4.90,\,5.10]$ | $0.7197625$ | $0.71881$ | $0.71979$ |
| $[5.10,\,6.90]$ | $0$ | $0$ | $0.048$ |
| $[6.90,\,7.10]$ | $0.7354849$ | $0.5636$ | $0.7516$ |
| $[7.10,\,7.90]$ | $0$ | $0$ | $0.1646$ |
| $[7.90,\,8.10]$ | $0.2450645$ | $0$ | $0.2889$ |

Read as a statement, subject to the certification caveats: any system that satisfies Weil positivity with Riemann's archimedean factor, a simple pole and a nonnegative prime measure supported in $x\ge1.05$ has prime mass between $0.4901289$ and $0.4901291$ in $[1.9,2.1]$, at most $2\cdot10^{-6}$ in $[2.1,2.9]$, and between $0.634277$ and $0.634285$ in $[2.9,3.1]$. This uses no hypothesis on the zeros of $\zeta$ and does not assume that the earlier primes are known. The comparison with the companion note's Propositions 3 and 4 is not like for like: those are certified, use a single compactly supported test function each, assume the earlier primes exactly, and give lower bounds near $0.04$ to $0.2$; the windows here are uncertified and use admissibility for test functions of every support length.

### 5.4 Computed, not certified: the zero measure away from the zeta zeros

By Corollary 3, if $w\ge0$, $h_w\ge0$ on the support of $\mu$, and $\Xi(t)^2w(t)\ge1$ on an interval $I$ of the $t$ axis, then $m(I)\le2\int h_w\,d\mu_\Lambda$. With kernels of degree $28$ and sign conditions on the fixed grid, with the same caveat as in section 5.3 ([xi_kernel_zero_side_bounds.py](../../certificates/prime-birth/xi_kernel_zero_side_bounds.py)):

| interval $I$ of $t$ (no zeta zero inside) | upper bound for $m(I)$ |
|---|---|
| $[0,\,10]$ | $3.4\cdot10^{-9}$ |
| $[0,\,13]$ | $1.1\cdot10^{-7}$ |
| $[0,\,13.9]$ | $3.8\cdot10^{-6}$ |
| $[14.4,\,15]$ | $3.9\cdot10^{-6}$ |
| $[15,\,20]$ | $4.4\cdot10^{-6}$ |
| $[15,\,20.8]$ | $1.4\cdot10^{-4}$ |
| $[21.3,\,24.8]$ | $1.2\cdot10^{-3}$ |
| $[22,\,24]$ | $4.7\cdot10^{-5}$ |
| $[25.3,\,30.2]$ | $1.2\cdot10^{-2}$ |
| $[26,\,29]$ | $3.0\cdot10^{-4}$ |

The first zeta zeros are at $14.1347$, $21.0220$, $25.0109$, $30.4249$. So in this computation, for a system of conductor $1$ whose prime measure is supported in $x\ge1.05$ and for $t\le30$, the zero measure has mass at most $1.2\cdot10^{-2}$ outside the intervals $(13.9,14.4)$, $(20.8,21.3)$, $(24.8,25.3)$ around the first three ordinates, and at most $4\cdot10^{-6}$ below $13.9$. As noted in section 7, the method gives no lower bound for the mass at those ordinates.

## 6. Two conjectures and what they would give

**Conjecture A (completeness).** If $(m,\mu)$ is an admissible system of conductor $1$, then $\mu=\mu_\Lambda$.

**Conjecture B (extremal conductor).** There is no admissible system of conductor $q<1$.

Conjecture A implies Conjecture B: a system of conductor $q<1$ gives, by Remark 2, a system of conductor $1$ with the same $\mu$ and zero measure $m+c\,dt$, $c>0$; Conjecture A makes $\mu=\mu_\Lambda$, and then, as at the end of the proof of Theorem 2, $m+c\,dt$ would be the purely atomic measure $\nu$.

Evidence: the tables in section 5, where the allowed room shrinks by a factor between $8$ and $125$ for every four degrees, and Theorem 2, which proves both conjectures for systems that differ from the true primes by a finite amount. By the argument that ends the proof of Theorem 2, Conjecture A implies

$$
\text{RH}\iff\text{there exists an admissible system of conductor }1 .
$$

The right side does not mention the primes. It says that the explicit distribution $W_0$ built from the pole and the Gamma factor can be written as the Fourier transform of a nonnegative measure plus a nonnegative measure. Conjecture B says that the rational field sits at the extreme point of this problem in the conductor, in the way Odlyzko's bounds place a number field relative to its discriminant.

Two cautions.

1. Neither conjecture is a general principle about archimedean data. For the data of a cubic field (two Gamma factors of one kind and one of the other, conductor $|d|$, a simple pole) uniqueness fails under GRH whenever two non-isomorphic cubic fields share the discriminant and signature, for example the four complex cubic fields of discriminant $-3299$ (quoted from memory, not looked up; $\mathbb Q(\sqrt{-3299})$ has class group of $3$-rank $2$): their zeta functions differ, since non-isomorphic arithmetically equivalent fields have degree at least $7$ by Perlis, and each gives an admissible system for the same data in the analogous sense. So a proof of Conjecture A would have to use something specific to conductor $1$ and degree $1$.
2. The equivalence above does not make RH easier in any way I can see. It moves the question to the existence of a nonnegative completion. The linear program of the companion note, section 4, is the finite version of that existence question.

## 7. Relation to earlier work and limits

The method of Corollary 1 is Odlyzko's: apply the explicit formula to a test function $h\ge0$ with $\hat h\ge0$ and drop nonnegative terms. In Odlyzko's discriminant bounds the sharper versions use GRH to make the zero sum nonnegative. Here positivity of the zero side is part of Definition 1, and for any $g\in\mathcal G$ with $h_g\ge0$ on the support of $\mu$ one has $\log(1/q)\le W_0(h_g)/h_g(0)$. What the multiples of $\Xi^2$ add is the exact evaluation of $W_0(h_g)$ through the true primes, identity (K), which is what Corollaries 2 to 4 and Theorem 2 need. The conclusions are about hypothetical systems and not about $\zeta$. Carneiro, Milinovich and Soundararajan use the same kind of positivity argument under RH to bound gaps between primes. Certified positivity of Weil's form for the true primes at fixed support length is a different question, treated by Zhu ([arXiv 2608.24827](https://arxiv.org/abs/2608.24827)), who certifies support length $1.6$.

Limits. The theorems compare hypothetical systems with the true primes; they do not show that any admissible system exists. Only section 5.1 is certified. The tables in sections 5.2 to 5.4 are computations: the kernels' signs are imposed at finitely many points and are not verified everywhere or beyond $x=24.5$, and the far tail is not bounded there. The kernels cannot see atoms of $m$ located at real zeros of $\Xi$, so this method gives no lower bound for the zero measure at the true zeros.
