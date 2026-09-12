# What literal compensated succession retains from an actual finite source

This is a written proof. The literal operator and signed arithmetic driver come from the [compensated successor representation](literal-compensated-successor-iterates.md); no theorem here is formalized in Lean.

Use the original physical $L^2(dx)$, with zero extension below $x=1$, and the literal compensated successor
$$
 SH(x)=\mathbf1_{x\ge1}H(x+1),\qquad C=S-h_1\delta,
 \qquad h_1(x)=x^{-1}\mathbf1_{x\ge1}.
$$
For the actual frozen source $g_N$, $N\ge2$, let
$$
 M_N=Q(g_N)=\sum_{n\le N}\frac{\Lambda(n)}{\sqrt n}-2\sqrt N+1,
 \qquad V_k=C^kh_1.
$$
We prove the fixed-source stabilization
$$
 \boxed{\|C^kg_N-M_NV_k\|_2\longrightarrow0\quad(k\to\infty),}
\tag{1}
$$
and the strong critical-dilation limit
$$
 \boxed{D_kC^kg_N\longrightarrow M_N\mathcal V
          \quad\hbox{in original }L^2(0,\infty),}
\tag{2}
$$
$$
 \mathcal V(x)=\frac4{\pi^2}
       \frac{\operatorname{atanh}((1+x)^{-1/2})}{\sqrt{1+x}},
 \qquad
 \boxed{\|\mathcal V\|_2^2=\frac{28\zeta(3)}{\pi^4}.}
\tag{3}
$$
Here $D_kF(x)=\sqrt k\,F(kx)$ is the unitary critical dilation. Every signed driver and the actual frozen endpoint remain in the proof. No positivity is asserted for the primitive of the fifth or any later source iterate.

## 1. Exact renewal input and actual arithmetic driver

The [finite-iterate theorem](literal-compensated-successor-iterates.md) proves
$$
 q_0=1,\quad q_j=\frac{\arctan\sqrt j}{\sqrt j}\ (j>0),\quad
 d_j=q_j-q_{j+1},
$$
$$
 r_0=1,\quad r_n=\sum_{m=1}^nd_{m-1}r_{n-m},\quad
 V_k(x)=\mathbf1_{x\ge1}\sum_{j=0}^k\frac{r_j}{x+k-j},
 \qquad \|V_k\|_2\le1.
\tag{4}
$$
The exact-kernel theorem in [exact-seed-renewal-asymptotic.md](exact-seed-renewal-asymptotic.md) supplies
$$
 r_n\to0,\qquad 0<r_n\le(n+1)^{-1/2},\qquad
 r_n\sim\frac2{\pi^2\sqrt n}.
\tag{5}
$$
That source verifies the actual borderline renewal hypothesis and also gives an independent proof from the exact Hausdorff moments and monotone renewal coefficients. We use its stated theorem, not a generic boundary-index renewal assumption.

For the signed source, set
$$
 e_{N,i}=Q(S^{i+1}g_N)-Q(S^ig_N).
$$
The already derived literal identity is
$$
 \boxed{C^kg_N=S^kg_N-\sum_{i=0}^{k-1}e_{N,i}V_{k-1-i}.}
\tag{6}
$$
These driver values retain the exact birth formula
$$
 Q(S^ig_N)=-q_i(1)+\sum_{2\le n\le N}\Lambda(n)q_i(n)
                                     -\int_1^Nq_i(t)dt,
$$
where $q_i(t)=Q(S^ih_t)$, with its exact shifted threshold
$\max(1,t-i)$. The seed, each proper power, and the continuous cell part have therefore not been collapsed to positive coefficients. The same note proves
$$
 \sum_{i\ge0}|e_{N,i}|\le C\sqrt N.
\tag{7}
$$
For $i\ge N-1$, all source samples are in the literal frozen tail, so
$$
 S^ig_N(x)=\frac{E_\psi(N)}{x+i},\qquad
 e_{N,i}=-E_\psi(N)d_i.
\tag{8}
$$
In particular $Q(S^ig_N)\to0$, and the full signed telescoping sum is
$$
 \boxed{\sum_{i\ge0}e_{N,i}=-M_N.}
