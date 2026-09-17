# A strict original-energy decrease for the actual full-prime source at two

For the actual natural source at $N=2$, with **every response prime and every proper power**, the original physical energy satisfies
$$
\boxed{\mathcal E(Y_\infty^a)-\mathcal E(Y_\infty^b)>\frac1{200}.}
\tag{1}
$$
This is a written proof with a verified interval-arithmetic certificate; it is not Lean formalized. The accompanying [Arb checker](../../certificates/full_prime_two_energy.py) proves a lower bound
$0.0064397329293\ldots$ by Arb interval arithmetic. Only primes through $40000$ are enumerated; explicit prime-distribution estimates enclose the entire omitted-prime sum. No extrapolation from the finite-prime Loewner theorem is used.

This is a theorem for this fixed actual source and the original energy. It does not prove the analogous comparison for all source cutoffs or the sign of the full W readout.

## 1. Actual inputs, metric, and retained kernel margin

Write
$$
L=\log2,\quad A=2-L,\quad
\kappa=2\sqrt2-1-\frac L{\sqrt2}-\frac{\pi A}{4}.
$$
Use the literal physical functions
$$
g=-\mathbf1_{[1,2)}-\frac A x\mathbf1_{[2,\infty)},\qquad
h=\mathbf1_{[1,\infty)}
\left(-\frac A{1+x}-\frac\kappa x\right),
$$
extended by zero to negative $x$. Their full anticausal outputs are
$$
O=Y_\infty^a=\sum_p\left[\frac1p g(p\,\cdot)
-\frac{p-1}{p}\sum_{j\ge2}g(p^j\,\cdot)\right],
$$
$$
N=Y_\infty^b=\sum_p\left[\frac1p h(p\,\cdot)
-\frac{p-1}{p}\sum_{j\ge2}h(p^j\,\cdot)\right].
\tag{2}
$$
The complete per-prime formulas are proved in Appendix A below,
and their full-prime measure representation is given in
[the coherent tail proof](full-prime-two-relative-energy-tail.md).
In particular $O$ is supported in $[0,1]$, $N\ge0$, and both
outputs are in physical $L^1\cap L^2$. The representation (8)--(10)
also verifies the original $L^2$ cutoff limit directly: $0\le B_P\le B$,
$B\in L^2(0,\infty)$, and the source measures have finite total
variation. Their shifted convolution majorants are in $L^2$ by
Young's inequality, so dominated convergence applies on negative ages.
On physical $x>1$, the positive bound in Section 7 gives an integrable
square majorant. No source-dependent change of metric is used.

Put $I=\int_0^\infty(O^2-N^2)$, $m=\int O$, and $c=\int_0^1N$.
The original metric is
$$
\mathcal E(F)=4\|F\|_2^2-\iint K(x-y)F(x)F(y)\,dx\,dy,
\qquad K(v)=\min(1,|v|^{-2}).
$$
Consequently
$$
\mathcal E(O)-\mathcal E(N)
=4I-m^2+\iint K(x-y)N(x)N(y)\,dx\,dy
\ge4I+c^2-m^2.
\tag{3}
$$
The lower bound retains the complete unit-square contribution of the actual new $K$-form. Its remaining contribution is nonnegative because this full output is positive.

For every prime, the exact old mass and new unit-core mass are
$$
m_p=\frac{A\log p}{p(p-1)},\qquad
c_p=\frac A p\sum_{j\ge1}p^{-j}
\log\frac{1+p^{j+1}}{1+p^j}
+\frac{\kappa\log p}{p(p-1)}.
\tag{4}
$$
The series is positive, with error at most
$A\log p\,p^{-J}/[p(p-1)]$ after $J$ terms. Also
$$
c_p-m_p\ge
\frac{\kappa\log p}{p(p-1)}-\frac A{p^2(p+1)}>0
\qquad(p\ge3).
\tag{5}
$$
Indeed $\kappa>.31$, $A<1.31$, $\log p>1$, and
$p(p+1)/(p-1)\ge6$. The last bound in (5) follows by retaining the full series and using
$$
\log\frac{1+p^{-j}}{1+p^{-j-1}}\le p^{-j}-p^{-j-1}.
$$
For $p=2$, direct lower summation in (4) proves $c_2>m_2$.
Thus all primes after $7$ increase both $c-m$ and $c+m$. Summing only the first 24 positive terms in (4) for $p=2,3,5,7$ yields
$$
\boxed{c^2-m^2>0.1446222051482930726.}
\tag{6}
$$
This step controls the full retained cross-prime kernel contribution; it does not assert an energy inequality prime by prime.

