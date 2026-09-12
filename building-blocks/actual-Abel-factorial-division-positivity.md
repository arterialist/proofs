# Positive division weights for the actual Abel feedback

For the literal completed source and ordinary successor, let $E(r)=\sum_{j\ge0}r^j\kappa(S^ja)$, $0\le r<1$. There is an exact division expansion
$$E(r)=\sum_{m\ge2}\varphi_r(m)\log m.$$
We prove $\varphi_r(m)\ge m^{-3/2}/36$ for every $m\ge2$ when $0\le r\le1/2048$. The negative total mass is retained at the terminal state $m=1$, where the readout $\log1$ is zero. For every fixed $r<1$ we also locate all possibly negative weights in an explicit finite moving core. These are written arithmetic proofs using ordinary Möbius inversion and absolute convergence. They do not use PNT, numerical primitive-sign certificates or RH.

The [feedback transform](successor-feedback-tail-Abel-poles.md) and [conditional converse](successor-feedback-RH-converse.md) show why the sign near $r=1$ matters. The small interval proved here is a distinct constructive argument; it does not establish that boundary sign.

## 1. Exact birth masses, inversion and factorial endpoints

For $y\ge1$ define
$$
q_0(y)=y^{-1/2},\qquad q_j(y)=\frac1{\sqrt j}\arctan\sqrt{\frac j{\max(1,y-j)}}\quad(j\ge1),
$$
$$d_r(y)=\sum_{j\ge0}r^j[q_{j+1}(y)-q_j(y)].\tag{1}$$
The maximum with one retains the original causal boundary. Indeed for the literal birth $b_y(v)=e^{-v/2}\mathbf1_{e^v\ge y}$,
$$
\frac12\int_0^\infty S^jb_y(v)\,dv
=\frac12\int_{\max(1,y-j)}^\infty\frac{dx}{\sqrt x(x+j)}=q_j(y).
$$
The actual density $-e^{v/2}$ is fixed by $S$ and has zero relative charge. Thus the complete birth decomposition gives
$$E(r)=\sum_{n\ge2}\Lambda(n)d_r(n).\tag{2}$$
All exchanges here are in relative charges. The bound (9) below makes the sum of their absolute values finite against $\Lambda(n)\le\log n$, so no separate divergent source mass is subtracted. The same source convention and fixed-history derivation appear in [the actual fifth-step calculation](actual-successor-fifth-primitive-failure.md).

For each $m\ge1$ set
$$\varphi_r(m)=\sum_{k\ge1}\mu(k)d_r(km).\tag{3}$$
For fixed $r<1$, (9) implies $|d_r(n)|\le C_r n^{-3/2}$ for $n\ge2$, with the single terminal value handled separately. Hence (3) converges absolutely and $\varphi_r(m)=O_r(m^{-3/2})$ for $m\ge2$. The double inversion also converges absolutely: after grouping by $\ell$, it is bounded by $C_r\sum_\ell \tau(\ell)\ell^{-3/2}<\infty$. Consequently
$$
\sum_{k\ge1}\varphi_r(kn)
=\sum_{\ell\ge1}d_r(\ell n)\sum_{d\mid\ell}\mu(d)=d_r(n).
\tag{4}
$$
Use $\sum_{d\mid m}\Lambda(d)=\log m$ in (2) to obtain
$$\boxed{E(r)=\sum_{m\ge2}\varphi_r(m)\log m.}\tag{5}$$
The interchange is justified by $\sum_m|\varphi_r(m)|\log m<\infty$. This is ordinary Möbius inversion on complete division histories, not a positivity-preserving inversion theorem.

There is a literal ordered factorial version:
$$
\boxed{E(r)=\lim_{M\to\infty}\sum_{m=1}^M
[\varphi_r(m)-\varphi_r(m+1)]\log(m!).}\tag{6}
$$
Summation by parts gives the finite sum $\sum_{m=2}^M\varphi_r(m)\log m-\varphi_r(M+1)\log(M!)$. Its final term tends to zero by the proved $O_r(M^{-3/2})$ bound. No sign for each factorial coefficient is claimed.

Taking $n=1$ in (4) retains the negative initial mass:
$$
\sum_{m\ge1}\varphi_r(m)=d_r(1)=-D(r)<0,\qquad
D(r)=\sum_{j\ge0}r^j[q_j(1)-q_{j+1}(1)]>0.
\tag{7}
$$
Here $q_0(1)=1$ and $q_j(1)=\arctan\sqrt j/\sqrt j$ decrease strictly to zero. The negative terminal state cannot be replaced by a continuous-boundary approximation.

## 2. Positive endpoint and a uniform complete-history bound

