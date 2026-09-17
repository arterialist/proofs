# Relative norms under a common cyclotomic scale

For integers $g\ge1$, $m>q\ge2$ and $(q,m)=1$, there is an exact reduced-conductor formula for the unit $\Phi_{gm}(\zeta_{gq})$. Its relative norm is a product of automorphic copies of Φ_m(ζ_q), with nonnegative integer exponents. The normalized logarithmic trace is a positive automorphism average times an explicit factor at primes shared by g and q. This does not discard those primes or assume the adjunction of a prime always increases the field degree.

The formula supplies a finite algebraic descent. Recovering the actual weighted, clipped old update requires additional fibre covariance and clipping defects, written explicitly below. No bound for those terms is proved here. The all-parameter results are written proofs. The accompanying exact symbolic certificates verify selected identities and the full-prefix fixture; no Lean formalization is claimed.

## 1. Fixed fields, embeddings and the norm formula

Let g≥1, q≥2, m>q be integers with gcd(q,m)=1. Put n=gq and N=gm. Choose ζ_t=exp(2πi/t), so ζ_{gq}^g=ζ_q, and identify K_q=Q(ζ_q) as a subfield of K_n=Q(ζ_n) through this equality. Let

$$
v=\Phi_m(\zeta_q),\quad \beta=\Phi_{gm}(\zeta_{gq}),\quad
D=[K_n:K_q]=\frac{\varphi(gq)}{\varphi(q)}.
$$

For a unit t modulo q, write σ_t(ζ_q)=ζ_q^t. Group-ring exponents have their usual multiplicative meaning: v^{Σe_tσ_t}=∏σ_t(v)^{e_t}. Let

$$
\mathcal P=\{\ell:\ell\text{ prime},\ \ell\mid g,\ \ell\nmid qm\},
\quad
 d_g=\frac g{\operatorname{rad}(g)}
       \prod_{\substack{\ell\mid g\\\ell\mid qm}}(\ell-1),
$$

with rad(1)=1 and empty products equal to one. Define

$$
\mathcal E_{g;q,m}
=d_g\prod_{\ell\in\mathcal P}(\ell-2+\sigma_{\ell^{-1}})
\in\mathbb Z[\operatorname{Gal}(K_q/\mathbb Q)].
$$

Every inverse here is modulo q. Then

$$
\boxed{N_{K_{gq}/K_q}\bigl(\Phi_{gm}(\zeta_{gq})\bigr)
=\Phi_m(\zeta_q)^{\mathcal E_{g;q,m}}.}\tag{N1}
$$

All coefficients of E are nonnegative integers, including after equal automorphisms are combined. Its augmentation is

$$
\operatorname{aug}(\mathcal E_{g;q,m})=
 d_g\prod_{\ell\in\mathcal P}(\ell-1)=\varphi(g).
\tag{N2}
$$

Thus N1 is more specific than an absolute norm-one statement. It gives the exact element of K_q, including its root-of-unity phase.

## 2. One prime step, including ramified and degree-one cases

Take integers u>v≥2 and a prime ℓ. Use η=ζ_{ℓv}, with η^ℓ=ζ_v, and put V=Φ_u(ζ_v). The prime cyclotomic identities are

$$
\Phi_{\ell u}(z)=
\begin{cases}
\Phi_u(z^\ell),&\ell\mid u,\\
\Phi_u(z^\ell)/\Phi_u(z),&\ell\nmid u.
\end{cases}
$$

If ℓ divides v, all ℓ roots of z^ℓ=ζ_v are primitive ℓv-th roots and constitute the relative orbit. If ℓ does not divide v, exactly one root has order v, namely ζ_v^{ℓ^{-1}}, and the other ℓ−1 constitute that orbit. This describes the actual embeddings fixing ζ_v.

When ℓ does not divide u, raising the primitive u-th roots to the ℓ-th power permutes them. Consequently

$$
\prod_{z^\ell=\zeta_v}\Phi_u(z)=\Phi_u(\zeta_v)=V.
$$

