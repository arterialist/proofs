# Deleting primes from the integers: the counting error is a sum of ripples

**Status.** Theorem 1 is an exact identity with a short proof, checked by exact rational arithmetic on nine sets of primes. It is very likely classical; see the note on sources at the end. Theorem 2 is proved below in full and is unconditional. Sections 4 and 5 are numerical observations and a heuristic, labelled as such. Nothing here proves or bounds anything about zeros of $\zeta$. No Lean formalization yet.

## 1. Setting

Let $S$ be a set of primes with $\sum_{p\in S}1/p<\infty$. Let $\mathcal D$ be the set of squarefree integers $d\ge1$ all of whose prime factors lie in $S$, and put

$$
b(n)=\begin{cases}1&\text{no prime of }S\text{ divides }n\\0&\text{otherwise}\end{cases}
\qquad
N(x)=\sum_{n\le x}b(n),\qquad a=\prod_{p\in S}\left(1-\frac1p\right)>0 .
$$

Since $b(n)=\sum_{d\mid n,\ d\in\mathcal D}\mu(d)$ and $a=\sum_{d\in\mathcal D}\mu(d)/d$,

$$
R(x):=N(x)-ax=-\sum_{d\in\mathcal D}\mu(d)\left\{\frac xd\right\}. \tag{1}
$$

The series converges absolutely because $\{x/d\}=x/d$ for $d>x$. Each $d\in\mathcal D$ contributes one sawtooth of period $d$ and height $1$.

Write $D(x)=\#\{d\in\mathcal D:d\le x\}$.

## 2. Exact variance for finitely many deleted primes

**Theorem 1.** Let $S$ be a finite set of $k$ primes with product $P$. Then $R(n)$ is periodic in $n$ with period $P$, and its variance over one period is

$$
\frac1P\sum_{n=1}^{P}\left(R(n)-\overline R\right)^2=\frac{a\,(2^k-a)}{12}. \tag{2}
$$

*Proof.* $N(n+P)=N(n)+\varphi(P)$ and $aP=\varphi(P)$, so $R$ has period $P$. For $1\le m\le P-1$ put $\widehat R(m)=\frac1P\sum_{n=1}^{P}R(n)e(-mn/P)$ with $e(t)=e^{2\pi it}$. Since $R(n)-R(n-1)=b(n)-a$ and $\sum_{n}e(-mn/P)=0$,

$$
\left(1-e(-m/P)\right)\widehat R(m)=\frac1P\sum_{\substack{n=1\\(n,P)=1}}^{P}e(-mn/P)=\frac{\mu(q)\,\varphi(P)}{P\,\varphi(q)},\qquad q=\frac{P}{(m,P)},
$$

by Hölder's evaluation of the Ramanujan sum. Writing $m/P=j/q$ with $(j,q)=1$ and using Parseval,

$$
\frac1P\sum_{n=1}^{P}\left(R(n)-\overline R\right)^2=\sum_{m=1}^{P-1}|\widehat R(m)|^2
=a^2\sum_{\substack{q\mid P\\q>1}}\frac{1}{\varphi(q)^2}\sum_{\substack{1\le j<q\\(j,q)=1}}\frac{1}{4\sin^2(\pi j/q)} .
$$

From $\sum_{j=1}^{q-1}\csc^2(\pi j/q)=(q^2-1)/3$ and Möbius inversion, the inner sum is $J_2(q)/12$ with $J_2(q)=q^2\prod_{p\mid q}(1-p^{-2})$. Since $J_2(q)/\varphi(q)^2=\prod_{p\mid q}\frac{p+1}{p-1}$,

$$
\frac1P\sum_{n=1}^{P}\left(R(n)-\overline R\right)^2=\frac{a^2}{12}\left(\prod_{p\in S}\frac{2p}{p-1}-1\right)=\frac{2^ka-a^2}{12}. \qquad\blacksquare
$$

The proof shows more than (2). The frequency $j/q$ carries energy $a^2/(4\varphi(q)^2\sin^2(\pi j/q))$ when $q\in\mathcal D$ and zero energy otherwise. Deleting one more prime $p$ multiplies the leading term $2^ka$ by $2(1-1/p)$.

[sifted_integers_exact_variance.py](../../certificates/prime-birth/sifted_integers_exact_variance.py) confirms (2) in exact fractions for $S=\{2\},\{3\},\{2,3\},\{3,7\},\{2,3,5\},\{3,7,13\},\{2,3,5,7\},\{5,11,13,17\},\{2,3,5,7,11\}$.

## 3. A lower bound on windows, for infinite $S$

The period $P$ is far larger than any $x$ of interest once $S$ is large, so Theorem 1 does not say what happens on $[X,2X]$. The next result does, for the ripples with small $q$.

**Theorem 2.** Suppose $D(x)\le Cx^\theta$ for all $x\ge1$, with $C\ge1$ and $0\le\theta<1$. For $X\ge1$ put

$$
Q=\left(\frac{a(1-\theta)}{72\,C}\,X^{1-\theta}\right)^{1/2}.
$$

Then

