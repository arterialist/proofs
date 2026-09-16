# Paired factorial innovations: complete parity rows and retained terminal covariance

The actual dyadic innovation has an entire family of zero even floor rows, not only its first moment −1. Across all proper quotient histories the complete innovations also sum to zero, forcing a negative integrated aggregate cross correlation. These structural constraints do not enforce a nonpositive correlation of the distinguished innovation with terminal admissions: an actual N=5 example disproves that scalar damping candidate. No energy doubling bound follows from the aggregate cancellation alone.

## Actual full innovation and its floor rows

Keep f_a(t)=1−e^(−at), the original complete factorial weight w(t)=t^(−2)−[t(e^t−1)]^(−1), and the literal Möbius responses g_N. For N≥1 and n≤2N put

q_n=floor(N/n), ε_n=floor(2N/n)−2q_n∈{0,1}.

The full innovation is

d_N(t)=g_(2N)(t)−g_N(2t)
      =f_1(t)Σ_{n≤2N}μ(n)ε_n e^(−2q_n t).   (1)

Every old and newly admitted divisor history is retained. Define c_q=Σ_{n≤2N:q_n=q}μ(n)ε_n. Expanding (1) in the original basis f_a gives paired coefficients D_(2q)=−c_q and D_(2q+1)=c_q for q≥1, plus D_1=c_0 because f_0=0. In particular c_0=M(2N)−M(N) is the actual far-clock terminal value. Its contribution is not silently replaced by a new coefficient vector.

For every integer j≥1, finite termwise floor differences give the exact complete innovation row

Σ_a D_a floor(a/j)
 =Σ_{n≤2N}μ(n)ε_n 1_{j | (2q_n+1)}.   (2)

Indeed increasing 2q by the single carry ε changes floor(2q/j) precisely when ε=1 and j divides 2q+1. Thus ALL EVEN rows in (2) vanish. The first row is Σμ ε=−1, while the odd rows retain their actual divisibility loading. This is a compatibility of the paired sizes before absolute values; there is no assumed independence of the two scales or deletion of prime-power/divisor coefficients. Vanishing even rows alone does not determine the odd rows or the innovation energy.

## All quotient innovations and a global integrated constraint

For k≤2N put q_k=floor(N/k), e_k=floor(2N/k)−2q_k. Define d_(q,e)=g_(2q+e)(t)−g_q(2t), with g_0=0. Subtracting the two complete finite renewal laws gives

Σ_{k=1}^{2N}d_(q_k,e_k)(t)=0.   (3)

The forcings agree exactly at f_(2N); they do not disappear by approximation. All N terminal indices N<k≤2N have q_k=0,e_k=1, so their contribution is N g_1. Consequently the old-history bundle obeys

Σ_{k≤N}d_(q_k,e_k)=−N g_1.   (4)

With the full inner product ⟨u,v⟩_w=∫₀∞u(t)v(t)w(t)dt, all terms are finite: each finite response is O(t) at zero and bounded at infinity. Expanding (3) yields the actual integrated aggregate constraint

Σ_{k≠l}⟨d_(q_k,e_k),d_(q_l,e_l)⟩_w
       =−Σ_k||d_(q_k,e_k)||²_w.   (5)

The ordered pairs include repeated quotient histories. Their individual correlations need not be negative. If the terminal copies are grouped first, (4) instead gives

Σ_{k,l≤N}⟨d_(q_k,e_k),d_(q_l,e_l)⟩_w
       =N² B(1,1)=N²log2.   (6)

Thus the old bundle itself has a positive quadratic reserve of order N². The zero sum does not bound the distinguished d_N from above: other proper-division innovations can cancel it coherently. Reinterpreting (5) as an upper bound without estimating that cancellation would be a tautology, not arithmetic damping.

## A discriminating terminal-admission damping candidate fails

A specific additional scalar proposal is that the distinguished innovation must oppose the new terminal history:

⟨d_N,g_1⟩_w≤0 for every N.   (7)

This is different from comparing d_N to the old response g_N(2t), and is not the already open full doubling-work budget. It tests whether the complete parity rows and proper-division balance force a sign on this particular admission channel.

For actual N=5, retaining the full μ tables through 10 gives

g_10=f_10−f_5−f_3−f_2+f_1,
g_5(2t)=f_10−f_4−2f_2,
d_5=f_4+f_2+f_1−f_5−f_3.

Its entire floor row vector is (−1,0,−1,0,−1) for j=1,...,5 and zero thereafter. It therefore satisfies the zero even rows and all actual odd loads in (2).

The actual complete quotient compatibility at this horizon is

d_(5,0)+d_(2,1)+d_(1,1)+2d_(1,0)+5g_1=0.   (8)

Using the original complete factorial kernel B(a,1)=a log(1+1/a), the admission correlation is exactly

⟨d_5,g_1⟩_w
 =4log(5/4)+2log(3/2)+log2−5log(6/5)−3log(4/3)
 =log(5^9/2^20)>0,

because 1953125>1048576. This disproves (7) on the actual full coefficient system; the aggregate cancellation (8) remains exact. Other innovations compensate the positive distinguished terminal port. No terminal term, reverse ordered cross term, density compensation, or divisor history is omitted.

Equations (2)–(6) are genuine full arithmetic compatibility constraints. The N=5 calculation shows that they do not supply this particular scalar damping sign. A useful upper estimate must control the actual proper-division reserve and all signed correlations, possibly together with the real first-cell Mertens trace; neither replacing that reserve by absolute values nor merely invoking its zero total proves a subpower bound. The stronger diagonal hypothesis is not used here. No claim about the surviving weaker energy target or RH is inferred from this note.

This is written mathematics using the published finite-renewal, binary-carry and complete factorial-kernel identities. It supplies no new compiled Lean theorem or unconditional energy upper bound.

Independent publication review checked the full quotient renewal, the retained N terminal copies, the parity-row identity and both exact logarithmic correlations. The companion [rational certificate](factorial-paired-damping-certificate.py) reconstructs the actual Möbius responses and verifies the N=3 and N=5 claims without quadrature. This certificate checks those finite examples; the general identities are the written algebraic proofs above. Lean formalization of these additional paired-scale identities remains pending.
