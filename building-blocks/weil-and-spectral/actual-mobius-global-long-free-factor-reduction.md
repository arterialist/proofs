# Global Möbius partition with a long free factor

## Scope and status

Put

\[
 c=\mu*\mu,\qquad N=T^\lambda,\qquad D=T^d,
 \qquad L=DT/N.
\]

Apply the pointwise identity

\[
 c*1=(\mu*\mu)*1=\mu
\tag{1}
\]

before partitioning the two factors. After that identity is in place, take

\[
 q\asymp Q=T^v,qquad t\asymp R=T^w,qquad v+w=d.
\tag{2}
\]

The calculation below controls a larger set of `q` blocks in this global
partition. It does not extend the complete pointwise cofactor cutoff. A
`q,t` block is part of the convolution representation in (1), and need not
equal a subset of the original one-variable `m` sum.

This is a partial global-partition reduction. It makes no priority claim.

## Direct treatment of the packet amplitude

On a Poisson shell `|k|\asymp J`, write

\[
 r=J/L,
 \qquad
 y=\frac{kH}{qt}\asymp r.
\]

For fixed `k,q`, the amplitude in the `t` sum is

\[
 A_{k,q}(t)=\frac{D}{qt}
 \left[
 \log\!\left(\frac{N}{qt}\right)\widehat G_T(y)
 +\widehat Q_T(y)
 \right].
\tag{3}
\]

The packet transforms vanish to first order at zero and are Schwartz at
infinity. Their logarithmic derivatives have the same bounds. More
precisely, with `u=log t`, `y=(kH/q)e^{-u}`, and
`z=log(N/q)-u`, differentiation gives

\[
 \frac{d}{du}A_{k,q}(e^u)
 =-\frac{D}{qe^u}
 \left[z\widehat G_T(y)+\widehat Q_T(y)+\widehat G_T(y)
 +y\{z\widehat G_T'(y)+\widehat Q_T'(y)\}\right].
\]

Here `|z|\ll log T` and `D/(qt)\asymp1`. The first-order zero and Schwartz
bounds give

\[
 |\widehat G_T(y)|+|\widehat Q_T(y)|
 +|y\widehat G_T'(y)|+|y\widehat Q_T'(y)|
 \ll_A\min(y,y^{-A}).
\]

The `u` interval has bounded length. Integrating the displayed derivative
therefore proves, for every fixed `A>0`,

\[
 \sup_{t\asymp R}|A_{k,q}(t)|
 +\operatorname{Var}_{t\asymp R} A_{k,q}(t)
 \ll_A (\log T)\min(r,r^{-A}).
\tag{4}
\]

This is the right way to insert the packet weight. Robert and Sargos'
Theorem 3 has an unweighted inner variable, so a Mellin or Fourier twist in
that variable would not meet its hypotheses. Instead, partial summation
applies (4) to the unweighted maximal sum in their equation (6.8). For fixed
`q`, the literal condition `qt\in I` cuts the dyadic `t` block to an
interval, which the same maximum covers. The coefficients `c(q)` and the
separated `k` coefficient remain outside the inner sum.

## Robert--Sargos estimate and shell factors

