# Canonical finite prime observations and their minimal ground input

## 1. The three different objects denoted by `J`

Tracing the finite-observation note through its consumers resolves the
notation collision.

1. In `theta-prime-retained-ground-covariance-bound.md`,
   \(J_{\rm p}^{\psi}\) is a **measure** on directed exterior prime edges.
   It is not a scalar functional.
2. In \(\mathcal O_{M,J}=P_{M,J}A_M\), the second \(J\) is a **positive
   integer dimension/cutoff index** for a finite-rank projection.  It is not
   an operator named \(J\).
3. In `theta-complete-signed-core-finite-block-certificate.md`,
   \[
     Jx=\mathcal O\left(Tx-\frac{\langle x,k_Q\rangle}{d_Q}q\right)
                                                               \tag{1}
   \]
   is a **finite-vector-valued core observation**.  Its codomain is the
   finite-dimensional Hilbert space \(\mathcal Z\), and the signed core
   operator contains \(J^*J\).

No source in this chain selects a scalar complex observation.  The phrase
“finitely many scalar edge measurements” describes the coordinates of a
vector.  Thus the four real rows

\[
  \langle x,1_C\rangle,\quad\langle x,a_c\rangle,
  \quad\Re Jx,\quad\Im Jx                              \tag{2}
\]

are faithful only after an additional proved choice
\(\dim_{\mathbb C}\mathcal Z=1\).  The published construction makes no such
choice.  If \(\dim_{\mathbb C}\mathcal Z=d\), the complex formulation has
\(2+2d\) real nullspace rows.  On a real reflection-invariant realization
some coordinate pairs can be reduced, but that also requires a specified
real filter basis.

The exact rank-one comparison preceding (1) is

\[
 Q(f,g)=\frac1a\int_O\frac{\psi}{\rho}f\overline g\,d\nu,
 \quad d_Q=Q(q,q),                                      \tag{3}
\]
\[
 T x=Bx-\langle x,a_c\rangle1_O,
 \quad a_c=B^*\psi/\mu,
 \quad k_Q=\tau_C+a^{-1}\mathcal S^*q_\gamma,           \tag{4}
\]
\[
 \mathcal Sx=Tx/\rho,qquad
 c_Q(x)=\frac{Q(Tx,q)+\langle x,\tau_C\rangle}{Q(q,q)}
       =\frac{\langle x,k_Q\rangle}{d_Q}.                \tag{5}
\]

The observation is applied after this same coefficient \(c_Q(x)\) is
inserted.  It is not an extra freely fitted constraint.

## 2. What the published theorem actually chooses

The full directed prime conductance is

\[
 J_{\rm p}^{\psi}(du,dv)=
 \sum_{q\ge2}\sum_{\sigma=\pm1}
 \frac{\Lambda(q)}{\sqrt q}\psi(u)\psi(v)
 \Phi(u)\Phi(v)\,du\,\delta_{u+\sigma\log q}(dv),       \tag{6}
\]

with both orientations and every proper prime power.  Put

\[
 d\gamma=\rho\psi\,d\nu,qquad
 a=\gamma(O),qquad
 \ell(u)=q_{\rm p}^{\gamma}(u,O).                        \tag{7}
\]

The exactly-one-jump sublaw is

\[
 \mathsf P_1(du,dv)=
 \frac{J_{\rm p}^{\psi}(du,dv)}
 {(a+\ell(u))(a+\ell(v))}.                               \tag{8}
\]

For \(M\ge2\), the source restricts (8) to \(q\le M\) and

\[
 E_M=\{|u|\le M,\ \operatorname {dist}(u,C)\ge M^{-1},
       \ M^{-1}\le\psi(u)\le M,\ \ell(u)\le M\}.        \tag{9}
\]

Calling the restricted labelled-edge measure \(\sigma_M\), it defines

\[
 A_Mf=2^{-1/2}\left(\frac{f(v)}{\rho(v)}
                    -\frac{f(u)}{\rho(u)}\right)
       \in L^2(\sigma_M).                                \tag{10}
\]

Then it says: choose finite-rank orthogonal projections \(P_{M,J}\)
increasing strongly to the identity, “for example” by orthonormalizing
simple functions on rational intervals, and use
\(\mathcal O_{M,J}=P_{M,J}A_M\).  The later compactness proof shows that
some \((M,J)\) detects a fixed bounded-energy source class.  It does not
output:

