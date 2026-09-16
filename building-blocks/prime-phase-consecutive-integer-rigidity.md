# Consecutive-integer rigidity for a near-return of every prime phase

Written calculation, 2026-09-17. This tests whether the prime-torus recurrences in [the boundary-localization note](https://github.com/arterialist/proofs/blob/main/building-blocks/prime-graph-boundary-localization-sine-mass.md) can occur at carriers too low for the archimedean logarithm to pay. The result is an unconditional quantitative lower bound on a simultaneous near-return of all prime phases. It uses only the condition on actual prime logarithms, unique factorization, and consecutive integers. It does not give an RH-scale Weil inequality.

Let $N\ge 100$ and suppose
\[
\max_{\substack{p\le N\\p\text{ prime}}}
\operatorname{dist}(t\log p,2\pi\mathbb Z)\le\delta,
\qquad t\ge1.
\tag{1}
\]
Set $\epsilon=(\log N/\log2)\delta$. By unique factorization and the triangle inequality for circle distance, every integer $1\le n\le N$ satisfies
\[
\operatorname{dist}(t\log n,2\pi\mathbb Z)\le
\Omega(n)\delta\le\epsilon.
\tag{2}
\]
The use of **all** integers, especially consecutive ones, is essential here. Put $M=\lfloor N/4\rfloor$ and fix an integer $R\ge1$ with $R\le M/4$. If
\[
\epsilon\le 10^{-2}(2/5)^R,
\tag{3}
\]
then
\[
\boxed{\qquad t>\frac{\pi M^{R+1}}{R!}.\qquad}
\tag{4}
\]

Here is a proof with explicit room in the constants. Write $x_n=t\log n/(2\pi)$ and $\eta=\epsilon/(2\pi)$, so $\operatorname{dist}(x_n,\mathbb Z)\le\eta$. For $0\le r\le R$, the forward difference $\Delta^r x_n$ is within $2^r\eta$ of an integer whenever $n+r\le N$.

First suppose $t\le\pi M$. For $M\le n<2M$, consecutive $x_n$ differ by at most $t/(2\pi M)\le1/2$. Their nearest integers must therefore agree, because their errors are at most $\eta$ and $1-2\eta>1/2$. Hence $t\log2/(2\pi)=|x_{2M}-x_M|\le2\eta$, or $t\le 2\epsilon/\log2<1$, a contradiction. Thus $t>\pi M$.

For $r\ge1$ and $n\ge M$, the elementary integral formula for finite differences gives
\[
\Delta^r\log n=(-1)^{r-1}(r-1)!
\int_{[0,1]^r}(n+s_1+\cdots+s_r)^{-r}ds,
\qquad |\Delta^{r+1}\log n|\le\frac{r!}{M^{r+1}}.
\tag{5}
\]
At the two endpoints $n=M,2M$, since $r\le M/4$,
\[
|\Delta^r\log M-\Delta^r\log(2M)|
\ge\frac{(r-1)!}{M^r}
\left[(4/5)^r-(1/2)^r\right]
\ge\frac{(r-1)!}{4M^r}(4/5)^r.
\tag{6}
\]
Suppose inductively that $t>\pi M^r/(r-1)!$ and, toward a contradiction, $t\le\pi M^{r+1}/r!$. By (5), adjacent $\Delta^r x_n$ in $M\le n\le2M$ differ by at most $1/2$. By (3), each is within $2^r\eta$ of an integer and $1-2^{r+1}\eta>1/2$, so those integers are all equal. Their endpoint variation is at most $2^{r+1}\eta$. Yet (6) forces
\[
t\le 8(5/2)^r\epsilon\frac{M^r}{(r-1)!}
<\pi\frac{M^r}{(r-1)!},
\tag{7}
\]
contradicting the inductive lower bound. Induction through $r=R$ proves (4).

For the carrier tolerance $\delta=a^{-6}$ in the published recurrence, take $N=\lfloor e^{2a}\rfloor-1$ and $R=\lfloor4\log a\rfloor$. Then $\epsilon=O(a^{-5})$ and (3) holds for all sufficiently large $a$, while $R\le M/4$. Therefore every such carrier obeys
\[
\log t\ge 8a\log a-O((\log a)^2+a).
\tag{8}
\]
In particular its first possible near-return is superpolynomial in $N$: for every fixed $K$, $t/N^K\to\infty$ as $a\to\infty$ under this tolerance. The estimate remains far below the $\log t\asymp e^a$ scale at which Suzuki's logarithmic archimedean multiplier could automatically pay an $O(e^a)$ raw-prime row. For graph-deficit smallness at a fixed, nonvanishing phase tolerance, (2) only gives $\epsilon\asymp a\delta$ and the hypothesis (3) fails. Thus consecutive-integer rigidity is a useful obstruction to low **very accurate** returns, but does not close the global Weil sign problem.

The prime-shift and archimedean normalizations used for the comparison are in [Suzuki, §2.4](https://arxiv.org/html/2606.09096v2). No literature priority is asserted; the lower bound itself is the elementary finite-difference consequence of (1).
