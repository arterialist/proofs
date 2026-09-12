# Growing-cutoff, growing-time cocycle in the actual source norm

This written proof retains the complete prime process and every signed arithmetic cell. Its exact birth and dissipation identities do not bound the terminal source norm. No result here is formalized in Lean. The bounded-generator dissipation identity is classical; the arithmetic consumers use the [actual birth Gram](original-l2-evolved-source-gram-work.md), [charge loading](actual-charge-arrival-loading.md), [process return expansion](long-time-signed-source-rank-one.md), and [successor transfer](short-time-source-and-W-successor-transfer.md).

Fix $c>0$, $t_n=c\log n$, including $t_1=0$. In original age $L^2$, unitarily equivalent to physical $L^2(dx)$, let

$$
T_t=\mu_t*,\qquad \widehat{T_tf}(\xi)=e^{-t\Phi(i\xi)}\widehat f(\xi),
\qquad A=\operatorname{Re}\Phi(iD),\qquad 0\le A\le2\lambda I.
$$

Here $\Phi$ is the complete process exponent, $\lambda$ its finite activity, and its Lévy density is denoted $F$. This $\Phi$ is not the theta kernel. The finite-source state $a_n=Ug_n$ retains its natural frozen tail. Put $h_b(x)=x^{-1}1_{x\ge b}$ and

$$
V_n=U\left[\Lambda(n)h_n-\int_{n-1}^n h_b\,db\right],\qquad n\ge2.
$$

Its exact physical formula is

$$
U^{-1}V_n(x)=
\begin{cases}
0,&x<n-1,\\
-(x-n+1)/x,&n-1\le x<n,\\
(\Lambda(n)-1)/x,&x\ge n.
\end{cases}
$$

Thus $a_n=a_{n-1}+V_n$, $a_1=-Uh_1$, and $J_n:=\|T_{t_n}a_n\|_2^2$ has seed $J_1=1$.

## Exact dissipation and both signed birth orders

For every $f\in L^2$, finite activity makes

$$
\Gamma(f)=\int_0^\infty F(w)\|\tau_wf-f\|_2^2dw
=2\langle f,Af\rangle\ge0,
\qquad \frac{d}{ds}\|T_sf\|_2^2=-\Gamma(T_sf).
\tag{1}
$$

Define

$$
D_n=\int_{t_{n-1}}^{t_n}\Gamma(T_sa_{n-1})ds
=\|T_{t_{n-1}}a_{n-1}\|_2^2-\|T_{t_n}a_{n-1}\|_2^2\ge0.
\tag{2}
$$

With $A_n^-=T_{t_n}a_{n-1}$ and $B_n=T_{t_n}V_n$, the exact identity is

$$
J_n-J_{n-1}=-D_n+\langle A_n^-,B_n\rangle
+\langle B_n,A_n^-\rangle+\|B_n\|_2^2.
\tag{3}
$$

For integers $2\le X<Y$, set $W_{[X,Y]}=\sum_{X<n\le Y}\operatorname{Re}\langle A_n^-,B_n\rangle$ and $L_{[X,Y]}=\sum_{X<n\le Y}\|B_n\|_2^2$. Then

$$
J_Y-J_X=-\sum_{X<n\le Y}D_n+2W_{[X,Y]}+L_{[X,Y]}.
\tag{4}
$$

The global sum starts at the literal seed one. Both mixed orders and the full quadratic innovation remain.

## The arithmetic product in the evolving Gram

Let

