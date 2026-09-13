# Literal successor transport of the additive Goldbach source

The literal successor transports each full prime-power birth through a positive probability kernel. Its additive pair count has an exact escape formula and an $O(X)$ deficit using Chebyshev alone. Compensation retains both rank terms and a finite weighted constant. This written proof does not assert an additive prime-pair existence theorem, a global screw sign or an RH bound.

## Actual source and its counting measure

Write $\psi(x)=\sum_{n\le x}\Lambda(n)$, retaining every prime power, and

$$
g(x)=\psi(x)/x-1\quad(x\ge1),\qquad
a(v)=e^{v/2}g(e^v)1_{v\ge0}.
$$

The [literal causal successor and charge](actual-successor-resonance-charge-cocycle.md) give $Sg(x)=g(x+1)$ for $x\ge1$ and zero below one. Its compensated version is $Cg=Sg-\kappa/x$ on $x\ge1$, where

$$
\kappa=\sum_{n\ge2}\Lambda(n)
 [\arcsin(n^{-1/2})-n^{-1/2}]>0.
\tag{1}
$$

The completed counting functions associated with these sources are zero below 1 and, for x>=1,

$$
\Psi_S(x)=\frac{x}{x+1}\psi(x+1),\qquad
\Psi_C(x)=\Psi_S(x)-\kappa.
\tag{2}
$$

Thus their locally finite Stieltjes measures satisfy

$$
\mu_S=\sum_{n\ge2}\Lambda(n)K_n,\qquad
\mu_C=\mu_S-\kappa\delta_1,
$$
$$
K_n=\left(1-\frac1n\right)\delta_{n-1}
       +1_{x\ge n-1}\frac{dx}{(x+1)^2}.
\tag{3}
$$

Each K_n is a positive probability measure: its atom has mass 1-1/n, its complete tail has mass 1/n, and its cumulative function is x/(x+1) for x>=n-1 and zero otherwise. Every bounded interval sees finitely many n, so the sum in (3) is an exact local measure identity. In particular n=2 contributes the initial atom (log 2)/2 at x=1. The compensated initial atom is (log 2)/2-kappa; its sign is not assumed.

Integration by parts gives the useful normalization

$$
\int x^{-1/2}K_n(dx)
 =\frac12\int_{n-1}^\infty\frac{x^{-1/2}}{x+1}dx
 =\arcsin(n^{-1/2}).
\tag{4}
$$

Therefore kappa is precisely the absolutely convergent excess of these transported half-moments over the original n^{-1/2}. Subtracting kappa delta_1 cancels this excess. This is an identity of convergent differences, not subtraction of two infinite arithmetic moments.

## Exact additive pair leakage and its cofactor bound

Set

$$
\mathcal G(X)=\sum_{m+n\le X}\Lambda(m)\Lambda(n),\quad
\mathcal G_S(X)=(\mu_S*\mu_S)([0,X]).
$$

This convolution uses addition of physical coordinates. Convolution in logarithmic age instead encodes products. Since K_m*K_n is a probability supported on [m+n-2,infinity),

$$
0\le\mathcal R(X):=\mathcal G(X+2)-\mathcal G_S(X).
\tag{5}
$$

For s=X+2>=m+n its exact escape probability is

$$
r_{m,n}(X)=\frac{s-1}{s}
 \left(\frac1{s-m}+\frac1{s-n}\right)
 +\frac1{s^2}\log\frac{(s-m)(s-n)}{mn}.
\tag{6}
$$

To verify it, integrate the cumulative function of K_n against K_m, separating the atom. One obtains

$$
r_{m,n}=\frac1{s-n}+
 \frac{m-1}{m(s-m)}+
 \int_m^{s-n}\frac{dz}{z^2(s-z)}.
$$

An antiderivative of the integrand is

$$
\frac1{s^2}\log\frac z{s-z}-\frac1{sz}.
$$

Substitution and simplification yield (6). At the contact s=m+n the logarithm is zero and (6) equals 1/m+1/n-1/(mn), exactly the mass outside the initial pair atom. In the whole allowed region its logarithm is nonnegative. No tail has been removed.

Consequently

$$
\mathcal R(X)=
\frac{2(s-1)}s\sum_{m\le s-2}
 \Lambda(m)\frac{\psi(s-m)}{s-m}
+\frac1{s^2}\sum_{m+n\le s}\Lambda(m)\Lambda(n)
 \log\frac{(s-m)(s-n)}{mn}.
\tag{7}
$$

Both terms are nonnegative. Chebyshev's bound psi(y)<=C y makes the first term O(s). The second is O(1), since its logarithm is bounded above by log(s/m)+log(s/n), and

$$
\sum_{m\le s}\Lambda(m)\log(s/m)
 =\int_1^s\frac{\psi(u)}u du=O(s).
$$

Thus the complete arithmetic pair deficit satisfies

$$
\boxed{0\le\mathcal G(X+2)-\mathcal G_S(X)\le C(X+2).}
\tag{8}
$$

