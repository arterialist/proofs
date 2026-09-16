# Signed alternating response with the arrival defect retained

This bounded attempt gives a finite-horizon signed compensation inequality for the actual constrained theta source. It identifies an arithmetic dual-energy quantity that can be estimated without assigning a sign to a mixed pairing. It also keeps the original Suzuki arrival defect explicit. The supplied interface does not identify the Suzuki positive-map action with the theta conditional forms, so these two costs cannot yet be combined into one theorem. RH and the sharp theta gap remain open.

These are written calculations using the actual form identification in the linked notes. No Lean file was compiled for this note.

## The precise source consumer

Use [the actual affine optimizer and conditional edge forms](theta-affine-comparison-conditional-edge-energy.md), equations (1)-(6), and [the affine normalization](theta-score-matched-affine-gap.md), equations (12)-(17). The signed two-parameter response and all definitions needed from its derivation are restated below.

Fix a physical exterior cutoff R and the actual odd core score. All definitions below use its actual ground ψ, measure γ, sources S_f and S_q, and scalar m. Write

\[
\mathcal B_C=E_C[\sigma_C]-\alpha\|\sigma_C\|_\nu^2,
\quad f=B\sigma_C,\quad q=\tau_O,
\quad m=\langle\sigma_C,\tau_C\rangle_\nu.
\]

On the unchanged actual full form domain V, put

\[
W=\{z\in V:\langle z,S_q\rangle_\gamma=0\},
\quad h_{t,s}=m_M+t n_c+s n_p,
\]
\[
J_R(t,s)=\mathcal B_C+
\min_{\langle v,S_q\rangle_\gamma=-m}
\bigl(h_{t,s}[v]-2\langle S_f,v\rangle_\gamma\bigr).
\tag{1}
\]

The physical extension is ψv. Thus (1) retains the original score constraint and the ground normalization. The mean constraint vanishes by odd parity. At t=s=1 this is the true affine form, not a new pole-null problem. The continuous gamma contribution is contained in the actual k and m_M identification, including the continuous remainder after the established minorants.

For completeness the affine coefficient at arbitrary positive t,s is fixed by the actual covariance of h_{t,s},

\[
U_{t,s}(g,h)=\langle H_{t,s}^{-1}S_g,S_h\rangle_\gamma,
\quad \eta_{t,s}=\frac{U_{t,s}(f,q)+m}{U_{t,s}(q,q)},
\quad v_{t,s}=H_{t,s}^{-1}(S_f-\eta_{t,s}S_q).
\tag{2}
\]

H_{t,s} denotes the positive operator represented by the closed coercive form. Formula (2) is a source formula, not an assertion that the component forms act as L² operators on v.

## The signed compensation inequality

Fix 0<ε<1. This is a finite parameter horizon at a fixed physical R; no ε=0 endpoint or R→∞ passage is taken. Define constrained responses z_c,z_p∈W by

\[
h_{t,s}(z_i,z)=n_i(v_{t,s},z),\qquad z\in W,
\quad z_\Sigma=z_c+z_p,\quad z_\Delta=z_c-z_p.
\tag{3}
\]

The actual mixed response identity and polarization give

\[
\partial_t\partial_s J_R
=-2h_{t,s}(z_c,z_p)
=\tfrac12\bigl(h_{t,s}[z_\Delta]-h_{t,s}[z_\Sigma]\bigr).
\tag{4}
\]

Consequently the finite-horizon interaction satisfies the exact identity

\[
\mathfrak I_{R,\epsilon}
:=J_R(1,1)-J_R(\epsilon,1)-J_R(1,\epsilon)+J_R(\epsilon,\epsilon)
=\tfrac12\int_\epsilon^1\int_\epsilon^1
\bigl(h_{t,s}[z_\Delta]-h_{t,s}[z_\Sigma]\bigr)\,ds\,dt,
\tag{5}
\]

and the proved signed upper bound