The possible product sign is (−1)^{(ℓ−1)φ(u)}=1, since u≥3. Therefore the relative norm of the denominator Φ_u(η) is V if ℓ|v, and V/σ_{ℓ^{-1}}(V) otherwise. Combining this with the numerator, whose relative norm is the appropriate field-degree power of V, proves

$$
\boxed{N_{K_{\ell v}/K_v}\Phi_{\ell u}(\zeta_{\ell v})=
\begin{cases}
V^\ell,&\ell\mid u\text{ and }\ell\mid v,\\
V^{\ell-1},&\ell\text{ divides exactly one of }u,v,\\
V^{\ell-2}\sigma_{\ell^{-1}}(V),&\ell\nmid uv.
\end{cases}}\tag{N3}
$$

No denominator vanishes in these formulas. In the denominator case ℓ∤u, its argument has order ℓv, which cannot equal u. Also V is nonzero because u>v.

For ℓ=2 and odd v, K_{2v}=K_v and the relative degree is one. If u is odd as well, the last line is just σ_{2^{-1}}(V), with no identity factor. Replacing this field step by $V$ would give the wrong embedding.

To compose, write g=ℓh and apply N3 with u=hm and v=hq. If ℓ|h, both indices are divisible by ℓ and the new factor is ℓ. If ℓ∤h but ℓ|qm, exactly one index is divisible by ℓ and the factor is ℓ−1. Otherwise the factor is ℓ−2+σ_{ℓ^{-1}}. Norms commute with these automorphisms after restriction, by Galois equivariance and the abelian cyclotomic Galois groups. Norm transitivity therefore gives N1. Repeated copies of each prime contribute ℓ^{v_ℓ(g)−1}; its last copy contributes the stated scalar or automorphism factor. This also proves independence of the order of prime removal.

The base value V=v is a unit without an additional resultant assumption. In its Möbius product every divisor d of m is coprime to q, and Σ_{d|m}μ(m/d)=0. Hence v is a product of integer powers of

$$
\frac{\zeta_q^d-1}{\zeta_q-1}.
$$

Each ratio is an algebraic integer and a unit: if de≡1 mod q, the geometric sum 1+ζ_q^d+...+ζ_q^{d(e−1)} is its inverse. N1 is thus a unit of K_q. Since β is an algebraic integer with relative norm a unit, its characteristic polynomial over K_q shows that β^{-1} is integral. This establishes the asserted unit property of the actual upper value.

## 3. Logarithmic trace and character action

Let G_t=(Z/tZ)^×. Reduction G_n→G_q is surjective, with fibres F_a={u∈G_n:u≡a mod q} of size D. Define the actual real logarithmic profiles

$$
L(u)=\log|\Phi_{gm}(\zeta_n^u)|,
\qquad \ell(a)=\log|\Phi_m(\zeta_q^a)|.
$$

There are no logarithm branches in these absolute logarithms. Taking the logarithm of the absolute value of N1 under every embedding of K_q gives

$$
\sum_{u\in F_a}L(u)=
 d_g\prod_{\ell_0\in\mathcal P}
 (\ell_0-2+T_{\ell_0^{-1}})\ell(a),
\quad (T_t f)(a)=f(at).
\tag{N4}
$$

Here the product is an additive operator on functions. To normalize it, set

$$
P=\prod_{\ell_0\in\mathcal P}
\frac{\ell_0-2+T_{\ell_0^{-1}}}{\ell_0-1},
\qquad
r_{g,q}=\frac{\varphi(g)}D
=\prod_{\substack{p\mid g\\p\mid q}}\left(1-\frac1p\right).
$$

Then

$$
\boxed{\overline L_a:=\frac1D\sum_{u\in F_a}L(u)
=r_{g,q}(P\ell)(a).}\tag{N5}
$$

The operator P is a finite positive average of permutations, preserves constants and uniform mass, and contracts every uniform L^p norm for 1≤p≤∞. The extra scalar r_{g,q} is in (0,1]. These properties concern the averaged logarithm in N5, not the unresolved fluctuations inside the fibres.

For a character χ modulo q, T_tχ=χ(t)χ. Thus the unnormalized reduced multiplier is

$$
d_g\prod_{\ell_0\in\mathcal P}
\bigl(\ell_0-2+\overline{\chi(\ell_0)}\bigr).
\tag{N6}
$$

