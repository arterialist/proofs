# Integer interpolation of the actual factorial potential

The second integer-aligned interpolation has a definite signed outcome. For the actual factorial potential $F$, the exact feedback budget is
$$
2rE(r)=N_r+H_r,
$$
where $N_r$ is an explicit nodal arithmetic pairing and $H_r$ is the cell interpolation correction. Although $F$ is convex on every sufficiently late cell,
$$
\boxed{H_r\longrightarrow H_\infty< -\frac1{4000}
\quad(r\uparrow1).}
\tag{1}
$$
Thus the proposed lower comparison $2rE(r)\ge N_r$ fails for the complete actual source near the resolvent boundary. This conclusion retains all prime powers and the initial cells. It neither signs $E(r)$ nor excludes other uses of integer-aligned interpolation.

## 1. Actual source and complete cell identity

Use the notation and exact budget of [the factorial feedback source](../successor-and-division/successor-feedback-arithmetic-kernel.md):
$$
F(y)=\log y-\sum_{m\le y}\frac{\Lambda(m)}m+\frac{\psi(y)}y
=-\int_1^y\left(\frac{\psi(t)}t-1\right)\frac{dt}{t}.
\tag{2}
$$
This $F$ is the factorial potential, not the critical age primitive used in the RH converse. It is continuous, $F(1)=0$, and positive for $y>1$. On the complete cell $[n,n+1]$,
$$
F(y)=F(n)+\log(y/n)+\psi(n)(1/y-1/n),
\tag{3}
$$
including the right endpoint by continuity. All new prime-power contributions at that endpoint cancel in (2). In particular
$$
d_n:=F(n+1)-F(n)
=\log(1+1/n)-\frac{\psi(n)}{n(n+1)},
\quad F''(y)=\frac{2\psi(n)-y}{y^3}\quad(n<y<n+1).
\tag{4}
$$
The derivative has its literal jump $-\Lambda(n)/n^2$ at each integer $n\ge2$. No global convexity is asserted. PNT does imply convexity on all sufficiently late cells, since $\psi(n)/n\to1$.

Let $IF$ be the continuous linear interpolant of the integer values of $F$, and set $\varepsilon(y)=IF(y)-F(y)$. With $s=y-n\in[0,1]$, its exact cell formula is
$$
\boxed{\varepsilon(n+s)=
s\log(1+1/n)-\log(1+s/n)
+\psi(n)\frac{s(1-s)}{n(n+1)(n+s)}.}
\tag{5}
$$
The first term pair is nonpositive, and the last term is nonnegative. This keeps the actual density and arithmetic contribution separate before any estimate. It also shows directly that the interpolation error vanishes at every integer.

For later bounds use the ordinary Dirichlet Green kernel on the unit interval,
$$
G(s,t)=\min(s,t)[1-\max(s,t)].
$$
Cellwise integration gives
$$
\varepsilon(n+s)=\int_0^1G(s,t)F''(n+t)dt,
\quad \int_0^1G(s,t)dt=\frac{s(1-s)}2.
\tag{6}
$$
All derivatives in (6) are taken within one cell. The integer derivative jumps are retained separately in the nodal data; they are not treated as positive curvature measures.

## 2. Exact jump cancellation and the nodal pairing

Put $k_r(y)=yw_r(y)$ and $V_r(y)=-k_r'(y)>0$ on open cells. Its literal jumps and initial value are
$$
[k_r]_n=n(1-r)r^{n-1}\quad(n\ge2),\qquad k_r(1)=-r.
$$
The exact budget is
$$
2rE(r)=\sum_{n\ge2}[k_r]_nF(n)-\int_1^\infty V_r(y)F(y)dy.
\tag{7}
$$
Define
$$
K_n(r)=\int_n^{n+1}k_r(y)dy,
\qquad H_r=\int_1^\infty V_r(y)\varepsilon(y)dy.
\tag{8}
$$
Replace $F$ by $IF-\varepsilon$ in (7). Integration by parts against the full measure $dk_r$, including its integer jumps, gives exactly
$$
\boxed{\begin{aligned}
2rE(r)&=N_r+H_r,\\
N_r&=-\sum_{n\ge1}K_n(r)d_n
=\sum_{n\ge2}[K_n(r)-K_{n-1}(r)]F(n).
\end{aligned}}
\tag{9}
$$
The initial boundary is zero because $IF(1)=0$. At infinity
$k_r(y)=O_r(y^{-1/2})$ and $IF(y)=O(\log(2y))$, so the boundary
vanishes. The bound on $K_n$ and (4) give absolute convergence of
the first series in (9). For the second series, the exact history
densities in (16) imply $V_r(y)=O_r(n^{-3/2})$ uniformly inside
the cells meeting $[n-1,n+1]$, for $n\ge3$. Indeed histories
$j\le n/3$ contribute $v_j(y)\le Cj n^{-3/2}$ by their explicit
formula with $j/y\le1/2$; the remaining geometric tail is
$O_r(nr^{n/3})$, which is smaller than any fixed negative power
of $n$. The jumps in that interval are also exponentially small.
Thus the total variation of $k_r$ on $[n-1,n+1]$ is
$O_r(n^{-3/2})$, and $|K_n-K_{n-1}|$ has the same bound.
Together with $F(n)=O(\log(2n))$, this proves absolute convergence
of the second series. These estimates use the exact histories,
not derivatives of an asymptotic equivalence. The nodal residual
coefficients are exactly $K_n-K_{n-1}$, with no extra birth or
initial term.

