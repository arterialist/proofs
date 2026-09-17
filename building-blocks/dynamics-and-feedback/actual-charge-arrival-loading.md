# Actual charge-arrival loading and exact seeded work

This written arithmetic proof keeps the full unit-cell density integral, the initial seed and every proper prime power. It uses classical quantitative PNT and Abelian integration; no theorem here is formalized in Lean.

The actual finite-source charge is
$$
M_N=1+\sum_{n\le N}\frac{\Lambda(n)}{\sqrt n}-2\sqrt N,
\qquad M_1=-1.
$$
Its exact integer arrival is
$$
\boxed{m_n=M_n-M_{n-1}
=\frac{\Lambda(n)}{\sqrt n}
       -2(\sqrt n-\sqrt{n-1}),\qquad n\ge2.}
\tag{1}
$$
The second term is the full integral of $t^{-1/2}$ over the cell $[n-1,n]$. It is not replaced by a point sample.

We prove
$$
\boxed{\sum_{n=2}^N m_n^2
=\frac12\log^2N-\log N+C_m+o(1),}
\tag{2}
$$
with an explicit convergent constant below. The seeded signed charge work is then exact. No bound for $M_N$ is assumed or deduced.

## 1. The exact density-ramp correction

Put
$$
r_n=2(\sqrt n-\sqrt{n-1})
=\frac{2}{\sqrt n+\sqrt{n-1}}
=\frac1{\sqrt n}+\epsilon_n,
$$
where
$$
\boxed{\epsilon_n=
\frac1{\sqrt n(\sqrt n+\sqrt{n-1})^2}>0.}
\tag{3}
$$
Thus $\epsilon_n=O(n^{-3/2})$ and
$$
m_n=\frac{\Lambda(n)-1}{\sqrt n}-\epsilon_n.
$$
Squaring before summing retains the signed density interaction:
$$
m_n^2=\frac{\Lambda(n)^2}{n}
       -\frac{2\Lambda(n)}n+\frac1n
       -\frac{2(\Lambda(n)-1)\epsilon_n}{\sqrt n}
       +\epsilon_n^2.
\tag{4}
$$
The exact ramp correction
$$
\boxed{C_{\rm ramp}
=\sum_{n=2}^\infty
 \left[-\frac{2(\Lambda(n)-1)\epsilon_n}{\sqrt n}
                       +\epsilon_n^2\right]}
\tag{5}
$$
is absolutely convergent. Its tail is $O(\log N/N)$, even using only
$\Lambda(n)\le\log n$. The sum begins at 2: the initial charge is the distinct seed $-1$, not a density cell with lower endpoint zero.

Equivalently, the summand in (5) is
$$
-\frac{2(\Lambda(n)-1)}
 {n(\sqrt n+\sqrt{n-1})^2}
+\frac1{n(\sqrt n+\sqrt{n-1})^4}.
$$
This preserves every prime power and the no-arrival cells without assigning a sign to the whole correction.

## 2. Establishing the constants from actual PNT, before identifying them

