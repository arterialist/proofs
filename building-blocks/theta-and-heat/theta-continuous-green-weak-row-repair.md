# Continuous Green inversion of the actual weak ground row

The full continuous clock inverse used for the covariance and the translation-invariant physical continuous inverse are different operators. The first is coercive in the ground-weighted clock space. The second has a slow exponential Green mode that must be removed before it can be inserted into the actual exponential weak row. This note gives an exact repair and computes its non-small coefficient for the actual scaling family.

## The physical continuous resolvent and its exact slow mode

Use the physical multiplier and jump kernel
$$
 A=a_0+L_r,\qquad
 r(s)=\frac{e^{-s/2}}{1-e^{-2s}}
       =\sum_{j\ge0}e^{-b_js},\qquad b_j=2j+1/2.
$$
Choose a fixed $\kappa>-a_0$, and write $m=\kappa+a_0>0$. Then $A+\kappa$ is positive and invertible on physical $L^2$. Its symbol is $F_\kappa(\xi^2)$, where
$$
 F_\kappa(z)=m+\sum_{j\ge0}\frac{2z}{b_j(b_j^2+z)}.
\tag{1}
$$
The series converges locally uniformly away from its displayed poles. There is exactly one root $-\beta_0^2$ with $0<\beta_0<1/2$, and exactly one root $-\beta_j^2$ with $b_{j-1}<\beta_j<b_j$ for each j≥1. Indeed the derivative with respect to z is positive on every real interval between poles, while the two one-sided pole limits have opposite signs. No nonreal root exists: for Im z>0 each summand in (1) has strictly positive imaginary part.

