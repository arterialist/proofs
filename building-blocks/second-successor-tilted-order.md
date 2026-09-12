# Tilted cumulative negativity and W order for the second actual successor

Use the actual causal source and compensated successor from [second-compensated-successor.md](second-compensated-successor.md):
$$
a(v)=e^{-v/2}[\psi(e^v)-e^v],\qquad
(Sf)(v)=\sqrt{\frac{e^v}{1+e^v}}f(\log(1+e^v)),\qquad
Cf=Sf-\kappa(f)e^{-v/2}.
$$
These formulas apply for $v\ge0$; every source and successor is zero at negative ages. Here $\kappa(f)=\frac12\int_0^\infty(Sf-f)$, using the absolutely convergent relative integral. Put
$$
\kappa=\kappa(a),\quad b=Ca,\quad \kappa_b=\kappa(b),\quad c=Cb,
\qquad P_1=I(b-a),\quad P_2=I(c-b)=Q_2,
$$
where $I$ is causal integration. The existing proofs establish $P_1,P_2>0$ at every positive age and
$$
.2789<\kappa<.279,\qquad .2529<\kappa_b<.253.
\tag{1}
$$
The first primitive has the established envelope $P_1(v)<.93\vartheta(v)$, where $\vartheta(v)=e^{-v/2}-e^{-3v/2}$. We prove the same envelope for the second primitive and then the strict order
$$
\boxed{A_0(v)<B_0(v)<C_0(v)<0\quad(v>0),}
\tag{2}
$$
with $A_0=I(e^{-v/2}a)$, $B_0=I(e^{-v/2}b)$, and $C_0=I(e^{-v/2}c)$. This gives a second strict finite-cutoff, log-squared W comparison, with the complete original same-prime subtraction unchanged.

## 1. An actual upper envelope for the second primitive

Write $F(x)=P_2(\log x)$ for $x\ge1$. We claim
$$
\boxed{0<P_2(v)<\frac{93}{100}\vartheta(v)\quad(v>0).}
\tag{3}
$$
Positivity is the preceding second-successor theorem. The new upper bound uses the actual charge intervals (1), every prime-power birth through $24$, and the already proved unconditional tail estimate. The bounded interval checks are in [second-successor-tilted-order.py](certificates/second_successor_tilted_order.py), using Arb at 192-bit precision. They concern finite exact logarithmic and arctangent expressions, not sampled derivative values.

On $1\le x<2$, with the left derivative used at $x=2$, the literal formula is
$$
P_2'(\log x)=\frac{\sqrt x}{x+2}\log3
-\frac{\sqrt x}{(x+1)(x+2)}\log2
-\kappa\frac{\sqrt x}{x+1}
+\frac{\kappa-\kappa_b}{\sqrt x}.
$$
Consequently
$$
P_2'(\log x)\le
\frac{\sqrt2}{4}\log3-\frac{2789}{10000}\frac{\sqrt2}{3}
+\left(\frac{279}{1000}-\frac{2529}{10000}\right)<\frac3{10}.
\tag{4}
$$
The upper bound is enclosed below $0.283044$. The right derivative at $x=2$ includes the newly shifted arrival at four and is not bounded by this first-cell argument. The primitive itself is continuous there. Because $P_2(0)=0$, integration on the first cell gives $P_2(v)\le.3v$ throughout $0\le v\le\log2$. On this interval $\vartheta(v)\ge v/(2\sqrt2)$, so the ratio is at most $.6\sqrt2<.93$.

For the middle cells, replace $\kappa$ by $\kappa_+=.279$ and $\kappa_b$ by $\kappa_{b,-}=.2529$ in the exact primitive, obtaining $F_+\ge F$. The coefficients of the two charges in the primitive are respectively
$$
\int_1^x\frac{du}{u^{3/2}(u+1)}>0,
\qquad -2(1-x^{-1/2})<0,
$$
which proves the direction of this substitution. On a cell $n<x<n+1$, the derivative of $F_+$ has the sign of the explicit quadratic
$$
N_n(x)=\Lambda(n+2)x(x+1)-\psi(n+1)x
+\kappa_+(x+2)-\kappa_{b,-}(x+1)(x+2).
\tag{5}
$$
The exact endpoint increment is
$$
\begin{aligned}
F_+(X)-F_+(n)={}&\sqrt2\psi(n+2)
 [\arctan\sqrt{X/2}-\arctan\sqrt{n/2}]\\