\[
\boxed{\quad
J_R(1,1)\le J_R(\epsilon,1)+J_R(1,\epsilon)-J_R(\epsilon,\epsilon)
+\tfrac12\int_\epsilon^1\int_\epsilon^1 h_{t,s}[z_\Delta]\,ds\,dt.
\quad}
\tag{6}
\]

The additive core normalization cancels in (5) because its four coefficients sum to zero. It remains in every value in (6). No source rescaling or affine coefficient replacement occurred.

This is useful when the alternating continuous-minus-prime response is small, even if the separate responses are large. It does not require h(z_c,z_p)≥0. The favorable sum-response term was kept in (5) and then discarded only in the valid direction for (6).

## Exact arithmetic data for the alternating source

Use the common score subtraction

\[
Pz=z-\frac{R_0(z,\varphi)}{R_0[\varphi]}\varphi,
\quad R_0=R_c+R_p,\quad\varphi=\sigma_O/\psi,
\]

with P=I in the zero-denominator case, as established in the conditional-edge note. The source for z_Δ is the actual form-dual functional

\[
\ell_\Delta^{t,s}(z)=n_c(v_{t,s},z)-n_p(v_{t,s},z)
=R_c(Pv_{t,s},Pz)-R_p(Pv_{t,s},Pz).
\tag{7}
\]

Define the polarized same-half form with the full directed conductance,

\[
\operatorname{Same}_i(x,y)=\tfrac12\int_{\text{same half}}
(x(u)-x(w))(y(u)-y(w))J_i(du,dw).
\]

Then (7) is exactly

\[
\operatorname{Same}_c(Pv,Pz)-\operatorname{Same}_p(Pv,Pz)
+m_c\operatorname{Cov}_{\pi_c}(\Delta_\times Pv,\Delta_\times Pz)
-m_p\operatorname{Cov}_{\pi_p}(\Delta_\times Pv,\Delta_\times Pz).
\tag{8}
\]

Each covariance subtracts its own full crossing mean. P remains common to both components. In particular, the prime covariance uses

\[
m_p\,\mathbb E_{\pi_p}F=
\sum_{\log n>2R}\frac{\Lambda(n)}{\sqrt n}
\int_R^{\log n-R}\psi(u)\psi(u-\log n)
\Phi(u)\Phi(u-\log n)F(u,u-\log n)\,du.
\tag{9}
\]

The prime same-half term uses

\[
\operatorname{Same}_p(x,y)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
\int_{\substack{u,u+\log n\in O\\\text{same half}}}
\psi(u)\psi(u+\log n)\Phi(u)\Phi(u+\log n)
\bigl(x(u+\log n)-x(u)\bigr)
\bigl(y(u+\log n)-y(u)\bigr)\,du.
\tag{10}
\]

Equations (9) and (10) include every actual prime power. The other orientation is already included by symmetry; no extra half factor belongs in these formulas. The continuous conductance is exactly

\[
J_c=J_c^\psi-\gamma\otimes\gamma
-(e^R-1)1_{\{\text{same half}\}}\gamma\otimes\gamma.
\tag{11}
\]

It may have infinite same-half activity. Finite form energy, rather than a finite-rate approximation, justifies the pairings.

## A fixed-form majorant and the quantity still to estimate

Let h_*:=h_{\epsilon,\epsilon} restricted to W. Define one concrete arithmetic dual energy

\[
Q_\Delta(R,\epsilon;t,s)=
\sup_{z\in W}\{2\ell_\Delta^{t,s}(z)-h_*[z]\}.
\tag{12}
\]

This is the squared h_* dual norm of the exact source (8). Since h_{t,s}≥h_*, its variational inverse satisfies

\[
0\le h_{t,s}[z_\Delta]
=\sup_{z\in W}\{2\ell_\Delta^{t,s}(z)-h_{t,s}[z]\}
\le Q_\Delta(R,\epsilon;t,s).
\tag{13}
\]

