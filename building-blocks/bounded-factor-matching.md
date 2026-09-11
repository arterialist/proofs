# Bounded-ratio matching: the full three-step closure also fails the cost target

The time-dependent dual obstruction extends to the full odd path closure of length at most three, including its endpoint ratios up to 8. A finite nonresonance certificate for the actual H-values repairs the head-neighbor argument. For every fixed k>12, the corrected positive matching-cost energy satisfies

```math
 \mathcal K_X\gg_k\frac{X^{5-12/k}}{(\log X)^{2k}}.
 \tag{B1}
```

Thus k=13 already disproves the proposed all-epsilon O(X^(4+epsilon)) bound for this enlarged graph. The exponent is 53/13, and every epsilon<1/13 is excluded. Matchings may vary with time and may be chosen independently for the prefix and suffix. The result concerns the positive matching-cost majorant. Signed coarse-primitive cancellation and RH remain open.

The new proof does not require every permitted head edge to stay expensive throughout the late interval. It bounds the measure of the times when any of them is cheap.

## 1. Definitions and retained terms

Use the actual divisor source and its integrated observables:

```math
 H(q)=\log(q!)-\sum_{d\le q}\lfloor q/d\rfloor+2\gamma q,
 \quad H(0)=0,\quad
 A(y)=\int_0^yH(\lfloor u\rfloor)\,du,
```
```math
 v_n(t)=n[A(t/n)-A(X/n)],\qquad
 u_n(t)=n[A(2X/n)-A(t/n)]. \tag{B2}
```

X is a positive integer, N=2X-1, and all vertices are actual squarefree n<=N with their actual Möbius signs. The original graph connects apr to aq, where p,r,q are three distinct primes, a is squarefree and coprime to prq, and the endpoint ratio is in [1/2,2]. The enlarged graph G3 joins endpoints of original odd paths of length at most three. Repetitions are harmless; they add no endpoint pairs beyond allowing the original edges. Opposite Möbius parity is preserved.

For each graph let C(f) be the minimum, over partial matchings, of the sum of |f_n| on unmatched vertices and |f_n-f_m| on matched edges. C0 is the complete opposite-sign relaxation, and Gamma=C-C0>=0. Retain

```math
 d_X(t)=\int_X^t(2\gamma+\{x\})\,dx,\qquad D_X=(2\gamma+1/2)X,
```
```math
 \mathcal K_X=\int_X^{2X}
 \bigl([C(v(t))+d_X(t)]^2+
       [C(u(t))+D_X-d_X(t)]^2\bigr)\,dt. \tag{B3}
```

Both correction terms are nonnegative. The exact inverse gives sum mu(n)v_n=P_X+d_X and sum mu(n)u_n=R_X+D_X-d_X, for the actual prefix and suffix integrals of psi(x)-x. All prime powers remain in the underlying identity. Squareful labels have zero coefficient, and the label 2X has zero primitive on this interval. Integer endpoint values have measure zero and no omitted integrated correction. The lower bound below uses only B3's prefix term; it does not discard that term's correction or redefine the signed error.

## 2. Number of neighbors of a many-prime label

The following counting fact does not use the observable. Suppose an edge satisfies

```math
 \omega(n/\gcd(n,m))\le r, \tag{B4}
```

where n is a product of k>r distinct primes, each at least (alpha X)^(1/k). Put

```math
 L=(\alpha X)^{1-r/k},\qquad
 D_{k,r}=\sum_{j=0}^{r}\binom{k}{j}.
```

Its gcd with m retains at least k-r of those source factors and is at least L. There are at most D_(k,r) possible gcd divisors of n, obtained by deleting at most r of its factors. For each possible divisor a, there are at most floor(2X/a) integer multiples within the cutoff. Counting all of them, even inadmissible ones, proves

```math
 \deg(n)\le\sum_a\lfloor2X/a\rfloor
                  \le\frac{2D_{k,r}X}{L}. \tag{B5}
```

