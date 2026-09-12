# Original-space birth Gram, complete cell loading and signed work

This written proof concerns the original frozen-source $L^2$ norm. It retains the [complete positive prime process](positive-successor-seed-jump-process.md), all signed arithmetic cells and the frozen tail. The [charge-loading theorem](actual-charge-arrival-loading.md) supplies the arithmetic asymptotic after the exact cell calculation. No Gram, loading or signed-work theorem below is formalized in Lean.

Let $\mu_t$ be the law of the actual age $W_t$, and put $T_tF=\mu_t*F$ for $t\ge0$. Use $Uf(v)=e^{v/2}f(e^v)$ and

$$
h_b(x)=x^{-1}\mathbf1_{x\ge b},\qquad
\nu_N=-\delta_1+\sum_{2\le n\le N}\Lambda(n)\delta_n-\mathbf1_{[1,N]}(b)db,
$$
$$
g_N=\int h_b\nu_N(db)
=\mathbf1_{x\ge1}\frac{\psi(\min(x,N))-\min(x,N)}x.
$$

The arithmetic atom at $N$ is included; the density endpoint adds no atom. All finite-source integrals below are absolute. The proof uses neither a finite mean of $W_t$ nor a positive exponential age moment.

## Exact two-history Gram and its normalized defect

Put $p_0(v)=e^{-v/2}\mathbf1_{v\ge0}$, with $\|p_0\|_2=1$. Then $Uh_b=b^{-1/2}p_0(v-\log b)$ and

$$
\langle p_0(\cdot-u),p_0(\cdot-v)\rangle=e^{-|u-v|/2}.
$$

For independent copies $W_t,W_t'$ define

