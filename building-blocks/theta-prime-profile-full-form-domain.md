# Full form-domain regularity of the actual prime profile and affine trial potential

The prime cross profile is not obtained by smoothing an arbitrary L² input. Its finite complete energy follows instead from the actual ground equation, the physical logarithmic form, and the theta decay at one of the two endpoints of every long prime-power shift. This note proves that regularity and then checks the remaining sources in the score-matched affine trial.

Fix R>0. Extend the actual killed ground ψ by zero on C=[−R,R]. The hard-split domain theorem gives ψ∈D(L), E(ψ)=α, and Lψ=αψ on O. On C the original crossing source is retained; the zero extension is not asserted to be a full eigenfunction. Use ν=bΦdu, b=2cosh(u/2), ρ=(e^{|u|}+1)^(−1), and γ=ρψν. The proved bound ||ψ||∞≤P∞ is finite at this fixed core.

The physical domain theorem is §16, equation (16.1), of [jump eigenfunction regularity](theta-jump-eigenfunction-regularity.md). It says
$$
 h\in V_L\quad\Longleftrightarrow\quad
 h\in L²(\nu),\quad\Phi h\in\mathcal H,
 \qquad\|g\|_\mathcal H²=\int\log(2+|\xi|)|\widehat g(\xi)|²d\xi.
 \tag{1}
$$
The complete physical prime operator is bounded. Thus there are fixed theta constants Cθ,Cθ′ such that
$$
 \|\Phi h\|_\mathcal H²\le C_\theta(E(h)+\|h\|_\nu²),\qquad
 E(h)\le C'_\theta(\|\Phi h\|_\mathcal H²+\|h\|_\nu²).
 \tag{2}
$$
These are form estimates, not bounds on an unweighted physical operator action.

## 1. Two uniform logarithmic-form multiplier estimates

Let A be the actual physical archimedean operator, with lower endpoint a₀. Its positive jump form is
$$
 \mathfrak a(g)=\langle(A-a_0)g,g\rangle
 =\frac12\iint r(|u-v|)|g(u)-g(v)|²du\,dv,
 \quad r(t)=\frac{e^{-t/2}}{1-e^{-2t}}\le\frac1t.
$$
The norm ||g||²₂+𝔞(g) is equivalent to ||g||²_H.

For a hard half-line projection P, the exact splitting identity, initially on compact smooth g, is
$$
 \mathfrak a(Pg)+\mathfrak a((I-P)g)-\mathfrak a(g)
 =2\operatorname{Re}\int_{P\times(I-P)}g(u)\overline{g(v)}r(|u-v|)du\,dv.
$$
The cross operator has Carleman norm at most π. Consequently
$$
 \mathfrak a(Pg)\le\mathfrak a(g)+\pi\|g\|²_2,
 \qquad\|Pg\|_\mathcal H\le C_P\|g\|_\mathcal H,
 \tag{3}
$$
with C_P independent of the cut location. Closure proves this for all g∈H; interval projections follow by two half-line cuts. This is specific to the logarithmic form. No positive-order Sobolev assertion about arbitrary discontinuous multipliers is used.

For a bounded Lipschitz multiplier m, the product increment inequality gives
$$
 \|mg\|_\mathcal H
 \le C_m(\|m\|_\infty+\operatorname{Lip}(m))\|g\|_\mathcal H.
 \tag{4}
$$
Indeed the additional row integral is bounded by a constant times
∫₀∞r(t)min(t²,1)dt<∞. Translations are isometries of H. These constants depend only on the fixed logarithmic norm convention.

## 2. The ground equation supplies a small logarithmic tail

For T>R let h_T=ψ1_(u<−T). The one-boundary version of the proved hard split gives
$$
 E(h_T)=\alpha\|h_T\|_\nu²
       +\langle B_T^{(-)}(\psi-h_T),h_T\rangle_\nu.
$$
The complementary vector includes both exterior halves. Its crossing norm is bounded by the same available tail bound
$$
 \|B_T^{(-)}\|\le b_T
 =2\pi\|\omega\|_\infty\|1_{|u|>T}\omega\|_\infty+\Gamma_T,
 \quad \omega=\sqrt{\Phi/b}.
