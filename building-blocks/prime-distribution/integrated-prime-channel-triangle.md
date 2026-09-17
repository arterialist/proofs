# Integrating prime channels before taking the norm triangle

The proposed integrate-first norm triangle also has an elementary obstruction. For every integer X≥e¹²⁸, define

```math
 U_{p,X}(t)=\left(\int_X^t f_p(x)\,dx,
                        \int_t^{2X}f_p(x)\,dx\right),\qquad
 f_p(x)=J_p(\lfloor x\rfloor),
```

with the actual increments

```math
 J_p(n)=\left\lfloor\frac{\log n}{\log p}\right\rfloor\log p
       -\#\{2\le d\le n:P^+(d)=p\}.
 \tag{I1}
```

Set J_p(n)=0 for p>n. The Hilbert norm below is the usual norm of L²([X,2X];R²), summing the squares of both components. Then

```math
 \boxed{\sum_{p\le2X}\|U_{p,X}\|_2
 \ge\frac{\log2}{8}\sqrt{\frac23}\,X^{5/2}.}
 \tag{I2}
```

In particular the squared norm-triangle cost is at least (log 2)²X⁵/96. This excludes proving the desired O_ε(X^(4+ε)) squared coarse-primitive bound by this particular triangle estimate for every ε>0: any ε<1 contradicts an upper bound of that order on the triangle cost itself. It gives no lower bound on the actual signed coarse-primitive form. It gives no lower bound for the actual signed prime error.

## 1. Elementary prime mass with explicit thresholds

Write θ(x)=Σ_{p≤x}log p. The following deliberately loose bounds suffice:

```math
 \theta(M)\ge\frac{\log2}{2}M\quad
 (M\text{ integer},\ \log M\ge64),\qquad
 \theta(x)\le4(\log2)x\quad(x\ge1).
 \tag{I3}
```

For completeness, each prime-power summand in the valuation of the central binomial coefficient is zero or one. Hence

```math
 \psi(2m)\ge\log\binom{2m}{m}
 \ge2m\log2-\log(2m+1).
```

With m=⌊M/2⌋ this gives ψ(M)≥(M−1)log 2−log(M+1). Higher powers contribute only for p≤√M, and the complete contribution at each such prime is at most log M. Thus ψ(M)−θ(M)≤√M log M. For t=log M≥64, the normalized loss is at most

```math
 (t+2\log2)e^{-t}+te^{-t/2}
 \le\frac{66}{2^{64}}+\frac{64}{2^{32}}<\frac14<\frac{\log2}{2}.
```

Both functions on the left decrease on this range; e>2 and 1/2<log 2<1 justify the comparison. This proves the lower bound in I3 while retaining all prime powers in ψ.

For the upper bound, every prime in (m,2m] divides the central binomial coefficient, so θ(2m)−θ(m)≤2m log 2. Summing at m=2^j gives θ(2^k)≤2(2^k−1)log 2. If 2^(k−1)<x≤2^k, monotonicity gives θ(x)≤4x log 2. The interval 1≤x≤2 is immediate. No prime number theorem or RH estimate is used.

## 2. Channels that cannot cancel internally on the block

Put t=log X and y=8X/t. Since t≥128, y<X. Also

```math
 \log y=t+\log8-\log t\ge t/2,
 \qquad y^2>2X.
 \tag{I4}
```

For the first inequality, log t≤t/2 for t≥2. For the second, e^(t/2)>t/2 implies y²/(2X)=32e^t/t²>8. These bounds are much stronger than needed.

Select primes y<p≤X. For every integer n with X≤n≤2X, we have p≤n<p². Consequently the first term of I1 has exactly one power and equals log p. Every integer with largest prime factor p and size at most n is uniquely p·m with 1≤m≤n/p<p. Conversely every such m has all prime factors below p, so it produces a member of that shell. Thus, exactly,

```math
 J_p(n)=\log p-\lfloor n/p\rfloor.
```

Because p>8X/t,

```math
 \lfloor n/p\rfloor\le n/p\le2X/p<t/4
 \le\tfrac12\log p.
```

Therefore f_p(x)≥(log p)/2 throughout [X,2X], including the integer endpoint convention. There are no omitted prime powers here: higher powers exceed the whole block. All other primes retain their full definition I1 and are simply not needed for the lower bound on the sum of nonnegative norms.

Each selected channel has both primitives bounded below by those of the constant (log p)/2. Hence

```math
 \|U_{p,X}\|_2^2
 \ge\frac{(\log p)^2}{4}
       \int_X^{2X}\big((v-X)^2+(2X-v)^2\big)\,dv
 =\frac{(\log p)^2}{4}\frac{2X^3}{3}.
 \tag{I5}
```