The Green operator is convolution with a positive integrable kernel
$$
 q_\kappa(u)=\sum_{j\ge0}d_j\frac{\beta_j}{2}e^{-\beta_j|u|},
 \qquad
 d_j=\frac1{\beta_j^2F_\kappa'(-\beta_j^2)}>0,
 \qquad \sum_jd_j=1/m.
\tag{2}
$$
Here is an elementary route to the representation, avoiding an assumption about its tail. Truncate (1) at a finite j. Its rational reciprocal has simple interlacing negative real poles with positive residues, plus a nonnegative constant. Its value at z=0 is 1/m, so it is a positive mixture of the functions $\beta^2/(\beta^2+z)$, with total mixture mass at most 1/m. The constant tends to zero because $\sum_j2/b_j$ diverges. Compactness of the finite measures and locally uniform convergence in (1) give a representing measure for the reciprocal. On any compact segment of the negative real axis its support can consist only of the displayed simple roots; this follows either by the elementary Stieltjes inversion formula or by passing the finite interlacing poles on that segment. There is no remaining mass at infinity, since $1/F_\kappa(x)\to0$ as x→∞. The residues are those in (2). Fourier inversion of $\beta^2/(\beta^2+\xi^2)$ proves (2), with convergence in L¹.

Consequently, if z is nonnegative, compactly supported, and nonzero,
$$
 (A+\kappa)^{-1}z(u)\sim
 \frac{d_0\beta_0}{2}M_{\beta_0}(z)e^{-\beta_0u}
 \quad(u\to+\infty),
\tag{3}
$$
with the analogous negative-tail moment. In particular this resolvent does not preserve the weak-row test class with exponential decay rate greater than 1/2. The obstruction occurs for an actual positive test and the actual continuous kernel, not for an arbitrary model operator.

## Exact moment correction restores the mixed domain

Suppose z belongs to the physical logarithmic form space, is locally bounded, and decays like $e^{-\beta|u|}$ with β>1/2. Choose two fixed compact smooth functions with an invertible moment matrix at ±β₀, and subtract their unique linear combination to obtain z♯ with
$$
 M_{\beta_0}(z^\sharp)=M_{-\beta_0}(z^\sharp)=0.
\tag{4}
$$
Then $u=(A+\kappa)^{-1}z^\sharp$ belongs to D(A) and decays at every rate
$$
 1/2<\eta<\min(\beta,\beta_1).
\tag{5}
$$
For the first exponential term in (2), (4) writes each convolution tail solely as integrals over the corresponding tail of z♯; these are O(e^(-η|u|)). All remaining terms have β_j≥β₁, and their exponential η-moments sum to at most
$(1-\eta^2/\beta_1^2)^{-1}\sum_{j≥1}d_j$. This proves (5) without differentiating any ground state.

Moreover the repaired Green test automatically has the original two Weil pole moments zero:
$$
 M_{1/2}(u)=M_{-1/2}(u)=0.
\tag{6}
$$
For a justification retaining the critical endpoint, the Fourier–Laplace multiplier identity first holds in the original convergence strip |Re s|<β₀. The vanishing conditions (4) remove its two intervening poles, and (5) permits analytic continuation through them up to |Re s|<η. At s=±1/2 the reciprocal $1/F_\kappa(-s^2)$ has a zero, because F has its first actual pole there; hence the continued moment identity gives (6). These zeros must not be confused with the artificial resolvent poles at ±β₀.

## The complete ground equation gives a signed Green-row identity

Retain literally the weak ground source
$$
 d\eta_R=[\delta1_Ob\psi+1_C\mathcal B_R]du,
 \qquad \mu=\int bG,
 \qquad d\widetilde\eta_R=d\eta_R-\tfrac12\mu b\,du.
$$
For u from (4)–(5), all prime sums below are absolutely convergent in their pairing with G. Self-adjointness of A, the equation $(A+\kappa)u=z^\sharp$, and the established weak ground row give
$$
 \boxed{\quad
 Q_{\rm W}(G,u)
 =\langle G,z^\sharp\rangle
       -\kappa\langle G,u\rangle
       -\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
          \int G(v)[u(v+\log n)+u(v-\log n)]dv
 =-\int u\,d\eta_R.
 \quad}
\tag{7}
$$
The equality with the final expression uses (6); before that cancellation the full pole term is $\frac12\mu\int bu$. The core arrival in η_R has not been dropped. Formula (7) isolates the signed full prime correction to the continuous Green row. It is valid even though u/Φ need not have the theta source norm.

This identity is not obtained by separately applying the physical inverse to SG and bψ. Those quantities can have exponentially growing tails, and their individual L² resolvents are not justified. Only the admissible test-side inversion above is used.

## The actual scaling family pays a growing correction port

For the real even h_t from the coherent-core source, fix an even compact smooth counterprofile ρ with $M_{\beta_0}(\rho)=1$. A single even correction suffices:
$$
 h_t^\sharp=h_t-H_{\beta_0}(t)\rho,
 \qquad H_{\beta_0}(t)=M_{\beta_0}(h_t).
$$
The original row is restored exactly as
$$
 Q_{\rm W}(G,h_t)=Q_{\rm W}(G,h_t^\sharp)
                   +H_{\beta_0}(t)Q_{\rm W}(G,\rho).
\tag{8}
$$
The newly required moment is not the small Weil pole value H_t at 1/2. The exact change of variables gives, for 0<b<1/2,
$$
 M_b(h_t)=-t^{-b}\int_t^\infty x^{b-1/2}K_{\rm sc}(x)dx
          -t^b\int_t^\infty x^{-b-1/2}K_{\rm sc}(x)dx.
$$
The scaling-kernel endpoints yield
$$
 \boxed{\quad
 H_{\beta_0}(t)
 =-\mathcal M K_{\rm sc}(\beta_0+1/2)t^{-\beta_0}+O(1),
 \qquad -\mathcal M K_{\rm sc}(\beta_0+1/2)>0.
 \quad}
\tag{9}
$$
The sign follows directly from the exact Mellin transform in [scaling-kernel Mellin calculation](../goldbach/goldbach-scaling-kernel-hard-wall.md): its value is negative on (1/2,1). Thus the repaired inversion retains a growing finite-dimensional port. It cannot be declared small from the separately proved $H_t=O(\sqrt t\log(1/t))$ at the original pole. Nor is applying the Green operator a bound for the original row: (7) concerns u, while (8) and the relation $h_t^\sharp=(A+\kappa)u$ retain the additional operators and counterprofile.

## What remains valid in the ground-weighted continuous covariance base

For comparison, let $K_c=a+A_{c,\mathrm{rem}}$ on L²(γ), and let $\mathfrak p$ be the complete nonnegative prime form. The actual clock is $K=K_c+\mathfrak p$ as a form sum. This positive inverse has no physical slow-tail ambiguity. With $R_c=K_c^{-1}$, define the closed densely defined operator
$$
 T=A_p^{1/2}R_c^{1/2}.
$$
Its domain is dense because bounded continuous-form truncations lie in the full prime-form domain, as proved in the continuous-base source. Form conjugation then gives the exact bounded identity
$$
 \boxed{\quad
 K^{-1}=R_c^{1/2}(I+T^*T)^{-1}R_c^{1/2}.
 \quad}
\tag{10}
$$
For every admissible weighted source S, putting x=R_c^(1/2)S yields
$$
 \langle R_cS,S\rangle-\langle K^{-1}S,S\rangle
 =\int_{[0,\infty)}\frac{\lambda}{1+\lambda}\,d\langle E_{T^*T}(\lambda)x,x\rangle\ge0.
\tag{11}
$$
This retains all prime edges and the full continuous inverse. It is not a scalar geometric-series estimate: no bound $\|T\|<1$, or suitable small spectral support for the actual source, has been established. Applying (11) to a source f-cq must precede the actual affine minimization; it does not remove either pole constraint or keep its optimizer fixed without proof.

Finally, an exponential physical test z cannot be silently used as a clock potential z/G. Its squared clock norm would be
$$
 \int\left|\frac zG\right|^2d\gamma
 =\int_O\frac{e^{-|u|/2}|z(u)|^2}{G(u)}du.
\tag{12}
$$
For the actual h_t its nonzero exponential tail and the bound G≤P∞Φ make (12) divergent. Thus (10)–(11), though valid for the actual weighted covariance sources, are not a direct inverse formula for the exponential mixed row. The test-side repair (4)–(9) gives a legitimate bridge with all its additional moments restored. No usable small-scale contraction follows from positivity of the continuous base alone; the remaining tasks are an estimate for the signed prime term in (7) and the exact growing correction in (8), or an admissible source-specific spectral estimate in (11).

## Attribution and formal scope

The domain and ground-transform inputs are proved in the linked theta chapters. The weak equation, parity and form-resolvent operations are classical methods, applied here with the full prime-power arrival and both poles retained. The positive reciprocal representation is the classical Stieltjes/complete-Bernstein mechanism, as developed by Schilling, Song and Vondraček in [Bernstein Functions](https://motapa.de/bernstein_functions/index.shtml); the interlacing and residue argument above supplies the actual kernel. These mixed-domain, Green and correction identities are written proofs. No Lean formalization or sign for the remaining arithmetic row is asserted.