For integers $n\ge2$, the arcsine expansion gives
$$
d_0(n)=\arcsin(n^{-1/2})-n^{-1/2}
=\sum_{\ell\ge1}a_\ell n^{-\ell-1/2},\qquad
a_\ell=\frac{\binom{2\ell}{\ell}}{4^\ell(2\ell+1)}>0.
$$
At $n=1$ the literal value is instead $d_0(1)=\pi/4-1<0$. Absolute summation and the ordinary Euler product in $\Re s>1$ give, for every $m\ge2$,
$$
\boxed{\varphi_0(m)=\sum_{\ell\ge1}\frac{a_\ell}{\zeta(\ell+1/2)}m^{-\ell-1/2}
\ge\frac{m^{-3/2}}{6\zeta(3/2)}.}\tag{8}
$$
Equation (7) then forces $\varphi_0(1)<0$.

For all integers $n\ge2$ and $j\ge0$,
$$\boxed{|q_{j+1}(n)-q_j(n)|\le2\pi(j+1)n^{-3/2}.}\tag{9}$$
If $n>2(j+1)$, extend the index to $u\in[j,j+1]$ and use
$$q_u(n)=n^{-1/2}\int_0^1(1-ut^2/n)^{-1/2}\,dt.$$
Its $u$ derivative is at most $(\sqrt2/3)n^{-3/2}$. If $n\le2(j+1)$, both masses lie in $[0,\pi/(2\sqrt n)]$, giving an even smaller bound $\pi(j+1)n^{-3/2}$. The latter range includes the whole branch where the lower boundary has returned to one. This proves (9) without deleting returned histories.

