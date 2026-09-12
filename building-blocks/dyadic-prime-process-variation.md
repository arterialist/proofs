# Dyadic smoothing of the actual complete prime process

This written proof keeps all prime powers and the no-jump atom. The [complete seed tail](collective-successor-seed-long-memory.md) and [density BV theorem](positive-history-successor-charge-relaxation.md) supply the arithmetic input. Conditioning independent Poisson components and convolution contraction are classical; the proof below derives the needed estimates directly. No density-variation or successor-relaxation theorem here is formalized in Lean.

Let
$$
 F_P(v)=\sum_{p\le P}\frac{e^{v/2}}{v}
 p^{-\lfloor v/\log p\rfloor-1}\mathbf1_{v\ge\log p},
 \qquad F=F_\infty,
$$
and let the associated compound-Poisson laws be
$$
 \mu_{P,t}=e^{-\lambda_Pt}\delta_0+m_{P,t}(v)\,dv,
 \qquad\lambda_P=\int_0^\infty F_P(v)\,dv.
 \tag{1}
$$
Variation below means the whole-line total variation of the distributional derivative of the density. It does not mean differentiating the no-jump atom.

For an absolute constant depending only on the actual density bounds,
$$
 \boxed{\operatorname{Var}(m_{\infty,t})\le C/t\qquad(t\ge1).}
 \tag{2}
$$
The finite-cutoff strengthening is
$$
 \boxed{\operatorname{Var}(m_{P,t})
 \le\frac{C}{\sqrt{t\min(t,1+\log P)}}
 \qquad(P\ge2,\ t\ge1).}
 \tag{3}
$$
In particular (2) holds uniformly through times $t\lesssim\log P$. For every fixed finite $P$, an all-time $O_P(t^{-1})$ bound is false.