The degree estimate is an upper bound and does not assume these potential neighbors exist. Each distinct actual neighbor also satisfies |n-m|>=gcd(n,m)>=L.

Every edge of G3 satisfies B4 with r=6, in both orientations. Each original move deletes at most two factors present at its source. Any factor of the initial label absent from the final label must have been deleted in one of the three moves. There are at most six such distinct initial factors, even if factors are later reintroduced. Multiplying the three original endpoint ratios also gives

```math
 n/8\le m\le8n. \tag{B6}
```

The proof below applies to the larger graph of all opposite-sign squarefree endpoint pairs obeying B4 in both orientations and B6. It therefore applies to G3 without needing a characterization of which potential paths exist.

## 3. Actual finite nonresonance

Fix alpha=13/8, beta=7/4, t0=15/8, and let the late interval I_X=[t0 X,2X] have length ell X=X/8. Take n in [alpha X,beta X]. A head neighbor m<X satisfying B6 has m>=13X/64. For t in I_X,

```math
 1\le\lfloor t/m\rfloor\le\lfloor128/13\rfloor=9. \tag{B7}
```

Write h1=H(1). The [exact rational calculation](certificates/matching_nonresonance.py) proves

```math
 h1>3/20,\qquad
 |H(q)-h1|>\delta:=37/1000\quad(2\le q\le9). \tag{B8}
```

For orientation, the certified intervals lie within 10^-12 of the following displays:

| q | H(q)-H(1) |
|---:|---:|
| 2 | -0.152421489637 |
| 3 | 0.100622128834 |
| 4 | -0.358652180243 |
| 5 | 0.405217061994 |
| 6 | -0.648592138975 |
| 7 | 0.451749339884 |
| 8 | -0.314377788633 |
| 9 | 0.037278118506 |

The finite inequalities follow from a positive rational logarithm series and a digamma remainder. After range reduction to $1\le r\le2$, use

```math
\log r=2\sum_{j=0}^{59}\frac{z^{2j+1}}{2j+1}+E,\quad
z=(r-1)/(r+1),\quad0\le E\le\frac{2z^{121}}{121(1-z^2)}.
```

For $N=100$, Euler's constant lies between $H_N-\log N-1/(2N)+1/(12N^2)-1/(120N^4)$ and the same expression without its final term, by [DLMF 5.11.2 and §5.11(ii)](https://dlmf.nist.gov/5.11). The certificate evaluates the finite formulas with Python's exact rational arithmetic. Run `python3 certificates/matching_nonresonance.py` from this directory; no third-party packages are required. It checks only the finite inequalities used by the proof. No assertion for all quotient values $q$ is made.

## 4. Cheap head edges occupy short time intervals

For n in the displayed terminal range and t in I_X, its prefix is v_n(t)=h1(t-n). For any fixed head neighbor m<X, define f_m(t)=v_m(t)-v_n(t). On the part of I_X with floor(t/m)=q, the function is affine and

```math
 f_m'(t)=H(q)-h1. \tag{B9}
```

Each q occurs on at most one interval. For q>=2, B8 implies that the set |f_m(t)|<Y occupies at most 2Y/delta of that interval, independently of its intercept. There are at most eight such intervals.

The q=1 piece has zero slope, so it must be handled separately. If t/m<2 and m<X, all preceding points in the integral from X to t also have quotient 1. Hence v_m(t)=h1(t-X) and

```math
 f_m(t)=h1(n-X)\ge h1(\alpha-1)X. \tag{B10}
```

When Y does not exceed this bound, the q=1 piece has no bad times. Therefore

```math
 \bigl|\{t\in I_X: |v_m(t)-v_n(t)|<Y\}\bigr|
                   \le16Y/\delta. \tag{B11}
```

This also covers cells truncated by either endpoint of I_X. Values at floor jumps are continuous for the primitives, and individual endpoints have zero measure.

