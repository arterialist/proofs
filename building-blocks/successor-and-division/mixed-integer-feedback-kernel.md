# The two-integer feedback kernel, its contact, and the literal seed

Retain the actual birth masses
$$
 q^0(u,x)=
 \begin{cases}
 u^{-1/2}\arcsin\sqrt{u/x},&0<u<x,\\
 \pi/(2\sqrt u),&u\ge x,
 \end{cases}
 \qquad q^0(0,x)=x^{-1/2},
$$
and
$$
 q_0(n)=n^{-1/2},\qquad
 q_j(n)=j^{-1/2}\arctan
       \sqrt{\frac{j}{\max(1,n-j)}}\quad(j\ge1).
 \tag{1}
$$
The physical boundary at one and every integer clock are retained.
The original arithmetic birth index is $n\ge2$. We also use the
literal extension to $n=1$, explicitly, when recording the seed.

Define
$$
 H^0(j,n)=q^0(j+1,n+1)-q^0(j,n+1)
                         -q^0(j+1,n)+q^0(j,n),
$$
and define $H(j,n)$ by the same formula with $q_j$.
There is an exact sign pattern:
$$
 \boxed{
 \begin{array}{lll}
 H^0(j,n)<0& (0\le j<n),&
 H^0(n,n)=b_n>0,\quad H^0(j,n)=0\ (j>n),\\
 H(j,n)<0& (0\le j\le n-2),&
 H(n-1,n)=d_n>0,\quad H(j,n)=0\ (j\ge n),
 \end{array}}
 \tag{2}
$$
where
$$
 b_n=\frac{\arctan(n^{-1/2})}{\sqrt n},\qquad
 d_n=\frac12\int_n^{n+1}\frac{dx}{x\sqrt{x-n+1}}>0.
 \tag{3}
$$
For $n=1$, the negative range in the second line is empty and
$d_1=1-1/\sqrt2$.

## 1. The cusp and the boundary return are separate contacts

Put $K_j^0(n)=q^0(j,n)-q^0(j,n+1)$. For $0\le j\le n$,
$$
 K_j^0(n)=\frac12\int_n^{n+1}\frac{dx}{x\sqrt{x-j}},
 \qquad K_j^0(n)=0\quad(j\ge n+1).
 \tag{4}
$$
The endpoint integral at $j=n$ is finite and equals $b_n$.
For $0\le j<n$, this expression increases strictly with $j$.
More explicitly,
$$
 H^0(j,n)
 =-\frac14\int_j^{j+1}\int_n^{n+1}
                   \frac{dx\,du}{x(x-u)^{3/2}}<0.
 \tag{5}
$$
At $j=n-1$, the double integral remains finite: near its corner
the possible singularity is bounded by a constant times
$(s+t)^{-3/2}$, which is integrable over a two-dimensional square.
At $j=n$, the drop from $K_n^0=b_n$ to $K_{n+1}^0=0$
gives the positive contact in (2). Thus the off-diagonal negative
mixed derivative is not a global negative mixed measure.

The literal return is exactly
$$
 q_j(n)=q^0(j,n)-b_j\mathbf1_{j\ge n}.
$$
Taking both integer differences gives
$$
 \boxed{H(j,n)=H^0(j,n)
                  +b_n\mathbf1_{j=n-1}-b_n\mathbf1_{j=n}.}
 \tag{6}
$$
The old diagonal contact cancels. The new contact has size
$$
 H(n-1,n)=K_{n-1}^0(n)=d_n.
$$
Equivalently the literal $K_j(n)=q_j(n)-q_j(n+1)$ is strictly
positive and strictly increasing for $0\le j\le n-1$, then is
zero for $j\ge n$. In particular $q_n(n)=q_n(n+1)$.
The plateau condition must be applied to both $n$ and $n+1$;
it does not move the contact to $j=n-2$.

## 2. Exact row and column sums

Write $u_j(n)=q_{j+1}(n)-q_j(n)$. For finite integers $J,K$,
$$
 \sum_{j=0}^J H(j,n)=K_0(n)-K_{J+1}(n),\qquad
 \sum_{n=1}^K H(j,n)=u_j(K+1)-u_j(1).
 \tag{7}
$$
The corresponding statements hold with superscript zero.
In particular
$$
 \boxed{\sum_{j\ge0}H(j,n)
          =n^{-1/2}-(n+1)^{-1/2}>0.}
 \tag{8}
$$
The column is not conservative without its initial boundary term.

For the literal seed put
$$
 z_0=1,\qquad z_i=q_i(1)=\frac{\arctan\sqrt i}{\sqrt i},
 \qquad f_i=z_{i-1}-z_i>0\quad(i\ge1).
$$
These are exactly the already established renewal interarrival
probabilities; $z_i\to0$ and $\sum_{i\ge1}f_i=1$.
Since $u_j(n)\to0$ as $n\to\infty$,
$$
 \boxed{\sum_{n\ge1}H(j,n)=f_{j+1}.}
 \tag{9}
