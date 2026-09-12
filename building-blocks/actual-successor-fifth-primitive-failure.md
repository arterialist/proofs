# The fifth actual compensated-successor primitive is negative initially

The positive primitive order of the first two actual successors does not persist at every iterate. With the literal completed source, the same compensated successor, and every prime power retained, we prove
$$
\boxed{P_5(v)<-\frac{v}{20}\quad
       (0<v\le\log(101/100)),\qquad
P_j=I(C^ja-C^{j-1}a).}
\tag{1}
$$
This is an actual-source counterexample, not a counterexample obtained by replacing the source or its metric. It rules out a class containing all these actual iterates that both preserves primitive positivity under $C$ and proves $P_j\ge0$ for all $j$. It does not rule out other iterated-successor comparisons or decide the complete W sign.

The scalar renewal formulas below are the completed-source version of the already established [literal compensated-successor renewal representation](literal-compensated-successor-iterates.md). The new deduction is the potential update with its initial boundary term, the necessary initial inequality, and the rigorous failure of that inequality on the actual fifth step. The certificate is [successor-fifth-primitive.py](certificates/successor_fifth_primitive.py).

## 1. Exact source and charge recurrences

Write $x=e^v\ge1$, and let
$$
g_0(x)=\frac{\psi(x)}x-1,\qquad
a(v)=\sqrt x\,g_0(x),\qquad a_0(v)=x^{-1/2}.
$$
The sources are causally zero-extended to $v<0$. Set $a_j=C^ja$, $\kappa_j=\kappa(a_j)$, and $g_j(x)=x^{-1/2}a_j(\log x)$. The exact successor rule is
$$
g_{j+1}(x)=g_j(x+1)-\frac{\kappa_j}{x},\qquad
\kappa(f)=\frac12\int_0^\infty(Sf-f)(v)dv.
$$
Thus
$$
\boxed{g_j(x)=\frac{\psi(x+j)}{x+j}-1
 -\sum_{i=0}^{j-1}\frac{\kappa_i}{x+j-1-i}.}
\tag{2}
$$
The density $-1$ remains literal. It is fixed by ordinary physical translation and contributes zero to the relative charge. It has not been removed by assigning a finite absolute charge to a divergent source.

For the seed, put
$$
q_j=\begin{cases}1,&j=0,\\
\arctan\sqrt j/\sqrt j,&j>0,\end{cases}
\qquad d_j=q_j-q_{j+1}>0.
$$
If $e_j=\kappa(S^ja)$, the full feedback is
$$
\boxed{\kappa_j=e_j+\sum_{i=0}^{j-1}d_{j-1-i}\kappa_i.}
\tag{3}
$$
This is the positive scalar renewal from the cited source. Positivity of its renewal coefficients does not imply positivity of the primitive of the source difference: the driver and the boundary balance remain signed.

Here the completed arithmetic driver has a convergent explicit series. For integers $n\ge2$, define
$$
q_j(n)=\begin{cases}
q_j,&n\le j+1,\\
n^{-1/2},&j=0,\\
j^{-1/2}\arcsin\sqrt{j/n},&j>0,\ n>j+1.
\end{cases}
$$
The first case is the clipped initial boundary, not an extrapolation of the last formula below its domain. Direct integration of the shifted birth indicator gives
$$
q_j(n)=\frac12\int_{\max(1,n-j)}^\infty
                       \frac{dx}{\sqrt x(x+j)},
\qquad
\boxed{e_j=\sum_{n\ge2}\Lambda(n)[q_{j+1}(n)-q_j(n)].}
\tag{4}
$$
The relative integral is absolutely convergent. For fixed $j$, its large-$n$ coefficient is $O_j(n^{-3/2})$, and $\Lambda(n)\le\log n$. One can also justify the passage from finite birth sums directly in the relative-charge kernel: away from the bounded initial segment it is $O(x^{-3/2})$ in physical coordinates, and $\psi(x)/x\le\log x$. Thus the formula retains the full infinite source without assuming convergence of its separate absolute charges.