&-2[\psi(n+1)+\kappa_+]
 [\arctan\sqrt X-\arctan\sqrt n]\\
&+2(\kappa_{b,-}-\kappa_+)(X^{-1/2}-n^{-1/2}).
\end{aligned}
\tag{6}
$$
Starting with $F_+(1)=0$, the script encloses the roots of (5) for all cells through $23$. Every interior root is a local minimum; none is an unresolved endpoint. Thus the maximum of $F_+$ on each cell is at an endpoint. The positive function $x^{3/2}/(x-1)$ also has its cell maximum at an endpoint (its only critical point, $x=3$, is a minimum). For every $n=2,\ldots,22$, all four products of these two endpoint maxima are rigorously less than $.63$. This proves
$$
F(x)<.63\frac{x-1}{x^{3/2}}\quad(2\le x\le23).
\tag{7}
$$
The script retains precisely $2,3,4,5,7,8,9,11,13,16,17,19,23$ as the prime powers through $24$.

For $x\ge23$, the exact tail identity and the established Trudgian bound used in the preceding source give $\epsilon_{23}<.162$ and
$$
\left|F(x)-\frac{2\kappa_b}{\sqrt x}
+2\kappa[x^{-1/2}-\arctan(x^{-1/2})]\right|
\le4\epsilon_{23}(\sqrt{x+1}-\sqrt x)
<\frac{2\epsilon_{23}}{\sqrt x}.
\tag{8}
$$
The square bracket is positive. Therefore $\sqrt xF(x)<.506+.324=.83$, whereas $.93(1-1/x)\ge.93(22/23)>.83$. This completes (3). The PNT input, including its domains, is imported exactly from the proved tail statement of the preceding note; no stronger prime estimate is used.

## 2. The second tilted cumulative is strictly negative