## 2. Exact source measures reduce the finite calculation to the actual kernel

Let $U F(v)=e^{v/2}F(e^v)$, $a=Ug$, $b=Uh$, and $f=b-a=P'$.
The kernel of the full prime memory is
$$
B(t)=\sum_p e^{t/2}p^{-\lfloor t/\log p\rfloor-1}
\mathbf1_{t\ge\log p}.
\tag{7}
$$
The complete source innovation measures are
$$
\nu_a=(D+\tfrac12)a
=-\delta_0+\frac L{\sqrt2}\delta_L
-e^{v/2}\mathbf1_{(0,L)}\,dv,
$$
$$
\nu_b=(D+\tfrac12)b
=-(A/2+\kappa)\delta_0
-A\frac{e^{v/2}}{(1+e^v)^2}\mathbf1_{v>0}\,dv.
\tag{8}
$$
Both the initial boundary and the old arrival at two are present. The new density has its entire exponential tail. For negative age, write
$y(-q)=UO(-q)$, $n(-q)=UN(-q)$, $q\ge0$.
Convolution with these measures gives, almost everywhere,
$$
y(-q)=B(q)-\frac L{\sqrt2}B(q+L)
+\int_0^L e^{v/2}B(q+v)\,dv,
\tag{9}
$$
$$
n(-q)=(A/2+\kappa)B(q)
+A\int_0^\infty\frac{e^{v/2}}{(1+e^v)^2}B(q+v)\,dv.
\tag{10}
$$
These formulas sum all primes before taking any quadratic expression. The prime-power collision ages form a null set; no source atom is omitted from (8).

## 3. Explicit primary input for every omitted prime