$$
For the continuous term this is the single-boundary Carleman estimate, enlarged to the displayed two-boundary constant. For prime edges the off-diagonal block is bounded by ||K_p−P_TK_pP_T||≤Γ_T. Thus no crossing between the two exterior halves has been omitted. Since ||ψ−h_T||ν≤1,
$$
 E(h_T)\le\alpha P_\infty²\nu(O_T)
                   +b_TP_\infty\sqrt{\nu(O_T)}.
$$
Applying (2) gives the explicit tail estimate
$$
 \boxed{\quad
 \|\Phi\psi1_{u<-T}\|_\mathcal H
 \le\mathcal T(T):=
 \left[C_\theta\{(\alpha+1)P_\infty²\nu(O_T)
                 +b_TP_\infty\sqrt{\nu(O_T)}\}\right]^{1/2}.
 \quad}
 \tag{5}
$$
The public complete-prime tail estimate is
Γ_T≤C(1+(T+1)e^T)e^(−c e^(2T)); see [weil jump form](theta-weil-jump-form.md) (8.1), with its exterior estimate. The theta tail of ν has the same type. Polynomial factors may be absorbed by decreasing c. Therefore
$$
 \mathcal T(T)\le C_{R,\psi}e^{-c_1e^{2T}}
 \tag{6}
$$
for sufficiently large T. No pointwise derivative of ψ was used.

## 3. Convergence of every prime-power arrival in physical form norm

Set g_−=Φψ1_(u<−R), which belongs to H by (1)–(3). On u>R the exact prime profile is
$$
 T_p(u)=2e^{u/2}\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
                    g_-(u-\log n).
 \tag{7}
$$
The strict crossing condition is built into the support of g_−. Define m(u)=Φ(u)e^(u/2), a globally smooth bounded multiplier with bounded derivative. Thus
$$
 \Phi w_p\,1_{u>R}
 =2\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
       1_{u>R}m(u)g_-(u-\log n).
 \tag{8}
$$
For large n let l=log n and split g_− into its restrictions to v≥−l/2 and v<−l/2. The first piece has H norm at most C_P||g_−||_H. Its translate is supported on u≥l/2. Choose a smooth guard which is zero below l/2−1 and one above l/2. Multiplying m by this guard does not change its action on that translated piece. By the full theta derivative bounds, the supremum and Lipschitz norm of the guarded multiplier are at most C exp(−c₂e^l)=C exp(−c₂n).

The far piece has H norm at most 𝒯(l/2), bounded by C_(R,ψ)exp(−c₁n) by (5)–(6). Apply (3)–(4) to both pieces, retaining the final exterior cutoff. This proves
$$
 \|1_{u>R}m(u)g_-(u-\log n)\|_\mathcal H
 \le C_{R,\psi}e^{-c_3 n}
 \tag{9}
$$
for all sufficiently large n. The finitely many remaining indices are legitimate H vectors by (3)–(4). Since Λ(n)≤log n, (9) proves absolute convergence of the entire series (8) in H.

The pointwise nonnegative arrival sums agree with this limit: H convergence implies L² convergence and an almost-everywhere subsequence, while the nonnegative partial sums have the already established finite pointwise limit. Reflection supplies the negative half and the odd sign. Hence Φw_p∈H for w_p extended by zero on C.

The existing complete departure estimate also gives
$$
 |w_p(u)|\le 2P_\infty B_p/\rho(u),\qquad
 \|w_p\|_\nu²\le4P_\infty²B_p²\int_O\rho^{-2}d\nu<\infty.
 \tag{10}
$$
Equations (1), (8)–(10) prove w_p∈V_L. For the full internal ground conductance, bounded ψ then gives
$$
 \mathsf E_\psi(w_p)
 =\tfrac12\iint_{O²}|\Delta w_p|²\psi(u)\psi(v)J(du,dv)
 \le P_\infty²E(w_p)<\infty.
 \tag{11}
$$
Its L²(γ) membership was already proved by the cross-rate bound. We have therefore established
$$
 \boxed{\quad w_p\in V_K=D(K^{1/2}),\qquad
                    \varepsilon\in D(K^{3/2}).\quad}
 \tag{12}
$$
For the second conclusion use Kε=aε+w_c+w_p, ε∈D(K), and w_c∈D(K). The resulting prime-profile energy is finite; no uniform numerical smallness is claimed.

## 4. The actual score-crossing source also has full energy

