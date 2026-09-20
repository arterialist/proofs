# Prime-log zeros and a positive-cost Laplace bound

Let

\[
B(u)=\frac1{2\pi}\int_{\mathbb R}e^{itu}\,d\mu(t),
\qquad \mu\ge 0,
\]

be continuous, Hermitian, positive definite, and supported in \([-D,D]\).
Assume

\[
B(\log p)=0
\]

for every prime \(p\le e^D\). Define

\[
q(t)=\bigl[1+\log(2+|t|)\bigr](t^2+1/4)^2,
\qquad
E(B)=\frac1{2\pi}\int_{\mathbb R}q(t)\,d\mu(t).
\]

Then, for every \(|\delta|<1/2\),

\[
\boxed{
\left|\int_{-D}^{D}B(u)e^{(\delta+i\gamma)u}\,du\right|
\le C_\delta E(B)
}
\]

uniformly in \(D\) and \(\gamma\). Zeros at prime powers may also be
imposed, but the proof only uses the zeros at primes.

## Spectral cost and prime-log cells

The weight \(q\) satisfies \(1+|t|\le Cq(t)\). When \(E(B)<\infty\),

\[
B(0)\le CE(B),
\qquad
\|B'\|_\infty
\le \frac1{2\pi}\int |t|\,d\mu(t)
\le CE(B).
\tag{1}
\]

If \([a,b]\) is an interval between two zeros of \(B\), with
\(h=b-a\), then

\[
|B(u)|\le \|B'\|_\infty\min(u-a,b-u),
\qquad
\int_a^b|B(u)|\,du\le \frac14\|B'\|_\infty h^2.
\tag{2}
\]

We apply this to consecutive prime-log cells.

## The second moment of prime-log gaps

Write \(G_n=p_{n+1}-p_n\). For fixed

\[
\frac12<\theta\le\frac{11}{21},
\]

the verified exceptional-set estimate recorded by Gafni and Tao is

\[
|\mathcal E_{\eta}(X,\theta)|
\ll_{\eta,\theta,\varepsilon}
X^{\frac32(1-\theta)+\varepsilon}.
\tag{3}
\]

Here \(\mathcal E_{\eta}(X,\theta)\) is the set of starting points where
the prime number theorem fails by a fixed proportion in an interval of
length \(x^\theta\). Their Lemma 1.1(iii) attributes this range and exponent
to Bazzanella, Lemma 1. The claimed continuation below \(\theta=1/2\) is not
used.

A prime-free interval of this length lies in \(\mathcal E_{\eta}\) for a
fixed \(\eta<1\), once \(X\) is large. Proper prime powers contribute only

\[
O\!\left((X^{\theta-1/2}+1)\log X+(\log X)^2\right)=o(X^\theta).
\]

Large gaps therefore give disjoint exceptional intervals, and (3) implies

\[
\sum_{\substack{p_n\asymp X\\G_n>C_\theta X^\theta}}G_n
\ll X^{\frac32(1-\theta)+\varepsilon}.
\tag{4}
\]

The Baker-Harman-Pintz bound \(G_n\ll p_n^{21/40}\) now gives

\[
\begin{aligned}
\sum_{G_n\le C_\theta X^\theta}G_n^2
&\ll X^{1+\theta},\\
\sum_{G_n>C_\theta X^\theta}G_n^2
&\ll X^{\frac{21}{40}+\frac32(1-\theta)+\varepsilon}
\ll X^{1+\theta+\varepsilon}.
\end{aligned}
\tag{5}
\]

The last comparison only requires \(\theta\ge41/100\). The bounded number
of gaps crossing the block endpoints contributes
\(O(X^{42/40})\), which is smaller. Hence

\[
\sum_{p_n\asymp X}G_n^2
\ll X^{1+\theta+\varepsilon}.
\tag{6}
\]

For \(h_n=\log p_{n+1}-\log p_n\), this becomes

\[
\boxed{
\sum_{p_n\asymp X}h_n^2
\ll X^{-1+\theta+\varepsilon}.
}
\tag{7}
\]

## Dyadic summation

Equations (1), (2), and (7) imply

\[
\int_{\log X}^{\log(2X)}|B(u)|\,du
\ll E(B)X^{-1+\theta+\varepsilon}.
\tag{8}
\]

Cells cut by a dyadic endpoint are enlarged to the corresponding full
prime-log cell. These enlargements have bounded overlap. There is no extra
support-boundary term: continuity and compact support give \(B(D)=0\), and
the last interval from a prime log to \(D\) is no longer than the crossing
prime gap.

Put \(\alpha=|\delta|<1/2\). Hermitian symmetry gives
\(|B(-u)|=|B(u)|\), so the contribution of the block at physical scale
\(X\) is at most

\[
CE(B)X^{\alpha-1+\theta+\varepsilon}.
\tag{9}
\]

Choose

\[
\frac12<\theta<\min\left(\frac{11}{21},1-\alpha\right)
\]

and then \(\varepsilon>0\) with
\(\alpha+\theta+\varepsilon<1\). The powers of two in (9) form a
convergent geometric series. The bounded interval before the first prime log
is controlled by \(|B(u)|\le B(0)\). This proves the stated bound.

The method does not reach \(|\delta|=1/2\). It would require the excluded
endpoint \(\theta=1/2\), where the dyadic exponent loses its negative
margin.

## Scope

The theorem controls bilateral Laplace loading by the positive cost \(E(B)\).
That cost has fourth-order polynomial growth in frequency. It is much
stronger than the signed archimedean term in Weil's criterion, whose
multiplier is neither positive nor strong enough to dominate \(E(B)\).
The result therefore does not prove Weil positivity or the Riemann
hypothesis. It rules out bounded-complete-cost counterexamples throughout
the open critical strip and isolates the remaining problem: relate the
signed Weil form to a coercive positive quantity without assuming the
desired positivity.

## References

- A. Gafni and T. Tao, "On the number of exceptional intervals to the prime
  number theorem in short intervals," Definition 1.1 and Lemma 1.1(iii),
  [arXiv:2505.24017](https://arxiv.org/abs/2505.24017).
- D. Bazzanella, "Primes in almost all short intervals II," *Boll. Un. Mat.
  Ital.* (8) 3-B (2000), 717-726, Lemma 1.
- R. C. Baker, G. Harman, and J. Pintz, "The difference between consecutive
  primes, II," *Proc. London Math. Soc.* 83 (2001), 532-562,
  [doi:10.1112/plms/83.3.532](https://doi.org/10.1112/plms/83.3.532).
