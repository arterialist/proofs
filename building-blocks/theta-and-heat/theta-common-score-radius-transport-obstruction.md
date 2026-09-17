# Exact radius transport and the obstruction to a common-score residual recurrence

This note consumes [theta affine comparison conditional edge energy](theta-affine-comparison-conditional-edge-energy.md) and [theta ground exponential weak cross row](theta-ground-exponential-weak-cross-row.md). It retains the actual full continuous and prime forms, both pole constraints, and the optimizer
$$
 v_R=M_R^{-1}(S_{f_R}-t_RS_{q_R}),\qquad
 t_R=\frac{U_R(f_R,q_R)+m_R^{\rm aff}}{U_R(q_R,q_R)},
$$
where f_R=B_Rσ_(C_R), q_R=τ_(O_R), and m_R^aff=⟨σ_(C_R),τ_(C_R)⟩ν. The symbol m_R below denotes the quadratic form of M_R, not this scalar affine moment. The actual estimator is n_R[v_R], with n_R=k_R−m_R≥0. Its full form-domain membership has already been proved.

The conclusions are an exact energy transport and two obstructions to closing a stronger defect recurrence from the presently available norm and mixed-row hypotheses. They do not give a counterexample to a possible recurrence for the single specified family v_R.

## 1. Exact ground transition between two radii

Let T>R, A=O_R\O_T, and let ψ_R,ψ_T be the positive even normalized killed grounds with eigenvalues α_R,α_T. Extend ψ_T by zero on A. The actual hard split gives
$$
 D_R\psi_T=\alpha_T\psi_T-1_A B_{(T;R)}^*\psi_T.
$$
Pairing against ψ_R gives the exact identity
$$
 \boxed{\quad
 (\alpha_T-\alpha_R)\langle\psi_R,\psi_T\rangle_\nu
 =\langle B_{(T;R)}\psi_R1_A,\psi_T\rangle_\nu>0.
 \quad}
 \tag{1}
$$
The continuous kernel is strictly positive between A and O_T, so the right side is positive. Thus α_T>α_R, with no removal of prime arrivals. The overlap is also positive.

Writing y=ψ_R1_(O_T) gives
$$
 (D_T-\alpha_R)y=B_{(T;R)}\psi_R1_A.
 \tag{2}
$$
If y=bψ_T+y_⊥, then
$$
 b=\frac{\langle B_{(T;R)}\psi_R1_A,\psi_T\rangle}
          {\alpha_T-\alpha_R},
\quad
 y_\perp=(D_T-\alpha_R)^{-1}_{\psi_T^\perp}
         P_{\psi_T^\perp}B_{(T;R)}\psi_R1_A.
 \tag{3}
$$
The inverse on the complement is bounded by 1/(α_T−α_R+d_T), where d_T is the positive spectral separation above the simple ground. These formulas specify the normalized-ground transition and its denominator; a small crossing norm alone does not bound the normalized direction by a contraction.

## 2. Physical transport contracts the complete energy exactly

For this section let h∈V_L be real, odd, supported in O_T, and satisfy ⟨h,τ⟩ν=0. The other constraint ⟨h,1⟩ν=0 follows from oddness. Equivalently the physical test z=Φh has both moments M_(±1/2)(z)=0.

The original ground transform and exact common-domain theorem put
$$
 F_R=h/\psi_R\in V_{k_R},\qquad F_T=h/\psi_T\in V_{k_T}.
$$
Both potentials are odd and centered in their respective γ clocks. No lower bound on either ground is used. The physical identity, including exterior killing, gives
$$
 k_R[F_R]=E(h)-\alpha_R\|h\|_\nu²,\qquad
 k_T[F_T]=E(h)-\alpha_T\|h\|_\nu².
$$
Hence
$$
 \boxed{\quad
 k_T[F_T]=k_R[F_R]-(\alpha_T-\alpha_R)\|h\|_\nu².
 \quad}
 \tag{4}
$$
This is a genuine scale transport with coefficient one and a favorable signed decrement. All continuous and prime-power edges are present through E(h).

