# Exact valuation reduction and neutral old updates

There is a useful exact reduction, but dividing conductor and index by their gcd is not always valid. The universally allowed divisor is

$$
h=\gcd\!\left(n,\frac N{\operatorname{rad}N}\right),
$$

and it gives

$$
\boxed{\Phi_N(\zeta_n^a)=\Phi_{N/h}(\zeta_{n/h}^a).} \tag{1}
$$

After this reduction, every prime still common to conductor and index occurs to exponent one in the index. There is also a concrete neutral-update filter: if a prime factor of the reduced index is congruent to either 1 or −1 modulo the reduced conductor, then the full logarithmic increment is zero at every embedding. A valuation gap by itself, in either direction, does not imply neutrality.

Throughout, $2\le n<N$, $n\nmid N$, and $(a,n)=1$. Thus the root is old and the new cyclotomic factor does not vanish there. All evaluations and logarithms are of the actual factor $\Phi_N$; no scalar or unit normalization is silently removed.

## The maximal radical-preserving common reduction

The elementary polynomial identity

$$
\Phi_N(z)=\Phi_{\operatorname{rad}N}
                 (z^{N/\operatorname{rad}N})
$$

implies, for every divisor $t\mid N/\operatorname{rad}N$,

$$
\Phi_N(z)=\Phi_{N/t}(z^t). \tag{2}
$$

Indeed $N/t$ retains every prime factor of $N$, and both sides reduce to the same expression with index $\operatorname{rad}N$. Taking the largest such $t$ that also divides $n$ gives (1). This common divisor is maximal for the universal polynomial identity. In fact, for any $t\mid N$,

$$
\frac{\varphi(N)}{t\varphi(N/t)}
=\prod_{\substack{p\mid N\\p\nmid N/t}}(1-1/p).
$$

Degree comparison shows that $\Phi_N(z)=\Phi_{N/t}(z^t)$ can hold only when dividing by $t$ removes no prime from the index, equivalently $t\mid N/\operatorname{rad}N$. The converse was proved above. This does not exclude accidental additional equalities at particular roots.

Put $n_0=n/h$, $N_0=N/h$. At a prime with $f=v_p(n)$ and $e=v_p(N)>0$, the removed exponent is $\min(f,e-1)$. Therefore

$$
\begin{array}{c|c|c}
\text{condition}&v_p(n_0)&v_p(N_0)\\ \hline
e>f&0&e-f\\
1\le e\le f&f-e+1&1.
\end{array} \tag{3}
$$

Let $g=\gcd(n,N)$. The following conditions are equivalent:

- $h=g$;
- $v_p(N)>v_p(n)$ at every prime common to $n$ and $N$;
- $(n_0,N_0)=1$.

Under these conditions, the full gcd reduction is justified:

$$
\Phi_N(\zeta_n^a)=\Phi_{N/g}(\zeta_{n/g}^a),
\qquad (n/g,N/g)=1. \tag{4}
$$

No embedding twist is needed in (1) or (4), because the removed divisor divides the conductor and $\zeta_n^h=\zeta_{n/h}$ with the standard roots. The original exponent $a$ remains coprime to the new conductor. These statements are exact for every embedding simultaneously.

## Prime-adic ratio, including both conductor levels

Write

$$
N=p^e m,\qquad n=p^f s,
\qquad p\nmid ms,\qquad e\ge1,
$$

and define

$$
\xi=\zeta_n^{a p^{e-1}}.
$$

The exact prime-power identity gives

$$
\boxed{\Phi_N(\zeta_n^a)
=\frac{\Phi_m(\xi^p)}{\Phi_m(\xi)}.} \tag{5}
$$

The two arguments have orders

$$
\operatorname{ord}(\xi)=p^{\max(f-e+1,0)}s,
\qquad
\operatorname{ord}(\xi^p)=p^{\max(f-e,0)}s. \tag{6}
$$

Thus when $e\le f$, the numerator and denominator generally belong to different conductor levels. Treating them as a quotient of conjugates at a conductor coprime to $m$ would be unjustified.