It vanishes precisely when 3∈P and χ(3)=−1. A factor at 2 is a nonzero unit-modulus character value; a factor at a prime at least 5 has modulus at least ℓ_0−3>0. The real logarithmic profile has only even characters, so this criterion can be restricted to those components. Positivity of the averaging coefficients does not make every character multiplier positive.

Equation (N4) is the Galois sum of logarithmic absolute values. The algebraic field trace of $\beta$ has a different exact expression. If Φ_{gm}(z)=Σ_j c_jz^j, then

$$
\operatorname{Tr}_{K_n/K_q}(\beta)=\sum_jc_jR_j,
$$

$$
\boxed{R_j=
\sum_{\substack{d\mid g\\(d,q)=1\\g/d\mid j}}
\mu(d)\frac gd\,
\zeta_q^{\,[j/(g/d)]d^{-1}}.}\tag{N7}
$$

For j=0 the divisibility condition is automatic and R_0=D. To prove N7, write a fibre element as 1+qk, 0≤k<g, and insert Σ_{d|(g,1+qk)}μ(d). Only d coprime to q contribute. The congruence 1+qk≡0 mod d gives one k-class modulo d. Summing its g/d exponential terms gives zero unless g/d divides j; otherwise its phase is the displayed power of ζ_q. Formula N7 is an algebraic trace identity and carries no positivity statement.

## 4. Actual weights and the exact lost covariance

Let $w_N(x)$ be half the sum of the two incident gaps at $x$ in the circular order-$N$ Farey mesh. Keep $w(u)=w_N(u/n)$ without normalization and set $A_a=\sum_{u\in F_a}w(u)$. The [exact Farey inverse-class formula](cyclotomic-activity-quadrature.md) gives

$$
A_a=\frac1{2gq}
\sum_{\substack{g(m-q)<b\le gm\\(b,gq)=1}}
\frac{\mathbf1_{b\equiv a^{-1}\ (q)}+
      \mathbf1_{b\equiv-a^{-1}\ (q)}}b.
\tag{N8}
$$

The two terms are both counted when they coincide. This measure is generally neither constant on each upper fibre nor a scalar multiple of the actual reduced Farey weight at cutoff m.

Use uniform averages within a fibre and define Cov_a(f,h)=D^{-1}Σ_{F_a}(f−bar f_a)(h−bar h_a). For the unclipped actual factor,

$$
\boxed{\sum_{u\in G_n}w(u)L(u)
=\sum_{a\in G_q}A_a\,r_{g,q}(P\ell)(a)
+D\sum_{a\in G_q}\operatorname{Cov}_a(w,L).}\tag{N9}
$$

The covariance is exactly the part invisible to the relative logarithmic trace. Even if it were controlled, transferring a cancellation under reduced weights would require a second measure correction. With counting-measure adjoint P*, the first term in N9 is r_{g,q}Σ_a(P*A)_a ℓ(a). If w_m(a/q) is the reduced Farey weight and γ=(Σ_aA_a)/(Σ_aw_m(a/q)), its exact difference from the scaled reduced average is

$$
r_{g,q}\sum_a[(P^*A)_a-\gamma w_m(a/q)]\ell(a).
\tag{N10}
$$

This identity defines γ by the actual masses. It does not choose or adjust the arithmetic weights.

## 5. Full clipping and its additional correction

Define the complete prefix $F_K(z)=\prod_{j=1}^K\Phi_j(z)$ and let $Y=\lfloor m/q\rfloor$. Since $q$ does not divide $m$,

$$
\left\lfloor\frac{N-1}{n}\right\rfloor
=\left\lfloor\frac Nn\right\rfloor=Y.
$$

The [complete derivative factorization](cyclotomic-adjacent-history-correction.md) writes $F_K'(\alpha)=n\operatorname{lcm}(1,\ldots,\lfloor K/n\rfloor)U_{n,K}(\alpha)$ at a primitive $n$th root, with $U_{n,K}$ an algebraic unit. Thus, setting $\nu_{n,K}(u)=\log|U_{n,K}(\zeta_n^u)|$, the full previous derivative logarithm is