\tag{9}
$$

## 2. Adjacent seed iterates become close

Let $b_\ell=S^{\ell+1}h_1-S^\ell h_1$. Its full original norm has the summable bound
$$
 b_\ell(x)=-\frac{\mathbf1_{x\ge1}}{(x+\ell)(x+\ell+1)},
 \qquad
 \|b_\ell\|_2\le\frac1{\sqrt3(1+\ell)^{3/2}}.
\tag{10}
$$
Formula (4) gives exactly
$$
 V_{k+1}-V_k=r_{k+1}h_1+\sum_{\ell=0}^k r_{k-\ell}b_\ell.
\tag{11}
$$
For each fixed $\ell$, its coefficient tends to zero by (5). The summable bound (10), with $r_n\le1$, permits dominated convergence in the series. Hence
$$
 \|V_{k+1}-V_k\|_2\to0.
$$
It follows that $\|V_{k-1-i}-V_k\|_2\to0$ for every fixed $i$. Also (5), splitting the sum in (11) at $\ell=k/2$, gives the useful quantitative bound
$$
 \boxed{\|V_{k+1}-V_k\|_2\le C(1+k)^{-1/2}.}
\tag{12}
$$
For the first half use $r_{k-\ell}\le Ck^{-1/2}$ and summability of (10); for the second use $\|b_\ell\|_2\le Ck^{-3/2}$ and
$\sum_{j\le k/2}r_j\le C\sqrt k$.

## 3. Fixed-source stabilization, with its complete tail

Combining (6) and (9) gives
$$
 C^kg_N-M_NV_k
 =S^kg_N-\sum_{i<k}e_{N,i}(V_{k-1-i}-V_k)
                      +\left(\sum_{i\ge k}e_{N,i}\right)V_k.
\tag{13}
$$
For $k\ge N-1$, the first term has exact norm
$$
 \|S^kg_N\|_2=\frac{|E_\psi(N)|}{\sqrt{k+1}},
$$
which tends to zero at fixed $N$. The last term tends to zero by (7). In the middle term, each fixed-lag difference tends to zero by Section 2 and is bounded by two. Dominated convergence against the full $\ell^1$ driver proves (1). In particular the infinite driver tail is not replaced by a finite driver or discarded at the source cutoff.

The mechanism only needs the exact signed identity (6), an $\ell^1$ driver of total mass $-M_N$, decay of the ordinary shift, and adjacent seed stability. It does not require that $C$ preserve a cone of general positive functions or positive primitives.

## 4. The exact strong dilation profile of the seed orbit

Set
$$
 F_k(x)=\sqrt k\,V_k(kx)
 =\mathbf1_{x\ge1/k}\frac1{\sqrt k}
                  \sum_{j=0}^k\frac{r_j}{x+1-j/k}.
\tag{14}
$$
For every fixed $x>0$, (5) and Riemann sums imply
$$
 F_k(x)\longrightarrow
 \frac2{\pi^2}\int_0^1\frac{dt}{\sqrt t(x+1-t)}
 =\mathcal V(x).
\tag{15}
$$
The $j=0$ term tends to zero. To justify the endpoint $t=0$, first omit $j\le\varepsilon k$. On the remaining interval the renewal equivalent is uniform as $k\to\infty$; the omitted sum is bounded by $C\sqrt\varepsilon/(x+1-\varepsilon)$ using the all-index bound in (5). Then let $\varepsilon\downarrow0$. The endpoint $t=1$ is nonsingular for fixed $x>0$. Substitution $t=s^2$ evaluates the integral in (15) as (3).

There is a square-integrable majorant on the entire physical half-line:
$$
 \boxed{F_k(x)\le C\log(1+1/x),\qquad x>0,\ k\ge1.}
\tag{16}
$$
Below $1/k$ the left side is zero. For $x\ge1/k$, split (14) into $j\le k/2$ and $j>k/2$. The first part is bounded by $C/(1+x)$, since $\sum_{j\le k/2}r_j\le C\sqrt k$. In the second part $r_j\le C/\sqrt k$, giving
$$
 C\sum_{\ell=0}^{\lfloor k/2\rfloor}\frac1{kx+\ell}
 \le C\left[\frac1{kx}+\log(1+1/x)\right].
