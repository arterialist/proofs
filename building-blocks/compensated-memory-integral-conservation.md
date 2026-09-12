# Exact integral conservation for the compensated successor memory

This written proof uses the [complete seed](collective-successor-seed-long-memory.md), [relative successor charge](actual-successor-resonance-charge-cocycle.md), and [bounded compensated-kernel theorem](charge-compensated-successor-memory.md). It does not estimate the anticausal response or the Weil sign. No theorem here is formalized in Lean.

To keep coordinates explicit, let $\mathcal E_c^{\rm phys}$ be the physical transport of the causal additive completion: for $f(u)=e^{u/2}H(e^u)$, set $\|f\|_{\mathcal E^{\rm phys}}=\|H\|_{\mathcal E}$. The output integrals below use physical age $u$ or $v$. The kernel theorem is a bounded map from this transported space into $L^1(dv)$.

Put
$$
 a_0(v)=e^{-v/2}1_{v\ge0},\qquad
 b(v)=\frac{2v}{(1+v)^2}1_{v\ge0},\qquad
 r=B-b,\quad R_0=\int r.
$$
Here $r\in L^1$, $b\in L^2$, $b(v)\to0$, and
$\|b'\|_1=1$, using causal zero extension.
Let $Kf=B*f$, let $S$ be the exact causal successor, and set
$$
 Cf=Sf-a_0\delta(f),\qquad q_0=Ka_0.
 \tag{1}
$$
The factor is fixed by $\int a_0=2$ and
$\delta(f)=\frac12(\int Sf-\int f)$ when these integrals exist.

## Finite-source theorem

For every causal $f$ with
$$
 \int_0^\infty(1+u)|f(u)|\,du<\infty,
 \tag{2}
$$
the exact compensated memory difference
$$
 [C,K]f=[S,K]f-a_0\delta(Kf)+q_0\delta(f)
 \tag{3}
$$
belongs to $L^1$ and has integral zero. No bounded-variation
assumption is needed for this undifferentiated statement.

The relative functional on $Kf$ uses its actual kernel
$$
 \delta(h)=\frac12\int_0^\infty k(v)h(v)\,dv,\qquad
 k(v)=
 \begin{cases}
 -1,&0\le v<\log2,\\
 (1-e^{-v})^{-1/2}-1,&v\ge\log2.
 \end{cases}
 \tag{4}
$$
The kernel is bounded and decays exponentially after its initial
interval. Hence this pairing exists for $Kf=m_fb+\rho_f$ below,
although $Kf$ generally is not integrable.

### Translation and successor boundary identities

For $u\ge0$, $R_ub-b\in L^1$, with norm at most $u$.
For $R>u$,
$$
 \int_0^R(R_ub-b)=-\int_{R-u}^R b\longrightarrow0.
$$
Consequently
$$
 \int(R_ub-b)=0.
 \tag{5}
$$
For $\sigma(t)=\log(e^t+1)$, the exact change of variables gives
$$
 \int_0^R Sb
 =\int_{\log2}^{\sigma(R)}(1-e^{-u})^{-1/2}b(u)\,du.
$$
Subtract $\int_0^R b$. The upper interval between $R$ and
$\sigma(R)$ contributes a quantity tending to zero.
The remaining integrand in (4) is absolutely integrable.
Since also $Sb-b\in L^1$, this proves
$$
 \int(Sb-b)=2\delta(b).
 \tag{6}
$$
The initial interval is retained and the upper boundary limit is
proved; no two divergent integrals have been subtracted formally.

### Integrals of the exact remainders

Write $m_f=\int f$. The exact remainder is
$$
 \rho_f=r*f+\int_0^\infty f(u)(R_ub-b)\,du,\qquad
 Kf=m_fb+\rho_f.
 \tag{7}
$$
The Bochner integral converges absolutely in $L^1$ by (2).
Equation (5) and Fubini imply
$$
 \int\rho_f=m_fR_0.
 \tag{8}
$$
Successor preserves (2), since $\sigma^{-1}(u)\le u$ and its
change-of-variable weight is at most $\sqrt2$ on $u\ge\log2$.
Thus the same formulas apply to $Sf$. They also apply to $a_0$:
$$
 q_0=2b+\rho_{a_0},\qquad \int\rho_{a_0}=2R_0.
 \tag{9}
$$
The scalar in (3) obeys
$\delta(Kf)=m_f\delta(b)+\delta(\rho_f)$.

Substitute (7)--(9) into (3), using
$m_{Sf}=m_f+2\delta(f)$. The nonintegrable multiple of $b$
cancels exactly:
$$
 [C,K]f=m_f(Sb-b)+S\rho_f-\rho_{Sf}
       +\delta(f)\rho_{a_0}-a_0\delta(Kf).
 \tag{10}
$$
Every term on the right is in $L^1$. Its integral is
$$
 \begin{aligned}
 &2m_f\delta(b)+m_fR_0+2\delta(\rho_f)
   -m_{Sf}R_0+2\delta(f)R_0\\
 &\hspace{25mm}-2m_f\delta(b)-2\delta(\rho_f)=0,
 \end{aligned}
 \tag{11}
$$
by (6), (8), and $\int S\rho_f=\int\rho_f+2\delta(\rho_f)$.
This proves the theorem.

For every finite prime cutoff $P$, one also has
$$
 \int[C,K_P]f=0.
 \tag{12}
$$
Both finite-prime convolutions are integrable, $C$ preserves the
integral, and $K_P$ multiplies it by $2H_P$, where $H_P=\sum_{p\le P}1/p$ and the sum is over primes.

## The bounded extension and the complete actual source

The exact kernel theorem establishes a bounded extension
$$
 \mathcal T=[C,K]:\mathcal E_c^{\rm phys}\longrightarrow L^1,
 \tag{13}
$$
(11), density of compact causal inputs, and continuity of
integration on $L^1$ imply
$$
 \int\mathcal T f=0\quad(f\in\mathcal E_c^{\rm phys}).
 \tag{14}
$$
The separate absolute charge $Q(f)$ need not exist.
After local identification of kernels, the exact actual source
with [relative charge](actual-successor-resonance-charge-cocycle.md) $\kappa>0$ therefore satisfies
$$
 [S,K]a=\mathcal Ta+a_0\delta(Ka)-\kappa q_0.
 \tag{15}
$$
The complete nonintegrable part of the response remains in the explicit port
$-\kappa q_0$.