For clarity the full kernel is elementary. On $(n,n+1)$, only histories $0\le j\le n-1$ have arrived. Hence
$$
\begin{aligned}
K_n(r)={}&(1-r)\sum_{j=0}^{n-1}r^j
\left\{\frac23[(n+1-j)^{3/2}-(n-j)^{3/2}]\right.\\
&\hspace{41mm}\left.+2j[\sqrt{n+1-j}-\sqrt{n-j}]\right\}\\
&-\frac23[(n+1)^{3/2}-n^{3/2}].
\end{aligned}
\tag{10}
$$
The history born at $n+1$ has no mass in this open cell. In particular $K_1=-\frac{2r}{3}(2\sqrt2-1)$.

The actual arithmetic pairing in (9), before absolute values, is
$$
\boxed{N_r=\sum_{n\ge1}\frac{K_n(r)}{n(n+1)}
\left[\psi(n)-n(n+1)\log(1+1/n)\right].}
\tag{11}
$$
Equivalently,
$$
N_r=\sum_{m\ge2}\Lambda(m)
\sum_{n\ge m}\frac{K_n(r)}{n(n+1)}
-\sum_{n\ge1}K_n(r)\log(1+1/n).
\tag{12}
$$
Both interchanges converge absolutely for fixed $r$, using $|K_n|=O_r(n^{-1/2})$ and $\psi(n)\ll n$. Every proper power and the density term remain in (11)–(12).

## 3. Elementary uniform bounds and the boundary limit of the correction

We use the elementary global bound
$$
\psi(n)\le2n\log2\qquad(n\ge1).
\tag{13}
$$
Here is a proof fixing its constants. For $N=2m$, every prime power in $(m,2m]$ contributes its $\log p$ to the valuation sum of $\binom{2m}{m}$, and all other floor differences are nonnegative. Thus
$\psi(2m)-\psi(m)\le\log\binom{2m}{m}\le2m\log2$.
For $N=2m+1$, the corresponding interval is $(m+1,2m+1]$, giving
$\psi(2m+1)-\psi(m+1)\le\log\binom{2m+1}{m}\le2m\log2$.
The last inequality follows because the two equal central coefficients sum to at most $2^{2m+1}$. Strong induction from $\psi(1)=0$ proves (13). All powers are included in the binomial valuations.

Equations (4), (6), and (13) imply
$$
|\varepsilon(y)|\le\frac{C}{(1+y)^2}\quad(y\ge1)
\tag{14}
$$
with an absolute constant. Therefore
$$
H_\infty:=\frac12\int_1^\infty\frac{\varepsilon(y)}{\sqrt y}dy
\tag{15}
$$
is absolutely convergent.

The fixed-history density from the exact source note is
$$
v_j(y)=\begin{cases}
1/(2\sqrt y),&1<y<j+1,\\
1/(2\sqrt y)-(y-2j)/(2(y-j)^{3/2}),&y>j+1.
\end{cases}
$$
It is positive, has total integral $j$, and
$$
V_r=(1-r)\sum_{j\ge1}r^jv_j.
\tag{16}
$$
Let $h_j=\int v_j\varepsilon$. Below $j+1$ its density is exactly that in (15). Above $j+1$, (14) and $\int v_j=j$ give an absolute bound $C/j$; the corresponding omitted tail of (15) is $O(j^{-3/2})$. Consequently
$$
h_j=H_\infty+O(1/j).
$$
Absolute Fubini in (16) follows from the same bounds. Averaging the last identity gives the quantitative limit
$$
\boxed{H_r=H_\infty+
O\left((1-r)\log\frac2{1-r}\right).}
\tag{17}
$$
This controls the moving history range as well as every fixed initial cell. Pointwise convergence of $V_r$ alone would not justify (17).

