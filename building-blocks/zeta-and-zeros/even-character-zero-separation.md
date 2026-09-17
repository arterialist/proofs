# Even-character families separate possible zeta zeros

A single numerator $L(s,\chi)$ might cancel a zero in $L(s,\chi)/\zeta(s)$. The full family of primitive even nonprincipal characters at unbounded prime conductors cannot do so. The finite character identity below proves this separation, with an explicit conductor bound at any possible right-half zero. The holomorphic-quotient consumer is RH-equivalent and remains an unproved premise. These are written proofs using classical character, Hurwitz-zeta and Abel-summation methods; no Lean formalization or priority claim is made.

## 1. The exact normalized character sum

Fix an odd prime q and let E_q be its even nonprincipal Dirichlet characters. Every member is primitive because q is prime. Define

$$
 \mathcal A_q(s)=\frac2{q-1}\sum_{\chi\in E_q}L(s,\chi).
 \tag{E1}
$$

The number of summands is $(q-3)/2$; thus (E1) is not the arithmetic mean over that set. At $q=3$ the family is empty. For Re s>0 and s≠1,

$$
 \boxed{\mathcal A_q(s)=
 q^{-s}\{\zeta(s,1/q)+\zeta(s,1-1/q)\}
 -\frac2{q-1}(1-q^{-s})\zeta(s).}                         \tag{E2}
$$

Here ζ(s,a) is the actual Hurwitz zeta function and all positive real powers use their real logarithms. The formula is a finite Fourier identity, not a limit of characters or an interchange with a conditionally convergent series.

To prove it, the even-character orthogonality projector is

$$
 \sum_{\chi\text{ even mod }q}\chi(a)
 =\frac{q-1}{2}\,\mathbf1_{a\equiv1\text{ or }-1\pmod q}
 \qquad(q\nmid a).
$$

