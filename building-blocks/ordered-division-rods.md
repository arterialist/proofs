# Products of ordered proper-division ratios

A proper division rod is a pair of natural numbers $(l,r)$ with $0<l<r$ and $l\mid r$. Its exact ratio is $q=r/l\in\mathbb N$. A finite family is ordered and separated when $r_i<l_{i+1}$ for every consecutive pair.

For $m$ such rods with $r_i\le N$ and $N\ge1$,

$$
\prod_{i<m}q_i\le N,
\qquad
\prod_{i<m}q_i\le1+\sum_{i<m}(r_i-l_i).               \tag{1}
$$

The second inequality requires no cutoff $N$. It is strict when $m\ge2$. For a single rod beginning at $l=1$, it is an equality. The empty product is one; this explains the first inequality's explicit assumption $N\ge1$.

**Proof.** Let $P_k=\prod_{i<k}q_i$. A nonempty prefix satisfies $P_k\le r_{k-1}$ by induction: $P_1=q_0\le r_0$, and separation gives $P_k\le r_{k-1}<l_k$, hence $P_{k+1}=P_kq_k\le l_kq_k=r_k$. For the empty prefix, $P_0=1\le l_0$. Thus

$$
P_{k+1}=P_k+P_k(q_k-1)
\le P_k+l_k(q_k-1)=P_k+(r_k-l_k).
$$

Induction proves the second inequality in (1). At the final step with at least two rods, $P_k<l_k$ and $q_k-1>0$, making the bound strict. The prefix bound and $r_{m-1}\le N$ prove the first inequality.

Proper divisibility also forces $q\ge2$, so

$$
2l\le r\le2(r-l).                                    \tag{2}
$$

Thus a bound $D$ on the total gap confines every right endpoint to $2D$. This is a finite arithmetic input to degree stabilization of interval models; it does not prove a spectral or zeta-function statement.

[DivisionRod.lean](BuildingBlocks/DivisionRod.lean) formalizes these arguments in namespace `BuildingBlocks.RenewalRod`. Its `endpoint_product_bounds` theorem imposes hypotheses only on the selected finite prefix, with no conditions on unused values of the endpoint functions. Natural division is justified by `DivisionRod.ratio_mul_left`. The strict total-gap bound is `ordered_product_lt_one_add_total_gap`; (2) is `right_le_two_mul_gap`.

The proof uses ordinary divisor exactness and a telescoping product induction. The product-to-gap argument also works for separated real intervals with $l_i\ge1$ when $q_i=r_i/l_i>1$; the integral ratio supplies the stronger factor-two assertion (2). No mathematical originality or first-formalization claim is made. The extracted source imports only mathlib's finite-product and natural-number modules and Lean's Omega tactic, and compiles with Lean 4.24.0 and the pinned mathlib dependencies. No RH assumption or nonstandard axiom is used.
