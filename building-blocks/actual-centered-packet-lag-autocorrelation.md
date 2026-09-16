# Actual finite Goldbach packets realize both late autocorrelation phases

The late-cell renewal primitive has a negative pairing with every
nonnegative decreasing convex test. This note checks that shape premise
against the derivative autocorrelation of the **actual** finite centered
Goldbach packet. Its far-lag phase changes with the terminal prime
error, even though each packet has a nonnegative heat Gram. The result
does not rule out an inequality using the complete uncut response and
its causal history.

For integer $N\ge2$, retain every prime power and the initial
$a_1=-1$ in
\[
a_n=\Lambda(n)-1\quad(1\le n\le N),\qquad
D_N(t)=\sum_{n\le N}a_ne^{-nt},\qquad
d_N(v)=e^{-v/2}D_N(e^{-v}).
\tag{1}
\]
The [direct moving-core readout](actual-moving-core-centered-heat-gram.md#direct-finite-goldbach-readout-without-a-terminal-atom) measures
$\|d_N\|_2^2=\sum_{m,n\le N}a_ma_n/(m+n)\ge0$ without inserting a
compensating terminal atom. Nevertheless its lag autocorrelation
$C_N(s)=\int_{\mathbb R}d_N(v+s)d_N(v)\,dv$ has the exact finite formula
\[
\boxed{\quad
C_N(s)=e^{-s/2}\sum_{n,m\le N}
                 \frac{a_na_m}{m+n e^{-s}},\qquad s\ge0.
\quad}
\tag{2}
\]
Indeed $t=e^{-v}$ turns the integral into
$e^{-s/2}\sum_{n,m}a_na_m\int_0^\infty
 e^{-(m+n e^{-s})t}dt$. All sums are finite, so this retains every
additive cross term and needs no limiting interchange.

Define the two literal packet endpoints
\[
E_N=\sum_{n\le N}a_n=\psi(N)-N,
\qquad L_N=\sum_{n\le N}\frac{a_n}{n}.
\tag{3}
\]
Since the rational function in (2) is analytic at $e^{-s}=0$,
\[
e^{s/2}C_N(s)=E_NL_N+O_N(e^{-s}).
\tag{4}
\]
The smooth packet and all its derivatives decay superexponentially at
$v\to-\infty$ and exponentially at $v\to+\infty$. Differentiation
followed by integration by parts therefore gives, for $f_N=d_N'$,
$C_{f_N}(s):=\int f_N(v+s)f_N(v)dv=-C_N''(s)$. Differentiating (2)
also yields
\[
\boxed{\quad
e^{s/2}C_{f_N}(s)=-\tfrac14E_NL_N+O_N(e^{-s}),
\qquad
e^{s/2}[-C_{f_N}'(s)]=-\tfrac18E_NL_N+O_N(e^{-s}).
\quad}
\tag{5}
\]
The latter is the type of lag weight multiplying $J-\ell$ before
integration by parts in the renewal derivative-energy pairing.

For completeness, the sign of $L_N$ is eventually fixed. Put
$A(x)=\sum_{n\le x}a_n=E(x)+\{x\}$. The unconditional
zero-free-region prime number theorem gives
$A(x)=O(xe^{-c\sqrt{\log x}})+O(1)$, so partial summation makes
$L_N$ converge. For $\Re z>1$ its Dirichlet series is exactly
\[
\sum_{n\ge1}\frac{a_n}{n^z}
=-\frac{\zeta'(z)}{\zeta(z)}-\zeta(z).
\tag{6}
\]
The convergent partial-summation integral permits passage to $z=1$.
The Laurent expansion
$\zeta(1+h)=h^{-1}+\gamma+O(h)$ then gives
\[
\boxed{\quad L_N\longrightarrow-2\gamma<0.\quad}
\tag{7}
\]
Littlewood's unconditional two-sided oscillation of $E(x)$ supplies
infinitely many integer $N$ with $E_N>0$ and infinitely many with
$E_N<0$: between consecutive integers $E(x)=E(\lfloor x\rfloor)
-(x-\lfloor x\rfloor)$, so integer sampling changes its value by
less than one. By (5)--(7), $C_{f_N}(s)$ is eventually positive for
each sufficiently large packet with $E_N>0$, and eventually negative
for each sufficiently large packet with $E_N<0$. In the latter case
the weight $-C_{f_N}'(s)$ is eventually negative too.

The lag threshold depends on $N$. In particular this does not assert
a negative test inside $0\le s\le\log N$, nor identify $f_N$ with
the tuned causal derivative $h_\beta'$ of the uncut heat response.
It does show that positive finite Goldbach Grams and the exact
late-cell phase theorem cannot, by themselves, put even the actual
centered finite-packet derivative autocorrelation in the required
nonnegative-convex cone. The terminal value $E_N=D_N(0)$ is precisely
the coefficient of $e^{-v/2}$ in the packet's right heat tail; it
controls the far-lag phase instead of disappearing from it.
