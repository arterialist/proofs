# Original density and seed charge cancellation

Developed in the RH Proof branch, with Lean implementation by Harvey and independent mathematical review and compilation by RH Proof. Written analytic claims are distinguished from compiled statements below; no novelty claim is made.

This is a written calculation for the original relative charge,
including the causal origin and frozen terminal. The origin and
integer-atom charge formulas are compiled in [ChargeOriginalBirth.lean](BuildingBlocks/ChargeOriginalBirth.lean).
The real-density joint integrability and original-charge interchange
are now compiled in [ChargeDensityFubini.lean](BuildingBlocks/ChargeDensityFubini.lean), with only standard
axioms. The total density evaluation is now compiled by the
alternate cutoff proof in [ChargeDensityEvaluation.lean](BuildingBlocks/ChargeDensityEvaluation.lean). The
literal causal frozen-source decomposition, its original charge
as finite atom charges plus the terminal-tail charge, and its
nonnegativity are now compiled in [ChargeFrozenSource.lean](BuildingBlocks/ChargeFrozenSource.lean).
The real-y arcsine evaluation, explicit R(N) formula, strict
positivity and infinite-source identification below remain written
proofs. None proves the RH sign criterion.

Let beta_y(v)=exp(-v/2)1_(exp(v)>=y), y>=1, on v>0, and use
the original kernel k from BuildingBlocks.SuccessorCharge. Put
q(y)=kappa(beta_y). Literal integration gives

    q(y)=pi/4-1/sqrt(y), 1<=y<=2,
    q(y)=arcsin(1/sqrt(y))-1/sqrt(y), y>=2.

For y>=2, q(y)>=0 and q(y)<=1/(3 y sqrt(y)). The compiled
integer theorem identifies this with the original central defect,
rather than defining a new charge to fit the formula.

The full density D(v)=integral_1^infinity beta_y(v)dy is
(exp(v)-1)exp(-v/2) on v>0. This D need not be L1. Nevertheless
the original charge integrand is absolutely integrable. On the
initial cell 0<v<log2 it is bounded; beyond log2 the established
kernel bound |k(v)|<=2exp(-v) yields

    |k(v)| integral_1^infinity |beta_y(v)|dy
      <=2exp(-v/2).

The joint indicator exp(v)>=y is measurable. Fubini applied to
this kernel product therefore gives the legitimate relative-charge
identity kappa(D)=integral_1^infinity q(y)dy. It does not apply
an L1 charge-difference theorem to the non-L1 density source.

On [2,infinity), an antiderivative of q is

    P(y)=y arcsin(1/sqrt(y))+sqrt(y-1)-2sqrt(y).

Direct differentiation proves P'=q. Also
P(y)=y q(y)-1/(sqrt(y-1)+sqrt(y)), so the cubic q bound
proves P(y) tends to zero without requiring a series expansion. Hence

    integral_1^2 q(y)dy=pi/4-2sqrt(2)+2,
    integral_2^infinity q(y)dy=2sqrt(2)-1-pi/2,
    kappa(D)=1-pi/4.

The first birth is v_1=-a0. Its original charge is also
1-pi/4, as independently compiled by direct origin integration.
Thus its charge cancels the charge of the full subtracted density.

There is a second proof of this total density charge that avoids
evaluating real-y arcsines. For R>=2 let
F_R(v)=exp(v/2)1_(v<=log R), on the causal integration domain.
These cutoffs are L1. The literal successor is
exp(v/2)1_(v<=log(R-1)), because its amplitude cancels the
square-root growth and its argument replaces x by x+1. Therefore

    integral_(v>0) F_R(v)dv=2(sqrt(R)-1),
    integral_(v>0) S F_R(v)dv=2(sqrt(R-1)-1),
    kappa(F_R)=sqrt(R-1)-sqrt(R).

The last equality uses the charge-difference theorem only on the
L1 cutoff. The original kernel times exp(v/2) is bounded by
2exp(-v/2), including the initial interval. Dominated convergence
at that kernel-product level consequently proves
kappa(exp(v/2))=0. Since
D(v)=exp(v/2)-exp(-v/2), linearity of the integrable kernel
products gives kappa(D)=-kappa(a0)=1-pi/4. No undefined
difference of the two infinite absolute source masses is taken.
This alternate cutoff proof is compiled in [ChargeDensityEvaluation.lean](BuildingBlocks/ChargeDensityEvaluation.lean).
Independent compilation reports no warnings and only the standard
axioms propext, Classical.choice and Quot.sound.

For an integer N>=2 the actual frozen source has the exact birth
representation

    a_N=-a0+sum_(2<=n<=N)Lambda(n)beta_n
                   -integral_1^N beta_y dy.

This representation retains the tail after exp(v)>N, where its
value is E(N)exp(-v/2). Finite linearity and the same density
interchange yield

    kappa(a_N)=sum_(2<=n<=N)Lambda(n)q(n)+R(N),
    R(N)=integral_N^infinity q(y)dy
        =2sqrt(N)-sqrt(N-1)-N arcsin(1/sqrt(N)).

In particular R(N)>0 and R(N)<=2/(3sqrt(N)). Each atom term
is nonnegative, and the n=2 term is strictly positive. Therefore
every such original frozen initial charge is strictly positive.
Its limit is the absolutely convergent complete prime-power sum

    kappa(a)=sum_(n>=2)Lambda(n)q(n)>0.

The last identification is justified at the original kernel-product
level. For n>=2 the kernel is nonnegative on beta_n's support,
so Tonelli identifies the complete atomic integral with its sum.
The sum is finite from Lambda(n)<=log(n) and the cubic q bound.
The density kernel product is integrable as shown above. No global
L1 or L2 membership of a has been assumed.

This signs only e_0 and its frozen analogues. The goal requires
a consistent sign of the complete E(r)=sum_j e_j r^j on an entire
interval approaching r=1. Higher-age coefficients contain signed
linked histories. Initial positivity and absolute atom-charge
summability do not supply that missing all-age constraint.
