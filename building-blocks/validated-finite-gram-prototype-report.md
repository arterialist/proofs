# Validated finite-Gram prototype: exact preflight and first missing datum

## Scope and outcome

I built the smallest exact-rational replay for the finite constrained Gram
certificate at radius two.  It uses the five even linear hats on

\[
  0,\frac12,1,\frac32,2
\]

and therefore would leave one generic constrained direction after four
independent real constraints.  The hats are reflected evenly to \([-2,2]\);
the endpoint hat is retained, since hard-boundary killing is part of the
form rather than a Dirichlet trace imposed on the trial functions.

The replay result is

> **INCOMPLETE — no numerical evidence.**

This is a source-data obstruction, not a failed eigenvalue test.  No value
of \(r_N+\beta_N\), no Schur deficit, and no claim about the coefficient-one
inequality follows.  In particular, this run is not evidence against the
theta inequality and makes no RH claim.

The machine-readable output is [finite-gram-preflight-result.json](certificates/finite-gram-preflight-result.json).  The
runner never interprets a missing entry as zero and has no floating-point
path.

## Exact mesh and constraint issue

The mesh file [rational-even-hat-mesh-level4.json](certificates/rational-even-hat-mesh-level4.json) records every hat by
rational support.  It also records the exact unweighted even-Lebesgue Gram

\[
\begin{pmatrix}
1/3&1/6&0&0&0\\
1/6&2/3&1/6&0&0\\
0&1/6&2/3&1/6&0\\
0&0&1/6&2/3&1/6\\
0&0&0&1/6&1/3
\end{pmatrix}.
\]

That matrix is only a check of the spline implementation.  It is explicitly
excluded from the theta test because the actual mass uses
\(d\nu=b\Phi\,du\).

The requested interface lists four real rows

\[
 \langle x,1_C\rangle,\qquad \langle x,a_c\rangle,
 \qquad \Re Jx,\qquad \Im Jx.                    \tag{1}
\]

The first two are legitimate named rows, although \(a_c=B^*\psi_2/\mu\)
still needs the validated killed ground.  The last two are not presently
instantiable from the published arithmetic source.  In
`theta-prime-gain-finite-observations.md`, the observation is

\[
 \mathcal O_{M,J}=P_{M,J}A_M:L^2(O,\nu)\to\mathbb C^J,       \tag{2}
\]

where \(M\), the dimension \(J\), and the orthonormal edge filters \(e_i\)
are chosen by an existence/compactness argument.  The source supplies no
concrete \(M,J,e_i\), and does not specialize (2) to one complex scalar.
Consequently \(\Re J\) and \(\Im J\) in (1) cannot be filled without adding
an observation that is not in the source.  If a scalar observation is later
fixed, the exact common projection is

\[
 \phi_j=h_j-\sum_{\ell=1}^4 \mathcal L_\ell(h_j)z_\ell,
 \qquad \mathcal L_k(z_\ell)=\delta_{k\ell},               \tag{3}
\]

and must be applied before any killed or port Gram is formed.  The replay
requires provenance for (3); an interval merely containing zero is not
accepted as proof of exact nullspace membership.

This is the earliest missing datum.  Refining the mesh does not repair it.

## Entries accepted by the replay

For a constrained basis \(\phi_1,\ldots,\phi_N\), the certificate schema
requires outward rational interval matrices for

\[
 M_{ij}=\int_C\phi_j\overline{\phi_i}\,d\nu,
 \qquad A=K^{\rm c}+K^{\rm p}-\alpha_2M.                  \tag{4}
\]

The prime matrix is split into a finite head and a proved all-power tail.
The head ledger must enumerate \(q=p^k\), including proper powers, and both
orientations.  A largest-prime label without this ledger is rejected.

The port matrix is entered as four coherent contributions

\[
 P=P_{cc}+P_{cp}+P_{pc}+P_{pp},                            \tag{5}
\]

where

\[
 P_{ij}=\frac1a\int_O\frac{\psi_2(u)}{\rho(u)}
 (B\phi_j)(u)\overline{(B\phi_i)(u)}\,d\nu(u).             \tag{6}
\]

The replay sums (5) before taking a row-norm bound.  Thus it does not replace
the mixed continuous-prime terms or prime-prime crossing covariances by
diagonal positive pieces.  It separately requires the complete prime-power
head ledger, the \(+/-\) orientation ledger, the prime tail, the exterior
tail, and the ground normalization \(a\).  This is a data-format safeguard;
the current source supplies none of the required validated numerical
entries involving \(\psi_2\).

Given complete inputs, exact rational Gershgorin bounds produce

\[
 a_-\le\lambda_{\min}(A_N),\qquad
 p_+\ge\lambda_{\max}(P_N),\qquad r_N\le p_+/a_-.          \tag{7}
\]

They are conservative but rigorous.  With rational enclosures for
\(P_0\), \(\lambda_{N+1}\), and \(\alpha_2\), the tail test is

