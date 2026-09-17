# Positivity survives the second actual compensated successor

Let
$$
a(v)=e^{-v/2}[\psi(e^v)-e^v]\mathbf1_{v\ge0},\qquad
a_0(v)=e^{-v/2}\mathbf1_{v\ge0},
$$
and use the literal causal successor
$$
(Sf)(v)=\sqrt{\frac{e^v}{1+e^v}}\,f(\log(1+e^v))
\quad(v\ge0),\qquad (Sf)(v)=0\quad(v<0).
$$
For the sources below the relative integral is absolutely convergent. Write
$$
\kappa(f)=\frac12\int_0^\infty(Sf-f)(v)dv,\qquad
Cf=Sf-\kappa(f)a_0.
$$
Put $\kappa=\kappa(a)$, $b=Ca$, $\kappa_b=\kappa(b)$, $c=Cb$, and
$$
Q_2(v)=\int_0^v(c-b)(u)du,
\qquad Q_2(v)=0\quad(v<0).
$$
The conclusion is
$$
\boxed{Q_2(0)=0,\qquad Q_2(v)>0\quad\text{for every }v>0.}
\tag{1}
$$
This is proved for the complete actual source, retaining the shifts by one and two and all prime powers. It is not inferred from positivity of the first primitive, and does not assert positivity under arbitrary further iteration. The proof uses literal formulas, an absolutely bounded charge tail, the existing unconditional PNT estimate, and a bounded interval calculation at every possible cell minimum through $x=23$.

## 1. Literal shifts and the second relative charge

For $x=e^v\ge1$, write $E(x)=\psi(x)-x$. The exact identities are
$$
Sa(v)=\frac{\sqrt x}{x+1}E(x+1),\qquad
S^2a(v)=\frac{\sqrt x}{x+2}E(x+2),\qquad
Sa_0(v)=\frac{\sqrt x}{x+1}.
$$
Therefore
$$
\boxed{c-b=S^2a-Sa-\kappa Sa_0+(\kappa-\kappa_b)a_0.}
\tag{2}
$$
All the density terms cancel exactly in $S^2a-Sa$. On a real cell $n<x<n+1$,
$$
\boxed{(c-b)(\log x)=
\sqrt x\left[\frac{\psi(n+2)}{x+2}-\frac{\psi(n+1)+\kappa}{x+1}\right]
+\frac{\kappa-\kappa_b}{\sqrt x}.}
\tag{3}
$$
Chebyshev's bound and the one-step increment $\Lambda(n+2)\le\log(n+2)$ show that (3) is $O((1+v)e^{-v/2})$. Thus the defining relative integrals converge absolutely, without assigning finite integrals to $a$ or $Sa$ separately.

Direct integration gives $\kappa(a_0)=\pi/4-1$. For the other part, the prime-two endpoint differs from the general prime-power kernel. The exact convergent series is
$$
\begin{aligned}
\kappa(Sa)={}&(\log2)\left[\frac{\arctan\sqrt2}{\sqrt2}-\frac\pi4\right]\\
&+\sum_{n\ge3}\Lambda(n)
\left[\frac{\arcsin\sqrt{2/n}}{\sqrt2}
-\arcsin(n^{-1/2})\right],
\end{aligned}
\tag{4}
$$
and hence
$$
\boxed{\kappa_b=\kappa(Sa)+\kappa(1-\pi/4).}
\tag{5}
$$
To verify (4), the coefficient of each arrival in the integrated $j$-shifted source is
$$
\frac12\int_{\max(1,n-j)}^\infty\frac{dx}{\sqrt x(x+j)}
=\frac1{\sqrt j}\arctan\sqrt{\frac{j}{\max(1,n-j)}}.
$$
Take the difference $j=2$ minus $j=1$. For $n\ge3$, use $\arctan\sqrt{j/(n-j)}=\arcsin\sqrt{j/n}$. At $n=2$ the first lower endpoint is one, not zero, giving precisely the separate first line of (4).

The interchange with the arrival sum is absolute. For $n\ge3$, the unintegrated difference is positive on $[n-2,n-1)$ and negative thereafter; its total absolute integral is $O(n^{-3/2})$. The sum against $\Lambda(n)\le\log n$ converges. Thus (4) neither deletes the initial strip nor uses a merely formal subtraction of divergent integrals.

## 2. Complete charge enclosures with analytic tails