Let $E(t)=\psi(t)-t$. Use the established unconditional envelope
$$
|E(t)|\le Ct e^{-c\sqrt{\log t}},\qquad t\ge1,
\tag{6}
$$
with constants enlarged on the initial range. For this classical input see Trudgian, [*Updating the error term in the prime number theorem*, Theorem 1](https://arxiv.org/pdf/1401.2689), enlarging constants on a bounded initial interval.

Define
$$
A_1(N)=\sum_{n=2}^N\frac{\Lambda(n)}n,\qquad
A_2(N)=\sum_{n=2}^N\frac{\Lambda(n)\log n}{n}.
$$
Exact Stieltjes integration on $(1,N]$, using $E(1)=-1$, gives
$$
\boxed{A_1(N)-\log N
=\frac{E(N)}N+1+\int_1^N\frac{E(t)}{t^2}\,dt,}
\tag{7}
$$
$$
\boxed{A_2(N)-\frac12\log^2N
=\frac{E(N)\log N}{N}
-\int_1^N E(t)\frac{1-\log t}{t^2}\,dt.}
\tag{8}
$$
The lower term vanishes in (8) because $\log1=0$; it does not vanish in (7).
The integrals converge absolutely at infinity by (6). Thus the constant limits in these equations are established directly from actual arithmetic, independently of Laurent coefficients.

Write $\gamma$ for Euler's constant and use the [Stieltjes convention in DLMF §25.2(i)](https://dlmf.nist.gov/25.2#i):
$$
\zeta(1+s)=s^{-1}+\gamma-\gamma_1s+O(s^2).
\tag{9}
$$
The constants just proved to exist can now be identified by real Abelian integration. If $A_1(e^u)=u+c_1+o(1)$, then
$$
-\frac{\zeta'(1+s)}{\zeta(1+s)}
=s\int_0^\infty e^{-su}A_1(e^u)\,du
=s^{-1}+c_1+o(1).
$$
The Laurent expansion identifies $c_1=-\gamma$. Similarly,
$$
\left(\frac{\zeta'}{\zeta}\right)'(1+s)
=s\int_0^\infty e^{-su}A_2(e^u)\,du
=s^{-2}+c_2+o(1),
$$
and (9) gives $c_2=-\gamma^2-2\gamma_1$. These Abelian passages use the already established bounded remainders in (7)–(8); they do not infer summatory asymptotics from a Laurent expansion alone.

All prime-power corrections in replacing $\Lambda(n)\log n$ by $\Lambda(n)^2$ are explicit:
$$
\Lambda(p^k)\log(p^k)-\Lambda(p^k)^2
=(k-1)(\log p)^2.
$$
Therefore
$$
\begin{aligned}
\sum_{n=2}^N\frac{\Lambda(n)^2}{n}
&=A_2(N)
-\sum_{\substack{p^k\le N\\k\ge2}}
            \frac{(k-1)(\log p)^2}{p^k},\\
\sum_{p}\sum_{k\ge2}\frac{(k-1)(\log p)^2}{p^k}
&=\sum_p\frac{(\log p)^2}{(p-1)^2}<\infty.
\end{aligned}
\tag{10}
$$
In particular
$$
\boxed{\sum_{n=2}^N\frac{\Lambda(n)^2}{n}
=\frac12\log^2N-\gamma^2-2\gamma_1
-\sum_p\frac{(\log p)^2}{(p-1)^2}+o(1).}
\tag{11}
$$
Every higher power is present in the convergent prime sum.

One quantitative version follows from the same proof. The errors in (7) and (8) are respectively
$$
O((1+\sqrt{\log N})e^{-c\sqrt{\log N}}),\qquad
O((1+\log^{3/2}N)e^{-c\sqrt{\log N}}).
$$
The omitted proper-power tail in (10) is
$O(N^{-1/2}\log^2(2N))$, using the elementary proper-power count $O(\sqrt x)$. No fine bound for the full prime-error source has been inserted beyond (6).

## 3. Two leading terms of the complete squared charge loading

Summing (4), using
$\sum_{n=2}^N1/n=\log N+\gamma-1+o(1)$, and substituting (7)–(11), proves (2) with
$$
\boxed{C_m=
-\gamma^2-2\gamma_1
-\sum_p\frac{(\log p)^2}{(p-1)^2}
+3\gamma-1+C_{\rm ramp}.}
\tag{12}
$$
The error may be taken to be
$$
O\!\left((1+\log^{3/2}N)e^{-c\sqrt{\log N}}
           +N^{-1/2}\log^2(2N)+\frac{\log N}{N}\right).
\tag{13}
$$
Thus the constant is a genuine convergent limit, not merely a bounded unspecified error.

The arithmetic origin of the second term can also be separated. PNT with the same absolutely integrable errors gives constants $C_{\rm prime}$, $C_{\rm cell}$, and a finite proper-power total such that
$$
\sum_{p\le N}m_p^2
=\frac12\log^2N-2\log N+\log\log N+C_{\rm prime}+o(1),
\tag{14}
$$
$$
\sum_{\substack{2\le n\le N\\\Lambda(n)=0}}m_n^2
=\log N-\log\log N+C_{\rm cell}+o(1),
\tag{15}
$$
$$
\sum_{\substack{n=p^k\\k\ge2}}m_n^2<\infty.
\tag{16}
$$
For (14), expand $(\log p-1)^2/p$, retain the convergent ramp correction, and use
$\sum_{p\le N}1/p=\log\log N+B_1+o(1)$.
For (15), sum $r_n^2=1/n+O(n^{-2})$ over all integers and remove prime and proper-power cells. The prime removal has the same $\log\log N$ term; all proper-power removals converge. Formula (16) follows from $m_{p^k}^2\le C(1+\log^2p)p^{-k}$ for $k\ge2$.
These calculations explain the cancellation of the two $\log\log N$ terms and the remaining coefficient $-1$ of $\log N$ in (2). None of the density cells or proper powers has been deleted.

## 4. Exact seeded signed charge work

The charge history telescopes exactly:
$$
M_N=-1+\sum_{n=2}^Nm_n.
$$
Squaring one admission at a time gives
$$
M_n^2-M_{n-1}^2=2M_{n-1}m_n+m_n^2.
$$
Hence
$$
\boxed{\mathcal W_M(N):=\sum_{n=2}^NM_{n-1}m_n
=\frac12\left[M_N^2-1-\sum_{n=2}^Nm_n^2\right].}
\tag{17}
$$
The seed square is exactly one. Inserting the arithmetic loading gives
$$
\boxed{\mathcal W_M(N)
=\frac12M_N^2-\frac14\log^2N+\frac12\log N
-\frac12(1+C_m)+o(1).}
\tag{18}
$$
This is not a sign theorem for $\mathcal W_M(N)$: the terminal $M_N^2$ remains. No boundedness or growth estimate for $M_N$ has been assumed.


The [original-space evolved Gram theorem](original-l2-evolved-source-gram-work.md) uses this exact arithmetic loading after forming each complete signed cell. Its time-uniform error is separate from the PNT remainder here.