It follows by applying the ordinary character orthogonality formula to a and −a and dividing their sum by two. Insert it into the finite Hurwitz representation of each L-function. Subtract the principal character, whose L-function is (1−q^(−s))ζ(s). This gives E2. The primary identities are recorded in [DLMF25.15.3](https://dlmf.nist.gov/25.15.E3) and [DLMF27.8.6](https://dlmf.nist.gov/27.8.E6); the prime-modulus primitivity statement is given in the latter section.

## 2. Paired Hurwitz expansion and a quantitative remainder

There is an explicit approximation retaining the possible zeta-zero factor:

$$
 \boxed{\mathcal A_q(s)=1+
 \left(2q^{-s}-\frac{2(1-q^{-s})}{q-1}\right)\zeta(s)
 +R_q(s),}                                                \tag{E3}
$$
$$
 |R_q(s)|\le
 |s(s+1)|\left(2^{\sigma+2}+
                    \frac{2^{\sigma+1}}{\sigma+1}\right)
 q^{-\sigma-2},\qquad \sigma=\Re s>0,\quad s\ne1.          \tag{E4}
$$

Use the recurrence ζ(s,1/q)=q^s+ζ(s,1+1/q). For f(a)=ζ(s,a), the paired real Taylor remainder has the integral formula

$$
 f(1+h)+f(1-h)-2f(1)
 =\int_0^h(h-t)\{f''(1+t)+f''(1-t)\}\,dt.
$$

For h=1/q and q≥3, every argument lies inside [1/2,3/2]. The Hurwitz derivative identity gives f''(a)=s(s+1)ζ(s+2,a). This follows by two differentiations, with no singular argument since Re(s+2)>2. The absolutely convergent series and its decreasing real majorant give

$$
 |\zeta(s+2,a)|\le
 a^{-\sigma-2}+\frac{a^{-\sigma-1}}{\sigma+1}
 \le2^{\sigma+2}+\frac{2^{\sigma+1}}{\sigma+1}.
$$

The integral of the two triangular weights is h². Multiplication by q^(−s) proves E3–E4. The recurrence and derivative formulas are recorded in [DLMF25.11.3](https://dlmf.nist.gov/25.11.E3) and [DLMF25.11.17](https://dlmf.nist.gov/25.11.E17). Taylor's formula is applied in the positive real a variable; no branch cut is crossed.

Consequently A_q(s) tends to1 as q tends to infinity through primes, locally uniformly on {Re s>0, s≠1}. On a compact subset, σ has a positive minimum, |s(s+1)| and |ζ(s)| are bounded, and every term on the right of E3 except1 tends uniformly to zero. Thus, for every point in this domain and every sufficiently large prime q, at least one χ∈E_q has L(s,χ)≠0. No claim that a single fixed character is nonzero throughout the domain follows.

## 3. Separation at every possible zero

A stronger quantitative statement holds at a possible zeta zero. If

$$
 \zeta(s)=0,\qquad \frac12<\Re s\le1,\qquad |\Im s|\le T,
$$

then the middle term of E3 vanishes exactly and

$$
 |\mathcal A_q(s)-1|\le10(T+2)^2q^{-5/2}.                 \tag{E5}
$$

Indeed, |s(s+1)|≤(T+2)². On 0<σ≤1, 2^(σ+2)≤8 and 2^(σ+1)/(σ+1)≤2: the convex function 2^r is bounded by its chord 2r on 1≤r≤2. Hence the constant in parentheses in E4 is at most10. Also q^(−σ−2)≤q^(−5/2) on the stated range. Therefore every prime q≥5 with

$$
 q^{5/2}>20(T+2)^2                                      \tag{E6}
$$

has a primitive even nonprincipal character whose numerator does not vanish at s. In fact the maximum of |L(s,χ)| over χ∈E_q exceeds1/2, since |A_q(s)|>1/2 and its sum-of-coefficient magnitudes is (q−3)/(q−1)<1. The character can depend on the point $s$. More precisely the maximum is at least $(q-1)|\mathcal A_q(s)|/(q-3)>1/2$. This is conditional only on the point being an actual zeta zero; it does not assert that such an off-line zero exists.

## 4. Exact holomorphic-family criterion

The holomorphic-family consumer is precise. Let Q be any unbounded set of odd prime conductors. Suppose, for every q∈Q and every χ∈E_q, there exists a function H_χ holomorphic on Re s>1/2 and satisfying

$$
 \zeta(s)H_\chi(s)=L(s,\chi)\quad(\Re s>1).              \tag{E7}
$$

Then full RH follows. On the connected punctured half-plane {Re s>1/2, s≠1}, the identity theorem extends E7 without dividing by unknown zeta values. A zero s₀ there would force every numerator in every selected conductor to vanish at s₀. Choose q sufficiently large in Q and apply E3, or E5 when a height bound is supplied. This is a contradiction. Zeta has no zeros for Re s>1 by the Euler product, and its simple pole is at1, so this excludes every right-half nontrivial zero. The actual zeta functional equation then excludes left-half nontrivial zeros by reflection, by the [classical zeta zero symmetry](https://dlmf.nist.gov/25.10).

This includes arbitrary zero multiplicity. If $\zeta$ vanishes to order $m\ge1$ at $s_0$ and the selected numerator is nonzero there, then its quotient has a pole of order $m$. No simple-zero assumption is used.

Conversely, under RH these quotients are holomorphic on Re s>1/2: zeta is nonzero away from1 there, and its reciprocal has a zero at the simple pole1. Nonprincipal $L$-functions are [entire](https://dlmf.nist.gov/25.15). Thus E7, quantified over the specified family, is an RH-equivalent holomorphic condition. It is not an available assumption in an unconditional proof.

## 5. Actual twisted coefficients and the Abel endpoint

For the cyclotomic character consumer, put a_χ=μ*χ with the actual Dirichlet convolution, including every prime power. An unproved but sufficient arithmetic premise is

$$
 \forall q\in Q\ \forall\chi\in E_q\ \forall\varepsilon>0,
 \qquad \sum_{n\le x}a_\chi(n)=O_{\chi,\varepsilon}
                       (x^{1/2+\varepsilon}).            \tag{E8}
$$

There is no requirement that the implied constants be uniform in the conductor for this implication. The conductor prime is retained: for a character modulo $q$, $a_\chi(q)=-1$ and $a_\chi(q^j)=0$ for $j\ge2$. For each fixed $\chi$, write $S_\chi(x)=\sum_{n\le x}a_\chi(n)$. The exact finite Abel formula, with its endpoint, is

$$
 \sum_{n\le R}a_\chi(n)n^{-s}
 =S_\chi(R)R^{-s}+s\int_1^R S_\chi(x)x^{-s-1}\,dx.
$$

Here $a_\chi(1)=S_\chi(1)=1$, so no extra lower-boundary term is required. The atom at $1$ is included, and the identity also holds at $R=1$. Under (E8), the upper-boundary term tends to zero locally uniformly in $\Re s>1/2$. Abel summation therefore constructs

$$
 H_\chi(s)=s\int_1^\infty
       \left(\sum_{n\le x}a_\chi(n)\right)x^{-s-1}\,dx.
$$

The all-epsilon bound makes the integral locally uniformly holomorphic on Re s>1/2. On a compact set choose ε strictly smaller than the distance of its real parts from1/2; the resulting integrable power also dominates logarithmic derivatives. Initially in Re s>1, |a_χ(n)|≤d(n) gives absolute Dirichlet convergence and H_χ=L(s,χ)/ζ(s), using the actual Möbius inverse. Hence E8 implies E7 and full RH. No converse from RH to the summatory bounds E8 is claimed here.

## 6. Attribution and exact normalization checks

The method is finite character orthogonality combined with the small-argument Hurwitz recurrence and standard Abel continuation. The full primitive even family removes a possible common-zero cancellation left unresolved by a single fixed-character quotient. This is a classical-method synthesis for the current dependency, with no novelty claim. It does not establish E7 or E8, bound cyclotomic unit deficits, validate a Farey-interaction estimate, or prove RH.

The [exact normalization certificate](../../certificates/even_character_zero_separation.py) uses both roots of order $(q-1)/2$ for the even subgroup and roots of order $q-1$ for the full character group. The latter includes the empty family at $q=3$. It verifies the finite projector, the paired Taylor identity for an arbitrary polynomial of degree at most six, and the actual identity $1*(\mu*\chi)=\chi$ through $n=32$ for the even nonprincipal character modulo $5$, retaining its conductor prime and square. Run `python3 certificates/even_character_zero_separation.py` from this directory with Python 3 and SymPy. All exact assertions pass.

These checks concern finite algebraic normalizations. The universal nonvanishing-family result and conditional analytic implications are the written proofs above. Neither (E7) nor (E8), a bound for cyclotomic deficits, or a Farey-interaction estimate is supplied here. Replacing the family by a finite set of characters, or by one preselected character at each conductor, is not justified by this argument.
