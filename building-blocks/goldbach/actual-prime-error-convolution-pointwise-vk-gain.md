# A pointwise Vinogradov--Korobov gain for the actual prime-error convolution

Let $\Lambda$ include every prime power and set

$$
\psi(x)=\sum_{n\le x}\Lambda(n),\qquad E(x)=\psi(x)-x,
\qquad a_h=\frac{E(h)}h\quad(h\ge2),
$$

$$
Q_s=\sum_{\substack{m,h\ge2\\m+h=s}}\Lambda(m)a_h
\qquad(s\ge4).
\tag{1}
$$

Write

$$
\Phi(x)=\frac{(\log x)^{3/5}}{(\log\log x)^{1/5}},\quad
A_0=\frac1{48.0718},\quad
d=\left(\frac{5^6A_0^3}{2^2 3^4}\right)^{1/5}
=0.212579202\ldots.
\tag{2}
$$

Define $g(C)=A_0(5/3)^{1/3}C^{-2/3}$ for $C>0$, and let $c_*$ be the unique positive solution of

$$
c_*=d+g(c_*).
\tag{3}
$$

Numerically, $c_*=0.2714144067\ldots>d$.

**Theorem.** For every fixed $\varepsilon>0$ and integer $s\ge4$,

$$
\boxed{\displaystyle
|Q_s|\ll_\varepsilon s\exp[-(c_*-\varepsilon)\Phi(s)].}
\tag{4}
$$

The bound applies to the unsmoothed coefficient $Q_s$ itself. Directly taking absolute values with the prime-number-theorem error gives the smaller exponent $d$, up to an arbitrarily small loss. The argument below retains the signed difference $\Lambda(m)-1$ and controls it with a uniform truncated explicit formula.

The later [adaptive short-interval theorem](goldbach-cofactor-short-interval-vk-gain.md) strengthens (4) to the exponent $2^{2/5}d=0.280499938\ldots$. This note retains the distinct single-cutoff argument and its independently proved $c_*$ bound; use the short-interval theorem for the strongest bound currently established for $Q_s$ here.

