# An improved asymptotic zero-free-region constant

Let

$$
P(x)=\sum_{k=0}^{46}b_k\cos(kx)
$$

be the trigonometric polynomial certified by [`certificate.py`](certificate.py). It has $b_0=1$, every $b_k>0$, $b_1>b_0$, and $P(x)\geq0$ for every real $x$. The Mossinghoff–Trudgian–Yang construction, with Bellotti's value $B=4.43795$, therefore gives

$$
\zeta(\sigma+it)\ne0
$$

for all sufficiently large $|t|$ whenever

$$
\sigma\geq1-\frac{1}{48.0716(\log |t|)^{2/3}(\log\log |t|)^{1/3}}.
$$

This improves the previously published asymptotic constant $48.0718$.

## Certificate

The script contains exact rational factors for two normalized Fejér squares. One is the published MTY degree-46 polynomial; the other is an optimized factor found in this project. It forms the convex combination

$$
P(x)=\frac13P_{\mathrm{MTY}}(x)+\frac23P_{\mathrm{opt}}(x).
$$

Each component is nonnegative for every real $x$, so their mixture is nonnegative and has $b_0=1$. Exact rational autocorrelations verify $b_k>0$ for every $1\leq k\leq46$ and $b_1>b_0$. This proves all polynomial admissibility conditions without numerical sampling.

Let $b=\sum_{k=1}^{46}b_k$, and let $\theta\in(0,\pi/2)$ be the unique solution of

$$
\sin^2\theta=b_1(1-\theta\cot\theta).
$$

Alternating Taylor bounds with rational arithmetic certify

$$
1.132670959<\theta<1.132670962.
$$

Uniqueness follows because

$$
h(\theta)=\frac{\sin^2\theta}{1-\theta\cot\theta}
$$

is strictly decreasing on $(0,\pi/2)$. Indeed, the sign of $h'$ is the sign of
$3\sin\theta\cos\theta-\theta(1+2\cos^2\theta)$, whose negative has derivative
$4\sin\theta(\sin\theta-\theta\cos\theta)>0$.

The asymptotic constant is

$$
R_2=\sec^2\theta\left(\frac34\right)^{2/3}
 b\left(1+\frac1b\right)^{1/3}B^{2/3}.
$$

Cubing removes every fractional power:

$$
R_2^3=\frac9{16}\frac{b^2(b+1)B^2}{\cos^6\theta}.
$$

The script proves the resulting rational upper-bound comparison with $48.0716^3$ exactly. The polynomial's numerical objective is approximately $48.071596170$; this decimal is explanatory and is not used by the certificate.

Run:

```console
python3 certificate.py
```

No third-party package is required.

## Sources

- M. J. Mossinghoff, T. S. Trudgian, and A. Yang, [*Explicit zero-free regions for the Riemann zeta-function*](https://arxiv.org/abs/2212.06867), especially Section 8 and the formula for $R_2$.
- C. Bellotti, [*Explicit bounds for the Riemann zeta function and a new zero-free region*](https://arxiv.org/abs/2306.10680), especially the bound with $B=4.43795$ and the asymptotic constant $48.0718$.

Project author: arterialist. Computational search and exact certification: OpenAI Codex.
