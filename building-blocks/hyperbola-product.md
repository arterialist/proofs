# Möbius hyperbola product estimate

This bound controls a specified part of a signed hyperbola sum. Its finite arithmetic identities are verified in [Lean](BuildingBlocks/HyperbolaProduct.lean). The analytic argument below is a written proof using classical estimates. No mathematical originality or first-formalization claim is made; the exact statement's publication priority is unresolved. It does not improve a bound for the complete prime-counting error or prove RH.

## Statement

Let $N$ be a positive integer, let $\mu$ denote the Möbius function, and put

```math
\sigma(x)=\{x\}-\tfrac12,\qquad
a_N(k)=\sum_{\substack{d\mid k\\k^2\le Nd}}\mu(d)
\quad(k\ge1).
```

The convention includes $\sigma(j)=-1/2$ at integers. For integers $K$ satisfying $\sqrt N\le K\le N/2$, real $K\le y\le2K$, and every $\delta>0$,

```math
W(N,K;y):=\sum_{K<k\le y}a_N(k)\sigma(N/k),
\qquad
|W(N,K;y)|\ll_\delta N^\delta K^{4/3}N^{-1/3}.
```

The implied constant depends only on $\delta$. Consequently, for every integer $\sqrt N\le A\le N/2$,

```math
\left|\sum_{\sqrt N<k\le A}a_N(k)\sigma(N/k)\right|
\ll_\delta N^\delta A^{4/3}N^{-1/3}.
```

For sufficiently large $N$, take $A=\lfloor N^{5/8}\rfloor$ to obtain $O_\delta(N^{1/2+\delta})$.

## Finite arithmetic

The complete Möbius divisor sum gives

```math
\begin{aligned}
a_N(k)&=\mathbf1_{k=1} &&(k^2\le N),\\
a_N(k)&=-\sum_{\substack{d\mid k\\Nd<k^2}}\mu(d) &&(k\ne1).
\end{aligned}
```

For every real weight $w$,

```math
\sum_{k=1}^N a_N(k)w(k)
=\sum_{n=1}^N\mu(n)
  \sum_{m=1}^{\lfloor\sqrt{N/n}\rfloor}w(nm).
```

These three identities, the coefficient definition, a general finite factor-pair reindexing, and the complete Möbius divisor sum comprise the six declarations audited in this module. Lean uses natural division and `Nat.sqrt`; its cutoff is $\operatorname{Nat.sqrt}(N\mathbin{/}n)$.

## Analytic proof

Write $e(t)=\exp(2\pi i t)$, $Y=N/K$, and $L=\lfloor4K^2/N\rfloor$. The strict complementary identity reindexes the exponential sum as

```math
V_h:=\sum_{K<k\le y}a_N(k)e(hN/k)
=-\sum_{n\le L}\mu(n)
\sum_{\max(K/n,\sqrt{N/n})<m\le y/n}e(hN/(nm)).
```

The boundary $n=4K^2/N$, when integral, adds an empty interval. The inner variable has no arithmetic coefficient. On its ambient interval $K/n<t\le2K/n$, set $M=K/n$. Then

```math
f(t)=\frac{hN}{nt},\qquad
\frac{hY}{4M^2}\le f''(t)\le\frac{2hY}{M^2}.
```

The classical second-derivative estimate bounds the inner sum by $O(\sqrt{hY}+M/\sqrt{hY}+1)$, uniformly in the interval endpoints. The $1$ covers intervals with at most one integer. As $hY\ge2$, summing outer absolute values gives

```math
|V_h|\ll L\sqrt{hY}
+\frac{K}{\sqrt{hY}}(1+\log L).
```

Here $|\mu(n)|\le1$ is sufficient. This step uses no additional cancellation among the outer Möbius signs. See [Elkies, inequality II and proof, pages 1–2](https://people.math.harvard.edu/~elkies/M229.09/vdc.pdf).

For the Fourier step, let $\sigma_0$ equal $\sigma$ off the integers and zero at integers. For integer $T\ge1$, [Montgomery–Vaughan, Appendix D, Lemma D.1, pages 536–537](https://personal.science.psu.edu/rcv4/personal/Publications/MNTI/20.4_pp_535_543_Topics_in_harmonic_analysis.pdf) bounds the remainder after

```math
P_T(x)=-\sum_{h=1}^T\frac{\sin(2\pi h x)}{\pi h}
```

by $O(\min(1,1/((T+1)\|x\|)))$ off integers; the remainder is zero at integers. The notation $\|x\|$ means distance to the nearest integer.

For $k\nmid N$, let $r$ be the integer distance from $N$ to its nearest multiple of $k$. Then $1\le r\le k/2\le K$, $\|N/k\|=r/k$, and $k$ divides $N-r$ or $N+r$. Since $|a_N(k)|\le d(k)$ and $\sum_{k\mid q}d(k)=d_3(q)$, the weighted noninteger remainder is

```math
\ll\frac{K}{T+1}\sum_{r=1}^{K}
\frac{d_3(N-r)+d_3(N+r)}r
\ll_\delta\frac{K N^\delta}{T+1}.
```

Both arguments of $d_3$ lie between $N/2$ and $3N/2$. The standard fixed-order divisor bound absorbs the harmonic logarithm after reserving a smaller positive exponent. For completeness, its prime-power factor is $d_3(p^a)=\binom{a+2}{2}$; exponential growth of $p^{\eta a}$ dominates this polynomial, with constants needed for only finitely many small primes. At integer arguments, replacing $\sigma_0$ by $\sigma$ costs at most $\tfrac12\sum_{k\mid N}d(k)\ll_\delta N^\delta$.

Combining the Fourier coefficients with the bound for $V_h$, using $\sum_{h\le T}h^{-1/2}\ll\sqrt T$ and $\sum_{h\le T}h^{-3/2}\ll1$, yields

```math
|W(N,K;y)|\ll_\delta N^\delta
\left(L\sqrt{YT}+\frac K{\sqrt Y}+\frac K{T+1}+1\right).
```

Take $T=\lfloor Y^{1/3}\rfloor$. Since $Y\ge2$ and $L\le4K/Y$, each term is $O(KY^{-1/3})$. In particular, $K/\sqrt Y\le KY^{-1/3}$, and $KY^{-1/3}\ge N^{1/3}\ge1$. This proves the block bound because $KY^{-1/3}=K^{4/3}N^{-1/3}$.

Sum geometrically over doubling intervals starting at $\lceil\sqrt N\rceil$, using uniformity in the last endpoint. The possible initial integer contributes at most $d(\lceil\sqrt N\rceil)/2\ll_\delta N^\delta$. This proves the stated bound through $A$.

## Use and attribution

This isolates a controlled portion of the product-indexed sum. The part $k\le\sqrt N$ contributes exactly $-1/2$. Products above $N^{5/8}$ and the additional floor and boundary terms in the prime-error identity still require control. The product index $k=nm$ is not the original Möbius index $n$.

The arithmetic uses the classical [Möbius divisor identity, DLMF 27.5.2](https://dlmf.nist.gov/27.5.E2). The analytic inputs are van der Corput's estimate and classical Fourier truncation, cited above. No exact earlier statement was identified in the completed bounded literature search; this is not evidence establishing priority.

The formalization imports mathlib's [ArithmeticFunction module](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/NumberTheory/ArithmeticFunction.lean), credited to Aaron Anderson, with supporting mathlib modules. Imported dependencies retain their licenses. The extracted proof code uses this repository's MIT license; no mathlib source is copied. [Verification and source hashes](verification/hyperbola-product.json).