$$
These row sums are absolutely convergent, by (2) and the finite
positive contact. If only the original births $n\ge2$ are
included, the missing column is explicit:
$$
 H(j,1)=d_1\mathbf1_{j=0}.
 \tag{10}
$$
Thus the first row over $n\ge2$ has sum
$f_1-d_1=1/\sqrt2-\pi/4<0$; later rows retain the sum $f_{j+1}$.
No artificial arithmetic birth at one is introduced.

For comparison, the unreturned rows have
$$
 \sum_{n\ge1}H^0(0,n)=1-\pi/2,\qquad
 \sum_{n\ge1}H^0(j,n)
       =\frac\pi2(j^{-1/2}-(j+1)^{-1/2})\quad(j\ge1).
$$
Formula (6) converts these exactly to (9).

## 3. A killed upward generator, with the seed specified

Reindex the clock by $i=j+1$ and define, on states $i,n\ge1$,
$$
 \mathsf L_{i,n}=-H(i-1,n).
$$
Then
$$
 \mathsf L_{i,i}=-d_i,\quad
 \mathsf L_{i,n}>0\ (n>i),\quad
 \mathsf L_{i,n}=0\ (n<i),\qquad
 \sum_{n\ge1}\mathsf L_{i,n}=-f_i.
 \tag{11}
$$
Also
$$
 d_i\le\frac12\log(1+1/i)\le\frac1{2i}.
$$
Consequently this is a bounded upward generator with killing,
not a conservative generator on the positive integers.
Adding one absorbing state $0$, with
$\mathsf L_{i,0}=f_i$ and $\mathsf L_{0,n}=0$, makes it
conservative. All rates remain nonnegative off the diagonal.
Even $I+\mathsf L$ on this extended state space is a genuine
stochastic matrix, because $d_i<1$.

For a bounded sequence $G$, with absorbing value $G(0)=0$,
$$
 (\mathsf LG)(i)
 =\sum_{n>i}\mathsf L_{i,n}(G(n)-G(i))-f_iG(i).
 \tag{12}
$$
The upward transport and the seed killing are separate terms.
This construction is not reversible or doubly stochastic.
For example its positive-integer column sum is
$-n^{-1/2}+(n+1)^{-1/2}$, by (8).

There is also an exact feedback pairing with the actual cumulative
prime-power source. For $0<r<1$,
$$
 \boxed{
 E(r)=\sum_{n\ge2}\Lambda(n)W_r(n)
      =\sum_{i\ge1}r^{i-1}(\mathsf L\psi)(i),
 \quad
 W_r(n)=\sum_{j\ge0}r^ju_j(n).
 }
 \tag{13}
$$
Here $\psi(1)=0$, so (10) does not alter the arithmetic readout.
Indeed $u_j(n)=-\sum_{a\ge n}H(j,a)$; summing the admitted
$\Lambda(n)$ first gives $-\sum_aH(j,a)\psi(a)$.

All exchanges in (13) are absolute for fixed $r$.
One direct check uses Chebyshev's $\psi(a)\le Ca$.
For a row $i$, the portion $a\le2i$ has
$\sum|H(i-1,a)|\le2d_i\le1/i$, hence weighted cost $O(1)$.
For $a>2i$, (5) applies and gives $O(a^{-5/2})$, whose
$\psi$-weighted tail is $O(i^{-1/2})$.
The geometric clock weights therefore sum these absolute costs.
Formula (12) with $G=\psi$ displays (13) as a nonnegative
future-birth flux minus the nonnegative killing term
$\sum_i r^{i-1}f_i\psi(i)$. Their difference has not been signed.

## 4. The actual factorial primitive and both terminal terms

Use the exact positive arithmetic primitive
$$
 F_n=\log n-\sum_{k\le n}\frac{\Lambda(k)}k+\frac{\psi(n)}n,
 \qquad F_1=0.
$$
The complete factorial identity gives
$$
 F_n=\log n-\frac{\log(n!)}n
       +\frac1n\sum_{k\le n}\Lambda(k)
                          \left(1-\left\{\frac nk\right\}\right)>0
 \quad(n\ge2).
 \tag{14}
$$
In particular $F_2=\log2$. Integral bounds for $\log(n!)$
and Chebyshev's bound give $F_n=O(1)$.
This preserves all prime powers and the endpoint $k=n$.

Its exact adjacent difference is
$$
 F_{n+1}-F_n
 =\ell_n-\frac{\psi(n)}{n(n+1)},\qquad
 \ell_n=\log(1+1/n).
 \tag{15}
$$
The newly admitted $\Lambda(n+1)$ cancels in this difference;
the remaining $\psi(n)$ is not replaced by its density.
Put
$$
 a_n(r)=n(n+1)[W_r(n+1)-W_r(n)]
       =n(n+1)\sum_{j\ge0}r^jH(j,n).
