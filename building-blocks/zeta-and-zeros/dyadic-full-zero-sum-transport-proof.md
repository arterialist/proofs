# A full-zero-sum bound for long compact histories

Written proof, not Lean formalized. Agent3 proposed using M proportional
to P; root supplies the parameter order and summable majorants here.
This is approximation of the unchanged full Weil scalar, not positivity
of that scalar and not RH.

Agent3's independent audited proof now agrees with this argument in
`dyadic-full-weil-large-history-repair.md`. Taking D=1 and
Kc/2>R+2 gives O_h(P^(-R)) for any fixed R>0. The agreement includes
the complex Hermitian orientation, boundary denominator, absolute
low-zero majorant, high-zero tail and complete prime-power row.

Let h be fixed smooth compactly supported, with M_(+/-1/2)(h)=0.
Use actual local numerator/denominator transport at every prime
P<p<=2P, and compact truncations V_(p,M) retaining the forward term
and all advanced terms m=0,...,M-1. Coefficients are real. Set
M=ceil(KP), with K fixed below. For z=rho-1/2 the spectral weight is

\[
W_h(z)=M_z(h)\overline{M_{-\bar z}(h)},\qquad
W_{V_Bh}(z)=A_{P,M}(z)W_h(z),
\]

where A=v_B(z)v_B(-z). The second identity follows from real
translation coefficients; it does not require h to be real. Every
nontrivial zero rho is included with its multiplicity.

Use the unconditional classical zero-free region and its functional
equation reflection to fix c>0 such that every nontrivial zero obeys
delta_rho=min(Re rho,1-Re rho)>=c/log(|Im rho|+3).
The finitely many bounded-height zeros are absorbed by decreasing c.
An explicit classical region is given by
[Mossinghoff, Trudgian and Yang](https://arxiv.org/abs/2212.06867).
Also use the usual zero-counting bound N(T)=O(T log(T+3)).

Fix any D>0 and T_P=exp(DP). At |Im rho|<=T_P and large P,
delta_rho>=c/(2DP). The exact relative omission formula

\[
d_{p,M}(z)=\frac{(1-p^{-1})p^{-M(1/2+z)}}{1-p^{z-1/2}}
\]

therefore gives, for both z and -z,

\[
|d_{p,M}(\pm z)|
\le C_D\frac{P}{\log P}P^{-Kc/(2D)}.
\]

Here |1-p^(z-1/2)|>=1-p^(-delta_rho), and monotonicity
followed by 1-exp(-y)>=y/2 for small y bounds its reciprocal by
C_D P/log P. Chebyshev's dyadic prime count and product telescoping
bound the uniform low-height pair error by

\[
\epsilon_P=\exp\left(C_D
\frac{P^{2-Kc/(2D)}}{(\log P)^2}\right)-1.
\]

Choose Kc/(2D)>2. Then epsilon_P tends to zero. Crucially, the
low-height sum is bounded by epsilon_P times the fixed finite sum
sum_rho |W_h(rho-1/2)|, rather than by the number of zeros below T_P.
That fixed sum is finite by smooth compact support and zero counting.

For the remaining zeros, each summand in the finite local expansion
has modulus at most one on the entire closed critical strip
|Re z|<=1/2. There are M+1 summands, so

\[
|A_{P,M}(z)|\le(M+1)^{2\#\{P<p\le2P\}}\le\exp(C_*P).
\]

For each fixed K, the last constant C_* can be chosen independently
of K for sufficiently large P, since log(ceil(KP)+1)<=2 log P.
Integration by parts in the fixed test gives, for any integer L,
|W_h(z)|<=C_(h,L)(1+|Im z|)^(-2L), uniformly in this closed strip.
Zero counting yields the full high-height error bound

\[
\sum_{|\Im\rho|>T_P}|A_{P,M}(z)-1||W_h(z)|
\le C_{h,L}\exp(C_*P)T_P^{1-2L}\log(T_P+3).
\]

Choose L so that D(2L-1)>C_*. The test is smooth, so L has no
upper restriction. These choices are noncircular: fix D, choose K
from the low-height condition, then choose L. Both zero-sum errors
now tend to zero, proving Q(V_Bh) tends to Q(h) through the full
compact-test explicit formula, with all zeros and multiplicities.

The literal pole coordinates stay zero. Critical-line multiplier
error is bounded by exp(sum_p (1+p^(-1/2))p^(-M/2))-1, which
tends to zero; it controls the complete archimedean integral against
the fixed rapidly decaying transform of h. Consequently the exact
signed full prime-power row difference also tends to zero by the
same explicit formula. This is a joint approximation bound, not an
arithmetic sign estimate. The compact support diameter costs O_K(P^2).

No zero has been excluded from the critical strip's interior beyond
the existing classical zero-free boundary region. The result applies
equally if off-critical zeros exist. It therefore supplies no proof
of RH or of the original frozen-source subpower norm bound.