Put $p_j(v)=e^{-v/2}P_j(v)$. Integration by parts, including $P_j(0)=0$, gives
$$
D_j(v):=I(e^{-v/2}P_j')(v)
=p_j(v)+\frac12\int_0^v p_j(u)du>0.
\tag{9}
$$
Both primitive envelopes imply, with $r=e^{-v}$,
$$
D_j(v)<.93\left(\frac14+\frac r2-\frac{3r^2}{4}\right)
\le\frac{31}{100},\qquad j=1,2.
\tag{10}
$$
In particular $B_0=A_0+D_1$ and $C_0=A_0+D_1+D_2$, proving the strict comparisons in (2) once $C_0<0$ is established.

The literal second tilted source, retaining both successor shifts and charges, is
$$
e^{-v/2}c(v)=\frac{\psi(x+2)}{x+2}-1
-\frac{\kappa}{x+1}-\frac{\kappa_b}{x},\qquad x=e^v\ge1.
\tag{11}
$$
The finite exact inequalities $\psi(n)<n$ for $n=3,\ldots,10$ are checked by the same script. On $1\le x\le8$, they imply $\psi(x+2)<x+2$, with the literal right endpoint values included. Since both charges are positive, (11) is strictly negative on this entire interval. Hence $C_0(v)<0$ for $0<v\le\log8$.

For the remaining ages use the exact factorial identity from [the actual W analysis](actual-W-positive-primitive-analysis.md). With $m=\lfloor x\rfloor$,
$$
-xA_0(\log x)=x\log x-\log(m!)
+\sum_{n\le x}\Lambda(n)\left(1-\left\{\frac xn\right\}\right).
\tag{12}
$$
Every term in the last sum is nonnegative, including divisibility endpoints. The function $\log(m!)/x-\log x$ decreases within its cell. The trapezoidal inequality for the concave function $\log t$ yields
$$
A_0(\log x)\le\frac{\log(m!)}m-\log m
\le-1+\frac{1+\frac12\log m}{m}.
\tag{13}
$$
The last fraction decreases for $m\ge1$. For $m\ge8$, using $\log2<.7$, (13) is strictly below $-.7$. Equations (9)–(10) therefore give the uniform bound
$$
\boxed{C_0(v)<-\frac2{25}\quad(v\ge\log8).}
\tag{14}
$$
Together with the initial cells this proves (2) for every positive age. All three cumulatives vanish at zero.

## 3. The second strict log-squared W comparison

For $j=a,b,c$ define the literal same-prime readouts
$$
w_j=\rho*[(\mathrm{Id}-k*) (j*j)-\tau],\quad
k(v)=e^{-3v/2}\mathbf1_{v\ge0},\quad
\rho=\sum_{d\ge1}d^{-1}\delta_{\log d},\quad
W_j(x)=x^{3/2}w_j(\log x).
\tag{15}
$$
Here $\mathrm{Id}-k*$ denotes the identity operator minus convolution by $k$; $I$ still denotes causal integration. The same complete $\tau$ occurs in all three expressions: its terms are $(m-1)(\log p)^2$ for every $p^m$, $m\ge2$, with the normalization of the original W criterion. It is neither evolved nor truncated.

Set $U=-A_0$, $V=-B_0$, $Z=-C_0$. The proved order is $U>V>Z>0$ on positive ages. In particular
$$
Q_{bc}=V*V-Z*Z=(V-Z)*(V+Z)>0\quad(v>0).
\tag{16}
$$
These continuous causal potentials vanish at zero. Thus, writing $\beta=e^{-v/2}b$ and $\chi=e^{-v/2}c$, their full convolution squares satisfy $\beta*\beta-\chi*\chi=Q_{bc}''$ distributionally. This identity includes both mixed terms and the square of the increment; it is not a deletion of positive or negative channels.

Exponential tilting of (15) gives the exact filtered identity
$$
e^{-v/2}(w_b-w_c)=\rho_{3/2}*(\mathrm{Id}-k_2*)Q_{bc}'',\qquad
\rho_{3/2}=\sum_{d\ge1}d^{-3/2}\delta_{\log d},\quad
k_2=e^{-2v}\mathbf1_{v\ge0}.
\tag{17}
$$
The unchanged same-prime term cancels exactly between these two readouts. After three causal integrations,
$$
\boxed{I^3[e^{-v/2}(w_b-w_c)]
=\rho_{3/2}*K_0*Q_{bc}>0\quad(v>0),\qquad
K_0(v)=\tfrac12(1+e^{-2v})\mathbf1_{v\ge0}.}
\tag{18}
$$
Indeed $I^3Q_{bc}''=IQ_{bc}$ and the once-integrated filter has the positive kernel $K_0$. Strictness follows already from the $d=1$ term. All arithmetic sums at a fixed age are finite; only local absolute integrability is needed.

Combining (18) with the first-stage theorem gives the strict chain
$$
\boxed{\int_1^x\log^2(x/y)\frac{W_a(y)}{y^3}dy
>\int_1^x\log^2(x/y)\frac{W_b(y)}{y^3}dy
>\int_1^x\log^2(x/y)\frac{W_c(y)}{y^3}dy\quad(x>1).}
\tag{19}
$$
All three integrals are zero at $x=1$. Equation (18) is exactly one half of the corresponding difference in (19). The direct $a$ versus $c$ version also follows by replacing (16) with $(U-Z)*(U+Z)$.

This is a strict cumulative comparison for two actual compensated successors. It gives no sign for any individual W readout, no pointwise order between them, and no induction for arbitrary further iterates. The positivity of $P_2$ and its envelope were proved from the literal arithmetic source rather than from an assumed positivity-preserving property of the compensated successor.

The [actual fifth-primitive counterexample](actual-successor-fifth-primitive-failure.md)
now proves $P_5(v)<-v/20$ for $0<v\le\log(101/100)$, with an elementary
bound on the complete prime-power tail. Thus positivity does fail in this
specific orbit. This does not determine the global signs of $P_3$ or $P_4$,
or identify the earliest iterate at which positivity fails somewhere.

## Verification scope

The linked certificate was run successfully with `python-flint==0.9.0`. It verifies the bounded interval inequalities used in this written proof; the displayed analytic tail supplies the unbounded range. Run `python -B certificates/second_successor_tilted_order.py` from this directory. No Lean formalization of these actual iterate signs is claimed.