$$
\nu_m=-\delta_1+\sum_{2\le k\le m}\Lambda(k)\delta_k-1_{(1,m)}(b)db,
\qquad K_t(r)=\mathbb E e^{-|r+W_t-W_t'|/2},
$$

where $W_t,W_t'$ are independent complete process ages. The original-space Gram formula gives

$$
\begin{split}
\operatorname{Re}\langle A_n^-,B_n\rangle
=\int\nu_{n-1}(db)\bigg[&\frac{\Lambda(n)}{\sqrt{bn}}K_{t_n}(\log(b/n))\\
&-\int_{n-1}^n\frac{K_{t_n}(\log(b/d))}{\sqrt{bd}}\,dd\bigg].
\end{split}
\tag{5}
$$

The preceding seed, all admitted prime-power atoms and the entire new density cell remain. Although $K_t$ is a positive-definite Gram, the source measure and cell are signed. The common time in this pairing is exactly $t_n$.

## Complete diagonal loading

Put $k_t=K_t(0)$ and $m_n=\Lambda(n)/\sqrt n-2(\sqrt n-\sqrt{n-1})$. The proved cell estimate is

$$
\|B_n\|_2^2=k_{t_n}\big[m_n^2+e_n(t_n)\big],\qquad
|e_n(t)|\le\frac{2\log n}{n^2}+\frac1{2(n-1)^2}.
\tag{6}
$$

Uniformity in $t$ retains the signed ramp correction. The established inputs are

$$
\sum_{2\le n\le Z}m_n^2=\tfrac12\log^2Z-\log Z+C_m+R_m(Z),\qquad
R_m(Z)\to0,
\qquad k_t=\frac2{\pi^2t}+O\left(\frac{\log(2+t)}{t^2}\right).
$$

The remainder has the proved PNT rate. Partial summation gives $\sum_{X<n\le2X}m_n^2/\log n=\log2+O(1/\log X)$; the constant $C_m$ cancels and $R_m$ is bounded. Also $\sum_{X<n\le2X}m_n^2=O(\log X)$. Hence

$$
L_{[X,2X]}=\frac{2\log2}{\pi^2c}
+O_c\left(\frac{\log\log X}{\log X}\right),
\tag{7}
$$

and globally

$$
\sum_{2\le n\le N}\|B_n\|_2^2
=\frac{2\log N}{\pi^2c}+O_c\big((1+\log\log N)^2\big).
\tag{8}
$$

The errors in (6) cost $O_c(1/X)$ on a dyadic block. Proper powers, $\Lambda=0$ cells and finitely many small times are retained. No second-order global coefficient is claimed. In particular,

$$
2W_{[X,2X]}=J_{2X}-J_X+\sum_{X<n\le2X}D_n
-\frac{2\log2}{\pi^2c}
+O_c\left(\frac{\log\log X}{\log X}\right).
\tag{9}
$$

This is a signed identity, not an upper bound for $W$ or $J$.

## Summable clock-linearization errors from actual PNT

Let $u_n=T_{t_{n-1}}a_{n-1}$, $v_n=T_{t_{n-1}}V_n$, and $h_n=t_n-t_{n-1}$. Since $T_h^*T_h=e^{-2hA}$,

$$
J_n-J_{n-1}=2\operatorname{Re}\langle u_n,v_n\rangle+\|v_n\|_2^2
-2h_n\langle u_n,Au_n\rangle+R_n,
\tag{10}
$$

where exactly

$$
\begin{split}
R_n={}&\langle u_n,(e^{-2h_nA}-I+2h_nA)u_n\rangle\\
&+2\operatorname{Re}\langle u_n,(e^{-2h_nA}-I)v_n\rangle
+\langle v_n,(e^{-2h_nA}-I)v_n\rangle.
\end{split}
\tag{11}
$$

The first term is nonnegative, the last nonpositive, and the mixed remainder stays signed. Bounded functional calculus and contraction imply

$$
|R_n|\le C_\lambda\left[h_n^2Q_{n-1}(0)
+h_n\sqrt{Q_{n-1}(0)}\|V_n\|_2+h_n\|V_n\|_2^2\right],
\quad Q_m(0)=\|a_m\|_2^2.
\tag{12}
$$

The [actual PNT envelope](actual-short-time-psi-correlation.md), including the frozen terminal term, gives $Q_m(0)\le Cm e^{-b\sqrt{\log m}}$ for some $b>0$, after enlarging constants on the initial range. The complete cell satisfies

$$
\|V_n\|_2\le\frac{\Lambda(n)}{\sqrt n}+2(\sqrt n-\sqrt{n-1})
\le\frac{C\log(2n)}{\sqrt n},\qquad h_n=O_c(1/n).
$$

Substitution in (12), followed by $y=\sqrt{\log x}$ in the logarithmic tail integrals, proves

$$
\sum_{n\ge2}|R_n|<\infty,
\tag{13}
$$

and, decreasing $b$ if necessary,

$$
\sum_{n>N}|R_n|\le C_c\left[(1+\log^{3/2}N)e^{-b\sqrt{\log N}}
+\frac{\log^2(2N)}N\right].
\tag{14}
$$

Thus the full seeded identity is

$$
J_N=1+\sum_{n=2}^N\left[\langle u_n,v_n\rangle+\langle v_n,u_n\rangle
+\|v_n\|_2^2-2h_n\langle u_n,Au_n\rangle\right]+R_N^{\rm cum},
\tag{15}
$$

where $R_N^{\rm cum}=\sum_{2\le n\le N}R_n$ converges absolutely with (14). Replacing the diagonal time costs at most $Ch_n\|V_n\|_2^2$, another summable sequence, so (7)–(8) remain its leading loads. The previous-clock birth product minus dissipative action is still unbounded by this argument.

## Successor transfer of the whole birth budget

Use the literal compensated source $b_n=Ca_n$ and $f_n=b_n-a_n=P_n'$. The proved complete-process estimate is

$$
\|T_sf_n\|_2\le\frac C{1+s},\qquad n\ge2.
\tag{16}
$$

This follows from the actual primitive and complete density variation. It is not an estimate for an arbitrary unbounded prime operator.

Let $\mathcal H_{[X,2X]}=2W_{[X,2X]}+L_{[X,2X]}$, and define $\mathcal H^C$ by replacing $a_n$ with $b_n$ and $V_n$ with $b_n-b_{n-1}$. With $S_X=\max_{X\le j\le2X}\sqrt{J_j}$, (2)–(4) give exactly

$$
\mathcal H^C-\mathcal H
=(J^C_{2X}-J_{2X})-(J_X^C-J_X)+\sum_{X<n\le2X}(D_n^C-D_n).
\tag{17}
$$

At either endpoint, (16) bounds the square difference by $C_cS_X/\log X+C_c/\log^2X$. Inside each dissipation interval, $u=T_sa_{n-1}$ has $\|u\|\le S_X$ and $e=T_sf_{n-1}$ has $\|e\|\le C_c/\log X$. Since $\Gamma(u)=2\langle u,Au\rangle$,

$$
|\Gamma(u+e)-\Gamma(u)|\le C_\lambda(\|u\|\|e\|+\|e\|^2).
$$

The total interval length is $c\log2$. Therefore

$$
|\mathcal H^C_{[X,2X]}-\mathcal H_{[X,2X]}|
\le C_c\left[\frac{S_X}{\log X}+\frac1{\log^2X}\right].
\tag{18}
$$

This controls the whole signed block-budget difference without a factor equal to the number of arrivals. It retains both mixed orders and the dissipation cross term. It does not bound the budget itself.

## An actual sign obstruction

The first admission already refutes universally nonpositive birth work. Both $a_1$ and $V_2$ are strictly negative on positive ages: $V_2$ has its negative ramp and tail $(\log2-1)/x$. Positivity of the process and its nonzero no-jump atom imply

$$
\operatorname{Re}\langle T_{c\log2}a_1,T_{c\log2}V_2\rangle>0
\quad(c>0).
$$

At the previous time zero this pairing is exactly $\log2/2$. Even full dissipation does not force contraction of this first step. Direct integration gives

$$
Q_2(0)=1+\frac{(2-\log2)^2}{2}>1=J_1,
\qquad Q_2(t)\ge e^{-4\lambda t}Q_2(0).
$$

Thus $J_2>J_1$ for $0<c<\log Q_2(0)/(4\lambda\log2)$. This is an actual-source example. The open task is to control the full signed product (5), or its birth-minus-action sum (15), together with the terminal norm. The successor transfer (18) does not supply that bound.