* an integer \(M\);
* a projection rank \(J\);
* edge filters \(e_i\);
* a positive observation margin; or
* a modulus telling when the increasing projections are close enough.

Accordingly the original theorem is genuinely existential at this step.
Its qualitative conclusion cannot populate a numerical JSON certificate.

## 3. An explicit canonical replacement family

The arbitrary choice of filters can be removed.  Keep the edge label
\((q,\sigma)\), so coincident endpoint pairs from different labels are not
merged.  For integers \(M\ge2\) and \(L\ge0\), partition \([-M,M]\) into
half-open dyadic intervals

\[
 I_{M,L,k}=[-M+k2^{-L},-M+(k+1)2^{-L}).                  \tag{11}
\]

For each prime power \(q=p^r\le M\), orientation
\(\sigma\in\{-1,+1\}\), and cell \(I=I_{M,L,k}\), define the labelled edge
cell

\[
 D_{q,\sigma,I}={(u,v):u\in I\cap E_M,
                \ v=u+\sigma\log q\in E_M\}.            \tag{12}
\]

Let \(m_D=\sigma_M(D)\).  Define

\[
 e_D=\begin{cases}1_D/\sqrt{m_D},&m_D>0,\\0,&m_D=0,
       \end{cases}                                      \tag{13}
\]

and the coordinate

\[
 \boxed{
 (\mathcal O_{M,L}f)_D=
 \begin{cases}
 (2m_D)^{-1/2}\displaystyle\int_D
  \left(\frac{f(v)}{\rho(v)}-\frac{f(u)}{\rho(u)}\right)
        d\sigma_M,&m_D>0,\\[2mm]
 0,&m_D=0.
 \end{cases}}                                           \tag{14}
\]

The nonzero \(e_D\) are orthonormal because the labelled cells are
disjoint.  Bessel's inequality gives the coefficient-one estimate

\[
 \boxed{
 \|\mathcal O_{M,L}f\|_{\ell^2}^2
 \le\|A_Mf\|_{L^2(\sigma_M)}^2
 \le\mathscr D(f).}                                     \tag{15}
\]

Thus replacing the unspecified filters by (11)--(14) preserves exactly the
coefficient in the signed-core inequality.  It does not replace the full
theta form by the observed edges.  The continuous part, longer prime
histories, prime powers above \(M\), and unused position cells remain in the
nonnegative remainder behind the second inequality in (15).  The full
all-power rate \(\ell\) remains in both denominators in (8).

Simple functions on the dyadic cells are dense on every labelled branch.
As \(M\to\infty\) and \(L\to\infty\), these canonical projections converge
strongly to the identity on the exactly-one-jump edge space.  Replaying the
published compactness argument therefore proves:

> for each fixed nonempty bounded-energy source class, some canonical pair
> \((M,L)\) has the required positive observation margin.

This removes arbitrary filter selection, but the stopping pair is still
non-effective.  The existing theorem contains no quantitative compactness
or observability modulus from which to compute it.

There is a slightly simpler later-source variant.  The established bound
\(\|\psi\|_\infty\le P_\infty\) permits replacing (9) by the rational compact
window

\[
 W_M=\{|u|\le M,\ \operatorname {dist}(u,C)\ge M^{-1}\}. \tag{16}
\]

Indeed the marginal bound
\(\mathsf P_1(du,O)\le a^{-1}\gamma(du)\), symmetry, and
\(\rho^{-1}\le e^M+1\) on \(W_M\) give

\[
 \|A_Mf\|^2\le
 \frac{2P_\infty(e^M+1)}a\|f\|_{L^2(\nu)}^2.             \tag{17}
\]

This makes the window geometry fully rational; the ground still enters the
cell masses and the full-rate denominators.

## 4. Concrete ledger and JSON consequences

[canonical_prime_observation_ledger.py](../../formalization/verification/canonical_prime_observation_ledger.py) emits the symbolic finite ledger.
For the illustrative pair \((M,L)=(64,2)\), it contains 27 prime powers