This improves the crude O(X log X) estimate by keeping the cofactor psi(s-m)/(s-m) before taking bounds. The proof requires no RH or prime-pair theorem.

PNT additionally yields R(X)=2X+o(X). For the first sum in (7), split m<=s-Y and m>s-Y. On the first part psi(s-m)/(s-m) tends uniformly to 1 as Y tends to infinity; on the second, Chebyshev bounds it while psi(s)-psi(s-Y)=o(s) for each fixed Y by PNT. First let s tend to infinity and then Y tend to infinity. The second term stays O(1).

## Exact compensated pair and the weighted constant

The rank-one port is retained before squaring:

$$
\mu_C*\mu_C=\mu_S*\mu_S-2\kappa\,\tau_1\mu_S
                         +\kappa^2\delta_2.
$$

For every X>=2 this gives

$$
\boxed{\mathcal G_C(X)=\mathcal G(X+2)-\mathcal R(X)
 -2\kappa\frac{X-1}{X}\psi(X)+\kappa^2.}
\tag{9}
$$

In particular the difference from the shifted original count is O(X), with every continuous pair contribution and both charge terms present. No positivity of mu_C or its convolution is asserted.

For the ordinary weighted readout define

$$
B_C(X)=\int_{[2,X]}u^{-2}(\mu_C*\mu_C)(du),\qquad
B(X)=\sum_{n\le X}n^{-2}\sum_{m+k=n}\Lambda(m)\Lambda(k).
$$

Let $D_G(X)=\mathcal G_C(X)-\mathcal G(X)$. The elementary bound G(X+2)-G(X)=O(X log X) follows from at most three integer pair-sum levels and r_2(n)<=log(n)psi(n). Equation (9) therefore gives D_G(X)=O(X log X). All measures vanish below 2. Stieltjes integration by parts proves

$$
B_C(X)-B(X)=\frac{D_G(X)}{X^2}
             +2\int_2^X\frac{D_G(u)}{u^3}du
=d_C+O\!\left(\frac{\log X}{X}\right),
$$
$$
d_C:=2\int_2^\infty\frac{D_G(u)}{u^3}du.
\tag{10}
$$

The integral for d_C is absolutely convergent. This constant must be restored before multiplication by sqrt(X). After that restoration the relative secondary readout tends to zero at rate O(log X/sqrt X). This comparison does not bound either preserved secondary term.

## Primary-literature connection and its limits

Matsumoto and Suzuki, JNT 280 (2026), 918–946, [arXiv v2](https://arxiv.org/html/2409.00888v2), Proposition 6.1 supplies an unconditional explicit formula for H_1. Their Theorem 1.1 requires RH and rational independence of distinct positive zero ordinates, with multiplicities retained. Theorem 1.2's converse uses every locally Riemann-integrable test, including unbounded tests. Theorem 1.3's screw condition is equivalent to RH, without the independence assumption. Their zero-based infinitely divisible law is not the project's unconditional prime-age law.

Substituting the project's literal F into their formula identifies

$$
H_1(X)=\sqrt X[1+\gamma-F(X)]-X^{-1/2}A(X),
$$
$$
A(X)=\log(2\pi)+\tfrac12\log(1-X^{-2})
 +\tfrac X2\log\frac{X+1}{X-1}-1.
\tag{11}
$$

Here $F$ is the [actual factorial potential](factorial-ground-state-original-l2-domain.md). Write $S(v)=H_1(e^v)$. Differentiating (11) using the literal $F′$ gives, for $v>0$,

$$
a(v)=(\partial_v-\tfrac12)S(v)
-e^{-v/2}[\log(2\pi)+\tfrac12\log(1-e^{-2v})].
\tag{12}
$$

For causal extension, the right-hand side also contains -S(0)delta_0, with S(0)=gamma+2-log(4pi). The logarithmic singularity is locally integrable; it cancels only in the full expression. These are classical explicit-formula specializations, not a priority claim.

The source-action calculation (3)–(10) supplies a coupled additive constraint on precisely that source, including its compensation. It does not derive a global screw sign from Goldbach existence. A subsequent repeated-successor theorem would need uniform control of the evolving reference measure and its signed rank-one ports; one cannot iterate (8) after replacing the actual measure by an arbitrary positive measure and dropping compensation.

## Dependencies and formal scope

The [actual successor charge](actual-successor-resonance-charge-cocycle.md) fixes $\kappa$ and its convergent half-moment difference. The [factorial potential](factorial-ground-state-original-l2-domain.md) fixes the source in (11)–(12). The positive transport, additive convolution and Stieltjes integration use classical measure and summation tools; Matsumoto–Suzuki supply the attributed explicit formula and its separate conditional consumers. Every complete prime-power tail and both compensation terms are retained. The transport, escape bound and weighted comparison in this chapter are written proofs and are not formalized in Lean.

The [centered circle-majorant consumer](goldbach-additive-source-consumer.md) gives a separate quantitative route to the original source norm and clock action. Its positive majorant cannot be replaced by the signed additive remainder.