$$
The latter geometric sum has the equivalent exact expression
$$
 \sum_{j\ge0}r^jH(j,n)
 =K_0(n)-(1-r)\sum_{j\ge1}r^{j-1}K_j(n).
 \tag{16}
$$
In particular its initial $K_0(n)$ is not optional.

Two finite summations by parts, with $F_1=\psi(1)=0$, give
$$
 \boxed{\begin{aligned}
 \sum_{n=2}^K\Lambda(n)W_r(n)
 ={}&\psi(K)W_r(K)-\sum_{n=1}^{K-1}a_n(r)\ell_n\\
    &+a_{K-1}(r)F_K
      +\sum_{n=2}^{K-1}[a_{n-1}(r)-a_n(r)]F_n .
 \end{aligned}}
 \tag{17}
$$
Both terminal terms are displayed before any limit.

For fixed $r<1$, the exact early-clock derivative in (5),
followed by the geometric tail, gives
$$
 W_r(n)=O_r(n^{-3/2}),\qquad
 a_n(r)=-\frac{n^{-1/2}}{4(1-r)}+O_r(n^{-3/2}).
 \tag{18}
$$
For the second assertion, use
$H(j,n)=-\tfrac14n^{-5/2}
 +O((j+1)n^{-7/2})$ when $j+1\le n/2$;
the remaining histories have an exponentially small clock weight.
The contacts and literal returns are included in that remaining
finite triangular part.
Thus $a_{n-1}-a_n=O_r(n^{-3/2})$. All series below converge
absolutely, and the two terminal terms in (17) vanish. The full
factorial pairing is therefore
$$
 \boxed{
 E(r)=-\sum_{n\ge1}a_n(r)\ell_n
          +\sum_{n\ge2}[a_{n-1}(r)-a_n(r)]F_n .
 }
 \tag{19}
$$
No continuum term or initial cell has been omitted.

## 5. The exact remaining sign obstruction

The actual positivity of $F$ does not make it superharmonic for
(11). Since $F_1=0$ and every off-diagonal first-row rate is
strictly positive,
$$
 (\mathsf LF)(1)
   =\sum_{n>1}\mathsf L_{1,n}F_n
   \ge\mathsf L_{1,2}\log2>0.
 \tag{20}
$$
This is an actual source-specific obstruction, not an arbitrary
test function for a generic generator.

The coefficients in the full pairing (19) also have opposite signs
already at the endpoint $r=0$, to which every fixed coefficient
extends analytically. Here
$$
 a_1(0)=2(1-1/\sqrt2)>0,\qquad a_n(0)<0\quad(n\ge2).
$$
For $n\ge2$,
$$
 W_0(n)=\arcsin(n^{-1/2})-n^{-1/2}
       =\sum_{\ell\ge1}
       \frac{\binom{2\ell}{\ell}}{4^\ell(2\ell+1)}
                         n^{-\ell-1/2}.
$$
For every $s\ge3/2$, the function
$$
 b_s(x)=x(x+1)[x^{-s}-(x+1)^{-s}]
       =s\int_0^1\frac{x(x+1)}{(x+t)^{s+1}}\,dt
$$
is strictly decreasing on $x\ge2$. Indeed its integrand has
logarithmic derivative at most
$1/x-s/(x+1)\le0$, with strict inequality except for an
irrelevant endpoint case. Each positive series term therefore
makes $a_n(0)$ strictly increase for $n\ge2$.
It follows that
$$
 a_1(0)-a_2(0)>0,\qquad
 a_{n-1}(0)-a_n(0)<0\quad(n\ge3).
 \tag{21}
$$
In particular the first two opposite signs persist for every
sufficiently small actual $r>0$, by continuity.
This rules out a one-sign factorial coefficient argument on the
whole clock range.

The bounded outcome is (2), (6)–(13), and the exact complete
pairing (19): the mixed kernel contains a shifted positive contact,
an upward transport part, and precisely the seed's renewal killing.
Conservativity holds only with the absorbing state retained.
Neither this structure nor $F_n>0$ supplies the missing sign of
the full feedback $E(r)$. No arithmetic-side interpolation
inequality or RH inference is asserted here.


## Dependencies and formal scope

The [actual feedback kernel](successor-feedback-arithmetic-kernel.md) supplies the literal birth coefficients. The [exact renewal seed](../factorial-and-renewal/exact-seed-renewal-asymptotic.md) identifies the killing probabilities, and the [factorial-potential interpolation](../factorial-and-renewal/factorial-potential-integer-interpolation.md) preserves a different exact nodal pairing. Finite summation by parts and the absorbing-state completion of a killed generator are classical constructions. This chapter gives their actual arithmetic specialization, with both terminal terms and the signed source readout retained. It contains written proofs, not a Lean formalization or a sign theorem for $E(r)$.
