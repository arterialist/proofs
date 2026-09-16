# Paired-scale floor compatibility does not force old-response damping

This bounded multiscale test uses the actual dyadic floor-carry innovation before taking absolute values. Its full even floor rows vanish, and its linked quotient descendants obey an exact signed zero renewal. Nevertheless the integrated old-response damping sign fails already at the actual N=3 family. The failure concerns a specific proposed route to a scale estimate. It does not rule out signed compensation across several scales or establish any arithmetic upper bound.

Use f_a(t)=1−e^(−at), the full compensated factorial weight w, and the actual response g_N. At an even scale put q_n=floor(N/n), n≤2N, and

ε_n=floor(2N/n)−2floor(N/n)∈{0,1},
d_N(t)=g_(2N)(t)−g_N(2t)
      =(1−e^(−t))Σ_{n≤2N}μ(n)ε_n e^(−2q_n t).       (1)

This includes newly admitted q_n=0 histories and every signed old carry. If c_q=Σ_{n:q_n=q}μ(n)ε_n, its paired-size coefficients are c_q f_(2q+1)−c_q f_(2q), including c_0 f_1 since f_0=0. Thus the full floor transform of d has row

Σ_q c_q[floor((2q+1)/j)−floor(2q/j)]
 =Σ_q c_q 1_(j divides 2q+1).                       (2)

Every even j row vanishes. The first row is Σ_q c_q=−1 by the two actual first-moment constraints. These are statements about the entire actual innovation, not just a generic vector with one neutral moment.

There is also linked paired quotient renewal. For k≤2N write r_k=floor(2N/k), q_k=floor(N/k), b_k=r_k−2q_k∈{0,1}, and d_(q,b)=g_(2q+b)(t)−g_q(2t), allowing q=0. Subtracting the two complete finite renewals gives

Σ_{k=1}^{2N}d_(q_k,b_k)(t)=0.                       (3)

The k>N ports have q_k=0,b_k=1 and are exactly N copies of g_1. The remaining linked ports sum to −N g_1. The descendants use the same nested floor histories; they are not independent innovations.

Equation (3) implies a genuinely signed global covariance identity

Σ_{k≠l}〈d_(q_k,b_k),d_(q_l,b_l)〉_w
 =−Σ_k ||d_(q_k,b_k)||_w².                          (4)

All pairs and repetitions are retained. This aggregate negativity does not give a sign to one selected port paired with g_N(2t).

## The specific scale-damping candidate

A natural proposed simplification of the full scale square is

I_N:=〈g_N(2t),d_N(t)〉_w≤0.                        (5)

It would remove the mixed term in

Q_(2N)=||g_N(2t)||_w²+2I_N+||d_N||_w²,
||g_N(2t)||_w²=2Q_N−R_N,
R_N=∫_0^∞g_N(u)²/[u(e^(u/2)+1)]du≥0.               (6)

The density dissipation and entire positive clock are retained. Even (5) alone would still require a useful arithmetic bound on ||d_N||²; it is a possible damping step, not a sufficient RH proof. It is distinct from the already refuted zero net-work rule Q_(2N)≤2Q_N.

For the literal N=3 and N=6 Möbius tables,

g_3=f_3−2f_1,
g_3(2t)=f_6−2f_2,
g_6=f_6−f_3−f_2,
d_3=f_2−f_3=−e^(−2t)f_1.                          (7)

The newly admitted histories at n=5 and n=6 cancel completely; they have not been omitted. The innovation is strictly negative at every positive time, but the old response changes sign. The integrated mixed work is

I_3=−B(6,3)+B(6,2)+2B(2,3)−2B(2,2)
   =log(2^10 5^8/3^18)
   =log(400000000/387420489)>0.                     (8)

This is an exact integer comparison using the full entropy-minus-log-binomial B, with every ordered cross-size contribution in the product. No numerical quadrature or pointwise sign inference is used.

The actual innovation has first floor row −1, every even row zero, odd row j=3 equal −1, and all rows j>3 zero. It therefore satisfies the complete parity structure in (2). Its linked N=3 quotient ports from k=1,...,6 are

d_(3,0), d_(1,1), d_(1,0), g_1, g_1, g_1,

d_(1,1)=f_3−f_2−2f_1,
d_(1,0)=−f_1.

Their sum is exactly zero, as required by (3). Pairing their proper ports with g_3(2t) gives total −I_3<0, compensating the selected positive mixed work. Neither the even-row zeros nor the complete signed renewal enforces the local damping candidate (5).

## Multiscale consumer and remaining arithmetic estimate

A meaningful target would be, for every δ>0,

Q_N≤(2+δ)Q_floor(N/2)+C_δ N^(1+δ).                  (9)

Since 2+δ<2^(1+δ), binary ancestry iteration would give Q_N=O_δ(N^(1+δ)). This is only a consumer calculation, not an inequality established here. A factor N^ε paid at every step instead compounds into exp(O(ε(log N)²)) and does not yield a subpower bound.

The exact identities (1)–(4) identify additional parity and coupled-port structure. The actual certificate (8) blocks assigning global covariance negativity to the old-response port as in (5). A successful proof of (9) must bound the selected mixed work and innovation square together, or derive a reserve across several linked scales, with terminal birth ports and density retained. Such an arithmetic structural upper bound has not been obtained in this attempt.

The companion `factorial-paired-innovation-full-floor-rows.md` records the descendant's distinct full-row and terminal-port calculation. The stronger coefficient-one diagonal hypothesis remains refuted by known Mertens oscillation and is not revived here. Q_N=O(N), subpower energy bounds and RH remain unresolved. All new calculations here are written mathematics; no additional Lean theorem is asserted.

Independent publication review checked the full quotient renewal, the retained N terminal copies, the parity-row identity and both exact logarithmic correlations. The companion [rational certificate](factorial-paired-damping-certificate.py) reconstructs the actual Möbius responses and verifies the N=3 and N=5 claims without quadrature. This certificate checks those finite examples; the general identities are the written algebraic proofs above. Lean formalization of these additional paired-scale identities remains pending.