We use two unconditional bounds from [Dusart, *Estimates of some functions over primes without R.H.*, Proposition 5.1 and Theorem 5.2](https://arxiv.org/pdf/1002.0442):
$$
\theta(x)\le Ux,\quad U=1+\frac1{36260}\quad(x>0),
\qquad
|\theta(x)-x|\le\frac{10x}{(\log x)^3}\quad(x>32321).
\tag{11}
$$
They require no assumption that all zeta zeros satisfy RH. The second estimate is the $k=3,\eta_k=10$ entry of Theorem 5.2. Its moderate threshold is useful here. Trudgian's Theorem 1 supplies a different explicit bound but is not needed for the final certificate.

For $j\ge1$ and $x>32321$, Stieltjes integration by parts, with the boundary at $x$ retained, gives
$$
\left|
\sum_{p>x}p^{-j-1}
-\int_x^\infty\frac{du}{u^{j+1}\log u}
\right|
\le E_j(x):=\frac{10(2+1/j)}{x^j(\log x)^4}.
\tag{12}
$$
To check the constant, put $w(u)=u^{-j-1}/\log u$ and use
$$
u[-w'(u)]
=-\frac d{du}\frac{u^{-j}}{\log u}
+\frac{u^{-j-1}}{\log u}.
$$
Bound the decreasing relative theta error by $10/(\log x)^3$, and bound the last integral by $x^{-j}/(j\log x)$. For a finite interval $(x,z]$, the error is at most $E_j(x)+E_j(z)$, by subtracting the two tail identities. This preserves both endpoints.

Take $P_*=40000$. On each exact power sector,
$$
B(t)=e^{t/2}\sum_{j\ge1}
\sum_{e^{t/(j+1)}<p\le e^{t/j}}p^{-j-1}.
\tag{13}
$$
The terms with $p\le P_*$ are summed exactly. For the remaining terms set
$$
\alpha_j=\max(\log P_*,t/(j+1)),\qquad \beta_j=t/j,
$$
and include only $\beta_j>\alpha_j$. Their continuous value is
$$
\int_{\alpha_j}^{\beta_j}\frac{e^{-ju}}u\,du
=\operatorname{Ei}(-j\beta_j)-\operatorname{Ei}(-j\alpha_j),
\tag{14}
$$
with error $E_j(e^{\alpha_j})+E_j(e^{\beta_j})$. Multiplying the sum by $e^{t/2}$ gives a rigorous interval for the full $B(t)$. Thus no uncomputed prime is set to zero. There are finitely many sectors at each age, and all those sectors are included.

## 4. A justified infinite-age envelope

Define the comparison kernel
$$
C(t)=e^{t/2}\int_{e^{t/2}}^\infty\frac{du}{u^2\log u}
=\int_0^\infty\frac{e^{-tu}}{u+1/2}\,du .
$$
For $t\ge24$, the first sector's prime error is at most $480/t^4$, by (12), since $e^{t/2}>32321$. Replacing its upper limit $e^t$ by infinity costs at most
$e^{-t/2}+e^{-3t/2}$, even using all integers.

For sectors $j=2,3$, the first bound in (11) gives
$$
e^{t/2}\sum_{p>e^{t/(j+1)}}p^{-j-1}
\le \frac{U(j+1)^2}{jt}
\exp\left(-\frac{j-1}{2(j+1)}t\right).
\tag{15}
$$
For $j\ge4$, comparison with all integers gives
$$
e^{t/2}\sum_{n>e^{t/(j+1)}}n^{-j-1}
\le \frac1j e^{-3t/10}+e^{-t/2}.
$$
Sum through $j\le t/\log2$, using
$\sum_{j=4}^Jj^{-1}\le\log(J/3)$. Therefore
$$
\begin{split}
|B(t)-C(t)|\le{}&
\frac{480}{t^4}
+\frac{9U}{2t}e^{-t/6}
+\frac{16U}{3t}e^{-t/4}\\
&+\log\frac{t}{3\log2}\,e^{-3t/10}
+\left(\frac{t}{\log2}+1\right)e^{-t/2}
+e^{-3t/2}.
\end{split}\tag{16}
$$
For completeness, the six $t^3$-scaled terms are
$$
\frac{480}{t},\quad
\frac{9U}{2}t^2e^{-t/6},\quad
\frac{16U}{3}t^2e^{-t/4},\quad
t^3\log\frac{t}{3\log2}e^{-3t/10},\quad
\left(\frac{t}{\log2}+1\right)t^3e^{-t/2},\quad
t^3e^{-3t/2}.
$$
Their logarithmic derivatives, in order, are
$$
-\frac1t,\quad \frac2t-\frac16,\quad \frac2t-\frac14,\quad
\frac3t+\frac1{t\log(t/(3\log2))}-\frac3{10},\quad
\frac3t+\frac1{t+\log2}-\frac12,\quad
\frac3t-\frac32 .
$$
All are strictly negative for $t\ge24$. For the fourth, use
$\log(t/(3\log2))>2$, giving the upper bound
$3/24+1/48-3/10<0$; for the fifth, use the upper bound $4/24-1/2<0$.
Thus the sum attains its maximum at the stated endpoint. Arb verifies that the sum there is less than $105$. No asymptotic onset is being inferred from a finite grid. The numerical-onset statement is
$$
\boxed{|B(t)-C(t)|\le105\,t^{-3}\quad(t\ge24).}
\tag{17}
$$
This includes every higher prime-power sector. It replaces the earlier unspecified asymptotic onset by an explicit inequality.

## 5. Coherent infinite negative-age error

The actual $f=b-a$ has integral zero. In the physical coordinate it is positive until $x_0=A/\kappa-1>2$ and negative afterwards: on $1\le x<2$, $h-g=1-A/(1+x)-\kappa/x$ is increasing and positive at $1$; on $x\ge2$, it is $[A/(1+x)-\kappa]/x$. Consequently $P(v)=\int_0^vf$ is positive for $v>0$, vanishes at zero, and decays exponentially.

Put
$$
C_0=-\int a=2(\sqrt2-1)+\sqrt2 A,\quad
C_1=-\int va
=4-4\sqrt2+2L\sqrt2+\sqrt2 A(L+2),
$$
$$
M_P=\int P,\quad
V_a=2\sqrt2-1+\frac L{\sqrt2},\quad
V_f=\|\nu_b-\nu_a\|_{\rm TV}\le4\sqrt2-2.
\tag{18}
$$
The certificate uses $2.67<C_0<2.68$, $C_1<5.29$, and $0<M_P<.76$.
For the last bound the exact expression is
$$
M_P=-C_1+4A\,G+4\kappa,\qquad
G=\sum_{j\ge0}\frac{(-1)^j}{(2j+1)^2}.
$$
A 1000-term alternating sum encloses $G$, with error at most $2001^{-2}$.

The measure identities and
$C'(t)-C(t)/2=-1/t$ give
$$
y(-q)=Y(q)+\epsilon_y,\qquad
z(-q):=n(-q)-y(-q)=-J(q)+\epsilon_z,
$$
$$
Y(q)=-\int_0^\infty\frac{a(v)}{q+v}\,dv,\qquad
J(q)=\int_0^\infty\frac{P(v)}{(q+v)^2}\,dv,
$$
$$
|\epsilon_y|\le V_aKq^{-3},\qquad
|\epsilon_z|\le V_fKq^{-3},\qquad K=105,\quad q\ge H=24.
\tag{19}
$$
No derivative of the stepped remainder is used. Also $Y,J>0$,
$$
Y(q)\ge C_0/q-C_1/q^2,\qquad J(q)\le M_P/q^2.
$$
The checked inequality $2C_0H>2C_1+M_P$ therefore makes
$J(2Y-J)\ge0$ throughout this tail.

Expanding the complete quadratic difference
$-z(2y+z)$, and retaining every mixed error, gives
$$
\int_H^\infty[y(-q)^2-n(-q)^2]\,dq\ge-\mathcal T,
$$
$$
\mathcal T=
\frac{2C_0V_fK}{3H^3}
+\frac{M_P(V_a+V_f)K}{2H^4}
+\frac{(2V_aV_f+V_f^2)K^2}{5H^5}.
\tag{20}
$$
Using the upper bound for $M_P$, Arb obtains
$$
\boxed{\mathcal T<.058675154895.} \tag{21}
$$
This bounds the joint tail, rather than the two much slower separate norm tails.

## 6. Rigorous core integration, without an omitted-prime quadrature assumption

The checker uses the exact mesh $1/128$ on $0\le t\le38$. At every node it evaluates (13)–(14) and their explicit errors with Arb. Reciprocal-power prefix sums use the exact sieve through $40000$. Every integer floor used for a prime endpoint is checked by Arb inequalities. The exponential integral in (14) is evaluated as an interval special function.

Node bounds are converted into bounds on **whole cells**, not interpreted as quadrature samples. Between prime-power events the derivative of $B$ is $B/2$. Its only positive jumps are $p^{-3/2}$ at first-prime births; every proper-power jump is negative. For a cell $[l,r]$, let
$$
J_{l,r}=e^{r/2}\sum_{e^l<p\le e^r}p^{-2}.
$$
If the full node bounds are $B_-(l),B_+(l)$, then throughout the cell,
$$
e^{-(r-l)/2}B_-(r)-J_{l,r}
\le B(t)\le e^{(r-l)/2}B_+(l)+J_{l,r}.
\tag{22}
$$
The lower bound is also clipped at zero. The finite part of the birth sum is exact. For its part above $P_*$, put $Y=\max(P_*,e^l)$, $Z=e^r$. When $Z>Y$, (11) gives the upper bound
$$
\sum_{Y<p\le Z}p^{-2}
\le \frac{Z-Y+10Z/(\log Z)^3+10Y/(\log Y)^3}{Y^2\log Y}.
\tag{23}
$$
Thus the cell bounds retain all initial prime births and all downward power jumps. The certificate verifies that every cell upper bound is less than $2$; (17) and $C(t)\le2/t$ extend $B<2$ to all larger ages.

For (9), integrate the positive density $e^{v/2}$ exactly on its mesh cells, retaining the last partial cell at $L=\log2$. For (10), integrate its positive density exactly on $0\le v\le12$, using the primitive
$$
\frac{e^{v/2}}{1+e^v}+\arctan(e^{v/2}).
$$
The whole removed source-density tail is at most
$(4/3)e^{-18}$, using $B<2$. If $q$ and $v$ each range over one cell, $q+v$ lies in the union of two adjacent kernel cells. The minimum of their lower bounds and maximum of their upper bounds therefore enclose the convolution for the whole $q$-cell.

The positive convolution sums are evaluated by **Arb polynomial multiplication**, so this is interval convolution, not floating-point FFT quadrature. Outward dyadic conversions used only to choose minima and maxima are checked against the original Arb bounds. The shifted atom $B(q+L)$ is bounded on both cells it crosses.

For each observation cell, these operations give intervals $y_-\le y\le y_+$ and $0\le n\le n_+$. A lower bound for $y^2-n^2$ is the squared distance from $[y_-,y_+]$ to zero, minus $n_+^2$. Multiplying by the exact cell length and summing proves
$$
\boxed{
\int_0^{24}[y(-q)^2-n(-q)^2]\,dq
>.0360879364210 .
} \tag{24}
$$
All cross-prime work remains in the coherently summed $B$ before these squares are formed.

## 7. Entire positive-age tail and final bound

For physical $x>1$, $O(x)=0$. The exact positive new-output series gives
$$
N(x)\le A x^{-2}\sum_p\frac1{p^2(p+1)}
\le A x^{-2}\left(\frac{\pi^2}{6}-\frac32\right).
$$
The last identity bounds the prime sum by the complete integer sum. Hence
$$
\boxed{
\int_1^\infty N(x)^2\,dx
\le\frac{A^2}{3}\left(\frac{\pi^2}{6}-\frac32\right)^2
<.011958399582.
} \tag{25}
$$
This is the entire positive-age output, not a finite terminal window.

Combining (21), (24), and (25), the tighter Arb balls give
$$
I>-.0345456180547477402.
$$
Finally, (3) and the exact lower mass margin (6) give
$$
\mathcal E(O)-\mathcal E(N)
>0.0064397329293021118>\frac1{200}.
$$
The proof uses the full prime process, both source atoms, every proper power, all negative and positive ages, the whole quadratic increment, and the original physical metric. The independently checked finite two-prime energy signs are not assumed to persist under adding primes.


## Appendix A. Complete per-prime profiles and their domains

The following identities hold for every prime $p$, including all proper powers. Each fixed-prime series in (2) converges absolutely pointwise on $x>0$ and in physical $L^2$, because dilation by $p^j$ has norm $p^{-j/2}$.

The old output vanishes for $x\ge2/p$. On $1/p\le x<2/p$,
$$O_p(x)=-1/p+A/(p^2x).$$
On $x<1/p$, choose $j\ge2$ with $p^{-j}\le x<p^{1-j}$ and set $z=p^jx\in[1,p)$. Summing the complete geometric return gives
$$
O_p(x)=\begin{cases}(p-1)/p+A/(pz),&1\le z<2,\\A/z,&2\le z<p.\end{cases}
$$
In particular $|O_p|\le(p-1+A)/p$. To compute its mass, first integrate its defining series on $(0,R)$ for $R\ge2$. The primitive of $g$ at each $p^jR$ is a constant minus $A\log(p^jR)$. The constant and $\log R$ terms cancel; the absolutely convergent $j$-weighted geometric series gives (4). This argument never integrates the nonintegrable input $g$ separately over the whole half-line.

For the new output on the same cells,
$$N_p(x)=\frac{A(p-1)}p\sum_{k\ge0}\frac1{1+p^kz}+\frac\kappa z>0.$$
For $x\ge1/p$, set $z=px$. Then
$$
N_p(x)=\frac Ap D_p(z),\qquad
D_p(z)=\sum_{k\ge1}\frac{(p-1)(1-p^{-k})}{(1+z)(1+p^kz)}>0.
$$
This follows from subtracting $1/(1+z)$ from $(p-1)\sum_{k\ge1}(1+p^kz)^{-1}$ and using $(p-1)\sum_{k\ge1}p^{-k}=1$. Consequently
$$
D_p(z)\le\frac{p}{(p+1)z(1+z)},\qquad
N_p(x)\le\frac{A}{p(p+1)x(1+px)}.
$$
Integrating cell by cell, or first using finite spatial endpoints as for $m_p$, gives the $c_p$ series (4). Its positive-series remainder after $J$ terms is bounded there. These formulas establish the signs used in the full kernel margin without extrapolating a finite-prime matrix inequality.

The all-prime original-$L^2$ convergence follows from (8)–(10), finite source-measure variation, and the literal $B\in L^2$ theorem in [the seed construction](../successor-and-division/positive-successor-seed-jump-process.md). Its formal counterpart is [allPrimeSeed_memLp_two](../../formalization/BuildingBlocks/PrimeSeedAllPrimeSquare.lean). In negative age the shifts of $B$ have an $L^2$ convolution majorant, so prime-cutoff dominated convergence applies. On $x>1$, the displayed $x^{-2}$ bound gives the same conclusion. Physical $L^1$ on $(0,1)$ follows by Cauchy–Schwarz, and on $(1,\infty)$ by the $x^{-2}$ bound. Thus the full original-energy expression and every retained kernel integral are finite.

## Reproducing the certificate

Run `python -B certificates/full_prime_two_energy.py` from this directory with Python and `python-flint==0.9.0`. The certificate uses 160-bit Arb balls and fixed mathematical parameters. The verified lower bound is
$$0.006439732929302111890866662628477438470490,$$
with an enclosing radius below $7\cdot10^{-43}$. It checks whole-cell enclosures, explicit prime-sector errors and an analytic infinite-age envelope. The constant $1/200$ is a rigorous lower bound, not an approximation to the exact energy difference. The prime-distribution input is classical Dusart; the actual-source coherent reduction and interval proof are given above. No literature-priority claim is made.