$$
K_t(r)=\mathbb E e^{-|r+W_t-W_t'|/2},\qquad k_t=K_t(0)>0.
$$

Bochner integration and the bounded birth Gram give

$$
\boxed{\langle T_tUh_b,T_tUh_c\rangle
=(bc)^{-1/2}K_t(\log b-\log c).}
\tag{1}
$$

The difference law is symmetric. Thus $K_t$ is real, even and positive definite. The pointwise triangle inequality inside its expectation and Cauchy–Schwarz between translates of $T_tp_0$ imply

$$
e^{-|r|/2}k_t\le K_t(r)\le k_t\le1,
\qquad
0\le d_t(r):=1-K_t(r)/k_t\le1-e^{-|r|/2}\le|r|/2.
\tag{2}
$$

These comparisons hold for every time before any error is divided by $k_t$. In particular

$$
\boxed{\|T_tUg_N\|_2^2
=\iint (bc)^{-1/2}K_t(\log b-\log c)\nu_N(db)\nu_N(dc).}
\tag{3}
$$

This includes every zero-jump and positive-age pair, every prime power, the negative seed and all density terms.

## Form each complete arithmetic cell before estimating it

For $n\ge2$ put

$$
\omega_n=\Lambda(n)\delta_n-\mathbf1_{[n-1,n]}(b)db,
\quad v_n=\int h_b\omega_n(db),\quad V_n(t)=T_tUv_n.
$$

The seed is $-T_tUh_1$, of squared norm $k_t$. Define

$$
r_n=2(\sqrt n-\sqrt{n-1}),\quad
m_n=\Lambda(n)/\sqrt n-r_n,\quad
\epsilon_n=r_n-n^{-1/2}
=\frac1{\sqrt n(\sqrt n+\sqrt{n-1})^2}.
$$

Applying (1) to the whole signed cell gives

$$
\begin{aligned}
\|V_n(t)\|_2^2={}&\frac{\Lambda(n)^2k_t}{n}
-\frac{2\Lambda(n)}{\sqrt n}\int_{n-1}^n b^{-1/2}K_t(\log(n/b))db\\
&+\int_{n-1}^n\!\int_{n-1}^n
 (bc)^{-1/2}K_t(\log(b/c))dbdc.
\end{aligned}
\tag{4}
$$

Subtracting $k_tm_n^2$ now yields exactly

$$
\|V_n(t)\|_2^2=k_t[m_n^2+e_n(t)],
$$
$$
\begin{aligned}
e_n(t)={}&\frac{2\Lambda(n)}{\sqrt n}
\int_{n-1}^n b^{-1/2}d_t(\log(n/b))db\\
&-\int_{n-1}^n\!\int_{n-1}^n
 (bc)^{-1/2}d_t(\log(b/c))dbdc.
\end{aligned}
\tag{5}
$$

The two contributions have opposite signs. By (2), the first integral is at most $\int_{n-1}^n[b^{-1/2}-n^{-1/2}]db=\epsilon_n$. The density-density contribution is at most

$$
\eta_n=r_n^2-\int_{n-1}^n\!\int_{n-1}^n\frac{dbdc}{\max(b,c)}
=r_n^2-2[1-(n-1)\log(n/(n-1))]\ge0.
$$

Consequently

$$
-\eta_n\le e_n(t)\le\frac{2\Lambda(n)\epsilon_n}{\sqrt n},
\qquad
\boxed{|e_n(t)|\le\frac{2\log n}{n^2}+\frac1{2(n-1)^2}.}
\tag{6}
$$

For the second bound use $d_t(r)\le|r|/2$, $\log(n/(n-1))\le1/(n-1)$ and $r_n^2\le1/(n-1)$. The first cell has lower endpoint one, so these estimates include $n=2$. Estimating the atom and continuum independently before the cancellation in (5) would not yield this summable error.

## Loading with a remainder uniform over all process times

The series $C(t)=\sum_{n\ge2}e_n(t)$ converges absolutely and uniformly for $t\ge0$. Equation (6), summed by the first-term-plus-integral bound, gives

$$
|C(t)|\le4,\qquad
\left|C(t)-\sum_{n=2}^Ne_n(t)\right|
\le T_N:=\frac{2(\log N+1)}N+\frac1{2(N-1)}.
\tag{7}
$$

Write $L_N(t)=\sum_{n=2}^N\|V_n(t)\|_2^2$ and $S_m(N)=\sum_{n=2}^Nm_n^2$. Equations (5)–(7) give

$$
|L_N(t)-k_t[S_m(N)+C(t)]|\le k_tT_N.
\tag{8}
$$

The [actual charge-loading proof](actual-charge-arrival-loading.md) gives

$$
S_m(N)=\tfrac12\log^2N-\log N+C_m+R_m(N),
$$
$$
|R_m(N)|\le C\left[(1+\log^{3/2}N)e^{-c\sqrt{\log N}}
+N^{-1/2}\log^2(2N)+\frac{\log N}N\right].
\tag{9}
$$

Its convergent $C_m$ retains the full ramp and proper-power corrections. Combining these formulas proves

$$
\boxed{\left|L_N(t)-k_t[\tfrac12\log^2N-\log N+C_m+C(t)]\right|
\le k_t[|R_m(N)|+T_N].}
\tag{10}
$$

This holds for all $N\ge2,t\ge0$, so the limit $L_N(t)/(k_t\log^2N)\to1/2$ is uniform over arbitrary choices $t=t_N$. The coarser error omitting $C(t)$ is $k_t[4+|R_m(N)|]$. The time-dependent constant is not identified with its value at time zero.

At $t=0$, $d_0(r)=1-e^{-|r|/2}$ and $e_n(0)=2\Lambda(n)\epsilon_n/\sqrt n-\eta_n$. Thus the exact cell norm also reads

$$
\|Uv_n\|_2^2=\frac{\Lambda(n)^2-2\Lambda(n)}n
+2[1-(n-1)\log(n/(n-1))].
\tag{11}
$$

This independently checks the cell normalization against the charge approximation.

## Seeded signed work and its unresolved terminal norm

Define the original-space work

$$
W_N(t)=\sum_{n=2}^N\langle T_tUg_{n-1},V_n(t)\rangle.
$$

Its complete-source/cell formula is

$$
\begin{aligned}
W_N(t)=\sum_{n=2}^N\int\nu_{n-1}(db)\bigg[
&\Lambda(n)(bn)^{-1/2}K_t(\log(b/n))\\
&-\int_{n-1}^n(bc)^{-1/2}K_t(\log(b/c))dc\bigg].
\end{aligned}
\tag{12}
$$

One-admission polarization retains the exact seeded telescope

$$
\boxed{\|T_tUg_N\|_2^2=k_t+L_N(t)+2W_N(t).}
\tag{13}
$$

Therefore

$$
\begin{aligned}
W_N(t)={}&\tfrac12\|T_tUg_N\|_2^2
-\tfrac14k_t\log^2N+\tfrac12k_t\log N\\
&-\tfrac12k_t[1+C_m+C(t)]+\mathcal R_N(t),
\end{aligned}
$$
$$
|\mathcal R_N(t)|\le\tfrac12k_t[|R_m(N)|+T_N].
\tag{14}
$$

The time-dependent seed square $k_t$ is essential. These identities do not bound the signed work, because the terminal evolved norm remains. If an independent argument established $\|T_{t_N}Ug_N\|_2^2=o(k_{t_N}\log^2N)$, then (14) would give $W_N(t_N)=-\tfrac14k_{t_N}\log^2N[1+o(1)]$. That premise is not proved here.

The [source-correlation theorem](actual-short-time-psi-correlation.md) gives another exact expression for the same original norm. The present cell Gram is not an anticausal energy or a restored-age expectation, and it supplies no RH bound.
