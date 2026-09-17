# Coherent division markings and the prime-forcing selector

Consider every strict divisor chain from a positive integer to 1, retaining its incidence sign and the entry and exit of each prime coordinate under ordinary successor steps. The complete linear marking below is uniquely fixed by divisor recovery. It reduces to the classical prime-power indicator. A subsequent exact example shows why cancellation of adjacent responses does not bound the selected response that recovers prime forcing.

The alternating-chain formula is classical incidence algebra: see [Rota, §3, Propositions 1, 2 and 6 and Example 1](https://webhomes.maths.ed.ac.uk/~v1ranick/papers/rota1.pdf), which attributes the chain calculation to Philip Hall and identifies the arithmetic Möbius function. The results here are finite applications with a specified decoder, not a new RH bound or a Lean formalization.

## Complete chains and their endpoint response

Fix a prime $p$. For $n>1$, give a chain $n=n_0>n_1>\cdots>n_k=1$, $n_{i+1}\mid n_i$, the readout $(-1)^{k-1}v_p(n_{k-1})$. Let $G_p(n)$ be the sum over all such chains and set $G_p(1)=0$. The complete incidence sum gives

```math
G_p(n)=\sum_{d\mid n}\mu(d)v_p(n/d)
=\mathbf1_{\{n=p^a\text{ for some }a\ge1\}}.
```

Indeed, write $n=p^am$ with $(p,m)=1$. For $a\ge1$, the two possible powers of $p$ in a nonzero Möbius term leave $[a-(a-1)]\sum_{d\mid m}\mu(d)=\mathbf1_{m=1}$; for $a=0$ the readout is zero. Direct composite divisions are essential to the incidence count. Moreover $\sum_{d\mid n}G_p(d)=v_p(n)$, and this complete-divisor recovery identity uniquely determines $G_p$ by induction on proper divisors.

For $j_p(n)=v_p(n+1)-v_p(n)$, use the mark

```math
W_p(n)=\frac{G_p(n)+G_p(n+1)}{v_p(n)+v_p(n+1)}
```

when its denominator is positive and zero otherwise. Consecutive integers are coprime, so $0\le W_p(n)\le1$ and

```math
W_p(n)j_p(n)=G_p(n+1)-G_p(n),\qquad
R(n):=\sum_p\log p\,W_p(n)j_p(n)=\Lambda(n+1)-\Lambda(n).
```

At a transient $p^a$ the entry and exit marks are both $1/a$, and the two responses are exactly $\log p,-\log p$. Thus a refined path retains, and then cancels, every intermediate prime power.

For dilation by $m$, its exact marked successor defect is

```math
\mathcal J_{m,n}:=\sum_{r=0}^{m-1}R(mn+r)-R(n)
=\Lambda(m(n+1))-\Lambda(mn)-\Lambda(n+1)+\Lambda(n).
```

The unmarked valuation defect vanishes identically by $v_p(mn)=v_p(m)+v_p(n)$; the marked prime-power readout need not. For example $\mathcal J_{2,5}=\log5$; the intervening prime 11 cancels between $10\to11$ and $11\to12$.

## Zero paired response with a nonzero forcing decoder

Let $U(n)=\Lambda(n)$ for odd $n$ and zero for even $n$. Prime-power classification gives

```math
\Lambda(2n)-\Lambda(n)=(\log2)\mathbf1_{n=1}-U(n),
\qquad
\mathcal J_{2,n}=U(n)-U(n+1)-(\log2)\mathbf1_{n=1}.
```

Consequently, for every $k\ge1$,

```math
\mathcal J_{2,2k}=-\Lambda(2k+1),\qquad
\mathcal J_{2,2k+1}=\Lambda(2k+1).
```

The adjacent pair cancels exactly, but each odd prime supplies a nonzero response of size $\log p$. Including the initial and terminal terms gives, for $K\ge1$,

```math
\sum_{n=1}^K\mathcal J_{2,n}=-\log2-U(K+1),
```

```math
\sum_{n=1}^K|\mathcal J_{2,n}|^2
=(\log2)^2+2\sum_{r=3}^KU(r)^2+U(K+1)^2.
```

If $a_2(N)=\lfloor\log N/\log2\rfloor$, the actual forcing is recovered, for $N\ge2$, by the different selector

```math
\boxed{\psi(N)-N=-\sum_{k=1}^{\lfloor(N-1)/2\rfloor}\mathcal J_{2,2k}
+a_2(N)\log2-N.}
```

It selects only the even-base member of each canceled pair. All powers of 2 and the density term are explicit. Equivalently the original response has triangular decoder
$\psi(N)-N=\sum_{n=1}^{N-1}(N-n)R(n)-N$.
These identities explain exactly why a small unweighted response does not give the required prime-error estimate.

## Adding division-count memory

Let $\nu_t(d)$ sum strict chains from $d$ to 1 with weight $(-t)^r$ for $r$ steps. In the finite incidence algebra,

```math
\nu_t=(\delta_1+t(\mathbf1-\delta_1))^{-1},\qquad
\nu_1=\mu,\qquad \nu'_1=\mu*\mu-\mu.
```

If the complete-chain readout is multiplied by its full division count, its value is

```math
L_p=\left.\frac{d}{dt}(t\nu_t*v_p)\right|_{t=1}
=\mu*G_p,\qquad
L_p(n)=\mathbf1_{v_p(n)=1}\mu(n/p).
```

Summing with $\log p$ gives $\sum_p\log p\,L_p(n)=-\mu(n)\log n$. This agrees with the classical [logarithmic Möbius identity](https://dlmf.nist.gov/27.5.E5), differentiated in the incidence parameter. More generally,

```math
\nu_t*v_p=\sum_{j\ge0}(t-1)^j(\mu-\delta_1)^{*j}*G_p.
```

At each fixed integer argument the sum is finite. Thus every polynomial division-count marking stays within this explicit Möbius convolution algebra. These facts restrict the two specified constructions; they do not exclude a different marking with additional chronological information. Neither signed telescoping nor a postulated finite susceptibility supplies a bound for the actual selected forcing.