\[
 \beta_N\le \frac{P_0^+}{\lambda_{N+1}^- -\alpha_2^+}.     \tag{8}
\]

The runner reports either

\[
 r_N^++\beta_N^+\le1                                      \tag{9}
\]

or the sharper interval Schur condition

\[
 (\delta_N^+)^2\le(1-r_N^+)(1-\beta_N^+),                 \tag{10}
\]

as well as the exact rational excess in (9) when it fails.  A synthetic
one-dimensional algebra test gave
\(r^+=2/15\), \(\beta^+=2/35\), and sum \(4/21\); this only tests the replay
code and is not theta evidence.

## Missing validated inputs

The run records the complete list.  The analytically decisive items are:

1. a concrete actual observation: \(M,J,e_i\), or another explicitly proved
   scalar complex row, followed by the exact four-row projection (3);
2. a normalized validated enclosure of \(\psi_2\) and \(\alpha_2\), strong
   enough for \(a_c\), (6), and translated prime products;
3. interval quadrature for (4)--(6), with a finite \(p^k\) ledger and explicit
   theta/all-power/exterior tails;
4. a certified constrained complement floor
   \(\lambda_{N+1}^- >\alpha_2^+\); and
5. the global coherent ceiling \(P_0\), or a smaller direct complement port
   bound, plus the normalized mixed-block norm for (10).

The existing `validated-killed-ground-galerkin-certificate.md` specifies a
valid certificate format for items 2 and 4, but explicitly contains no
validated eigenpair or separation data.  Thus there is currently no honest
way to decide whether *any* small \(N\) passes (9) or (10).  Increasing \(N\)
before fixing item 1 would only produce larger matrices for an undefined
subspace.

## Three phase-space interpretations, translated and tested

### 1. Certified model reduction / observability

Regard \(A^{1/2}\) as the state energy and the coherent port column as an
observation operator \(C\).  The target is exactly

\[
 \|CA^{-1/2}\|^2\le1.                                    \tag{11}
\]

A reduced basis gives the low singular value \(r_N\); the discarded Hankel
or observation residual gives \(\beta_N\) and \(\delta_N\).  This is viable
and is precisely (9)--(10).  Adversarial test: balanced truncation needs a
certified observation map.  Since (2) is existential and (6) needs the
unknown ground, model reduction cannot generate the missing rows or tail
norm.  It organizes a future certificate but does not close the current
one.

### 2. Lehmann--Goerisch / flux-reconstructed finite elements

For a nonlocal form, reconstruct a continuous flux and every directed
prime-shift flux.  If the residual norm is \(\varepsilon\) and a complement
coercivity calculation gives \(g>0\), a spectral projector error of the
form

\[
 \|(I-\Pi_N)\widehat\Pi_N\|\le \varepsilon/g              \tag{12}
\]

turns Ritz matrices into outward enclosures and supplies the lower
\(\lambda_{N+1}\) required by (8).  This is viable because it can certify a
lower spectral bound, unlike raw Ritz values.  Adversarial test: the flux
ledger must contain the continuous diagonal strip, boundary killing, both
orientations, and all \(p^k\).  No such residual or separation artifact is
published.  Ritz eigenvalues alone are upper bounds and cannot be inserted
as \(\lambda_{N+1}^-\).

### 3. Robust SDP / electrical Kron reduction

Treat the bounded phase-space block and its complement as ports of a
passive network.  The coefficient-one claim is the robust LMI

\[
 \begin{pmatrix}
 I-R_N&-D_N\\-D_N^*&I-T_N
 \end{pmatrix}\succeq0,                                  \tag{13}
\]

whose scalar norm relaxation is (10).  Interval Cholesky or rational
LDL\(^*\) is a sharper successor to the runner's Gershgorin bound.  This is
also viable once the interval matrices exist.  Adversarial test: Kron
monotonicity cannot replace the signed coherent mixed columns.  Enclosing
continuous and prime pieces independently may erase their cancellation;
the strongest certificate must enclose each complete column \(B\phi_j\)
before forming (6).  Moreover, the previously observed exterior reserve
cancels in the Schur complement, so it supplies no missing positive margin
in (13).

These interpretations agree on the next constructive task: first publish a
specific finite observation and a validated radius-two ground/separation
artifact.  Only then does a small-mesh numerical experiment have a defined
actual subspace and a certifiable tail.

## Reproducibility and formal status

Run:

```text
python3 verification/validated_finite_gram_prototype.py \
  certificates/finite-gram-certificate-template.json \
  --write-mesh certificates/rational-even-hat-mesh-level4.json
```

[ValidatedFiniteGramEncoding.lean](BuildingBlocks/ValidatedFiniteGramEncoding.lean) formalizes rational interval
addition, the cast from rational coarse and Schur tests to real
inequalities, and exact common-row subtraction.  It compiles with Lean
4.24.0 with warnings treated as errors and contains no `sorry` or new
axioms.  Its axiom report lists only `propext`, `Classical.choice`, and
`Quot.sound`.  The Lean module proves certificate algebra; it does not
assert any missing analytic input.