The proof uses the established full-prime tail $F(v)\sim2/v^2$, whole-line $BV$ control, and the [uniform-convolution estimate](compensated-successor-total-variation-relaxation.md#2-convolution-powers-of-the-uniform-density). It does not require a differentiated Fourier local limit theorem.

## 1. Exact extraction with all residual histories retained

The actual seed asymptotic and variation results give
$$
 F,F_P\ge0,\quad \sup_{P\ge2}\{\|F_P\|_1+
 \operatorname{Var}(F_P)\}<\infty,\quad
 \lambda_P\ge\lambda_2>0,
$$
$$
 F(v)\ge d_0/v^2\quad(v\ge V_0)
 \tag{4}
$$
for some fixed $d_0,V_0>0$, increasing $V_0$ if necessary. Values at jump endpoints do not affect the density inequalities.

Put $r_j=2^jV_0$, $I_j=[r_j,2r_j)$, and
$$
 u_j=r_j^{-1}\mathbf1_{I_j},\qquad
 \alpha_j=c/r_j,\qquad
 h_j=\alpha_ju_j=c r_j^{-2}\mathbf1_{I_j},
 \tag{5}
$$
where $0<c\le d_0/8$. On $I_j$, (4) implies $h_j\le F/2$. The intervals have disjoint interiors, so $h=\sum_{j\ge0}h_j\le F/2$. Also
$$
 \alpha:=\int h=\frac{2c}{V_0},\qquad
 \operatorname{Var}(h)\le2c\sum_{j\ge0}r_j^{-2}<\infty.
 \tag{6}
$$
The variation estimate includes both endpoints of every interval; cancellation at common endpoints only improves it.

Thus the exact decomposition $F=h+F_{\rm res}$ has
$$
 F_{\rm res}\ge0,\quad F_{\rm res}\in L^1\cap BV,\quad
 \lambda_{\rm res}\ge\lambda/2>0.
 \tag{7}
$$
Every proper prime power remains in $F$ and hence in this decomposition. The uniform components are extracted positive pieces of the actual density, not a replacement jump process.

For finite $P$, $F_P(v)=F(v)$ almost everywhere on $v<\log P$. Extract only the intervals with $2r_j\le\log P$, indexed $0\le j\le M$. Then $h^{(M)}\le F_P/2$. The residual masses are at least $\lambda_2/2$, and their variations are bounded independently of $P,M$. When this index set is nonempty,
$$
 \tfrac14\log P<r_M\le\tfrac12\log P.
 \tag{8}
$$

## 2. Conditioning on the largest occupied scale

Realize the extracted process by independent Poisson counts $N_j$ of means $t\alpha_j$, with independent uniform jumps of density $u_j$, and an independent residual process. Since $\sum_jt\alpha_j<\infty$, only finitely many extracted jumps occur almost surely, even for the full process. Define $J$ as the largest $j$ with $N_j\ge1$, with a separate value for no extracted jump.

For the full process,
$$
 \sum_{k>j}\alpha_k=c/r_j,\qquad
 \mathbb P(J=j)=e^{-ct/r_j}(1-e^{-ct/r_j}).
 \tag{9}
$$
Conditional on $J=j$ and $N_j=n\ge1$, the law has a factor $u_j^{*n}$. All lower scales and the residual process form another probability convolution factor. They may include atoms. Such convolution cannot increase the variation of the density $u_j^{*n}$.

In particular, the elementary bound $\operatorname{Var}(u_j)=2/r_j$ gives
$$
 \sum_{j\ge0}\mathbb P(J=j)
 \operatorname{Var}(\text{conditional density})
 \le 2\sum_{j\ge0}r_j^{-1}e^{-ct/r_j}.
 \tag{10}
$$
The right side is at most $C/t$. To see this directly, split at $r_j=t$. The large-scale geometric tail is $O(1/t)$; the smaller scales are bounded by
$$
 \frac Ct\sum_{k\ge0}2^k e^{-c'2^k}\le C'/t.
 \tag{11}
$$
This bound also covers an empty small-scale part.

On the event with no extracted jumps, of probability $e^{-\alpha t}$, only the residual process remains. Its density has
$$
 \operatorname{Var}(m_{{\rm res},t})
 \le\frac{\operatorname{Var}(F_{\rm res})}{\lambda_{\rm res}}
       (1-e^{-\lambda_{\rm res}t})\le C.
 \tag{12}
$$
Indeed the derivative of $F_{\rm res}^{*n}$ can be assigned to one factor, with norm at most
$\operatorname{Var}(F_{\rm res})\lambda_{\rm res}^{n-1}$, and then summed in the Poisson series.

The exact density decomposition is therefore
$$
 m_{\infty,t}
 =\sum_{j\ge0}\mathbb P(J=j)\,g_{j,t}
   +e^{-\alpha t}m_{{\rm res},t},
 \tag{13}
$$
where each $g_{j,t}$ is a probability density. The remaining atom has mass
$e^{-\alpha t}e^{-\lambda_{\rm res}t}=e^{-\lambda t}$.
Equations (10)–(12) justify convergence of the derivative series in total variation and prove (2). They retain the derivative atoms inside the densities as well as the separate no-jump atom of the probability law.

## 3. The finite-cutoff crossover

The uniform convolution estimate, including the first uniform density with its two endpoint atoms, is
$$
 \operatorname{Var}(u_j^{*n})\le\frac{C}{r_j\sqrt n},
 \qquad n\ge1.
 \tag{14}
$$
For $N$ Poisson of mean $z>0$, set
$$
 b(z)=\mathbb E[N^{-1/2}\mathbf1_{N\ge1}]
 \le C\min(z,z^{-1/2}).
 \tag{15}
$$
For $z\le1$ this follows from $\mathbb P(N\ge1)\le z$; for $z\ge1$, split at $N=z/2$ and use the elementary exponential Poisson tail.

For the extracted scales $0,\ldots,M$,
$$
 \sum_{k=j+1}^M\alpha_k
 =c(1/r_j-1/r_M).
 \tag{16}
$$
Averaging (14) without normalizing away the event $N_j\ge1$ bounds the corresponding density variation by
$$
 C\sum_{j=0}^M
 e^{-ct(1/r_j-1/r_M)}
 \frac1{r_j}b(ct/r_j).
 \tag{17}
$$
The residual term is still $O(e^{-\alpha_*t})$, where
$\alpha_*=\alpha_0=c/V_0>0$, independently of $P,M$.

If $1\le t\le r_M$, use the bound by one for the variation after one uniform factor. The exponential factor in (17) is at most $e^c e^{-ct/r_j}$, so the argument (10)–(11) gives $C/t$.

If $t\ge r_M$, the $j=M$ contribution is at most
$$
 C r_M^{-1}(ct/r_M)^{-1/2}
 \le C/\sqrt{tr_M}.
$$
For $j<M$, $r_j\le r_M/2$, hence
$$
 e^{-ct(1/r_j-1/r_M)}\le e^{-ct/(2r_j)}.
$$
Using $b(z)\le Cz^{-1/2}$, the remaining terms are bounded by
$$
 \frac C{\sqrt t}\sum_{j<M}r_j^{-1/2}e^{-ct/(2r_j)}
 \le\frac C{\sqrt{tr_M}}
 \sum_{k\ge1}2^{k/2}e^{-c2^{k-1}}
 \le\frac C{\sqrt{tr_M}}.
 \tag{18}
$$
The residual exponential is bounded by $C/t$, which is no larger than $C/\sqrt{tr_M}$ in this regime.

Equation (8) now proves (3) for $\log P\ge2V_0$. For the bounded remaining range $2\le P<e^{2V_0}$, use the fixed prime-two uniform component already present at every cutoff. Its variation estimate is $C/\sqrt t$. Since $1+\log P$ is bounded in this range, enlarging the constant gives exactly (3).

## 4. Why fixed finite cutoffs cannot retain the full rate

For every finite $P$, the actual jump density has a finite second moment
$$
 M_{2,P}:=\int_0^\infty v^2F_P(v)\,dv\in(0,\infty).
 \tag{19}
$$
For example $F_p(v)\le e^{-v/2}/v$ on $v\ge\log p$, so finiteness follows for each finite sum. Let $Z_{P,t}$ have law (1). Its variance is $tM_{2,P}$. Chebyshev's inequality gives probability at least $3/4$ in an interval of length $4\sqrt{tM_{2,P}}$ centered at its mean. For all sufficiently large $t$, deleting the no-jump atom leaves at least $1/2$ of continuous mass in this interval. Consequently
$$
 \|m_{P,t}\|_\infty\ge\frac1{8\sqrt{tM_{2,P}}},
\qquad
 \operatorname{Var}(m_{P,t})\ge2\|m_{P,t}\|_\infty
 \ge\frac1{4\sqrt{tM_{2,P}}}.
 \tag{20}
$$
The middle inequality holds for any nonnegative whole-line integrable BV density, whose limits at both infinities are zero. This proves the claimed obstruction to $O_P(t^{-1})$, even with a cutoff-dependent constant.

The full-prime order $t^{-1}$ is itself sharp. The actual bound $F(v)\le C/(1+v)^2$ gives, for $R\ge1$,
$$
 \int_R^\infty F\le C/R,\qquad
 \int_0^R v^2F(v)\,dv\le CR.
 \tag{21}
$$
Fix a sufficiently large constant $D$ and split the process at jump size $R=Dt$. A jump above $R$ has probability at most $C/D$. The process using only smaller jumps has variance at most $CDt^2$, so Chebyshev places at least $3/4$ of that law in an interval of length $4\sqrt{CD}\,t$. For $D$ with $C/D\le1/8$, the full law has at least $5/8$ of its mass in the same interval. After deleting its exponentially small no-jump atom, at least $1/2$ remains there for all sufficiently large $t$. The density-height argument in (20) yields
$$
 \operatorname{Var}(m_{\infty,t})\ge c/t.
 \tag{22}
$$
The center used here is the finite mean of the truncated process; no finite mean is assumed for the full process.

## 5. The retained successor packet

Use the [finite-transport primitive](compensated-successor-finite-transport.md) and [positive-history response identities](positive-history-successor-charge-relaxation.md), on the causal mixed completion with physical representative $a(v)=e^{v/2}H(e^v)$:
$$
 (C-I)a=\partial P_a,\quad
 \|P_a\|_1\le C_a,
$$
$$
 [C,T_t]a=-(Dm_t)*P_a+R_t,\quad
 \|R_t\|_1\le C_a e^{-t\Phi(1)},\quad
 |\delta(T_ta)|\le C_a e^{-t\Phi(1)}.
 \tag{23}
$$
These include the actual natural sources and their proved completion. For $\kappa=\delta(a)$ and $q_t=T_ta_0$, the exact rank correction is
$$
 [S,T_t]a+\kappa q_t=[C,T_t]a+a_0\delta(T_ta).
$$
Because $\|a_0\|_1=2$, (2) and (23) prove
$$
 \boxed{\|[S,T_t]a+\kappa T_ta_0\|_1\le C_a/t
 \qquad(t\ge1).}
 \tag{24}
$$
With finite $P$, the identical source argument and (3) give
$$
 \|[S,T_{P,t}]a+\kappa T_{P,t}a_0\|_1
 \le\frac{C_a}{\sqrt{t\min(t,1+\log P)}}.
 \tag{25}
$$
The exponential constants are uniform since $\Phi_P(1)\ge\Phi_2(1)>0$. Equations (24)–(25) retain the actual reference packet, all prime powers, and the no-jump atom. They improve the error in the existing physical $L^1$ comparison. They do not authorize an unbounded energy readout or imply an RH sign.