Terminal neighbors need no time exclusion. If m>=X and m<=t, their prefix gap is h1|n-m|>=h1 L. If m>t, the gap is v_n(t)>=h1(t0-beta)X. The unmatched cost at n satisfies the same latter bound. Thus they are always at least Y provided

```math
 Y\le h1 L,\qquad Y\le h1(t_0-\beta)X. \tag{B12}
```

## 5. A feasible dual on enough times

Fix k>12, set r=6 and D=D_(k,6), and choose

```math
 c=\frac{\delta}{512D},\qquad Y=cL.
 \tag{B13}
```

For X>=1, L<alpha X. Since h1>3/20, this c obeys B10 and B12, including their required Y inequalities. For example c<=0.037/512, which is already smaller than (3/20)(t0-beta)/alpha. No unproved threshold estimate for gamma is used here.

Let T_n be the times when the unmatched cost at n and every incident edge cost are at least Y. A union bound using B5 and B11 gives

```math
 |I_X\setminus T_n|
 \le\frac{2DX}{L}\frac{16cL}{\delta}
 =\frac{32Dc}{\delta}X=\frac{X}{16}.
```

Consequently each label has at least half the late interval available:

```math
 |T_n|\ge X/16=|I_X|/2. \tag{B14}
```

The set of good times can differ with n. The argument does not require a common interval on which all family labels are simultaneously good.

Now let S_X consist of the products of k distinct primes in [(alpha X)^(1/k),(beta X)^(1/k)], and let M_X be the exact number of primes in this closed interval. Its difference from the corresponding difference of pi-values is at most one, accounting for the lower endpoint. Unique factorization and the unconditional prime number theorem give, for all sufficiently large X,

```math
 |S_X|=\binom{M_X}{k}
       \gg_k X/(\log X)^k. \tag{B15}
```

All its labels are actual vertices in [alpha X,beta X] with the same Möbius sign. Define the measurable integer-valued count

```math
 J(t)=\sum_{n\in S_X}{\bf1}_{T_n}(t).
```

At each time assign raw dual value z_n(t)=Y on these good family labels and zero elsewhere. The unmatched constraints z_n<=|v_n| hold by definition. No edge has two positive dual endpoints, since the family has one Möbius sign. Every edge with one positive endpoint satisfies z_n+z_m<=|v_n-v_m| by the definition of T_n. Summing these constraints over any partial matching proves

```math
 C(v(t))\ge YJ(t),\qquad
 \int_{I_X}J(t)\,dt\ge\frac{X}{16}|S_X|. \tag{B16}
```

Cauchy-Schwarz on I_X and d_X>=0 now give the explicit lower bound

```math
 \begin{aligned}
 \mathcal K_X&\ge Y^2\int_{I_X}J(t)^2\,dt\\
 &\ge Y^2\frac{(X|S_X|/16)^2}{X/8}
 =\boxed{\frac{c^2}{32}X L^2|S_X|^2}.
 \end{aligned} \tag{B17}
```

Combining B15 and B17 proves B1. For k=13 the exact constants in the construction are

```math
 D_{13,6}=4096,\quad L=(13X/8)^{7/13},
 \quad c=37/2097152000.
```

These small constants do not affect the asymptotic exclusion. The prime number theorem is used only in a fixed-ratio prime interval with fixed k. No short-interval or prime-correlation conjecture enters.

The dual bounds C=C0+Gamma. It need not be feasible for the complete relaxation. Consequently no separate lower bound on C0 or Gamma follows without further information, except Gamma>=max(0,YJ-C0). Most importantly, the dual does not bound the signed sum in the exact inverse from below. The large mean and the signed error remain subject to cancellation.


The dual argument is finite weak matching duality; the only prime-distribution input is the classical prime number theorem on a fixed-ratio interval. The finite source estimates are supported by the [published actual-H bounds](BuildingBlocks/DivisorForcingBound.lean). This is a useful arithmetic application, with exact priority unresolved. It does not bound the signed coarse energy from below and has no Lean formalization.