Set
$$
c_j=\frac{\binom{2j}{j}}{4^j(2j+1)},\qquad
D(s)=-\frac{\zeta'(s)}{\zeta(s)}.
$$
The already established first charge and the positive $n\ge3$ part of (4) are
$$
\kappa=\sum_{j\ge1}c_jD(j+1/2),
$$
$$
\sum_{j\ge1}c_j(2^j-1)
\left[D(j+1/2)-\frac{\log2}{2^{j+1/2}}\right].
\tag{6}
$$
The square bracket removes only the integer $2$; every proper power, including powers of two, remains. Each term in this latter series is positive. The first prime-two term in (4) is negative and stays separate.

Here are explicit upper bounds for both omitted tails. Fix $K\ge1$, put $r=K+1/2$, and
$$
C_2=\log2+\frac{2\log2}{r}+\frac2{r^2},\qquad
C_3=\log3+\frac{3\log3}{r}+\frac3{r^2}.
$$
Using $\Lambda(n)\le\log n$ and integral comparison for the decreasing function $(\log x)x^{-s}$ gives
$$
D(s)\le2^{-s}\left[\log2+\frac{2\log2}{s-1}+\frac2{(s-1)^2}\right],
$$
$$
D(s)-(\log2)2^{-s}
\le3^{-s}\left[\log3+\frac{3\log3}{s-1}+\frac3{(s-1)^2}\right]
\quad(s\ge3/2).
$$
Since $c_j\le1/(2j+1)$, the tails beyond $K$ are at most
$$
T_\kappa=\frac{C_2\,2^{-K-1/2}}{2K+3},\qquad
T_{\rm rest}=\frac{3C_3}{\sqrt3(2K+3)}(2/3)^{K+1}.
\tag{7}
$$
The resulting omitted upper bound for $\kappa_b$ is
$T_{\rm rest}+(1-\pi/4)T_\kappa$.

The accompanying [second-compensated-successor.py](../../certificates/second_compensated_successor.py) evaluates (6) through $K=40$ with python-flint Arb at 192-bit precision and applies (7). It proves the rational enclosures
$$
\boxed{\frac{2789}{10000}<\kappa<\frac{279}{1000},\qquad
\frac{2529}{10000}<\kappa_b<\frac{253}{1000}.}
\tag{8}
$$
For orientation, the computed partial value of $\kappa_b$ is about $0.252921512178$, with omitted upper bound less than $1.487\times10^{-9}$. The proof uses the enclosures (8), not an unbounded numerical prime sum.

## 3. Exact primitive cells and their complete bounded sign test

Write $F_2(x)=Q_2(\log x)$. Equation (3) gives, on $n<x<n+1$,
$$
\boxed{F_2'(x)=
\frac{\psi(n+2)}{\sqrt x(x+2)}
-\frac{\psi(n+1)+\kappa}{\sqrt x(x+1)}
+\frac{\kappa-\kappa_b}{x^{3/2}}.}
\tag{9}
$$
Multiplication by the positive denominator $x^{3/2}(x+1)(x+2)$ leaves the quadratic polynomial
$$
\boxed{N_n(x)=\Lambda(n+2)x(x+1)-\psi(n+1)x
+\kappa(x+2)-\kappa_b(x+1)(x+2).}
\tag{10}
$$
For $n\le A\le B\le n+1$, the exact cell increment is
$$
\begin{aligned}
F_2(B)-F_2(A)={}&\sqrt2\psi(n+2)
 [\arctan\sqrt{B/2}-\arctan\sqrt{A/2}]\\
&-2(\psi(n+1)+\kappa)[\arctan\sqrt B-\arctan\sqrt A]\\
&+2(\kappa_b-\kappa)(B^{-1/2}-A^{-1/2}).
\end{aligned}
\tag{11}
$$
Start from $F_2(1)=0$. The primitive is continuous at every integer even when its derivative jumps.

A uniform lower function is obtained by replacing $\kappa$ by $\kappa_{\rm lo}=2789/10000$ and $\kappa_b$ by $\kappa_{b,\rm hi}=253/1000$ in (9)–(11). Indeed the coefficient of $\kappa$ in the cumulative integral is
$$
\int_1^x\frac{du}{u^{3/2}(u+1)}>0,
$$
whereas the coefficient of $\kappa_b$ is $-2(1-x^{-1/2})<0$. Thus this is a pointwise lower function throughout every cell, not just a substitution at sampled endpoints.

The script checks the endpoints and every real root of the quadratic (10) inside each cell $n=1,\ldots,22$, using all prime-power arrivals through 24. On the first cell its leading coefficient is positive and its discriminant negative, so the lower function increases strictly from zero. On $[2,23]$ every checked minimum exceeds $1/20$. The only interior stationary point in this bounded test is in $(7,8)$, enclosed near $7.2228348448$; its lower-function value exceeds $0.13306$. These assertions are verified as Arb inequalities, with every possible quadratic root classified inside or outside its cell.

Consequently
$$
\boxed{Q_2(v)>0\quad(0<v\le\log23),\qquad
F_2(x)>1/20\quad(2\le x\le23).}
\tag{12}
$$
The first cell includes the shifts to primes two and three; subsequent cells retain arrivals such as four, eight, and nine. The arrival at 25 changes the right derivative at the final endpoint $x=23$ but contributes zero to the cumulative value there. It is not needed in the left-cell extremum calculation and is included in the full tail argument below.

## 4. A literal convergent tail formula and all-age positivity

The exact general compensated-successor primitive identity, including its initial strip, gives
$$
Q_2(v)=2\kappa_b e^{-v/2}
+\int_v^{\log(1+e^v)}b(u)du
-\int_{\log(1+e^v)}^\infty k_+(u)b(u)du,
\tag{13}
$$
where $k_+(u)=(1-e^{-u})^{-1/2}-1$. This formula holds for every $v\ge0$. The lower tail endpoint is always at least $\log2$, so the positive branch of $k$ is never used on the removed input strip. The definition of $\kappa_b$ makes the right side zero at $v=0$.

Substitute $b=Sa-\kappa a_0$. If $x=e^v$ and $|E(y)|\le\epsilon y$ for every $y\ge x+1$, then $|Sa(\log y)|\le\epsilon\sqrt y$ for every $y\ge x$. The two positive absolute-value kernels in (13) each have mass $2(\sqrt{x+1}-\sqrt x)$ against this bound. The $a_0$ part is explicit:
$$
\int_v^{\log(1+e^v)}a_0(u)du
-\int_{\log(1+e^v)}^\infty k_+(u)a_0(u)du
=2[x^{-1/2}-\arctan(x^{-1/2})].
$$
Thus
$$
\boxed{\left|F_2(x)-\frac{2\kappa_b}{\sqrt x}
+2\kappa[x^{-1/2}-\arctan(x^{-1/2})]\right|
\le4\epsilon(\sqrt{x+1}-\sqrt x)
<\frac{2\epsilon}{\sqrt x}.}
\tag{14}
$$
No total-variation bound on the uncentered source is used. This is an exact density/charge separation with a uniform arithmetic error bound.

The same published PNT estimate used for the first primitive, [Trudgian, Theorem 1](https://arxiv.org/pdf/1401.2689), gives the simultaneous bound
$$
|E(y)|\le\epsilon_{23}y\quad(y\ge23),\qquad
\epsilon_{23}<162/1000.
$$
The last strict inequality is enclosed in the script from the theorem's explicit expression
$$
\epsilon_{23}=\sqrt{\frac8{17\pi}}\,z^{1/2}e^{-z},\qquad
z=\sqrt{\log23/6.455}.
$$
The relative bound decreases after 23. Also $\arctan z\ge z-z^3/3$ for $0\le z\le1$, so
$$
0<1-\sqrt x\arctan(x^{-1/2})\le\frac1{3x}.
$$
For $x\ge23$, equations (8) and (14) therefore prove
$$
\begin{aligned}
F_2(x)&\ge\frac2{\sqrt x}
\left[\kappa_b-\epsilon_{23}-\frac\kappa{3x}\right]\\
&>\frac2{\sqrt x}
\left[\frac{2529}{10000}-\frac{162}{1000}
-\frac{279}{1000\cdot69}\right]
>\frac1{6\sqrt x}.
\end{aligned}
\tag{15}
$$
Together (12) and (15) prove (1) for every real positive age. Quantitative PNT in (14) also gives
$$
Q_2(v)=2\kappa_b e^{-v/2}+O(e^{-v/2-c\sqrt v}),
\tag{16}
$$
with the exact smaller charge correction from (14) still available. In particular $Q_2\in L^1$ and $\int Q_2>0$.

## Scope

The same compensated successor really does preserve the positive primitive order through this second application to the actual source. The proof retains both distinct charges, the exact shifts by one and two, the prime-two initial correction, every proper power, and the literal density. The finite computation is a bounded sign certificate combined with an all-real tail proof, not numerical evidence for untested ages.

There is no abstract induction principle here for arbitrary sources or all iterates of $C$. The second positive primitive supplies another concrete signed source comparison; converting it to a pointwise or eventual sign for the original quadratic W still requires its full source/filter arithmetic. No RH conclusion follows from (1).

## Verification scope

The linked certificate was run successfully with `python-flint==0.9.0`. It verifies the bounded interval inequalities used in this written proof; the displayed analytic tail supplies the unbounded range. Run `python -B certificates/second_compensated_successor.py` from this directory. No Lean formalization of these actual iterate signs is claimed.