$$
B(u)=\log|F_{N-1}'(\zeta_n^u)|
=\log(n\operatorname{lcm}(1,\ldots,Y))+\nu_{n,N-1}(u).
\tag{N11}
$$

The upper and lower common-scale old steps have scalar logarithms differing by log g, but their previous unit profiles are not thereby identified. This formula does not identify the upper previous unit profile with a reduced prefix. The next full logarithm is exactly B(u)+L(u). All prime powers in the scalar remain present, even though this particular step does not change Y.

Set h(x)=[−x]_+. The actual sector update is

$$
I_{n,N}=\sum_uw(u)\{h(B(u)+L(u))-h(B(u))\}.
$$

One exact clipping description is

$$
h(B+L)-h(B)=-\theta L,
\quad
\theta(u)=\int_0^1\mathbf1_{B(u)+tL(u)<0}\,dt\in[0,1].
$$

This holds also when L=0. Hence, with A_a^θ=Σ_{F_a}wθ,

$$
\boxed{I_{n,N}
=-r_{g,q}\sum_a(P^*A^\theta)_a\ell(a)
-D\sum_a\operatorname{Cov}_a(w\theta,L).}\tag{N12}
$$

The effective weights depend on the full previous derivative and its activation interval. Norm descent alone gives no bound or invariance for them.

An equivalent formula displays Jensen defects. Define J_a(X)=D^{-1}Σ_{F_a}h(X(u))−h(bar X_a)≥0. Then

$$
\begin{aligned}
I_{n,N}
={}&\sum_a A_a\{h(\overline B_a+\overline L_a)-h(\overline B_a)
+J_a(B+L)-J_a(B)\}\\
&+D\sum_a\{\operatorname{Cov}_a(w,h(B+L))
-\operatorname{Cov}_a(w,h(B))\}.
\end{aligned}\tag{N13}
$$

N5 supplies bar L_a only. Each Jensen defect is nonnegative, but their difference has no prescribed sign. Even uniform weights would retain this difference and the unknown previous mean bar B_a. For a single unit logarithm, Jensen makes the negative part of the mean a lower bound for the averaged negative parts; it supplies no upper bound for those averaged negative parts. N12–N13 identify the precise information still required to lift reduced-conductor cancellation to the actual weighted update.

## 6. An exact bounded fixture

Take g=3, q=5, m=7, so n=15, N=21. Write ζ=ζ_5 and β=Φ_21(ζ_15). Since Φ_7(ζ)=1+ζ and 3^{-1}=2 modulo 5, N1 gives

$$
N_{K_{15}/K_5}(\beta)=(1+\zeta)(1+\zeta^2)=-\zeta^4.
$$

Thus every logarithmic fibre trace is zero. This is the actual character cancellation predicted by N6 for the even quadratic character modulo five.

The fibre above numerator one is {1,11}. In Q[x]/Φ_15(x), the actual factor is

$$
\beta=-x^7+x^6+x^5-2x^4+x^3-x+1.
$$

Its product with its 11-conjugate is −x^{12}, exactly the embedded −ζ^4. Its absolute square minus one reduces to

$$
2x^7-x^6-2x^5+3x^4-2x^2+x.
$$

This is a nonzero polynomial of degree less than φ(15)=8. It cannot vanish at any primitive fifteenth root. Hence the two logarithms L(1),L(11) are nonzero opposites.

The actual cutoff-21 Farey weights are

$$
w(1/15)=\frac1{224},\qquad w(11/15)=\frac1{209}.
$$

Therefore the weighted logarithmic sum on this fibre is exactly

$$
\boxed{\sum_{u\in\{1,11\}}w(u/15)L(u)
=-\frac{15}{46816}\log|\Phi_{21}(\zeta_{15})|\ne0.}\tag{N14}
$$

This is an exact unit and weight calculation, with no numerical logarithms. It shows a nonzero covariance despite a zero relative logarithmic trace. It also gives a strictly positive Jensen defect for the negative part of the unit logarithm alone. It does not claim a nonzero full clipped update: that quantity retains the scalar 15 and the actual previous unit profile in N11. The complete clipped values for this same fibre are evaluated in §7.

