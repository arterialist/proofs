# What the actual positive primitive transfers at logarithmic process time

This written theorem transfers the short-time source and complete $W$ targets between the original and compensated actual sources. It uses the [uniform actual potential](full-prime-successor-potential-midpoint.md) and the [complete-process density variation](../prime-distribution/dyadic-prime-process-variation.md). The arithmetic square bounds remain open; the implication and the quantitative difference estimates are proved. No theorem in this chapter is formalized in Lean.

Only the complete prime-only finite-activity law is used:
$$
 \mu_t=e^{-\lambda t}\delta_0+m_t(v)dv,\qquad T_tf=\mu_t*f.
$$
Every proper prime power is present in its actual density. The law is a probability measure, so $T_t$ is a contraction on $L^2(dv)$. This space is unitarily the original physical $L^2(dx)$ under $Uf(v)=e^{v/2}f(e^v)$. It is not replaced by the mixed energy space.

## 1. Uniform smoothing of the literal successor difference

For the actual frozen source $a_N=Ug_N$, let $b_N=Ca_N$, and let $P_N'=b_N-a_N$. The proved actual source bound in the [full-prime potential theorem](full-prime-successor-potential-midpoint.md) is
$$
 |P_N(v)|+|P_N'(v)|\le C(1+v)e^{-v/2}1_{v\ge0},
\quad P_N(0)=0.
\tag{1}
$$
It is uniform over all natural cutoffs $N\ge2$, and also holds for the completed potential $P_\infty$. In particular both $L^2$ norms in (1) are uniformly bounded.

The [dyadic density theorem](../prime-distribution/dyadic-prime-process-variation.md) gives $\|Dm_t\|_{\rm TV}\le C/t$ for $t\ge1$. The derivative here is of the density; the no-jump atom remains separate. Distributional differentiation and convolution give exactly
$$
 T_tP_N'=e^{-\lambda t}P_N'+(Dm_t)*P_N.
\tag{2}
$$
There is no boundary atom in $P_N'$, since $P_N(0)=0$. The derivative of $m_t$ is a finite measure, including its jumps, and the last convolution belongs to $L^2$ by Young's inequality. Thus
$$
 \boxed{\sup_{N\ge2,\,N=\infty}\|T_tP_N'\|_2
       \le\frac C{1+t},\qquad t\ge0.}
\tag{3}
$$
For $t\le1$, this uses contraction and (1). For $t\ge1$, use (2), retaining the no-jump contribution $Ce^{-\lambda t}$.

Consequently, for finite source cutoffs,
$$
 \boxed{\big|\|T_tb_N\|_2-\|T_ta_N\|_2\big|
       \le C/(1+t).}
\tag{4}
$$
For every fixed $c>0$, this error is $O_c(1/\log N)$ at $t=c\log N$. Hence the proposed subpower squared-norm target for $T_{c\log N}a_N$ is equivalent to the same target for its literal compensated successor $T_{c\log N}b_N$. No $L^2$ claim for the individual completed $a_\infty,b_\infty$ is used.

The squared norm identity still retains its mixed term:
$$
 \|T_tb_N\|_2^2-\|T_ta_N\|_2^2
 =2\operatorname{Re}\langle T_ta_N,T_tP_N'\rangle
  +\|T_tP_N'\|_2^2,
$$
$$
 \left|\|T_tb_N\|_2^2-\|T_ta_N\|_2^2\right|
 \le\frac{C\|T_ta_N\|_2}{1+t}+\frac C{(1+t)^2}.
\tag{5}
$$
Thus (3) alone does not bound the full square. The exact source norm remains
$$
 \|a_N\|_2^2=\int_1^N\frac{[\psi(x)-x]^2}{x^2}dx
                  +\frac{[\psi(N)-N]^2}{N}.
\tag{6}
$$
In particular its frozen terminal term cannot be discarded when using the signed inverse to infer an RH bound.

## 2. Transfer of the full reflected W comparison on one causal window

Use the [exact full-source formula](../zeta-and-zeros/actual-W-positive-primitive-analysis.md)
$$
 w_a=\rho_*\{L_0(a*a)-\tau\},\qquad
 w_b=\rho_*\{L_0(b*b)-\tau\},
$$
$$
 \rho_*=\sum_{d\ge1}d^{-1}\delta_{\log d},\quad
 L_0=I-k*,\quad k(v)=e^{-3v/2}1_{v\ge0},\quad
 b-a=f=P_\infty'.
\tag{7}
$$
Here $a(v)=e^{-v/2}[\psi(e^v)-e^v]1_{v\ge0}$, and $\tau$ is the unchanged full same-prime subtraction. These reflected source products are not Hermitian norm squares. All objects are causal, and every convolution is well defined on a finite age interval without assuming that $a$ belongs to global $L^2$.

The literal evolved readout uses the evolved same-prime term:
$$
 w_a^{[t]}=\rho_*\{L_0[(T_ta)*(T_ta)]-T_{2t}\tau\}
              =T_{2t}w_a,
$$
and likewise for $b$. Their exact difference is
$$
 \Delta w^{[t]}=T_{2t}(w_b-w_a)
 =\rho_*L_0\{(T_ta)*(T_tf)+(T_tf)*(T_ta)+(T_tf)*(T_tf)\}.
\tag{8}
$$
Both mixed orders and the complete quadratic correction remain. The same-prime term cancels only because precisely the same term occurs in both readouts.

Fix one causal window $0\le v\le V$, and choose any integer $N\ge e^V$. The frozen $a_N$ agrees with $a$ on this window. Since the process is causal, so do $T_ta_N$ and $T_ta$. Therefore every occurrence of $T_ta$ in (8), when evaluated on this window, can be replaced by the global $L^2$ function $T_ta_N$. The correction $f=P_\infty'$ already belongs to $L^2$ and obeys (3).

The convolution inequality $\|u*v\|_\infty\le\|u\|_2\|v\|_2$, $\|k\|_1=2/3$, and
$$
 \rho_*([0,V])=\sum_{d\le e^V}\frac1d\le1+V
$$
give the complete-window bound
$$
 \boxed{\sup_{0\le v\le V}|\Delta w^{[t]}(v)|
 \le C(1+V)\left[
 \frac{\|T_ta_N\|_2}{1+t}+\frac1{(1+t)^2}\right].}
\tag{9}
$$
One common process time $t$ is used throughout the window. No diagonal-only estimate is substituted for a finite-interval norm.

At logarithmic process time $t=cV$, (9) yields, for $V\ge1$,
$$
 \boxed{\sup_{0\le v\le V}|T_{2cV}(w_b-w_a)(v)|
       \le C_c\|T_{cV}a_N\|_2+C_c/V.}
\tag{10}
$$
This comparison error is controlled by one source norm, rather than its square. The estimate uses the actual positive-primitive domain and the actual density variation, with the same-prime term and all multiples retained in the defining readouts.

For context, the same finite-window argument gives only
$$
 \sup_{0\le v\le V}
 |\rho_*L_0[(T_ta)*(T_ta)](v)|
 \le C(1+V)\|T_ta_N\|_2^2.
\tag{11}
$$
Thus the hard full square in the source target remains precisely the term that bounds the complete reflected product. Neither (3) nor a sign for a single directed-relative pairing supplies a bound for that term. Equations (4) and (10) are rigorous transfer components for the proposed short-time targets; they do not prove the short-time source or W target, an unsigned cancellation of the inverse measure, or RH.

The [diagonal-time transform](../dynamics-and-feedback/diagonal-process-time-W-transform.md) is a separate consumer. Its time depends on the output age. The common-time convolution identities here hold with one time fixed across each entire source window.