For x=σ_C, the compact physical input is g_C=Φx=Φ′1_C. It is compactly supported and of bounded variation. Therefore its Fourier transform is O((1+|ξ|)^(−1)). The multiplier of A is O(log(2+|ξ|)), so
$$
 Ag_C\in\mathcal H,
$$
since ∫_1^∞log³(2+ξ)ξ^(−2)dξ<∞. Away from C, the exact off-diagonal continuous action is
$$
 (B_cx)(u)=-\frac{Ag_C(u)}{b(u)},\qquad
 \Phi(u)\frac{B_cx(u)}{\rho(u)}
 =-\Phi(u)e^{|u|/2}Ag_C(u),\quad u\in O.
 \tag{13}
$$
There is no a₀g_C term outside C. The smooth multiplier in (13) can be extended through C with bounded derivative, and the hard exterior cutoff is bounded by (3). This proves physical H regularity of the continuous part, including its logarithmic boundary behavior.

For the prime part the physical formula is
$$
 \Phi\frac{B_px}{\rho}
 =1_O\Phi(u)e^{|u|/2}
  \sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
       [g_C(u-\log n)+g_C(u+\log n)].
 \tag{14}
$$
Each translated compact input is supported where |u|≥log n−R. A smooth guard on that support makes the multiplier and its derivative decrease like exp(−c_Rn²). Equations (3)–(4) therefore prove absolute H convergence of all terms in (14).

The remaining original L²(ν) condition for S_f=f/ρ can be checked directly. Near the two finite boundary points ρ is bounded below and B is L² bounded. For u>R+1 the continuous crossing is O_R(e^(−u)). In the prime crossing sum the support requires e^(u−R)≤n≤e^(u+R). The elementary bound Λ(n)≤log n, the number of these integers, b(u)≥e^(u/2), and bounded compact g_C give |B_px(u)|≤C_R(1+u). Reflection treats the negative tail. Hence |S_f(u)|≤C_R(1+|u|)e^(|u|) there, which is square-integrable against ν. Thus S_f∈L²(ν). Combining with (13)–(14) and (1) proves S_f∈V_L, and bounded ψ implies
$$
 S_f=(Bσ_C)/\rho\in V_K.
 \tag{15}
$$
Likewise S_y=σ_O/ρ and S_q=τ_O/ρ are in V_L: their zero extensions have theta-integrable original L² norms, and their physical products are smooth functions of theta decay followed by the hard cutoff. Their original derivatives have at most exponential growth before multiplication by Φ. Hence both lie in V_K by (11).

## 5. The score-matched inverse produces a legitimate full-form trial

The score matching uses M=K_cp and φ=y/ψ∈D(K), with
$$
 K\varphi=S_f+\delta S_y-\lambda S_q/2.
$$
Equations (12) and (15), the preceding source regularity, and w_c∈D(K) show that every vector in this right side and every finite-rank profile of M lies in V_K. Since K₀ is a scalar multiple of the identity plus the bounded half-line-constant projection, Mφ∈V_K. Therefore
$$
 v=(K-M)\varphi\in V_K.
$$
The score-matched comparison Mhat is K₀ plus the finite ranks generated by w_c,w_p,v (omitting a zero rank when appropriate). Its inverse is K₀^(−1) plus a finite-rank correction whose vectors are K₀^(−1)w_c, K₀^(−1)w_p, K₀^(−1)v. All are in V_K because K₀^(−1) adds only multiples of 1 and ε.

It follows that for every real scalar t, including the actual affine optimizer,
$$
 \boxed{\quad
 v_U=\widehat M^{-1}(S_f-tS_q)\in V_K.
 \quad}
 \tag{16}
$$
Thus (K−Mhat)[v_U] is a finite, legitimate nonnegative form value. The argument establishes the missing domain prerequisite for the primal affine-gap upper estimate. It does not assert that this energy is small, replace the full prime series by finite shifts, or introduce regularity assumptions on the ground state beyond its actual equation and proved boundedness.

## Attribution and formal scope

The closed-form representation theorem, ground-state transform, Carleman bound, nonnegative-form Cauchy–Schwarz and affine variational identities used here are classical. The proofs retain the actual ground state and every continuous and prime-power edge. These are written mathematical results, with no Lean claim for the full-form comparison or the remaining arithmetic smallness.
