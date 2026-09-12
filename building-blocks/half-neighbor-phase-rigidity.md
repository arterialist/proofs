# Exact rigidity from the half-neighbor prime defect

Let $\chi:\mathbb N\to\mathbb T$ be completely multiplicative, with $\chi(1)=1$. Here $\mathbb N=\{1,2,\ldots\}$ and $\mathbb T=\{z\in\mathbb C:|z|=1\}$. Define the successor/division defect by

$$
\mathcal E_2(\chi)=\sum_{k=2}^\infty
|\chi(2k-1)-\chi(2)\chi(k-1)|^2.
\tag{1}
$$

Only half of the adjacent pairs occur in this sum. The missing half will be recovered by an arithmetic identity, not assumed to satisfy the same hypothesis.

## The difference-of-squares bridge

Put

$$
a_n=\chi(2n+1)-\chi(2n),\qquad n\ge1.
$$

Complete multiplicativity identifies (1) with $\sum_{n\ge1}|a_n|^2$. If $m=2n+1$, then

$$
\chi(m^2)=\chi(m)^2,\qquad
\chi(m^2-1)=\chi(m-1)\chi(m+1).
$$

Since every $\chi$ value has modulus one,

$$
\begin{aligned}
|\chi(m+1)-\chi(m)|
&=|\chi(m^2-1)-\chi(m-1)\chi(m)|\\
&\le|\chi(m^2-1)-\chi(m^2)|
+|\chi(m)-\chi(m-1)|\\
&=|a_{2n(n+1)}|+|a_n|.
\end{aligned}
\tag{2}
$$

Both terms on the last line belong to the observed half of the differences, because $m$ and $m^2$ are odd. The map $n\mapsto2n(n+1)$ is injective.

Therefore the full adjacent energy has the exact bound

$$
\boxed{\sum_{m=1}^\infty|\chi(m+1)-\chi(m)|^2
\le|\chi(2)-1|^2+5\mathcal E_2(\chi).}
\tag{3}
$$

The initial term keeps the ground state 1. Proper prime powers are essential to (2), particularly $\chi(m^2)=\chi(m)^2$; no squarefree replacement is used.

There is also a pointwise consequence stronger than what is needed for (3). If $a_n$ tends to zero, then (2) makes all the missing adjacent differences tend to zero as well. Thus half-neighbor convergence alone implies full-neighbor convergence for a unimodular completely multiplicative function.

## Applying the primary rigidity theorem

Wirsing and Zagier prove that a modulus-one multiplicative function whose consecutive ratios tend to one is exactly $n^{it}$, for a real $t$. This is the multiplicative formulation immediately after Theorem 1 in [*Multiplicative functions with difference tending to zero*, Acta Arithmetica 100 (2001), 75-78](https://people.mpim-bonn.mpg.de/zagier/files/doi/10.4064/aa100-1-6/fulltext.pdf), printed p.75; their proof of Theorem 1 is on pp.76-77. For unit-modulus values, convergence of adjacent differences to zero is equivalent to convergence of those ratios to one.

Equation (2) establishes the required full-neighbor hypothesis from the actual half-neighbor hypothesis. Conversely,

$$
|(2n+1)^{it}-(2n)^{it}|
\le |t|\log(1+1/(2n))\le |t|/(2n),
$$

so every $n^{it}$ has finite energy (1). We obtain the exact classification

$$
\boxed{
\mathcal E_2(\chi)<\infty
\quad\Longleftrightarrow\quad
\chi(n)=n^{it}\text{ for every }n\ge1
\text{ and some real }t.}
\tag{4}
$$

In fact each of the following is equivalent to (4): convergence to zero of the half-neighbor defects; finiteness of the full adjacent energy; convergence to zero of all adjacent differences. The scale parameter $t$ is unique, since $\log(2)/\log(3)$ is irrational.

The theorem is obtained from the existing Wirsing-Zagier rigidity result and the explicit bridge (2). No novelty claim is made. The proof here is written mathematics; no Lean formalization is claimed.

## The all-prime family adds no further phase restriction

For a prime $p$, the exact defect is

$$
\mathcal E_p(\chi)=\sum_{k\ge2}
|\chi(pk-1)-\chi(p)\chi(k-1)|^2.
$$

For the functions selected by (4),

$$
\mathcal E_p(n^{it})
\le t^2\left(\frac{p-1}{p}\right)^2\frac{\pi^2}{6}.
\tag{5}
$$

Thus requiring finiteness for every prime, or even a uniform bound over all primes, selects exactly the same class as $\mathcal E_2$ alone. The $p=2$ condition already supplies the rigidity.

## Every nontrivial prime-proportional angle has infinite defect

For the proposed prime wrapping rule, let

$$
F(n)=\sum_p p\,v_p(n),\qquad
\chi_\alpha(n)=e^{i\alpha F(n)}.
\tag{6}
$$

Suppose $\mathcal E_2(\chi_\alpha)$ were finite. By (4), $\chi_\alpha(n)=n^{it}$. Evaluating at the primes 2, 3, and 5 then gives

$$
(9/8)^{it}=\frac{\chi_\alpha(3)^2}{\chi_\alpha(2)^3}=1,
\qquad
(25/32)^{it}=\frac{\chi_\alpha(5)^2}{\chi_\alpha(2)^5}=1.
\tag{7}
$$

If $t$ were nonzero, the two numbers $t\log(9/8)/(2\pi)$ and $t\log(25/32)/(2\pi)$ would be nonzero integers. Hence $\log(9/8)/\log(25/32)$ would be rational. Exponentiating that rational relation contradicts unique factorization, since 9/8 contains the prime 3 and 25/32 contains the prime 5. Therefore $t=0$.

Now $e^{2i\alpha}=e^{3i\alpha}=1$ forces $e^{i\alpha}=1$. Conversely that condition makes $\chi_\alpha$ identically one. Thus

$$
\boxed{\mathcal E_2(\chi_\alpha)<\infty
\quad\Longleftrightarrow\quad\alpha\in2\pi\mathbb Z.}
\tag{8}
$$

Every nontrivial angle has infinite defect, with no almost-everywhere exception. In fact its half-neighbor defects cannot tend to zero.

## Complex powers and the missing midpoint condition

Unimodularity is essential to the classification. Let $s=\sigma+it$ and $f_s(n)=n^s$. For each fixed prime $p$ and $k\ge2$, the fundamental theorem of calculus gives

$$
|f_s(pk-1)-f_s(p)f_s(k-1)|
=\left|s\int_{p(k-1)}^{pk-1}v^{s-1}\,dv\right|
\le C_{s,p}k^{\sigma-1}.
$$

Therefore $\mathcal E_p(f_s)<\infty$ whenever $\sigma<1/2$. In particular both $n^{i(\gamma+i\delta)}=n^{-\delta+i\gamma}$ and its reflected expression $n^{\delta+i\gamma}$ have finite defect for every $p$ whenever $|\delta|<1/2$. These are the two amplitudes associated with the critical strip in a complex scale parameter.

Applying the unimodular classification to either expression requires $\delta=0$ already. Dividing it by its modulus produces $n^{i\gamma}$ and discards $\delta$. Thus finite successor/division defect selects the logarithmic phase among unimodular multiplicative functions, but supplies no midpoint constraint for complex powers in the strip.

The related [divisor-conjugated successor](divisor-successor-overlap.md) retains a different, signed Gram structure. Neither result supplies the missing global sign in the [actual arithmetic criterion](actual-critical-sign-criterion.md).
