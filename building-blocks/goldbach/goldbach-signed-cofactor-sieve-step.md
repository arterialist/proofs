# A uniform sieve bound for the signed Goldbach cofactor step

The exact signed-cofactor successor law in
[Signed Goldbach cofactor crossings](goldbach-signed-cofactor-oscillation.md)
has an unconditional step bound smaller than its elementary
$O(\log ^2 s)$ bound. Classical interval sieve estimates give

\[
\boxed{|Q_{s+1}-Q_s|
  \ll \log (s+1)\,[\log\log(3s+3)]^2\qquad(s\ge4).}
\tag{1}
\]

This is a local regularity estimate for the actual von Mangoldt
convolution. It does not bound $Q_s$ uniformly at the RH scale.
The sieve input is classical: Montgomery and Vaughan's
[large-sieve theorem, Theorem 19.13](https://personal.science.psu.edu/rcv4/Vol2/Vol2.pdf),
which they note also follows from Selberg's $\Lambda^2$ upper sieve.
The argument below records its uniformity in the Goldbach total and
retains every proper prime power.

## The exact reduction

Set $n=s+1$, $E_t=\psi(t)-t$, $q_t=E_t/t$, and

\[
Q_s=\sum_{m=2}^{s-2}\Lambda(m)q_{s-m}.
\]

Reindexing the [exact successor identity](goldbach-signed-cofactor-oscillation.md)
with $y=n-m$ gives

\[
\begin{aligned}
Q_{s+1}-Q_s={}&\Lambda(n-2)q_2\\
 &+\sum_{y=3}^{n-2}\Lambda(n-y)
 \left\{\frac{\Lambda(y)-1}{y}
 -\frac{E_{y-1}}{(y-1)y}\right\}.
\end{aligned}
\tag{2}
\]

Define the nonnegative sums

\[
A_n=\sum_{y=3}^{n-2}\frac{\Lambda(y)\Lambda(n-y)}y,
\qquad
B_n=\sum_{y=3}^{n-2}\frac{\Lambda(n-y)}y.
\tag{3}
\]

Chebyshev's bound $\psi(t)\ll t$ implies $|E_t|\ll t$.
Consequently (2) yields the precise reduction

\[
|Q_{s+1}-Q_s|\ll \log n+A_n+B_n.
\tag{4}
\]

No sign cancellation is used in (4).

## The interval sieve, uniformly in $n$

Here is the form of [Montgomery--Vaughan, Theorem 19.13](https://personal.science.psu.edu/rcv4/Vol2/Vol2.pdf)
used below. If a nonempty set $\mathcal S$ lies in an interval of $H$
consecutive integers, and its members avoid $\delta(p)$ residue
classes modulo each prime $p\le R$, then

\[
|\mathcal S|\le
\frac{H+R^2}{G(R)},\qquad
G(R)=\sum_{d\le R}\mu^2(d)
 \prod_{p\mid d}\frac{\delta(p)}{p-\delta(p)}.
\tag{5}
\]

The avoided-class numbers may depend on $n$. We need two consequences
of (5), both with absolute implied constants. Fix an even $n$ and
an integer interval $I\subset [Y,2Y)\cap[3,n/2)$ of length $H\le Y$.
Take $R=\lfloor\sqrt Y\rfloor$ and $Y$ above a fixed absolute
threshold. Both $y$ and $n-y$ exceed $R$ for $y\in I$. Thus, if
both are prime, the forbidden classes modulo $p\le R$ are
$y\equiv0,n\pmod p$. Their number is

\[
\nu_n(p)=\begin{cases}1,&p\mid n,\\2,&p\nmid n.\end{cases}
\tag{6}
\]

Since $n$ is even, $\nu_n(2)=1$, and $\nu_n(p)<p$ for every
prime. The actual set may avoid more classes than (6); because
$u/(p-u)$ increases in $u$, replacing its actual $\delta(p)$ by
$\nu_n(p)$ weakens (5) safely. Write

\[
G_n(R)=\sum_{d\le R}\mu^2(d)
 \prod_{p\mid d}\frac{\nu_n(p)}{p-\nu_n(p)}.
\tag{7}
\]

We verify a lower bound for (7) with an absolute constant **uniform
in $n$**. Put $g_n(p)=\nu_n(p)/p$ and
$h_n(p)=g_n(p)/(1-g_n(p))$, extended multiplicatively to
squarefree integers. Choose $x=R^\eta$ for a sufficiently small
fixed $\eta>0$. Let

\[
F_n(x)=\sum_{d\mid\prod_{p\le x}p}h_n(d)
      =\prod_{p\le x}(1-g_n(p))^{-1}.
\]

Under probability weights $h_n(d)/F_n(x)$, the expected logarithm
of $d$ is

\[
\sum_{p\le x}g_n(p)\log p
\le 2\sum_{p\le x}\frac{\log p}{p}
\ll\log x.
\]

The last estimate follows from Chebyshev's $\vartheta(x)\ll x$
by partial summation. Choose $\eta$ small enough that this
expectation is at most $(\log R)/4$. Markov's inequality leaves
at least three quarters of $F_n(x)$ on $d\le R$. Hence
$G_n(R)\ge \tfrac34F_n(x)$. For even $n$,

\[
F_n(x)=2\prod_{3\le p\le x}\frac{p}{p-2}
 \prod_{\substack{3\le p\le x\\p\mid n}}
     \frac{p-2}{p-1}
\gg \frac{\phi(n)}n(\log x)^2.
\]

Indeed, Mertens' product estimate makes the first product
$\asymp(\log x)^2$, while

\[
\prod_{\substack{p\mid n\\p>2}}\frac{p-1}{p-2}
\le \frac n{\phi(n)}
 \prod_{p>2}\frac{(p-1)^2}{p(p-2)}
\ll\frac n{\phi(n)}.
\]

Because $\log x=\eta\log R$, we obtain

\[
G_n(R)\gg\frac{\phi(n)}n(\log R)^2.
\tag{8}
\]

Equations (5)--(8), $H\le Y$, and $R^2\le Y$ now give the
uniform short-interval Goldbach upper bound

\[
\boxed{\#\{y\in I:y\text{ and }n-y\text{ are prime}\}
\ll\frac n{\phi(n)}\frac{Y}{(\log Y)^2}.}
\tag{9}
\]

The same argument with one forbidden class, $g(p)=1/p$,
has $\prod_{p\le x}(1-g(p))^{-1}\asymp\log x$ and gives

\[
\boxed{\#\{y\in I:n-y\text{ is prime}\}
       \ll\frac{Y}{\log Y}.}
\tag{10}
\]

This is the interval prime upper bound often called the
$q=1$ Brun--Titchmarsh estimate. It is uniform in the position
of $I$ and in $n$.

## Dyadic sums and proper prime powers

The range $y\ge n/2$ is easy. Since $\Lambda(y)\le\log n$
and $\psi(n)\ll n$,

\[
\sum_{n/2\le y\le n-2}
 \frac{\Lambda(y)\Lambda(n-y)}y\ll\log n,
\qquad
\sum_{n/2\le y\le n-2}\frac{\Lambda(n-y)}y\ll1.
\tag{11}
\]

For $y<n/2$, use the intervals
$I_Y=[Y,2Y)\cap[3,n/2)$ with $Y=2^j$.
The last interval may be truncated; its length is still at most
$Y$, and throughout it $n-y>n/2$. Blocks below the absolute
threshold for (9)--(10) contribute $O(\log n)$ to either sum.

For the prime--prime part of $A_n$, (9),
$\Lambda(y)\le\log(2Y)$, and $\Lambda(n-y)\le\log n$
give per block

\[
\sum_{\substack{y\in I_Y\\y,n-y\text{ prime}}}
 \frac{\Lambda(y)\Lambda(n-y)}y
\ll\frac n{\phi(n)}\frac{\log n}{\log Y}.
\tag{12}
\]

Summing over dyadic $Y$ costs $\sum_{j\le\log_2n}1/j
\ll\log\log(3n)$. Thus the prime--prime part is
$O((n/\phi(n))\log n\log\log(3n))$.

If $y=p^k$ with $k\ge2$, irrespective of the other leg,

\[
\sum_{\substack{3\le y\le n-2\\y=p^k,\ k\ge2}}
 \frac{\Lambda(y)\Lambda(n-y)}y
\le\log n\sum_p\sum_{k\ge2}\frac{\log p}{p^k}
\ll\log n.
\tag{13}
\]

For the remaining case $y$ prime and $n-y=q^k$ with $k\ge2$,
we count each exponent separately. The numbers $n-y$ for
$y\in I_Y$ lie in an interval of length at most $Y$ inside
$(n/2,n]$. The mean value theorem applied to $u^{1/k}$
therefore bounds the number of possible integer bases $q$ by

\[
1+\frac{2Y}{k n^{1-1/k}}
\le1+\frac{2Y}{k\sqrt n}.
\tag{14}
\]

As $k\le\log_2n$ and $\Lambda(q^k)=\log q\le(\log n)/k$,
the total $\Lambda$ weight of proper powers $n-y$ in this block is

\[
\ll \log n\log\log(3n)+\frac{Y\log n}{\sqrt n}.
\tag{15}
\]

Multiplication by $\Lambda(y)/y\le\log(2Y)/Y$ and summation
over dyadic $Y$ gives

\[
\ll \log n\log\log(3n)
  +\frac{\log^3 n}{\sqrt n}
\ll\log n\log\log(3n).
\tag{16}
\]

Combining (11)--(16), for even $n$,

\[
A_n\ll\frac n{\phi(n)}\log n\log\log(3n).
\tag{17}
\]

For $B_n$, (10) bounds the prime part of each low-$y$
block by $O(\log n/\log Y)$. For the proper powers,
divide (15) by $Y$ and sum the dyadic blocks. With (11),

\[
B_n\ll\log n\log\log(3n).
\tag{18}
\]

When $n$ is odd, (17) has a simpler replacement. Two odd
prime powers cannot sum to $n$, so in every nonzero term of
$A_n$ one leg is $2^k$. The terms with $y=2^k$ total
$O(\log n)$ by $\sum_k2^{-k}<\infty$. If $n-y=2^k\le n/2$,
then $y\ge n/2$ and these $O(\log n)$ terms total
$O(\log^2n/n)$. There is at most one power $2^k>n/2$;
its term is $O(1)$ since $\Lambda(y)/y\le\log y/y\ll1$.
Therefore

\[
A_n\ll\log n\qquad(n\text{ odd}).
\tag{19}
\]

Finally, the standard uniform bound $n/\phi(n)\ll
\log\log(3n)$ converts (17)--(19) and (4) into (1).
For completeness, split the Euler product for $n/\phi(n)$
at $p=\log n$: Mertens bounds the factors below this cutoff
by $O(\log\log(3n))$, and the factors above it by an
absolute constant because $\omega(n)\le\log n/\log2$.

The companion oscillation note can insert (1) in
place of its quadratic step estimate to sharpen its sparse
crossing bound. This uses no new zero-free region, gives no
uniform size estimate for $Q_s$, and does not advance an RH
implication. The remaining $\log\log n$ in (17) comes from
summing the uniform short-interval sieve bound over dyadic
complementary ranges; this argument does not prove
$A_n\ll(n/\phi(n))\log n$.