For the common-score defects the corresponding exact identity is instead
$$
 \boxed{\quad
 n_T[F_T]=n_R[F_R]-(\alpha_T-\alpha_R)\|h\|_\nu²
               +m_R[F_R]-m_T[F_T].
 \quad}
 \tag{5}
$$
No sign for the last difference is supplied by the energy contraction.

Its contents can be written without an implicit metric change. For radius S=R or T let
$$
 M_S=K_{0,S}+\frac{w_{c,S}\otimes w_{c,S}}{d_{c,S}}
                 +\frac{w_{p,S}\otimes w_{p,S}}{p_S}
                 +\frac{v_{*,S}\otimes v_{*,S}}{d_{y,S}},
$$
with a zero score rank omitted. Put a_S=γ_S(O_S) and κ_S=a_S(e^S+1)/2. Then, for the transported h,
$$
 \begin{split}
 m_S[h/\psi_S]={}&
 \kappa_S\int_{O_T}\frac{\rho|h|²}{\psi_S}d\nu
 -\frac{\kappa_S-a_S}{a_S}
       \left|\int_{O_T}\rho\varepsilon h\,d\nu\right|²\\
 &+\frac{|\int_{O_T}\rho h w_{c,S}d\nu|²}{d_{c,S}}
  +\frac{|\int_{O_T}\rho h w_{p,S}d\nu|²}{p_S}
  +\frac{|\int_{O_T}\rho h v_{*,S}d\nu|²}{d_{y,S}}.
 \end{split}
 \tag{6}
$$
All entries are finite by the common-domain theorem and boundedness of M_S. Formula (6) shows exactly which inverse-ground weighted norm and profile moments a defect recurrence must compare. The scalar δ_S is not a multiplier of this entire signed difference.

To apply (5) to the actual optimized family, a further issue remains: h_T=ψ_Tv_T is not the restriction of ψ_Rv_R. The coefficients t_R,t_T each contain their actual affine denominator and source. Identifying these two physical trials, or bounding their difference, would be an additional theorem. Equations (1)–(6) do not make that substitution.

## 3. Same-potential normalized transport has a sharp concentration cost

Let μ_S=ψ_S²ν. The established actual shrinking-trial and sharp-crossing theorem gives, for w_R=e^(−√R/8) and T=R+6w_R, eventually
$$
 \mu_R(O_T)\le\exp[-2\pi e^{2R}w_R],\qquad\mu_T(O_T)=1.
$$
Therefore any domination of the unchanged potential norm,
$$
 \int_{O_T}|F|²d\mu_T
 \le C_{T,R}\int_{O_T}|F|²d\mu_R\quad\text{for every bounded }F,
$$
necessarily has
$$
 \boxed{\quad C_{T,R}\ge\mu_R(O_T)^{-1}
                   \ge e^{2\pi e^{2R}w_R}.\quad}
 \tag{7}
$$
Test F=1. The first constant is attained by the intermediate measure μ_R restricted to O_T and then normalized; the actual μ_T can require a still larger domination constant, or no finite constant. This is an actual normalization obstruction, not an arbitrary model. It concerns unchanged potentials, and does not contradict the favorable physical transport (4), which changes the potential by ψ_R/ψ_T.

## 4. Every even-ground mixed row is blind to the odd residual sector

For each radius S, the actual physical ground G_S=Φψ_S is even. The physical form A−S and the full Weil form Q preserve reflection. Thus for every admissible odd physical z,
$$
 \boxed{\quad \mathscr K(G_S,z)=Q(G_S,z)=0.\quad}
 \tag{8}
$$
This also follows from the exact weak-row measure in [theta ground exponential weak cross row](theta-ground-exponential-weak-cross-row.md): every part of that measure, including the full core arrival and both pole compensation densities, is even. Equation (8) does not delete pole terms; their two opposite odd moments cancel in the mixed pairing. If both moments of z are zero, they vanish separately.

The actual affine source and comparison potential in this branch are odd. Consequently even-ground weak rows alone cannot observe their odd conditional increments. To make this limitation quantitative, fix any exterior radius T. Choose a nonzero nonnegative even smooth χ supported in a compact annulus inside O_T. Set
$$
 v_\xi^{(0)}(u)=\chi(u)\sin(\xi u),\qquad
 h_\xi^{(0)}=\psi_Tv_\xi^{(0)}.