$$
\frac1X\int_X^{2X}R(u)^2\,du\ \ge\ \frac{a^2}{24\pi^2}\left(D(Q)-1\right). \tag{3}
$$

**Corollary 1.** If in addition $S$ is infinite, then $\frac1X\int_X^{2X}R^2\to\infty$, so $R$ is unbounded. If $S$ is finite, $R$ is bounded by $2^{|S|}$. Under the hypothesis of Theorem 2, the counting error of the $S$-free integers is bounded exactly when $S$ is finite.

**Corollary 2.** If $R(x)=O(x^\beta)$ then $D(y)=O\left(y^{4\beta/(1-\theta)}\right)$. In particular, if $D(y)\ge y^{\theta-\varepsilon}$ for large $y$, then $\beta\ge\theta(1-\theta)/4-\varepsilon$.

*Proof of Theorem 2.* Three steps.

*Step 1, sizes.* Partial summation gives $\sum_{d\in\mathcal D,\ d>y}1/d\le\int_y^\infty D(t)t^{-2}dt\le Cy^{\theta-1}/(1-\theta)$. With (1),

$$
|R(x)|\le D(x)+x\sum_{d>x}\frac1d\le C_1x^\theta,\qquad C_1=\frac{C(2-\theta)}{1-\theta}.
$$

*Step 2, an exponential sum.* Fix $q\in\mathcal D$, $q>1$, and let $T_q(x)=\sum_{n\le x}b(n)e(n/q)$. Then

$$
T_q(x)=\sum_{\substack{d\in\mathcal D\\d\le x}}\mu(d)\sum_{m\le x/d}e(dm/q).
$$

If $q\nmid d$ the inner sum is at most $1/(2\|d/q\|)\le q/2$ in absolute value. If $q\mid d$ it equals $\lfloor x/d\rfloor$, and $d=qm$ with $m\in\mathcal D$, $(m,q)=1$, $\mu(d)=\mu(q)\mu(m)$. Since $\sum_{m\in\mathcal D,(m,q)=1}\mu(m)/m=aq/\varphi(q)$,

$$
T_q(x)=\frac{\mu(q)\,a\,x}{\varphi(q)}+E_q(x),\qquad |E_q(x)|\le\frac q2D(x)+D\left(\frac xq\right)+\frac xq\sum_{m>x/q}\frac1m\le C_2\,q\,x^\theta,\quad C_2=\frac{3C}{1-\theta}.
$$

*Step 3, from $T_q$ to $R$.* With $N(u)=au+R(u)$ and integration by parts,

$$
T_q(2X)-T_q(X)=a\int_X^{2X}e(u/q)\,du+\Big[R(u)e(u/q)\Big]_X^{2X}-\frac{2\pi i}{q}\int_X^{2X}R(u)e(u/q)\,du .
$$

Put $I_q=\int_X^{2X}R(u)e(u/q)\,du$. The first term on the right is at most $aq/\pi$. Hence, for $q\le Q$,

$$
|I_q|\ \ge\ \frac{1}{2\pi}\left(aX-4C_2q^2X^\theta-\frac{aq^2}{\pi}-4C_1qX^\theta\right)\ \ge\ \frac{aX}{4\pi},
$$

because the choice of $Q$ gives $4C_2Q^2X^\theta=aX/6$, $Q^2\le X/72$ and $C_1\le C_2$.

*Step 4, the large sieve.* For real numbers $\lambda_1,\dots,\lambda_J$ with $|\lambda_i-\lambda_j|\ge\delta$ for $i\ne j$ and $f\in L^2[X,2X]$,

$$
\sum_{j}\left|\int_X^{2X}f(u)e(\lambda_ju)\,du\right|^2\le\left(X+\frac1\delta\right)\int_X^{2X}|f|^2 .
$$

This is the dual form of the Montgomery and Vaughan inequality $\int_X^{2X}|\sum_jc_je(\lambda_ju)|^2du\le(X+\delta^{-1})\sum|c_j|^2$. Apply it to $f=R$ and the frequencies $1/q$, $q\in\mathcal D$, $1<q\le Q$, which satisfy $|1/q-1/q'|\ge1/Q^2$. Then

$$
\left(D(Q)-1\right)\left(\frac{aX}{4\pi}\right)^2\le\left(X+Q^2\right)\int_X^{2X}R^2\le\frac{3X}{2}\int_X^{2X}R^2,
$$

which is (3). $\blacksquare$

*Remarks.*

1. Without the growth hypothesis, $\sum_{p\in S}1/p<\infty$ still gives $D(x)=o(x)$, and the same four steps with $o(X)$ error terms and any fixed finite set of $q$ give $\frac1X\int_X^{2X}R^2\to\infty$ for every infinite $S$. This version is a sketch; the error terms are not written out.
2. The range $Q\approx X^{(1-\theta)/2}$ comes from the crude bound $q/2$ for the non-resonant sums in Step 2. Averaging that bound over $q$ with the divisor bound should reach $Q\approx X^{(1-\theta)/(2-\theta)}$. That is not proved here.
3. The same argument applies to weights. If the prime $p$ is deleted with weight $w_p\in[0,1]$, so that $b=1*h$ with $h(d)=\mu(d)\prod_{p\mid d}w_p$, the frequency $1/q$ carries amplitude proportional to $\prod_{p\mid q}w_p$, and the energy is a sum of squared weights. This is not written out.