**Proof status and attribution.** This is a written analytic proof, not a Lean theorem or an RH result; no literature-priority claim is made. The finite split (8) is checked in [GoldbachCofactorLinearSplitFinite.lean](../../formalization/BuildingBlocks/GoldbachCofactorLinearSplitFinite.lean). The exact packet split and residual variation inequality behind (16), with both endpoints retained, are checked in [GoldbachCofactorPointwiseAbelFinite.lean](../../formalization/BuildingBlocks/GoldbachCofactorPointwiseAbelFinite.lean). The explicit formula, zero-density optimization, and resulting asymptotic estimate remain written arguments. Their analytic inputs are Bellotti's [2024 zero-free region](https://arxiv.org/abs/2306.10680), Johnston's [PNT transfer theorem](https://arxiv.org/html/2411.13791), classical Ingham zero density as documented by [Chourasiya and Simonič](https://arxiv.org/html/2507.15184), and the uniform explicit-formula theorem of [Cully-Hugill and Johnston](https://arxiv.org/html/2402.04272). It does not use the disputed near-edge zero-density claim or sharp $\varepsilon=0$ PNT assertion of Bellotti's later 2025 preprint.

## Uniform arithmetic inputs

Bellotti's earlier theorem gives $\beta\le1-A_0u(|\gamma|)$ for all sufficiently high nontrivial zeros $\rho=\beta+i\gamma$, where

$$u(T)=(\log T)^{-2/3}(\log\log T)^{-1/3}.$$

Johnston's result supplies, for every $\delta>0$,

$$
|a_h|\ll_\delta e^{-(d-\delta)\Phi(h)}.
\tag{5}
$$

We also use Ingham's uniform estimate $N(\sigma,T)\ll T^{3(1-\sigma)/(2-\sigma)}(\log T)^5$ for $1/2\le\sigma\le1$. Finally, Cully-Hugill and Johnston's Theorem 1.1, with $\alpha=1/2$, gives one constant $M$ such that

$$
E(m)=-\sum_{|\gamma|\le T}\frac{m^\rho}{\rho}
+O\!\left(\frac{m\log m}{T}\right)
\tag{6}
$$

for every integer $m\ge x_M$ and every $T$ satisfying $\max(51,\log m)<T<(\sqrt m-2)/2$. The implied constant in (6) is uniform in $m$ and $T$ in that range.

The [linearized-cofactor proof](goldbach-linearized-pointwise-vk-gain.md), using Soundararajan's absolutely convergent $\rho^{-2}$ explicit formula, gives

$$
\left|\sum_{h=2}^{n}a_h\right|
\ll_\delta n e^{-(c_2-\delta)\Phi(n)},
\qquad c_2=2^{2/5}d=0.280499938\ldots.
\tag{7}
$$

## Center the outer prime factor

Put $b_m=\Lambda(m)-1=E(m)-E(m-1)$. Then

$$
Q_s=\underbrace{\sum_{h=2}^{s-2}a_h}_{J_s}
+\underbrace{\sum_{m=2}^{s-2}b_m a_{s-m}}_{B_s}.
\tag{8}
$$

The first term obeys (7) with $n=s-2$. To estimate $B_s$, fix $C>0$ and set

$$
T=\exp(C\Phi(s)),\qquad \nu=A_0u(T),\qquad
m_0=\left\lceil(2T+3)^2\right\rceil.
\tag{9}
$$

For large $s$, $m_0<s$ and $T>\max(51,\log s)$. Every integer $m\in[m_0,s]$ satisfies the upper restriction on $T$ in (6), so *one fixed zero cutoff* works for every such $m$. Also,

$$
\nu\log s=(g(C)+o(1))\Phi(s).
\tag{10}
$$

## A fixed cutoff over the full convolution

Call a zero *near* if $|\gamma|\le T$ and $\beta>1-8\nu$. For large $s$ the finitely many low zeros are outside this near set. The zero-free region therefore bounds every near zero by $\beta\le1-\nu$. Ingham bounds their number by

$$
M(T)\ll T^{24\nu/(1+8\nu)}(\log T)^5
=\exp(o(\Phi(s))).
\tag{11}
$$

Define for every integer $1\le m\le s$

$$
F(m)=-\sum_{\rho\ \mathrm{near}}\frac{m^\rho}{\rho},
\qquad R(m)=E(m)-F(m).
\tag{12}
$$

The near-zero set is closed under complex conjugation, so $F(m)$ and $R(m)$ are real; this is the real-valued packet used in the finite Lean identity.

For $m\ge m_0$, (6), the far-zero condition $\beta\le1-8\nu$, and $\sum_{|\gamma|\le T}|\rho|^{-1}\ll\log^2T$ give

$$
|R(m)|\ll\frac{m\log m}{T}+m^{1-8\nu}\log^2T.
\tag{13}
$$

For $m<m_0$, Chebyshev's bound $E(m)=O(m)$ and the same reciprocal-zero sum give $|R(m)|\ll m_0\log^2T$. Hence

$$
\max_{1\le m\le s}|R(m)|
\ll \frac{s\log s}{T}+s^{1-8\nu}\log^2T+m_0\log^2T.
\tag{14}
$$

Because $m_0=\exp(O(\Phi(s)))=s^{o(1)}$, the last term is smaller than $s e^{-K\Phi(s)}$ for every fixed $K>0$.

The weight $a_h$ has logarithmic total variation. Indeed, the exact recurrence

$$
a_{h+1}-a_h
=\frac{\Lambda(h+1)-1}{h+1}-\frac{E(h)}{h(h+1)}
\tag{15}
$$

and Chebyshev's bounds imply $\sum_{2\le h\le s}|a_{h+1}-a_h|\ll\log s$ and $\sup_h|a_h|\ll1$. The finite summation-by-parts identity is

$$
\sum_{m=2}^{s-2}(R(m)-R(m-1))a_{s-m}
=R(s-2)a_2-R(1)a_{s-2}
+\sum_{m=2}^{s-3}R(m)(a_{s-m}-a_{s-m-1}).
$$

It and the bound by the maximum residual times the displayed endpoint-and-variation budget are Lean-compiled in the packet Abel module linked above. The analytic variation estimate then gives

$$
\left|\sum_{m=2}^{s-2}\bigl(R(m)-R(m-1)\bigr)a_{s-m}\right|
\ll (\log s)\max_{1\le m\le s}|R(m)|.
\tag{16}
$$

For the near-zero part, the discrete difference is exactly

$$
\frac{m^\rho-(m-1)^\rho}{\rho}
=\int_{m-1}^{m}t^{\rho-1}\,dt.
\tag{17}
$$

For each near zero, split its weighted sum at $h=s-m=s/2$. If $h\le s/2$, then $m\asymp s$ and (5) plus slow variation give

$$
\sum_{\substack{2\le m\le s-2\\s-m\le s/2}}
\left|\int_{m-1}^{m}t^{\rho-1}dt\right||a_{s-m}|
\ll_\delta s^{\beta-1}\sum_{h\le s/2}|a_h|
\ll_\delta s^\beta e^{-(d-\delta)\Phi(s)}.
\tag{18}
$$

If $h>s/2$, then $|a_h|\ll_\delta e^{-(d-\delta)\Phi(s)}$ and $\sum_{m\le s/2}\int_{m-1}^m t^{\beta-1}dt\ll s^\beta/\beta$. Every near zero has $\beta>1/2$ for large $s$, so this side obeys the same bound as (18). Summing over (11) and using $\beta\le1-\nu$ gives

$$
\left|\sum_{m=2}^{s-2}\bigl(F(m)-F(m-1)\bigr)a_{s-m}\right|
\ll_\delta M(T)s^{1-\nu}e^{-(d-\delta)\Phi(s)}
\ll_\delta s e^{-(d+g(C)-o(1)-\delta)\Phi(s)}.
\tag{19}
$$

This estimate retains the signed discrete prime difference rather than bounding the original $\Lambda(m)$ term absolutely.

## Optimize the cutoff

Equations (8), (14), (16), and (19) bound $Q_s$, up to arbitrarily small losses in the $\Phi(s)$ exponent, by the four rates

$$
c_2,\qquad C,\qquad 8g(C),\qquad d+g(C).
\tag{20}
$$

Choose $C=c_*$. By (3), $C=d+g(C)=c_*$. Numerically $8g(c_*)=0.470681636\ldots>c_*$, while $c_2>c_*$. Powers of $\log s$, the $\exp(o(\Phi(s)))$ near-zero count, and the uniform small-$m$ term are absorbed by $\varepsilon\Phi(s)$. This proves (4) for sufficiently large $s$; enlarging the implied constant covers the remaining integers.