$$
These functions are form-admissible: multiplication by a bounded smooth Lipschitz function preserves the original ground form. Choose v₀=τχ and set
$$
 a_\xi=\frac{\langle h_\xi^{(0)},\tau\rangle_\nu}
                  {\langle\psi_Tv_0,\tau\rangle_\nu},
 \quad v_\xi=v_\xi^{(0)}-a_\xi v_0,
 \quad h_\xi=\psi_Tv_\xi.
 \tag{9}
$$
The denominator is positive. Riemann–Lebesgue gives a_ξ→0. Thus h_ξ is odd, supported outside the core, and satisfies both exact constraints. Its physical representative z_ξ=Φh_ξ is compactly supported and bounded, with finite logarithmic form norm, so all ground-row pairings in (8) are legitimate and vanish for every S.

Nevertheless the full conditional edge energy is unbounded. Put g=Φψ_Tχ. This nonzero real even function belongs to H^(log/2). The actual archimedean multiplier a(t)=log|t|+O(1) yields
$$
 A[g\sin(\xi\cdot)]
 =\frac12\|g\|_2²\log|\xi|+o(\log|\xi|).
 \tag{10}
$$
For completeness, modulation shifts the Fourier transform by ±ξ. The individual weighted integrals divided by log|ξ| tend to ||g||²₂ by dominated convergence, using log(2+|ξ+t|)≤log(2+|ξ|)+log(2+|t|). The cross term tends to zero after this normalization: first approximate g in the logarithmic form norm by a function with compact Fourier support, where the shifted supports are disjoint, and then use weighted Cauchy–Schwarz. This requires only logarithmic form regularity, not differentiability of ψ_T.

The complete normalized prime operator and all lower-order terms are bounded in the original theta Hilbert space. The correction a_ξv₀ changes (10) by o(log|ξ|). The ground identity and boundedness of the fixed M_T therefore give
$$
 \boxed{\quad
 n_T[v_\xi]=\frac12\|\Phi\psi_T\chi\|_2²\log|\xi|
                       +o(\log|\xi|)\longrightarrow\infty.
 \quad}
 \tag{11}
$$
Also
$$
 \|v_\xi\|_{\gamma_T}²\longrightarrow
                       \tfrac12\int\chi²d\gamma_T>0.
$$
The physical L²(ν) norm of h_ξ likewise has a finite positive limit. Hence these examples may be normalized with either norm without losing (11). The exact common-score subtraction and both component cross-mean subtractions are already included in n_T=K_T−M_T. Since M_T is bounded, those finite ranks cannot remove the leading logarithmic energy.

Thus no estimate of n_T on admissible potentials can follow from their L² normalization and any collection of these even-ground mixed rows alone. This is an obstruction inside the actual full theta system, with all prime powers and both pole constraints retained. The examples are admissible exterior variations, not the distinguished arithmetic optimizer v_T. They do not disprove a source-specific recurrence that additionally uses its complete equation and coefficient dependence.

## The precise remaining scale estimate

There are two legitimate paths left by these identities. For physical transport one must control the signed finite-comparison change in (5)–(6), together with the difference between the two actual optimized physical trials. For unchanged potentials one must pay the normalization cost (7). The mixed weak rows do not supply either control on the odd sector, as (8)–(11) show.

Accordingly the available hypotheses yield the exact complete-energy recurrence (4), but not a closed contractive recurrence for n_R[v_R] or the actual signed mixed-ground convolution. Calling the missing terms small because the coherent score energy is small, or because the normalized ground is concentrated, would omit respectively the actual affine denominator/profile terms or the change of ground normalization. No such omission is made here.

## Attribution and formal scope

This is written mathematics, with no Lean formalization of the displayed domain, transport or sampling estimates. Ground-state transforms, spectral projection and Fourier modulation are classical. The exact transport is for a shared physical trial, not an identification of separately optimized arithmetic sources. No RH conclusion or passing full affine comparison is asserted.