Neither factor in (5) vanishes under $n\nmid N$. For example, if the numerator vanished, its argument would have order $m$, which is coprime to $p$. Formula (6) would then force $f\le e$ and $m=s$, hence $n\mid N$, a contradiction. The denominator is handled similarly. No limit at a zero, and therefore no omitted derivative factor $p$, occurs in (5).

The separate numerator and denominator need not be algebraic units. For instance, when the residual conductor is five and $m=1$, both are differences from one with norm five. Their quotient can nevertheless be a unit. Thus one must retain the full quotient rather than silently replace each factor by a normalized unit.

When $e>f$, both arguments have conductor $s$, and (5) becomes

$$
\xi=\zeta_s^{a p^{e-f-1}},
\qquad
\Phi_N(\zeta_n^a)=\frac{\sigma_p(\Phi_m(\xi))}{\Phi_m(\xi)},
\tag{7}
$$

where $\sigma_p$ is the automorphism of $\mathbf Q(\zeta_s)$ sending $\zeta_s$ to $\zeta_s^p$. It is an automorphism of this residual field; if $p\mid n$, it is not the map $\zeta_n\mapsto\zeta_n^p$ as an automorphism of the original field.

## A neutral-update condition valid at every embedding

If $e>f$ and $p\equiv1\pmod s$, equation (7) is exactly one. If $e>f$ and $p\equiv-1\pmod s$, its numerator is the complex conjugate of its denominator, so its modulus is one. Reciprocity makes the value explicit:

$$
\Phi_N(\zeta_n^a)=
\begin{cases}
1,&p\equiv1\pmod s,\\
\xi^{-\varphi(m)},&p\equiv-1\pmod s,\ m>1,\\
-\xi^{-1},&p\equiv-1\pmod s,\ m=1.
\end{cases} \tag{8}
$$

If the two congruences coincide, the first case can be used. Under the standing nondivisibility condition, the problematic case $s=1$ cannot occur with $e>f$. These are roots of unity, so the full increment $\log|\Phi_N(\zeta_n^a)|$ is zero, not merely zero on average.

The strongest immediate version applies (8) after the common reduction (1):

$$
\boxed{
\text{If some prime }p\mid N_0\text{ satisfies }
p\nmid n_0\text{ and }p\equiv\pm1\pmod{n_0},
\text{ then }|\Phi_N(\zeta_n^a)|=1\text{ for every }a.
} \tag{9}
$$

This removes the entire old update at that conductor and index, independent of its actual Farey weight and of the current sign of the derivative log. It can therefore be used inside the remaining interior interaction without estimating that update absolutely.

In particular, if the reduced conductor $n_0$ belongs to $\{2,3,4,6\}$, every old nondivisor update is neutral. Indeed common primes occur only once in $N_0$, and $N_0>n_0$, so $N_0$ must contain a prime coprime to $n_0$; every such prime is $\pm1\pmod{n_0}$. This includes large original conductors whose excess common index powers reduce them into one of these four conductors.

For example, $n=12,N=16$ gives

$$
\Phi_{16}(z)\equiv1-z^2\pmod{\Phi_{12}(z)},
\qquad |1-\zeta_{12}^{2a}|=1.
$$

Here the residual conductor after removing the common powers of two is three, and the index prime two acts by conjugation. As another example, $n=8,N=12$ first reduces to $(n_0,N_0)=(4,6)$, where the index prime three is −1 modulo four. Looking only at three modulo the unreduced conductor eight would miss this neutral update.

Condition (9) is sufficient, not necessary. Exact reduction in the small quotient ring gives

$$
\Phi_{385}(z)\equiv1\pmod{\Phi_{24}(z)},
$$

although none of the prime factors $5,7,11$ of 385 is congruent to $\pm1\pmod{24}$, and no common reduction applies. This note does not undertake the separate character-theoretic classification of such combined cancellations.

## A broader sufficient filter from signed divisor residues

The extra neutral case has an elementary certificate that does not require characters. For $1\le t\le\lfloor n/2\rfloor$, define

