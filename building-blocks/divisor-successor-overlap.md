# Divisor transport of the successor and its signed overlap

This note gives exact local update formulas and counterexamples for a divisor-conjugated successor. Its global resolvent is the classical Mertens/Redheffer quantity. The local formulas do not bound that quantity. These are written proofs; no first-publication or first-formalization claim is made.

For positive integer $N$, on the standard Euclidean space with basis $e_1,\ldots,e_N$, set

```math
Z(i,j)=\mathbf1_{i\mid j},\quad
M(i,j)=\mathbf1_{i\mid j}\mu(j/i),\quad
Se_n=\begin{cases}e_{n+1}&n<N,\\0&n=N.\end{cases}
```

Möbius inversion gives $M=Z^{-1}$. Put $T_N=MSZ$ and $v_m=Me_m$, padded with zeros when necessary.

## Local birth and overlap laws

Direct multiplication gives

```math
T_Ne_j=\sum_{\substack{d\mid j\\d<N}}v_{d+1}.
```

For $N\ge3$, define $b_N=\sum_{d\mid N,\,d<N}v_{d+1}$. Only the old last column and the new last column change, so

```math
\Delta_N:=T_N-(T_{N-1}\oplus0)
=v_Ne_{N-1}^{T}+b_Ne_N^{T}.
```

Both displayed columns have zero diagonal entry. Consequently their off-diagonal squared energy is

```math
\mathcal E_N=2^{\omega(N)}+\|b_N\|^2.
```

The exact Gram kernel factors prime by prime:

```math
K(a,b)=\langle v_a,v_b\rangle
=\sum_{i\mid(a,b)}\mu(a/i)\mu(b/i)
=\prod_p k(\nu_p(a),\nu_p(b)),
```

where $k(0,0)=1$, $k(j,j)=2$ for $j>0$, $k(j,j+1)=k(j+1,j)=-1$, and $k(j,l)=0$ when $|j-l|\ge2$. This follows by summing the exponent of $p$ in $i$; Möbius values vanish unless each residual exponent is 0 or 1.

For primes $p\ge3$, $v_p=e_p-e_1$ and $b_p=e_2-e_1$, giving $\mathcal E_p=4$. The same minimum occurs at the composite 9, since $v_9=e_9-e_3$ and $b_9=v_2+v_4=e_4-e_1$. Thus the energy does not characterize primes.

Nor are the cross terms always nonpositive. At $N=4$, $b_4=v_2+v_3$ and $K(2,3)=1$, so

```math
\mathcal E_4=8>6=2^{\omega(4)}+\|v_2\|^2+\|v_3\|^2.
```

Removing the common root does not restore a universal inequality. Let $P=I-e_1e_1^T$, so the projected kernel is $K(a,b)-\mu(a)\mu(b)$. For $N=90$, the proper shifted divisors are

```math
2,3,4,6,7,10,11,16,19,31,46.
```

Their six positive projected pairs are $(4,6),(4,10),(4,46),(6,10),(6,46),(10,46)$, each of value 1. Their five negative pairs are $(2,4),(2,6),(2,10),(2,46),(3,6)$, each of value $-1$. All other pairs vanish by the displayed local kernel. Hence

```math
\|Pb_{90}\|^2=21>19=\sum_{d\mid90,\ d<90}\|Pv_{d+1}\|^2.
```

The local energy nevertheless satisfies $\mathcal E_N\ll_\varepsilon N^\varepsilon$ for every $\varepsilon>0$, without cancellation: Cauchy–Schwarz bounds $\|b_N\|^2$ by $\tau(N)^2\max_{m\le N}\tau(m)$, and the standard divisor bound finishes the proof.

## The global signed quantity

Since $Ze_1=e_1$ and $T_N^k=MS^kZ$,

```math
T_N^ke_1=v_{k+1}\quad(0\le k<N).
```

Writing $\mathsf M(x)=\sum_{n\le x}\mu(n)$, nilpotence gives the finite identities

```math
W_N:=(I-T_N)^{-1}e_1=M\mathbf1,
\qquad (W_N)_i=\mathsf M(\lfloor N/i\rfloor),
```

```math
e_1^T(I-T_N)^{-1}e_1=\mathsf M(N),
\qquad \|W_N\|^2=\sum_{i\le N}\mathsf M(\lfloor N/i\rfloor)^2.
```

Also $\det(I-T_N)=1$. Cramer's rule identifies its root-deleted cofactor with $\mathsf M(N)$, which is precisely the determinant of the classical Redheffer matrix $Z+(\mathbf1-e_1)e_1^T$.

The desired family of bounds $\|W_N\|^2\ll_\varepsilon N^{1+\varepsilon}$ is equivalent to the classical all-$\varepsilon$ Mertens bound, hence RH. One direction takes the first coordinate. Conversely, $|\mathsf M(m)|\le C_\delta m^{1/2+\delta}$ gives

```math
\|W_N\|^2\le C_\delta^2N^{1+2\delta}
\sum_{i\ge1}i^{-1-2\delta};
```

choose $2\delta\le\varepsilon$.

The diagonal part of the global Gram sum is elementary:

```math
\sum_{a\le N}\|v_a\|^2=\sum_{a\le N}2^{\omega(a)}
=\sum_{d\le N}\mu(d)^2\lfloor N/d\rfloor
\le N(1+\log N).
```

The unproved part is control of the complete signed sum $\sum_{a,b\le N}K(a,b)$. Small individual birth energies do not provide it.

## Attribution

Möbius incidence inversion and the Redheffer determinant are classical. [Wilf, *The Redheffer matrix of a partially ordered set*](https://arxiv.org/html/math/0408263), explicitly proves the chain/determinant interpretation and recalls the RH equivalence. The update and overlap formulas above are elementary consequences in this specific successor construction. They retain useful counterexamples to local cancellation hypotheses, without claiming a new RH estimate.