## 4. An analytic negative certificate for the complete actual correction

Write $H_\infty=\sum_{n\ge1}H_n$, where
$H_n=\frac12\int_n^{n+1}\varepsilon(y)y^{-1/2}dy$.
Only the first four actual cells need separate treatment; the rest are bounded as one complete tail.

On $[1,2]$, $F(y)=\log y$ and $F''(y)\le-1/4$. Equation (6) and $y^{-1/2}\ge2^{-1/2}$ imply
$$
H_1\le-\frac1{96\sqrt2}.
\tag{18}
$$
On $[2,3]$, $\psi(2)=\log2$ and $2\psi(2)<2$, so $F''<0$ and $H_2\le0$.

On $[3,4]$ use $\psi(3)=\log6$, and on $[4,5]$ use $\psi(4)=\log12$. The latter includes the proper power $4$. From (6), if $F''\le M$ on a cell and $M\ge0$, then $H_n\le M/(24\sqrt n)$. Therefore
$$
H_3\le\frac{2\log6-3}{648\sqrt3},\qquad
H_4\le\frac{2\log12-4}{3072}.
\tag{19}
$$
For all $n\ge5$, (13) gives
$$
F''(y)\le\frac{4\log2-1}{n^2}\quad(n<y<n+1).
$$
It follows that
$$
\sum_{n\ge5}H_n\le\frac{4\log2-1}{24}
\sum_{n\ge5}n^{-5/2}
\le\frac{4\log2-1}{288}.
\tag{20}
$$
The last inequality integrates the decreasing function $t^{-5/2}$ over $[4,\infty)$.

Adding (18)–(20) proves
$$
\boxed{H_\infty\le
-\frac1{96\sqrt2}
+\frac{2\log6-3}{648\sqrt3}
+\frac{2\log12-4}{3072}
+\frac{4\log2-1}{288}
<-\frac1{4000}.}
\tag{21}
$$
The final strict inequality follows already from the coarse elementary bounds
$\sqrt2<1.415$, $\sqrt3>1.732$, $\log2<.694$, $\log6<1.792$, and $\log12<2.485$. The first two follow by squaring; the logarithmic bounds follow from the exponential series. No numerical integration or finite prime census is needed for this certificate.

Combining (17) and (21), there is an $r_1<1$ such that
$$
\boxed{2rE(r)=N_r+H_r<N_r-\frac1{8000}
\qquad(r_1<r<1).}
\tag{22}
$$
This is a failure of the specific actual comparison that would discard the complete interpolation correction as nonnegative. It does not contradict eventual convexity on the later cells: their complete positive budget was retained in (20), and the initial concave cells outweigh it.

## 5. What remains in the coherent nodal term

The remaining term is the explicit arithmetic pairing (11). For each fixed $n$,
$$
K_n(r)\longrightarrow-\int_n^{n+1}\sqrt y\,dy<0
\quad(r\uparrow1),
$$
whereas for each fixed $r<1$,
$$
K_n(r)\sim\frac{r}{2(1-r)}n^{-1/2}>0
\quad(n\to\infty).
$$
The latter follows by expanding each retained history at large $n$ and bounding the geometric tail before expanding. Thus neither $K_n$ nor its interaction with the actual bracket in (11) has a fixed favorable sign. In particular the bracket is the exact centered cell slope, not a freely chosen test sequence.

For parameters near one, a sign proof through this decomposition must establish
$N_r\ge-H_r$, with the actual positive threshold $-H_r$ tending to $-H_\infty>1/4000$. The present argument supplies that precise signed correction and proves the proposed simpler comparison false. It does not establish the remaining collective nodal inequality, replace it by absolute values, or infer an RH sign from factorial positivity or eventual cell convexity.

## Relation to the other interpolation and formal scope

The [integer-birth interpolation](../successor-and-division/actual-integer-birth-positive-quadrature.md) has a positive vanishing defect, with its [exact cusp asymptotic](../successor-and-division/successor-quadrature-cusp-asymptotic.md). The interpolation above acts on the factorial potential instead and has a negative nonvanishing correction. Both retain their initial cells and complete arithmetic tails. The unit-interval Green representation and binomial Chebyshev argument are classical; the complete source-specific pairing and comparison failure above are written proofs, not Lean theorems.

The same actual potential has a [closed original-$L^2$ ground-state realization](factorial-ground-state-original-l2-domain.md). Its positive pulled-back form retains the complete prime and density observations; this domain result does not change the signed interpolation correction proved here.