$$
On $x\ge1/k$, the added $1/(kx)$ is bounded by a constant multiple of $\log(1+1/x)$: use $x\le1$ and $x\ge1$ separately. Also $1/(1+x)\le\log(1+1/x)$. This proves (16).

The square of this majorant is integrable at both zero and infinity. Dominated convergence proves
$$
 \boxed{D_kV_k\to\mathcal V\quad\hbox{strongly in }L^2(0,\infty).}
\tag{17}
$$
This argument controls the complete profile, not only compact physical intervals.

To compute its norm, set $s=(1+x)^{-1/2}$:
$$
 \|\mathcal V\|_2^2
    =\frac{32}{\pi^4}\int_0^1\frac{\operatorname{atanh}^2s}{s}\,ds.
$$
With $u=\operatorname{atanh}s$, the integral becomes
$$
 \int_0^\infty\frac{2u^2}{\sinh(2u)}du
   =4\sum_{m\ge0}\int_0^\infty u^2e^{-(4m+2)u}du
   =\sum_{m\ge0}\frac1{(2m+1)^3}
   =\frac78\zeta(3).
$$
All exchanges here are positive Tonelli exchanges. This proves the exact constant in (3), and in particular
$$
 \|V_k\|_2^2\longrightarrow28\zeta(3)/\pi^4.
\tag{18}
$$

## 5. The retained arithmetic information

Critical dilation is unitary. Applying it to (1), then using (17), proves (2) and
$$
 \boxed{\|C^kg_N\|_2^2
               \longrightarrow\frac{28\zeta(3)}{\pi^4}M_N^2.}
\tag{19}
$$
The limit profile retains the sign of $M_N$, and its squared norm retains $M_N^2$. For each actual finite cutoff the known nonvanishing of this charge makes the limiting norm positive. The ordinary frozen shift tends to zero, but its exact compensation feedback carries this nonzero norm on an expanding physical scale.

These statements do not assert a fixed unscaled $L^2$ limit of $V_k$ or $C^kg_N$. The strong limit in (2) uses the displayed critical dilation. Nor do they assert positivity of the actual source iterates when $M_N<0$, or positivity of any of their successive primitives. The established failure of all-iterate primitive positivity is compatible with the signed renewal argument.

## 6. One explicit uniform finite-source remainder

The preceding fixed-$N$ theorem is unconditional. A quantitative estimate can also be retained without guessing a rate in the sharp renewal equivalent. From (12)--(13), for $N-1\le J\le k/2$ and $k\ge N-1$,
$$
 \|C^kg_N-M_NV_k\|_2
 \le\frac{|E_\psi(N)|}{\sqrt{k+1}}
 +\frac C{\sqrt k}\sum_{i<J}(i+1)|e_{N,i}|
                         +3|E_\psi(N)|q_J.
\tag{20}
$$
The last term uses the exact tail in (8). For the first $N-1$ driver values, (7) bounds the weighted sum by $CN^{3/2}$. For the rest,
$$
 \sum_{i=0}^{J-1}(i+1)d_i
      =\sum_{i=0}^{J-1}q_i-Jq_J\le C\sqrt J.
$$
Taking $J=\lfloor\sqrt k\rfloor$ therefore proves
$$
 \boxed{\|C^kg_N-M_NV_k\|_2
       \le C\left[\frac{N^{3/2}}{\sqrt k}
                    +\frac{|E_\psi(N)|}{k^{1/4}}\right],\qquad
 k\ge\max(4,(N-1)^2).}
\tag{21}
$$
All constants are independent of $N,k$. This is a coarse but explicit uniform remainder, with the actual terminal discrepancy still visible. It does not give a small error at $k$ comparable to $N$, and it is not a logarithmic-time RH estimate. The exact signed driver identity, rather than a positive-primitive induction, is what makes the fixed-source theorem and this bound possible.