Sum (9) for $j\ge1$ against $r^j$, then against $|\mu(k)|\le1$:
$$
|\varphi_r(m)-\varphi_0(m)|
\le2\pi\zeta(3/2)\frac{r(2-r)}{(1-r)^2}m^{-3/2},\qquad m\ge2.
\tag{10}
$$
For $r\le1/2048$, the coefficient is at most $24\cdot4095/2047^2<1/36$, using $\pi<4$ and $\zeta(3/2)<3$. The latter follows directly from $1+\int_1^\infty x^{-3/2}dx=3$. Equation (8) is at least $m^{-3/2}/18$. Therefore
$$
\boxed{\varphi_r(m)\ge\frac1{36}m^{-3/2}\quad(m\ge2,\ 0\le r\le1/2048).}\tag{11}
$$
Every iterate contributes to this estimate, including the negative fifth-primitive interval. Equations (5), (7) and (11) imply
$$
\boxed{E(r)\ge\frac{-\zeta'(3/2)}{36}>0,\qquad \varphi_r(1)<0
\quad(0\le r\le1/2048).}\tag{12}
$$
The negative mass is confined to state one in this interval. The proof is independent of the stronger primitive-based parameter range $0<r\le1/32$ in [the resolvent comparison](actual-successor-resolvent-primitive-order.md).

## 3. A finite moving core for every parameter

Define the individual history weights
$$\varphi_j(m)=\sum_{k\ge1}\mu(k)[q_{j+1}(km)-q_j(km)].$$
For $m\ge j+2$, no argument $km$ has passed its lower-boundary return. The complete arcsine expansion yields
$$
\boxed{\varphi_j(m)=\sum_{\ell\ge1}
\frac{a_\ell[(j+1)^\ell-j^\ell]}{\zeta(\ell+1/2)}m^{-\ell-1/2}>0.}\tag{13}
$$
The exchange is absolute because $(j+1)/m<1$. Thus only histories $j\ge m-1$ can contribute negatively at state $m$. Their entire geometric tail is bounded by
$$
\sum_{j\ge m-1}r^j|\varphi_j(m)|
\le2\pi\zeta(3/2)m^{-3/2}r^{m-1}
\left[\frac m{1-r}+\frac r{(1-r)^2}\right].\tag{14}
$$
All earlier histories add to the positive endpoint (8).

Put $n_r=(1-r)^{-1}$ and $M_r=\lceil16n_r\log(e n_r)\rceil$. Then for every $0<r<1$,
$$
\boxed{\varphi_r(m)\ge\frac{m^{-3/2}}{12\zeta(3/2)}\quad(m\ge M_r).}\tag{15}
$$
Indeed $r^{m-1}\le e^{-(m-1)/n_r}$, and $r^{m-1}(mn_r+rn_r^2)$ decreases for $m\ge n_r$. At $m=M_r$ it is bounded by
$$e^{-15}n_r^{-14}[16\log(e n_r)+2]\le18e^{-15}.$$
The last bracketed expression times $n_r^{-14}$ decreases for $n_r\ge1$. Multiplication by $24\pi\zeta(3/2)^2$ is less than $15552/e^{15}<1$, using $e>2$. Hence (14) is less than half of (8), proving (15). For large $n_r$, the same calculation permits $(2+\epsilon)n_r\log n_r$ for each fixed $\epsilon>0$, with an $\epsilon$-dependent threshold.

All negative logarithmic mass therefore lies in $2\le m<M_r$. The positive exterior obeys
$$
\sum_{m\ge M_r}\varphi_r(m)\log m
\ge\frac{2\log M_r+4}{12\zeta(3/2)\sqrt{M_r}},\tag{16}
$$
by comparison with the decreasing integral of $(\log x)x^{-3/2}$. The remaining sufficient comparison is that the signed sum on $2\le m<M_r$ be at least the negative of this lower bound. That finite-core inequality remains open as $r\uparrow1$; the core is not uniformly bounded.

Equivalently the complete signed logarithmic budget is
$$
\sum_{m\ge2}[\varphi_r(m)]_-\log m
\le\sum_{m\ge2}[\varphi_r(m)]_+\log m.\tag{17}
$$
Both sides are finite for every fixed $r<1$ and their difference is exactly $E(r)$. Establishing it on a final interval would satisfy the feedback criterion. The proven range and moving-core bound preserve the terminal mass and every returned history; they establish no sign for the full W source product. These results are written, not Lean formalized. The underlying Möbius/divisor and Euler-product identities are classical; no priority claim is made for them.

## 4. Fixed inverse weights have a stronger conditional sign obligation

The separate [continuous-shift Mellin proof](actual-Abel-feedback-Mellin-kernel.md) extends to a fixed integer $m\ge2$ by replacing the prime measure with the signed counting measure $\sum_{k\ge1}\mu(k)\delta_{km}$. Its absolute counting function is at most $y/m$, so the same complete variation proof applies without any Möbius cancellation estimate. For $r=e^{-t}$,
$$
\varphi_{e^{-t}}(m)=\sum_{k\ge1}\mu(k)t^{1/2}k(tkm)-C_m(t)+O_m(\sqrt t),
\tag{18}
$$
where $k$ is the continuous kernel in that chapter and
$$
C_m(t)=\frac{1-e^{-t}}{e^{-t}}\sum_{j\ge m}e^{-tj}b_j\,
\mathcal M(\lfloor j/m\rfloor),\qquad
\mathcal M(y)=\sum_{k\le y}\mu(k),\quad
b_j=\frac{\arctan(j^{-1/2})}{\sqrt j}.
\tag{19}
$$
The exact lower-boundary correction is signed here. The elementary bounds $|\mathcal M(y)|\le y$ and $b_j\le1/j$ give $|C_m(t)|\le C/m$ for $0<t\le1$. The error and its complete absolute variation estimate follow exactly as in equations (7)–(10) of the linked proof, with counting measure on multiples in place of $d\psi$.

In the initial absolute Dirichlet half-plane, the one-sided log-$A$ transform of the continuous term in (18) has meromorphic part
$$
\frac{m^{-s}M_k(s)}{\zeta(s)},\qquad
M_k(s)=\frac{\sqrt\pi\Gamma(s)\tan(\pi s)}{2s},\qquad s=z+1/2.
\tag{20}
$$
Its lower-$A$ tail is holomorphic for $\Re z<1$. The bounded remainder in (18) has a holomorphic Laplace transform for $\Re z>0$, bounded by $O_m(1/\epsilon)$ on every line $\Re z=\epsilon>0$ with $\epsilon\downarrow0$.

If even one fixed nonterminal weight $\varphi_r(m)$ has an eventual weak sign on a whole interval below one, the positive-Laplace argument first implies RH: (20) has no positive real singularity, and has a nonzero pole at each off-critical zero. After RH is obtained, the real transform as $z=\epsilon\downarrow0$ is $O_m(1/\epsilon)$, since $\zeta(1/2)\ne0$ and the real singularity of $M_k$ is only simple. A critical zero of multiplicity $q\ge2$ would instead give a nonzero pole of order $q$ in (20) at $z=i\gamma$. The bounded remainder is only $O_m(1/\epsilon)$ there and cannot cancel its leading term. For an eventually one-signed function, after removal of its compact initial interval, the modulus of its transform at $\epsilon+i\gamma$ is at most its real transform at $\epsilon$. This contradicts the order-$q$ growth. Thus the stated fixed-$m$ sign would imply both RH and simplicity of all critical zeros.

This is a conditional implication. It does not assert simplicity, nor that the fixed-$m$ sign fails. It also explains a distinction between individual inverse weights and their exact logarithmic readout. In the initial absolute half-plane, summing (20) against $\log m$ multiplies it by $-\zeta'(s)$, giving
$$-M_k(s)\frac{\zeta'(s)}{\zeta(s)}.$$
This combination has a simple pole at every zero, with its multiplicity in the residue. The full signed logarithmic budget therefore retains the RH-level pole structure while canceling the extra inverse-zeta pole orders. Taking absolute inverse weights would discard that cancellation.
