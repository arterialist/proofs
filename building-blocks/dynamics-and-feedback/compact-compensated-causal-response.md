# Compact compensated causal memory and its derivative response

The actual compensated memory commutator
$$
 T=[C,K]:\mathcal E_c\longrightarrow L^1(0,\infty)
$$
is compact. Its differentiated counterpart is compact into the causal full-line negative space defined below:
$$
 [C,A]:\mathcal E_c\longrightarrow W^{-1,1}_+(\mathbb R).
$$
The proof uses the exact full-prime kernel and retains the causal boundary atom. It asserts no compactness in the theta metric and no sign or anticausal conclusion.

The arithmetic inputs are proved in the [complete memory kernel](../successor-and-division/charge-compensated-successor-memory.md) and the [original derivative response](../factorial-and-renewal/charge-compensated-clock-response.md). We consume those identities, including every prime power and the initial interval.

## 1. Spaces and the complete kernel

For an additive causal source $g\in\mathcal E_c$, write
$$
 f(u)=e^{u/2}g(e^u),\qquad u\ge0.
$$
The anchored coercivity bound is
$$
 \|f\|_X:=\left(\int_0^\infty e^{-u}|f(u)|^2\,du\right)^{1/2}
 \le\|g\|_{\mathcal E}.
 \tag{1}
$$
We write operators on their physical representatives $f$, with the domain norm on $g$. All physical functions are extended by zero to the negative line.

The exact kernel of $T$, denoted $t(v,u)$, is jointly measurable and satisfies
$$
 \|t(\cdot,u)\|_{L^1_v}\le C e^{-u}\log(2+u).
 \tag{2}
$$
This includes both the initial region $0\le u<\log2$ and the charge correction. In particular,
$$
 \int_0^\infty e^u\|t(\cdot,u)\|_1^2\,du<\infty.
 \tag{3}
$$
Set $F(u)=e^{u/2}t(\cdot,u)$, as an $L^1_v$-valued function. Joint measurability and the separability of $L^1_v$ make $F$ strongly measurable. One can first restrict both variables to bounded intervals and then approximate the measurable kernel by simple functions. Equations (2)–(3) give
$$
 F\in L^2\bigl((0,\infty)_u;L^1((0,\infty)_v)\bigr).
 \tag{4}
$$

## 2. Compactness of the memory response

Let $Jg(u)=e^{-u/2}f(u)$. By (1), $J:\mathcal E_c\to L^2(du)$ has norm at most one, and
$$
 Tg=\int_0^\infty F(u)Jg(u)\,du
 \quad\hbox{in }L^1_v.
 \tag{5}
$$
Choose finite simple functions
$$
 F_n(u)=\sum_{j=1}^{m_n}\mathbf1_{E_{n,j}}(u)b_{n,j},
 \qquad |E_{n,j}|<\infty,\quad b_{n,j}\in L^1_v,
$$
converging to $F$ in the Bochner space (4). Define
$$
 T_ng=\sum_{j=1}^{m_n}b_{n,j}\int_{E_{n,j}}Jg(u)\,du.
$$
Each coefficient is a bounded functional by Cauchy–Schwarz, so $T_n$ has finite rank. The Bochner integral inequality gives
$$
 \|T-T_n\|_{\mathcal E_c\to L^1}
 \le\|F-F_n\|_{L^2_u(L^1_v)}\longrightarrow0.
 \tag{6}
$$
Thus $T$ is compact. This is a Banach-valued kernel argument; it does not describe $T:\mathcal E_c\to L^1$ as a Hilbert–Schmidt operator.

The established conservation law $\int Tg=0$ continues to hold. Compactness adds norm precompactness of images of bounded source sets, without changing that exact law.

## 3. A negative norm that retains the endpoint

Let $L^1_+$ mean causal $L^1$ functions extended by zero to $\mathbb R$. Define
$$
 W^{-1,1}_+
 =\{f_0+\partial_v f_1:f_0,f_1\in L^1_+\},
\qquad
 \|F\|_{-1,1,+}
 =\inf_{F=f_0+\partial_vf_1}
       \bigl(\|f_0\|_1+\|f_1\|_1\bigr).
 \tag{7}
$$
Equality is equality of distributions on the full real line. The kernel of the distribution map from $L^1_+\oplus_1L^1_+$ is closed, since convergence in both $L^1$ coordinates implies convergence against every smooth compactly supported test and its derivative. Consequently (7) is a Banach quotient norm.

Tests need not vanish at zero. For $a_0(v)=e^{-v/2}\mathbf1_{v\ge0}$,
$$
 \delta_0=a_0/2+\partial_v a_0\in W^{-1,1}_+.
 \tag{8}
$$
Thus this norm does not discard the initial atom. The two bounded maps needed below are
$$
 \|h\|_{-1,1,+}\le\|h\|_1,\qquad
 \|Hh\|_{-1,1,+}\le\tfrac32\|h\|_1,
 \quad H=\tfrac12-\partial_v.
 \tag{9}