\[
 2,3,4,5,7,8,9,11,13,16,17,19,23,25,27,29,31,32,
 37,41,43,47,49,53,59,61,64,                              \tag{18}
\]

both orientations, and 512 rational start cells, hence 27,648 candidate
complex coordinates.  The power \(64=2^6\) has \(\log64>4\), so the ledger
contains a branch capable of joining the two radius-two exterior
components.  This is only a concrete member of the canonical family.  No
positive detection margin is claimed for it.

For every cell, the JSON data needed are

\[
 m_D=\int_{D_{q,\sigma,I}}
 \frac{\Lambda(q)}{\sqrt q}
 \frac{\psi(u)\psi(v)\Phi(u)\Phi(v)}
 {(a+\ell(u))(a+\ell(v))}\,du,                            \tag{19}
\]

and, for each core basis function \(h_j\),

\[
 O_{D,j}=(2m_D)^{-1/2}\int_D
 \left(\frac{(Th_j-c_Q(h_j)q)(v)}{\rho(v)}
      -\frac{(Th_j-c_Q(h_j)q)(u)}{\rho(u)}\right)d\sigma_M.
                                                               \tag{20}
\]

The positive Gram contribution is

\[
 (G_J)_{ij}=\sum_D O_{D,j}\overline{O_{D,i}}.             \tag{21}
\]

If the observation is instead imposed as a joint-null constraint, every
complex coordinate in (20) supplies its real and imaginary row.  A
dimension-\(d\) observation therefore gives \(2+2d\), not automatically
four, real rows after adding mean and \(a_c\).

The prototype schema and runner have been corrected accordingly.  They now
require `observation_dimension_complex=d` and row names

```text
mean, a_c, Re_J_0, Im_J_0, ..., Re_J_(d-1), Im_J_(d-1).
```

The actual-data template leaves \(d\) null because no source-backed stopping
pair is known.  The earlier five-hat/four-row example is therefore only an
algebra test conditional on \(d=1\), not an actual theta trial space.

## 5. Minimal validated exterior eigenproblem

The observation is determined once the following actual eigenproblem is
validated.  Let \(\widetilde y\) be the zero extension of \(y\) from
\(O=\mathbb R\setminus[-2,2]\).  With
\(d\nu=b\Phi\,du\), define

\[
\begin{aligned}
 E_O^{\rm c}(y,z)
 &=\frac12\iint_{\mathbb R^2}
 [\widetilde y(v)-\widetilde y(u)]
 \overline{[\widetilde z(v)-\widetilde z(u)]}
 r(|u-v|)\Phi(u)\Phi(v)\,du\,dv,\\
 E_O^{\rm p}(y,z)
 &=\frac12\sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
 \sum_{\sigma=\pm1}\int_{\mathbb R}
 [\widetilde y(u+\sigma\log q)-\widetilde y(u)]
 \overline{[\widetilde z(u+\sigma\log q)-\widetilde z(u)]}\\
 &\hspace{42mm}\times\Phi(u)\Phi(u+\sigma\log q)\,du.
                                                               \tag{22}
\end{aligned}
\]

The required ground is the unique positive solution

\[
 E_O(\psi,z)=\alpha_2\langle\psi,z\rangle_{L^2(O,\nu)}
 \quad(z\in D(E_O)),\qquad
 \|\psi\|_{L^2(O,\nu)}=1,qquad\psi>0.                   \tag{23}
\]

Zero extension in (22) retains continuous and prime killing into the core.
The prime sum retains all powers and both orientations.

For a validated computation, (23) alone is not enough.  The minimal
certificate fields are:

1. outward mass and full-form matrices for a rational exterior Galerkin
   basis, with continuous diagonal treatment, every finite \(p^k\), both
   orientations, and a proved all-power/exterior tail;
2. a normalized Ritz vector \(\psi_h\), eigenvalue interval
   \([\alpha^-,\alpha^+]\), and strong residual
   \(\|(D-\alpha_h)\psi_h\|\le\varepsilon_{\rm op}\);
3. a certified complement floor \(\beta_2>\alpha^+\), giving
   \(\|\psi-\psi_h\|_2\le\sqrt2\varepsilon_{\rm op}/
   (\beta_2-\alpha^+)\);