$$
C_{n,N}(t)=
\sum_{\substack{d\mid N\\
\min(d\bmod n,\,n-(d\bmod n))=t}}
\mu(N/d).
\tag{10}
$$

No divisor in this sum has residue zero, because $n\nmid N$. Grouping the nonzero factors in the Möbius product by their residues up to sign gives the exact formula

$$
\log|\Phi_N(\zeta_n^a)|=
\sum_{t=1}^{\lfloor n/2\rfloor}
C_{n,N}(t)\log|1-\zeta_n^{at}|.
\tag{11}
$$

Each divisor is counted once, including the self-opposite residue $n/2$ when $n$ is even; there is no extra factor of two. Thus

$$
\boxed{C_{n,N}(t)=0\text{ for every }t
\quad\Longrightarrow\quad
|\Phi_N(\zeta_n^a)|=1\text{ for every }(a,n)=1.} \tag{12}
$$

Multiplication by an invertible $a$ permutes the residue classes modulo sign, including nonunit residue classes, so the same cancellation works at every embedding. This is a sufficient combinatorial neutrality condition. No necessity claim is made for composite conductors, where additional multiplicative relations between chord values must be considered.

Condition (12) contains the prime congruence filter. In the reduced pair, write $N_0=p^e m$ with $p\nmid m$ and $p\equiv\pm1\pmod{n_0}$. The nonzero Möbius coefficients pair divisors $p^{e-1}d$ and $p^e d$, $d\mid m$, with opposite signs. They have the same residue up to sign and cancel. This also lifts through the common reduction: any divisor of $N$ with nonzero Möbius coefficient is divisible by $h$, and its folded residue modulo $n$ is $h$ times the corresponding folded residue modulo $n_0$.

For $(n,N)=(24,385)$, the eight divisors are

$$
1,5,7,11,35,55,77,385.
$$

Their folded residues are respectively $1,5,7,11,11,7,5,1$, and their Möbius coefficients are $-1,+1,+1,+1,-1,-1,-1,+1$. Consequently

$$
\{t:C_{24,385}(t)\}=
\{1:0,\ 5:0,\ 7:0,\ 11:0\},
$$

with zero also on every unlisted class. This certifies the exact neutral update already found in the quotient ring. It is an actual point in the surviving interior at terminal cutoff $X=385$: $n=24>\sqrt X$ and $N-n=361>\sqrt N$. Thus the filter removes at least a concrete interior interaction beyond the separately controlled conductor and age bands. No density estimate or novelty claim follows from this fixture.

## Precise failures of stronger valuation claims

Naive gcd reduction already fails at $(n,N)=(10,14)$, with $g=2$. Exact quotient-ring calculation gives

$$
\Phi_{14}(z)\equiv1-z\pmod{\Phi_{10}(z)}.
$$

At $a=1$, its modulus is $2\sin(\pi/10)=\gamma^{-1}$, where $\gamma=(1+\sqrt5)/2$. But the proposed reduced value $\Phi_7(\zeta_5)$ equals $1+\zeta_5$, of modulus $\gamma$. Both the value and its modulus change. The shared prime two has equal valuations, so the radical-preserving condition is absent.

An arbitrarily stated gap of at least two in the index valuation is also insufficient. At $(n,N)=(10,16)$,

$$
v_2(N)-v_2(n)=3,
\qquad
\Phi_{16}(z)\equiv1-z^3\pmod{\Phi_{10}(z)}.
$$

Its magnitudes include $\gamma$ at $a=1$ and $\gamma^{-1}$ at $a=3$. The correct conductor reduction is coprime, but the residual prime two is neither 1 nor −1 modulo five; being in a coprime conductor does not force neutrality.

A gap in the opposite direction is no better. At $(n,N)=(16,20)$,

$$
v_2(n)-v_2(N)=2,
\qquad
\Phi_{20}(z)\equiv-z^6+z^4-z^2\pmod{\Phi_{16}(z)}.
$$

At $a=1$, this has modulus $\sqrt2-1<1$; at $a=3$, it has modulus $\sqrt2+1>1$. Here the justified common reduction is only $(16,20)\mapsto(8,10)$. Dividing by the full gcd four would instead predict $\Phi_5(\zeta_4)=1$, which is wrong.