$$

## 4. Compactness of the weighted successor term

Retain the actual definitions
$$
 (Sf)(v)=j(v)f(\sigma(v)),\quad
 j(v)=\sqrt{\frac{e^v}{1+e^v}},\quad
 \sigma(v)=\log(1+e^v),\quad d(v)=\frac1{1+e^v}.
$$
The exact change of variables gives $\|S\|_{X\to X}\le\sqrt2$. The full derivative convolution $A=HK$ has weighted total variation
$$
 M_{1/2}=2\sum_p p^{-2}<\infty,
 \qquad \|Af\|_X\le M_{1/2}\|f\|_X.
 \tag{10}
$$
Both first prime births and later powers enter this constant.

Put $z=SAf$. Then
$$
 \|z\|_X\le\sqrt2\,M_{1/2}\|g\|_{\mathcal E}.
$$
The multiplier $d$ supplies the following two quantitative bounds:
$$
 \|dz\|_2\le\tfrac12\|z\|_X,
\qquad
 \|\mathbf1_{(R,\infty)}dz\|_1
 \le (1+e^R)^{-1/2}\|z\|_X.
 \tag{11}
$$
Indeed $d(v)^2e^v\le1/4$, and
$$
 \int_R^\infty d(v)^2e^v\,dv=\frac1{1+e^R}.
$$
The second bound follows by weighted Cauchy–Schwarz.

For completeness, fix $R>0$, partition $[0,R]$ into finitely many intervals of length at most $h$, and let $P_hF$ be the cell averages of $F\in L^2(0,R)$, extended by zero. Set $e=F-P_hF$. Its integral on every cell is zero. The causal function
$$
 E(v)=\int_0^v e(w)\,dw\quad(0\le v\le R),\qquad
 E(v)=0\quad(v\notin[0,R])
$$
vanishes at every cell endpoint, including zero and $R$. Hence $\partial_vE=e$ as full-line distributions, with no endpoint atoms. Moreover,
$$
 \|F-P_hF\|_{-1,1,+}
 \le\|E\|_1
 \le h\|e\|_1
 \le2h\sqrt R\,\|F\|_2.
 \tag{12}
$$
This proves compactness of $L^2(0,R)\to W^{-1,1}_+$ by explicit finite-rank approximation.

Apply (12) to $F=\mathbf1_{[0,R]}dSAf$. Together with (11), it gives finite-rank operators approximating $dSA$ with operator-norm error at most
$$
 \sqrt2\,M_{1/2}
 \left(h\sqrt R+(1+e^R)^{-1/2}\right).
 \tag{13}
$$
First choose $R$ large, then $h$ small. Therefore
$$
 dSA:\mathcal E_c\longrightarrow W^{-1,1}_+
 \quad\hbox{is compact}.
 \tag{14}
$$
These estimates do not establish $L^1$ compactness. For example the functions $\mathbf1_{[0,1]}e^{2\pi i n v}$ satisfy the same type of local $L^2$ bound and have no $L^1$-convergent subsequence, although their negative norms tend to zero.

## 5. The exact differentiated response

The proved causal response identity is
$$
 [C,A]f
 =H(Tf)+dSAf+(a_0-\delta_0)k_f-a_0a_f,
 \qquad k_f=\delta(Kf),\quad a_f=\delta(Af).
 \tag{15}
$$
Here the charge functional $\delta$ is distinct from the Dirac distribution $\delta_0$. Both $k_f$ and $a_f$ are bounded scalar functionals on $\mathcal E_c$. The identity retains $Ha_0=a_0-\delta_0$. The separate first-arrival term vanishes because $Kf\in H^1_{\mathrm{loc}}$, is supported in $[\log2,\infty)$, and has trace $Kf(\log2+)=0$.

Equation (15) also supplies an explicit representation in the convention (7):
$$
 [C,A]f=f_0+\partial_v f_1,
$$
$$
 f_0=\tfrac12Tf+dSAf+\tfrac12a_0k_f-a_0a_f,
\qquad f_1=-Tf-a_0k_f.
 \tag{16}
$$
The map $HT$ is compact by (6) and (9). The map $dSA$ is compact by (14). The remaining two terms in (15) have finite rank in $W^{-1,1}_+$. Their sum proves
$$
 \boxed{[C,A]:\mathcal E_c\longrightarrow W^{-1,1}_+
 \text{ is compact}.}
 \tag{17}
$$

This is compactness of the actual causal commutator with all prime powers retained. It does not differentiate an $L^1$ estimate into another $L^1$ estimate. In particular the boundary distribution in (15) remains part of the exact formula. The result supplies a compact defect in the stated physical negative norm; a transport theorem in a different metric would require an additional argument.

The finite-rank approximation uses density of simple functions in Bochner $L^2$ and the standard Banach quotient construction. The actual-kernel input is the displayed column bound; neither a Hilbert–Schmidt interpretation of $L^1$ nor a compactness claim in the theta metric is used. This is a written analytic theorem with no Lean formalization.