## 2. The signed normalized-potential update

Let $P$ be an actual difference primitive at one of these finite iterates. It is continuous, causal, and $P(0)=P(\infty)=0$. These endpoint properties follow from the definition of the compensation and the absolute relative integral. The elementary bound $\Lambda(n)\le\log n$ also gives a tail $O_j((1+v)e^{-v/2})$ for each such primitive, sufficient for the integrations below.

Put $d=P'$, $\ell=\log2$, $b(v)=\log(1+e^v)$, and
$$
J(u)=(1-e^{-u})^{-1/2},\qquad h_1(u)=-J'(u)>0.
$$
Changing variables in the literal successor and integrating by parts yields
$$
2\kappa(d)=-J(\ell)P(\ell)+\int_\ell^\infty h_1(u)P(u)du,
$$
$$
\boxed{I(CP')(v)=J(b(v))P(b(v))
 +2\kappa(d)e^{-v/2}
 -\int_{b(v)}^\infty h_1(u)P(u)du.}
\tag{5}
$$
In particular, the initial boundary term and the compensation are both present. Formula (5) vanishes at $v=0$ exactly; deleting either term would change the source.

For $F_j(x)=\sqrt x P_j(\log x)$, (5) becomes
$$
\boxed{F_{j+1}(x)=F_j(x+1)+2(\kappa_j-\kappa_{j-1})
 -\frac{\sqrt x}{2}\int_{x+1}^\infty
             \frac{F_j(y)}{y(y-1)^{3/2}}dy.}
\tag{6}
$$
Since $F_{j+1}(1)=0$, the charge can equivalently be eliminated:
$$
\begin{aligned}
F_{j+1}(x)={}&F_j(x+1)-F_j(2)
 +\frac12\int_2^{x+1}\frac{F_j(y)}{y(y-1)^{3/2}}dy\\
&-\frac{\sqrt x-1}{2}\int_{x+1}^\infty
                          \frac{F_j(y)}{y(y-1)^{3/2}}dy.
\end{aligned}
\tag{7}
$$
A positive potential therefore supplies one positive integral and one negative tail integral, in addition to a signed translated increment. Neither positive renewal nor $P_j>0$ controls this balance by itself. The actual $F_1$ is not assumed to be increasing.

There is a particularly accessible necessary condition for positivity. From (2), at the right initial boundary,
$$
\boxed{P_j'(0+)=\frac{\Lambda(j+1)}{j+1}
 -\frac{\psi(j)}{j(j+1)}
 +\sum_{i=0}^{j-2}\frac{\kappa_i}{(j-1-i)(j-i)}
 -\kappa_{j-1}.}
\tag{8}
$$
For $P_j\ge0$ and $P_j(0)=0$, this quantity must be nonnegative. The birth at $j+1$, the accumulated earlier prime powers, and every feedback charge occur separately in (8).

## 3. An elementary rigorous full-tail certificate

Only $\kappa_0,\ldots,\kappa_4$ are needed. Take $N=100000$ and sum (4) over every prime power $n\le N$. No density or PNT estimate is needed for the remaining tail.

For $n>N$ and $0\le j\le4$, write
$$
q_j(n)=n^{-1/2}f(j/n),\qquad
f(z)=\frac{\arcsin\sqrt z}{\sqrt z}
=\int_0^1(1-zt^2)^{-1/2}dt.
$$
The value at $z=0$ is interpreted continuously. Differentiation gives
$$
0<f'(z)\le\frac1{6(1-z)^{3/2}},\qquad0\le z<1.
$$
It follows that the omitted tail $T_j$ of each $e_j$ is positive and satisfies
$$
\begin{aligned}
T_j&\le\frac1{6(1-5/N)^{3/2}}
           \sum_{n>N}\frac{\log n}{n^{3/2}}\\
&\le\boxed{E_N:=\frac{\log N+2}{3\sqrt N(1-5/N)^{3/2}}.}
\end{aligned}
\tag{9}
$$
The sum is bounded by the integral of the decreasing function $(\log t)t^{-3/2}$ from $N$ to infinity; the boxed quantity is the upper bound used by the script. The positive coefficients $d_j$ in (3) propagate lower and upper driver bounds without a sign assumption on the drivers themselves.

Arb at 128-bit precision, with directed interval enclosures of every logarithm, square root, arcsine, and arctangent, gives the following deliberately rounded outward intervals:

| Charge | Lower bound | Upper bound |
|---|---:|---:|
| $\kappa_0$ | $.2778806$ | $.2921256$ |
| $\kappa_1$ | $.2516415$ | $.2689435$ |
| $\kappa_2$ | $.1932736$ | $.2127970$ |
| $\kappa_3$ | $.2009042$ | $.2222504$ |
| $\kappa_4$ | $.1271393$ | $.1500644$ |

The script uses the unrounded enclosures. These broad intervals are enough for a strict sign; there is no need to sharpen the infinite arithmetic tail or extend the iterate range.

## 4. A negative interval for the fifth actual primitive

On $1\le x\le101/100$, the literal shifted values are $\psi(x+5)=\psi(6)=\psi(5)$ and $\psi(x+4)=\psi(5)$. In particular the missing birth is exactly $\Lambda(6)=0$, while the proper power $4$ is retained in $\psi(5)=2\log2+\log3+\log5$. Equation (2) gives
$$
\boxed{(a_5-a_4)(\log x)=\sqrt x\left[
 -\frac{\psi(5)}{(x+4)(x+5)}
 +\sum_{i=0}^3\frac{\kappa_i}{(x+3-i)(x+4-i)}
 -\frac{\kappa_4}{x}\right].}
\tag{10}
$$
Let $x_1=101/100$. The charges in the displayed interval table are positive. The bracket in (10) is therefore bounded above, throughout the whole interval, by
$$
-\frac{\psi(5)}{(x_1+4)(x_1+5)}
+\sum_{i=0}^3\frac{\kappa_i^{\rm upper}}{(4-i)(5-i)}
-\frac{\kappa_4^{\rm lower}}{x_1}.
\tag{11}
$$
The rigorous upper enclosure using the unrounded values is below $-.0782501$, and in particular below $-1/20$. Multiplication by $\sqrt x\ge1$ preserves this upper bound because it is negative. Since $P_5(0)=0$, integrating in age proves (1), including the explicit witness
$$
\boxed{P_5(\log(101/100))<-\frac1{20}\log(101/100)<0.}
\tag{12}
$$
The right initial derivative is used; no left derivative or distributional atom is substituted for it. The actual source has a causal initial jump, but its primitive is continuous and starts at zero.

## 5. Consequence for the proposed induction and the W consumer

The certified local failure is enough to disprove $P_j\ge0$ for all $j\ge1$. It does not assert which of the unchecked third or fourth primitives first fails somewhere, and it does not contradict the proved positivity and envelopes of $P_1$ and $P_2$.

The defect is an explicit arithmetic mismatch in (10): at the fifth step there is no shifted prime-power birth at $6$, while the earlier divisor history and the new compensating charge remain. Positive scalar renewal of the charges does not prevent this negative initial derivative. Any class forcing positivity at every stage of this actual orbit would contradict (12).

For the literal W readout, the complete source-square difference at this step is still
$$
a_5*a_5-a_4*a_4
=a_4*P_5'+P_5'*a_4+P_5'*P_5'.
$$
The same-prime term cancels only when the two readouts use exactly the same literal subtraction; the original filter and all-multiple aggregation remain. The negative interval (12) removes the proposed positive-primitive induction as a sign mechanism for these mixed terms. It gives no sign for their complete filtered sum and no conclusion about RH. Other arithmetic constraints on the full source product are not excluded by this particular failure.

## Verification scope

The linked certificate was run successfully with `python-flint==0.9.0`. It verifies the bounded interval inequalities used in this written proof; the displayed analytic tail supplies the unbounded range. Run `python -B certificates/successor_fifth_primitive.py` from this directory. No Lean formalization of these actual iterate signs is claimed.