Robert and Sargos,
[*Three-dimensional exponential sums with monomials*, Theorem 3,
equation (6.9)](https://perso.univ-st-etienne.fr/rool6510/robert-2006-crelle.pdf),
prove the unconditional estimate

\[
 (H_0N_0M_0)^{1+\varepsilon}
 \left[
 \left(\frac{X}{H_0N_0M_0^2}\right)^{1/4}
 +M_0^{-1/2}+X^{-1}
 \right]
\tag{5}
\]

for their sum with an unweighted inner `M_0` variable. Use

\[
 (H_0,N_0,M_0)=(J,Q,R),qquad
 X_{\rm phase}=NJ/D=Tr,
\]

and the exponents `(1,-1,-1)`. The divisor bound for `c(q)` costs
`T^epsilon` after the outer absolute values are taken.

Before multiplying by the packet factor in (4), restoring
`(L sqrt N)^{-1}` gives

\[
 T^\varepsilon\left[
 rD^{1/2}N^{-1/4}R^{-1/4}
 +rDN^{-1/2}R^{-1/2}
 +\frac{D}{T\sqrt N}
 \right].
\tag{6}
\]

For `r\le1`, (4) changes the shell factors in (6) to `r^2,r^2,r`.
For `r\ge1`, its arbitrary Schwartz power makes all three terms summable.
When `X_phase=Tr\le1`, use the trivial inner sum and the first-order packet
zero instead of (5). Summing these small shells gives

\[
 \ll T^\varepsilon\frac{D}{\sqrt N\,T^2}.
\tag{7}
\]

The physical shell `r\asymp1` therefore satisfies

\[
 \boxed{
 |S_{D,Q}|\ll_\varepsilon T^\varepsilon\left[
 D^{1/2}N^{-1/4}R^{-1/4}
 +DN^{-1/2}R^{-1/2}
 +\frac{D}{T\sqrt N}
 \right].}
\tag{8}
\]

Equations (4), (6), and (7) justify summing all Poisson shells without
placing a weight inside the unweighted Robert--Sargos variable.

## Exponent range

Set

\[
 d_*=\frac{2(\lambda+1)}5,
 \qquad
 \gamma_0=\frac{4-\lambda}{10},
 \qquad
 d=d_*+\delta.
\]

The three powers in (8) are

\[
 E_1=\frac{\gamma_0}{2}+\frac\delta2-\frac w4,
 \qquad
 E_2=\gamma_0+\delta-\frac w2,
 \qquad
 E_3=-(1-\gamma_0-\delta).
\tag{9}
\]

If

\[
 w\ge2\gamma_0+2\delta+\theta,
\tag{10}
\]

then the saving furnished by (8) is

\[
 c=\min\left\{\frac\theta4,1-\gamma_0-\delta\right\}.
\tag{11}
\]

One must assume `c>0`. The simpler value `c=theta/4` is valid under

\[
 \delta+\frac\theta4\le1-\gamma_0.
\tag{12}
\]

The range in (10) is nonempty only if

\[
 2\gamma_0+2\delta+\theta\le d.
\tag{13}
\]

Since `v=d-w`, (10) is equivalent to

\[
 \boxed{
 v\le\frac{3\lambda-2}{5}-\delta-\theta.}
\tag{14}
\]

For

\[
 u=\frac{42\lambda-55}{126},
\]

the endpoint gap over the earlier `v\le2u` range is

\[
 \frac{3\lambda-2}{5}-2u
 =\frac{149-21\lambda}{315}.
\tag{15}
\]

Thus (14) strictly contains that earlier range when

\[
 \delta+\theta<\frac{149-21\lambda}{315}.
\tag{16}
\]

This is a larger controlled `q` range inside the global convolution
partition. Nothing in (8) through (16) bounds every block needed for a
larger pointwise cutoff.

## The remaining short free-factor blocks

The blocks not covered by (10) have

\[
 0\le w<2\gamma_0+2\delta+\theta.
\tag{17}
\]

Expanding `c(q)` into two Möbius factors is exact within a retained `q`
block. Let `A=T^alpha`, take `alpha\ge(d-w)/2`, and sum the `t` block
trivially. The dual Robert--Sargos orientation then has normalized exponents

\[
 R_1=\frac{d-\lambda+\alpha+2w}{4},
 \qquad
 R_2=\frac{3d-\lambda-1-\alpha}{4},
\]

\[
 R_3=\frac{d+\alpha+w-\lambda}{2},
 \qquad
 R_4=d-\frac{\lambda+1}{2}.
\tag{18}
\]

At the balanced point `alpha=(d-w)/2`,

\[
 R_2=\frac{5\delta+w}{8}.
\tag{19}
\]

For `delta>0`, this term is positive throughout the balanced edge. At the
endpoint `delta=w=0`, it is zero.

One unresolved component of (17) is the `t=1` term

\[
 \frac1{L\sqrt N}\sum_{k\asymp L}\gamma_k
 \sum_{q\asymp D}(\mu*\mu)(q)W_k(q/D)
 e\!\left(-\frac{kN}{q}\right).
\tag{20}
\]

The estimates used here do not save a fixed power on its balanced
factorization. This identifies the point where this method stops. It does
not prove that Möbius-sign cancellation is necessary, and it makes no claim
about which future method could control (20).

## Conclusion

The global rewrite and Theorem 3 prove (14), subject to (11) through (13).
The result is unconditional and concerns a proper part of the global
partition. The balanced short-free-factor blocks remain outside the proved
range, so the complete pointwise endpoint does not move.

The rational identities in (9), (14), (15), and (19), together with the
strict saving and containment inequalities, are checked in
[`GlobalCOneLongFreeFactor.lean`](../../formalization/BuildingBlocks/GlobalCOneLongFreeFactor.lean).
Its dedicated
[`GlobalCOneLongFreeFactorAudit.lean`](../../formalization/verification/GlobalCOneLongFreeFactorAudit.lean)
checks every declaration in that module for unexpected axioms.