## Two consequences and their limits

First, in every old nondivisor sector [the classical cyclotomic resultant formula, Theorem 9](https://archive.mpim-bonn.mpg.de/1705/1/preprint_2016_45.pdf) gives

$$
\prod_{\substack{a\bmod n\\(a,n)=1}}
|\Phi_N(\zeta_n^a)|=1. \tag{13}
$$

This is also the norm-one update consequence of the previously established scalar/unit decomposition, since the scalar factor does not jump when $n\nmid N$. Therefore an increment nonnegative at every embedding must be zero at every embedding. There is no additional class of strictly favorable, phase-uniform nondivisor updates between “neutral” and “some negative embedding.” This says nothing about an individual phase, a subset of embeddings, or a weighted signed sum.

Second, fix $n=p^f s$ and $m$ coprime to $p$, with $s\nmid m$, as required by the standing nondivisibility condition when $e>f$. As the index exponent $e>f$ increases, the values in (7) follow a fixed Galois orbit in $\mathbf Q(\zeta_s)$. In particular,

$$
\Phi_{p^{e+1}m}(\zeta_n^a)
=\sigma_p\!\left(\Phi_{p^e m}(\zeta_n^a)\right).
$$

They repeat pointwise after $\operatorname{ord}_s(p)$ increases of the exponent. The multiset of magnitudes over all original embeddings, with multiplicities retained, is unchanged once $e>f$. The example $n=10$ has exact value period four for the powers of two above its conductor valuation: $\Phi_{256}\equiv\Phi_{16}\pmod{\Phi_{10}}$. This is a genuine bounded-conductor orbit constraint. It does not imply cancellation for the actual old-root statistic: the weights and the previous derivative deficits change between these indices.

## Exact verification and attribution

[the exact quotient-ring checker](../../certificates/cyclotomic_valuation_update.py) checked all 1,569 pairs $2\le n<N\le60$ with $n\nmid N$ in $\mathbf Q[z]/(\Phi_n)$. It verified (1), the valuation table and coprimality criterion, 2,697 instances of the prime-adic relation (5), and the exact resultant norm one. The 1,176 pairs satisfying the full-gcd criterion include coprime pairs where that reduction is trivial.

The checker found 370 prime congruence certificates, with repeated certificates possible for one pair, and verified each against the exact root-of-unity expression (8), transferred back through (1). They cover 319 neutral pairs in this finite range. It independently checks the counterexamples above, their squared-modulus polynomials, the residual-field orbit, and the additional neutral case $(24,385)$ outside the sufficient filter. All assertions pass.

It also computes all signed folded divisor counts in the finite range, verifies each zero-count certificate against the exact quotient-ring value, verifies that every prime certificate gives zero folded counts, and checks the explicit $(24,385)$ counts and its surviving-interior inequalities. The finite checks do not establish that either sufficient criterion is a classification.

These are exact rational polynomial computations, supplemented by the explicit analytic identities above. They are not numerical sampling of embeddings and not a proof-assistant formalization. No asymptotic count of the surviving interior pairs is claimed. The useful conclusions are the justified conductor reduction, the explicit zero-update filter, and the warning that large valuation gaps alone do not create a favorable sign.

The prime-power identities, reciprocity and exact values for a prime congruent to $\pm1$ are classical. See [Bzdęga, Herrera-Poyatos and Moree, *Cyclotomic polynomials at roots of unity*, Lemma 2 and Lemmas 18–19](https://archive.mpim-bonn.mpg.de/1705/1/preprint_2016_45.pdf). Their Theorem 1 and Remark 20 give the more general character-annihilation mechanism. The proof above applies those identities to the full old update, with its maximal common reduction, and records the precise failure of valuation-gap sign rules. These are written proofs and exact finite checks, not Lean formalizations or a priority claim. The checker requires Python and SymPy. The [range refinements](cyclotomic-restricted-range-refinements.md) and [reduced-coordinate theorem](cyclotomic-activity-quadrature.md) give complementary absolute estimates.
