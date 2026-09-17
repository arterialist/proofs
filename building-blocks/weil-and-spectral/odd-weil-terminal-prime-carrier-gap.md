# Full prime-graph cost for moderate-frequency odd Weil carriers

The full prime graph can have very small relative energy at arbitrarily late
Kronecker returns. This note gives an unconditional estimate for a specified
boundary-modulated family at much lower frequencies. It retains every
admitted prime power and exact pole-nullity. It does not sign the Weil form
for arbitrary odd tests or prove RH.

Let $a\to\infty$, $Z_a=a+\sinh a$, and $\phi(x)=\cosh(x/2)$. Let
$S_a[F]=\int_{-a}^a(P_a\phi/\phi)|F|^2$ and
$D_a[F]=S_a[F]-\langle F,P_aF\rangle$ be the weighted row and positive
graph deficit for the [actual prime shifts](../prime-distribution/prime-shift-weighted-schur-window-asymptotic.md).
For $t=t(a)\to\infty$, begin with the odd test
\[
F^0_{a,t}(x)=\sqrt{2/Z_a}\,\phi(x)\sin(tx)\mathbf1_{(-a,a)}(x).
\]
On the positive half-line put $u^0=\sqrt2 F^0|_{(0,a)}$ and
$h(x)=\sqrt2\sinh(x/2)$. Project $u^0$ orthogonally off $h$, normalize
it in $L^2(0,a)$, and take its normalized odd extension $F_{a,t}$.
Thus $F_{a,t}$ has exact odd pole moment zero.

**Theorem.** If $t(a)\to\infty$ and
$t(a)\le\exp(\tfrac14\sqrt a)$, then
\[
\boxed{\quad D_a[F_{a,t}]=(1+o(1))e^a,
\qquad S_a[F_{a,t}]=(1+o(1))e^a.\quad}
\tag{1}
\]
In particular, $D_a[F_{a,t}]/S_a[F_{a,t}]\to1$. For each $a$,
compact smooth odd pole-null tests can approximate $F_{a,t}$ while
preserving (1) asymptotically.

**Proof.** Put $X=e^{2a}$, $c_n=\log(X/n)$, and
\[
E_{a,n}=\frac{\Lambda(n)}{\sqrt n}
\int_{-a}^{a-\log n}\phi(x)\phi(x+\log n)\,dx,
\qquad T_a=\sum_{n<X}E_{a,n}.
\]
The [exact edge calculation](../prime-distribution/odd-prime-terminal-band-phase-transfer.md)
gives
\[
E_{a,n}=\frac{\Lambda(n)c_n}{4}\left(1+\frac1n\right)
 +\frac{\Lambda(n)}2\left(\frac{e^a}{n}-e^{-a}\right),
\qquad T_a=\frac X4+o(X).
\tag{2}
\]
Its oscillatory-integration estimate is uniform for $t\ge1$. With
$C_a(t)=\sum_{n<X}E_{a,n}n^{it}$, it reads
\[
S_a[F^0_{a,t}]=\frac2{Z_a}\bigl(T_a+O(X/t)\bigr),
\qquad
D_a[F^0_{a,t}]=\frac2{Z_a}\left(T_a-\operatorname{Re}C_a(t)
                                      +O(X/t)\right).
\tag{3}
\]
It remains to prove $C_a(t)=o(X)$ in the stated frequency range.

The terms of (2) other than $\Lambda(n)c_n/4$ contribute
$O(ae^a+a^2)=o(X)$ to $C_a(t)$ in absolute value. Set
\[
M_a(t)=\sum_{n<X}\Lambda(n)\log(X/n)n^{it}.
\]
The terms with $n\le e^a=\sqrt X$ contribute $O(ae^a)$ by
Chebyshev's bound. On $[e^a,X]$, write $\psi(x)=x+R(x)$.
[Trudgian's prime-number-theorem bound](https://arxiv.org/pdf/1401.2689)
applies to $\psi$, including all proper prime powers, and gives
\[
|R(x)|\le Cx a^{1/4}
\exp\!\left(-\sqrt{a/6.455}\right)
\qquad(e^a\le x\le X).
\tag{4}
\]
For $f(x)=\log(X/x)x^{it}$, Stieltjes integration by parts and
$|f'(x)|\le(1+ta)/x$ give an error at most
\[
O\!\left(X(1+t)a^{5/4}
\exp\!\left(-\sqrt{a/6.455}\right)+ae^a\right)=o(X),
\tag{5}
\]
since $1/\sqrt{6.455}>1/4$ and $t\le e^{\sqrt a/4}$.
The continuous main term is
\[
\int_{e^a}^{X}\log(X/x)x^{it}\,dx
=\frac{X^{1+it}}{(1+it)^2}+O(ae^a).
\tag{6}
\]
Its magnitude is $o(X)$ because $t\to\infty$. Consequently
$M_a(t)=o(X)$ and (2) gives $C_a(t)=o(X)$.
Now $Z_a\sim e^a/2$ and (3) prove
$D_a[F^0_{a,t}]=S_a[F^0_{a,t}]=(1+o(1))e^a$.

Finally, $\|u^0\|_2=1+O(1/t)$,
$\|h\|_2^2=\sinh a-a$, and direct integration gives
\[
\langle h,u^0\rangle=
\sqrt{2/Z_a}\,
\frac{\cosh a\sin(ta)-t\sinh a\cos(ta)}{1+t^2}.
\]
The pole projection and normalization change $F^0$ by $O(1/t)$ in
$L^2$. Both $S_a$ and $D_a$ have operator norm $O(e^a)$, so their
quadratic values change by $O(e^a/t)=o(e^a)$. At each $a$, smooth
compact approximation followed by a one-dimensional pole correction
preserves both values to any required accuracy. This proves (1).
$\square$

The estimate uses Trudgian's explicit $\psi$ error, and its carrier
range has $\log t=O(\sqrt a)$. This is far below the
$\log t\asymp e^a$ scale at which the archimedean logarithmic energy
can pay the full prime row. The [growing exceptional-prime construction](../prime-distribution/odd-prime-graph-growing-exceptional-phase-obstruction.md)
uses much later carriers and is consistent with (1). The theorem is
restricted to this modulated family and gives no all-window Weil
positivity inequality. In particular, (1) only gives the signed prime
expectation $\langle F_{a,t},P_aF_{a,t}\rangle=o(e^a)$.
The PNT error allowed by (5), after normalization, includes a term of
size $e^a(1+t)a^{5/4}e^{-\sqrt{a/6.455}}$. Even when this is $o(e^a)$,
it can be far larger than the archimedean energy $\asymp\log t$.