I3 and t≥128 give

```math
 \sum_{y<p\le X}\log p
 =\theta(X)-\theta(y)
 \ge\frac{\log2}{2}X-\frac{32\log2}{t}X
 \ge\frac{\log2}{4}X.
```

Summing the square roots of I5 proves I2 for all integers X≥e¹²⁸. It therefore applies to all sufficiently large dyadic blocks as well; the elementary sufficient dyadic threshold X=2^k with k≥256 follows from log 2>1/2. The actual integer-valued floor at 2X affects no integral and also satisfies the inequalities above.

## 3. The signed sum and the exact correction

Unique factorization partitions 2,…,n into the largest-prime shells, while the logarithmic prime-power terms sum to ψ(n). Thus

```math
 \sum_pJ_p(n)=\psi(n)-n+1.
```

For real x≥1, with c(x)=1+{x}, the actual error is exactly

```math
 e(x)=\psi(x)-x=\sum_pf_p(x)-c(x).
 \tag{I6}
```

On the block, all channels outside p≤2X vanish. Let T_Xf be the prefix/suffix pair and C_X=T_Xc. The coarse-primitive form is

```math
 S_X=\left\|\sum_{p\le2X}U_{p,X}-C_X\right\|_2^2.
 \tag{I7}
```

The norm triangle would upper-bound its square root by Σ_p||U_p||₂+||C_X||₂. I2 proves that this upper-bound strategy has cost of order at least X^(5/2), even after each prime is integrated before taking its norm. The correction is much smaller:

```math
 \|C_X\|_2^2=\frac32X^3+\frac{X}{60}.
 \tag{I8}
```

Even absorbing the correction into one prime channel changes the summed norms by at most ||C_X||₂, so this finite recentering does not change the exponent of the obstruction. None of these statements replaces the norm of the signed sum by a lower bound. Negative cross-prime inner products remain available in I7.

## 4. A finite integrated Gram consumer

The exact scalar kernel of T_X* T_X is

```math
 K_X(u,v)=(2X-\max(u,v))+(\min(u,v)-X)=X-|u-v|.
 \tag{I9}
```

This follows by integrating the two indicator products for prefix and suffix. All functions here are bounded on a finite block, so Fubini applies without an infinite-series interchange.

For i=0,…,X−1, put j_(p,i)=J_p(X+i). The channel is constant on each half-open unit interval. Integrating K_X over two unit cells gives the exact matrix

```math
 M_{ij}=X-|i-j|-\frac13\mathbf1_{i=j},\qquad
 G_{pq}=\langle U_{p,X},U_{q,X}\rangle=j_p^TMj_q.
 \tag{I10}
```

The off-diagonal average distance is |i−j|; the same-cell average distance is 1/3. M is positive definite: the prefix integration operator is injective on these step functions. Thus G is positive semidefinite as a prime-indexed Gram matrix, but its individual off-diagonal entries can have either sign.

The correction can be included with no approximation. Define

```math
 R_i=\sum_jM_{ij}
 =X^2-\frac{i(i+1)}2-\frac{(X-1-i)(X-i)}2-\frac13,
 \qquad
 b_i=\frac32R_i+\frac{2i-X+1}{12},
 \quad d=\frac32X^3+\frac{X}{60}.
 \tag{I11}
```

Then b_i=⟨T_X1_[X+i,X+i+1),C_X⟩ and d=||C_X||₂². For a direct derivation, write x=X+i+z with 0≤z<1. The correction prefix is 3i/2+z+z²/2 and the suffix is 3X/2 minus this quantity. Polynomial integration gives I11 and I8. Equivalently split c=3/2+(z−1/2); the mean-zero part has prefix (z²−z)/2 on every cell and opposite suffix. Its squared pair norm is X/60, and its cross term with the constant 3/2 vanishes over the full block.

Consequently the exact finite consumer is

```math
 \boxed{S_X=
 \sum_{p,q\le2X}j_p^TMj_q
 -2\sum_{p\le2X}j_p^Tb+d.}
 \tag{I12}
```

This retains all prime powers, all signed cross-prime terms, the base one and the fractional part. A useful future estimate must bound this actual centered quadratic expression; diagonal estimates or positive-semidefiniteness of G alone do not supply the desired O_ε(X^(4+ε)) bound.


The proof uses the classical Chebyshev central-binomial argument and unique largest-prime-factor decomposition. The exact Gram matrix is the integral of two Volterra kernels. No new prime-distribution theorem, originality or Lean-formalization claim is made.