4. a local or weighted sup-norm enclosure for \(\psi-\psi_h\), because
   (19), \(a_c\), and the translated products cannot be certified from an
   \(L^2\) error alone; and
5. interval values for
   \[
   a=\int_Oe^{-|u|/2}\psi(u)\Phi(u)\,du,qquad
   \mu=\int_O\psi(u)b(u)\Phi(u)\,du.                     \tag{24}
   \]

The full departure rate needed in (19) can then be computed directly as

\[
 \boxed{
 \ell(u)=e^{|u|/2}\sum_{q\ge2}\sum_{\sigma=\pm1}
  1_O(u+\sigma\log q)\frac{\Lambda(q)}{\sqrt q}
  \psi(u+\sigma\log q)\Phi(u+\sigma\log q).}             \tag{25}
\]

Formula (25) follows by dividing the branch density (6) by
\(d\gamma/du=e^{-|u|/2}\psi(u)\Phi(u)\).  A finite head plus the established
theta/ground tail gives interval enclosures on the compact cells.  These
are the first numerical inputs required by (19)--(21).

The existing ground-certificate note specifies items 1--5 abstractly but
contains no validated eigenpair or second-eigenvalue separation.  Numerical
status therefore remains **unstarted for the actual observation entries**.

## 6. Fresh observability and realization tests

### Reversible-process cylinder observations

Equations (11)--(15) are conditional expectations of the one-jump increment
onto a finite labelled-edge sigma-algebra.  The martingale convergence
theorem explains strong convergence of the canonical sensors.  Compactness
of the bounded-energy source image upgrades pointwise convergence to a
finite detecting level.  This is a viable realization of the published
existence proof.  Its effective version needs a modulus

\[
 \sup_{x\in\mathcal X_K,c}
 \|(I-P_{M,L})A(Tx-cq)\|\le\eta_{M,L}\to0               \tag{26}
\]

and a positive lower bound for the full observation on that compact set.
Neither bound is currently available.

### Finite-output control realization

The exact output operator at level \((M,L)\) is
\(C_{M,L}=\mathcal O_{M,L}(T-c_Q(\cdot)q)\).  The signed block credits the
observability Gramian \(C_{M,L}^*C_{M,L}\).  A finite-output realization
would be sufficient if its unobserved energy obeyed

\[
 \|(I-P_{M,L})A(Tx-c_Q(x)q)\|^2
 \le \epsilon E_C[x]+C_\epsilon\|C_{M,L}x\|^2.           \tag{27}
\]

The qualitative Ehrling estimate in the source uses the *complete* gain,
not a fixed finite output, so it does not prove (27).  Infinite rank of the
coherent return also rules out inferring a globally exact scalar
realization from injectivity alone.

### Analytic sampling at zeta zeros

Boundary injectivity maps a core input to the entire transform
\(G_x(s)\).  If the boundary output consists only of the two pole profiles,
then every nontrivial zeta zero is a zero of \(G_x\); the \(T\log T\) zero
count forces \(G_x\equiv0\).  This suggests finite samples of \(G_x\) as
sensors.  Adversarially, any fixed finite sample set has an
infinite-dimensional kernel on the full core space.  It could norm a compact
energy ball only with a quantitative exponential-type sampling inequality,
for example

\[
 \|x\|^2\le \epsilon E_C[x]+C_\epsilon
     \sum_{\rho\in\mathcal R_T}|G_x(\rho)|^2.             \tag{28}
\]

The Jensen argument proves uniqueness from an infinite zero set and gives
no constants in (28).  Thus analytic sampling is a plausible alternate
sensor design, but it does not presently improve the canonical one-jump
family.

## 7. Formal and reproducible artifacts

[CanonicalFiniteObservation.lean](../../formalization/BuildingBlocks/CanonicalFiniteObservation.lean) formalizes:

* coefficient-one Bessel contraction for finite orthonormal edge cells;
* the exact constraint count \(2+2d=4\iff d=1\);
* preservation of a coefficient-one observation in a lower bound; and
* insertion of the common affine optimizer before observation.

It compiles with Lean 4.24.0, warnings treated as errors, with no `sorry` and
no new axioms.  The formal module proves the finite algebra.  The edge
measure, eigenpair, and spectral separation remain explicit analytic inputs.