## 4. Numerical checks

[sifted_integers_ripple_amplitudes.py](../../certificates/prime-birth/sifted_integers_ripple_amplitudes.py), $X=10^7$, a set $S$ of $2669$ primes up to $2\times10^7$ with $a=0.451994$. After a cubic trend is removed from $R$ on $[X,2X]$:

| $q$ | in $\mathcal D$ | measured $\frac1X\lvert\sum R(n)e(n/q)\rvert$ | predicted $\frac{a}{2\varphi(q)\sin(\pi/q)}$ |
| --- | --- | --- | --- |
| 3 | yes | 0.13046 | 0.13048 |
| 7 | yes | 0.08681 | 0.08681 |
| 13 | yes | 0.07866 | 0.07870 |
| 21 | yes | 0.12630 | 0.12636 |
| 161 | yes | 0.08756 | 0.08775 |
| 251 | yes | 0.07196 | 0.07223 |
| 5077 | yes | 0.07058 | 0.07195 |
| 2, 5, 11, 6, 9, 30 | no | at most 0.00011 | 0 |

At $q=77681$ the measurement is $0.194$ against $0.072$; residual drift contaminates frequencies that low.

The variance of the detrended $R$ on $[X,2X]$ equals $\frac{a^2}{12}\sum_{q\in\mathcal D,\ q\le cX}\prod_{p\mid q}\frac{p+1}{p-1}$ with $c\approx0.25$ for the regularly spaced $S$ above, and with $c$ between $2$ and $4$ for a random $S$ of the same density. The cutoff $c$ is not explained.

## 5. The sieve of Eratosthenes in this language (heuristic)

Take $S=\{p\le\sqrt X\}$. The $S$-free integers in $(\sqrt X,X]$ are the primes in that range, so (1) is Legendre's formula and $R(x)=\pi(x)-\pi(\sqrt X)+1-ax$ with $a\sim2e^{-\gamma}/\log X$. Here $\theta=1$ and Theorem 2 says nothing.

If every sawtooth with $q\le x$ contributed its own energy and nothing else, the variance of $R$ near $x$ would be

$$
\frac{a^2}{12}\sum_{\substack{q\le x\ \text{squarefree}\\ \text{all } p\mid q \text{ at most }\sqrt x}}\ \prod_{p\mid q}\frac{p+1}{p-1}\ \approx\ \frac{4e^{-2\gamma}}{12}\cdot\frac{\zeta(2)}{\zeta(4)}\,(1-\log2)\,\frac{x}{\log^2x}\ \approx\ 0.0490\,\frac{x}{\log^2x}.
$$

The Riemann hypothesis with simple zeros gives a long-run mean square of $(\psi(x)-x)/\sqrt x$ equal to $2+\gamma-\log4\pi\approx0.0462$, which corresponds to $0.0462\,x/\log^2x$ for the prime count. [sieve_ripple_energy_count.py](../../certificates/prime-birth/sieve_ripple_energy_count.py) confirms the two constants in the count ($0.461X$ against $0.4664X$ for the weighted sum at $X=10^8$, and $a=0.060885$ against $0.060960$). On the single windows $[X/2,X]$ the measured mean of $(\psi(x)-x)^2/x$ is $0.040$ at $X=10^7$ and $0.034$ at $X=10^8$.

So counting ripples independently gives the size that the Riemann hypothesis predicts for the fluctuation of the primes, with a constant within about $6\%$ of the long-run value. This is a comparison of two numbers. It is not a derivation, and the agreement of the constants may be a coincidence. If the Riemann hypothesis fails, the true fluctuation exceeds $x^{1/2+\delta}$ infinitely often and the sawtooth terms with $dd'>x$ must then add coherently. Theorem 2 controls those terms only when $\mathcal D$ is sparse.

## Sources and priority

The function $\Delta(x,N)=\#\{n\le xN:(n,N)=1\}-x\varphi(N)$ is the same object as $R$ for finite $S$, with $N=P$. D. H. Lehmer studied it in *The distribution of totatives* (Canad. J. Math., 1955). P. Codecà and M. Nair, *Extremal values of $\Delta(x,N)$* (Canad. Math. Bull. 41, 1998, [doi:10.4153/CMB-1998-046-3](https://doi.org/10.4153/CMB-1998-046-3)), bound $\sup_x|\Delta(x,N)|$; a search on 11 November 2026 returned excerpts of that paper that appear to contain the quantity $\frac1{12}2^{\omega(N)}\varphi(N)/N$, and its abstract links averages of $\Delta(x,N)$ to the Riemann hypothesis through Franel's theorem. The full text was not read. Theorem 1 should therefore be treated as known. No claim of priority is made for Theorem 2 either; no search for it was done beyond the one above.

The large sieve inequality in Step 4 is from H. L. Montgomery and R. C. Vaughan, *Hilbert's inequality* (J. London Math. Soc., 1974).