## 7. Full-prefix clipping in the same fixture

The factor calculation above can be compared with the complete derivatives, rather than a surrogate threshold. Put $y=2\cos(2\pi/15)$, the largest root of

$$
y^4-y^3-4y^2+4y+1=0.
$$

Exact multiplication in $\mathbb Q[x]/\Phi_{15}(x)$ gives the following values of $|F_K'(\zeta_{15}^a)|^2$.

| $K,a$ | Squared full derivative modulus |
|---|---|
| $20,1$ | $-675y^3-225y^2+2475y+675$ |
| $20,11$ | $225y^2-450y+225$ |
| $21,1$ | $-900y^3-675y^2+3150y+2025$ |
| $21,11$ | $225y^3+675y^2-1125y-225$ |

The relation for $y$ is verified in the same quotient field. Real-root isolation and rational interval evaluation give

$$
\frac{66340003}{36309087}<y<\frac{69986818}{38305055},
$$

and each of the four displayed squared moduli is strictly greater than one. Consequently the full clipped deficits vanish at both roots and both cutoffs. The clipped increment on this fibre is zero, even though its weighted factor-logarithm sum (N14) is nonzero. This is a finite exact example, not a general derivative-clearance estimate.

## 8. Attribution, complementary proof and certificates

The proof uses the classical prime-step distribution relations for circular units, inverse Frobenius and norm transitivity. [Burns and Seo, *On circular distributions and a conjecture of Coleman*, §2.1.1, equation (4)](https://arxiv.org/html/1906.00312) fix compatible roots and state the two norm relations with that convention. The cyclotomic product and prime-dilation identities used here are recorded in [Bzdęga, Herrera-Poyatos and Moree, *Cyclotomic polynomials at roots of unity*, §2.2, equation (4) and Lemma 2](https://arxiv.org/html/1611.06783). Combining the distribution denominator with the cyclotomic numerator gives the factor $\ell-2+\sigma_{\ell^{-1}}$ in (N3). No priority claim is made for this specialization.

The [gcd-layer factorization](cyclotomic-coprime-interior-history.md) supplies a different proof method before taking a norm. It gives the exact identity

$$
\Phi_{gm}(\zeta_{gq})=
\prod_{\substack{b\mid g\\(b,m)=1}}
\Phi_m(\zeta_{qb})^{\mu(b)},\qquad
\zeta_{qb}=\zeta_{gq}^{g/b}.
$$

The norm proof above instead uses the one-prime identity (N3) and transitivity. Both methods retain nonunit divisors and repeated primes.

The [relative-norm certificate](../../certificates/cyclotomic_common_scale_norm.py) checks the nine triples

$$
(g,q,m)=(1,5,7),(2,5,7),(3,5,7),(4,5,7),(5,5,7),
(7,5,7),(9,5,7),(10,5,6),(6,5,7).
$$

It multiplies actual Galois conjugates in the rational cyclotomic quotient field, checks (N1), the algebraic trace (N7), absolute norm one and compatibility with the gcd-layer factorization. It also verifies the exact factor and weights in (N14), without numerical logarithms.

A [separate full-prefix certificate](../../certificates/cyclotomic_common_scale_full_prefix.py) checks the prime-step triples

$$
(u,v,\ell)=(6,4,2),(5,4,2),(6,5,2),(7,5,2),(5,3,3),(9,4,3),(7,4,3),
$$

the algebraic trace of all monomials of degree below $24$ for $g=6,q=4$, and the Farey weights by direct geometric enumeration. It differentiates the complete prefixes in §7 and verifies their strict modulus bounds by rational interval arithmetic. Both scripts require Python 3 and SymPy and can be run from this directory with `python3 certificates/cyclotomic_common_scale_norm.py` and `python3 certificates/cyclotomic_common_scale_full_prefix.py`. All assertions pass. These finite checks supplement the all-parameter written proofs.

The remaining analytic problem is to control the actual measure correction, fibre covariance, activation weights and Jensen differences in (N9)–(N13). The positive average in (N5) supplies none of those bounds by itself.