Existence and finiteness follow on the full domain. More explicitly, form Cauchy-Schwarz gives

\[
|\ell_\Delta^{t,s}(z)|
\le\bigl(\sqrt{n_c[v_{t,s}]}+\sqrt{n_p[v_{t,s}]}\bigr)
\sqrt{(n_c+n_p)[z]},
\]
\[
Q_\Delta\le\epsilon^{-1}
\bigl(\sqrt{n_c[v_{t,s}]}+\sqrt{n_p[v_{t,s}]}\bigr)^2.
\tag{14}
\]

Thus the following upper bound is proved and finite,

\[
\mathfrak I_{R,\epsilon}
\le\tfrac12\int_\epsilon^1\int_\epsilon^1
Q_\Delta(R,\epsilon;t,s)\,ds\,dt.
\tag{15}
\]

The estimate (14) proves boundedness, not smallness. The sharper quantity (12) retains the signed cancellation in (8), whereas replacing it by (14) usually loses the proposed compensation mechanism. For a specified finite budget b, a sufficient remaining arithmetic estimate is

\[
\int_\epsilon^1\int_\epsilon^1 Q_\Delta\,ds\,dt\le2b.
\tag{16}
\]

Equation (16) is an open estimate, not an adopted hypothesis or an RH conclusion. No numerical value at R=2 is certified here.

A finite trial family in W gives a lower bound on Q_Δ and therefore cannot certify (16) by itself. An upper certificate needs a bound on the omitted dual residual. If w is a form-admissible trial and e(z)=ℓ_Δ(z)−h_*(w,z), the exact completion is

\[
Q_\Delta=2\ell_\Delta(w)-h_*[w]+\|e\|_{h_*^\prime}^2.
\tag{17}
\]

This states the missing tail obligation explicitly, including every omitted prime-power edge and continuous contribution. It avoids treating a finite matrix inverse as the full constrained inverse.

## The paid arrival remains in the original metric

The exact half-history arithmetic interface gives the following Suzuki relation on L²([-log a,log a]):

\[
I+\sigma H_\omega=\mathcal C_\omega(I+\sigma G_\omega)-(T_\omega-I),
\qquad\sigma\in\{-1,1\},
\tag{18}
\]
\[
T_\omega(t)=\sum_{d\le\min(a^2,e^{2(t+\log a)})}
\frac{c_\omega(d)}{\sqrt d}.
\]

For every actual interval consumer x the original-metric cost is

\[
D_{a,\omega}[x]=\int_{-\log a}^{\log a}(T_\omega(t)-1)|x(t)|^2dt,
\]
\[
\langle(I+\sigma H_\omega)x,x\rangle
=\sum_{d\le a^2}\frac{c_\omega(d)}{\sqrt d}
\langle(I+\sigma G_\omega)S_{\log d/2}^*x,S_{\log d/2}^*x\rangle
-D_{a,\omega}[x].
\tag{19}
\]

This retains the signed gamma kernel, the true causal compression, and complete Euler coefficients. Positivity of the map does not certify that the first term pays D. The desired certificate in this consumer is precisely that the first term in (19) is at least D, with no T-normalized replacement of the original norm.

There is no demonstrated map from the actual constrained exterior potential v_{t,s} in (1) to an interval x for which (19) equals the theta mixed-response quantity (5) or (12). Their gamma kernels, measures and form domains are different objects in the current written interface. Accordingly this note does not add D_{a,ω}[x] to (15) or divide it by an arbitrary theta norm. Such a step requires an explicit form identity, its source normalization and its domain proof. The first nontrivial half-history displacement also reaches the theta seed's L² boundary described in the supplied interface, so literal shift transport is not already justified.

The constructive outcome is (6), (8), (12), and (15): a signed finite-horizon theta response bound with one exact arithmetic quantity left to estimate. Any eventual Suzuki-based proof must additionally supply the form transfer and pay the defect (19). Neither positive component forms nor arrival-normalized contractivity supplies those missing statements.
