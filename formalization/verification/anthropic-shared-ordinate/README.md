# Actual-zeta common ordinates: external Lean checks

These companion modules use **Lean 4.33.0-rc2**, the version of the pinned Anthropic project. They are separate from this repository's Lean 4.24.0 `BuildingBlocks` library. They prove statements about Mathlib's actual `riemannZeta` and the upstream analytic multiplicity, rather than an abstract replacement zero configuration.

The mathematical notes are [common ordinates and shifted poles](../../../building-blocks/zeta-and-zeros/shared-ordinate-zeros-and-shifted-zeta-poles.md) and [the Jordan summatory-error source audit](../../../building-blocks/prime-distribution/real-order-jordan-summatory-error-audit.md). The finite counting argument is an elementary corollary of reflection. Its asymptotic population uses the existing Alpöge–Furman theorem discovered by Claude; no originality claim is made for either input.

## Statements and scope

Let `good T₁ T₂` be the simple critical-line zero points in the literal window `T₁ < im ≤ T₂` with no left off-line zero at their ordinate. The finite theorem is

```text
3 * N0simple T₁ T₂ ≤ Ncount T₁ T₂ + 2 * (good T₁ T₂).card
```

`Ncount` counts all actual nontrivial zeros with analytic multiplicity. The same `good` set is the unique nontrivial zero point at each of its ordinates. For every member, all real shifts `0 < a < 1/2` preserve the numerator, and the shifted zeta ratio minus one has meromorphic order `-1`.

`eulerDeletion a P s` is the exact finite product

```text
∏ p ∈ P, (1 - exp((a-s) log p)) / (1 - exp(-s log p))
```

for any finite set `P` of actual natural-number primes, including the empty set. Its local factors and product are analytic and nonzero at a critical-line point when `a < 1/2`. Multiplication therefore preserves the selected simple pole.

The checked final declaration `uniform_common_optimized_all_poles` has one onset and the same `good T (2*T)` before every selected zero, real shift and finite prime set. Its population coefficient is exactly `(3 * Zeta23.ThmD.HD 1 - 1)/2`. It supplies the actual source density endpoint internally and has no density hypothesis from the caller. All eight companion modules passed the fresh root helper run, with 25 printed axiom audits containing only `propext`, `Classical.choice`, `Quot.sound`. The source endpoints and `HD_one` identity passed the same axiom audits.

The exact source identity `HD_one` identifies `HD 1` with

```text
3/2 - (sqrt 2)⁻¹ * (cos ((sqrt 2)⁻¹) / sin ((sqrt 2)⁻¹))
```

The decimal coefficient is displayed separately. `shared_ordinate_fraction.py` uses rational alternating Taylor enclosures, without floating-point certified comparisons, to show `0.508751 < (3*kappa-1)/2 < 0.508752`. The certificate calculation and its alternating-series justification are written mathematics, not a Lean numerical theorem.

| Module | Coverage |
| --- | --- |
| `ShiftedJordanCount` | Actual finite zero window, reflection, multiplicity and per-shift accounting used by the common-set proof |
| `CommonCount` | One common bad-ordinate union, exact count, ordinate uniqueness and all-shifts noncancellation |
| `ShiftedJordanPole` | Actual simple analytic zero, nonzero derivative and shifted-ratio meromorphic order |
| `CommonPoles` | Common-set and local-pole conjunction; its general density lemma names the density input |
| `CoprimePoles` | Exact finite exponential Euler factors, nonvanishing, analyticity and unchanged pole order |
| `ShiftedJordanFlatDensity` | Checked direct use of the actual two-thirds source endpoint |
| `ShiftedJordanOptimizedDensity` | Checked direct use of the actual native-constant density endpoint |
| `CommonDensityPoles` | Checked unconditional source-to-common-count-to-all-deletion composition |

The infinite Jordan Dirichlet-series identity, interpretation as a coprime summatory function, explicit residues, Mellin continuation, real-main-pole cancellation, Landau oscillation application and elementary remainder upper bounds are independently reviewed written analysis. They are not claimed as Lean theorems here. None of these population or oscillation results proves the full signed bound required for RH.

## Exact dependency pins

The source is [Anthropic's formal-math project](https://github.com/anthropics/formal-math/tree/fbdc36bbf17d20af3fd0447c6d1a8a02773c9844/zeta23), commit `fbdc36bbf17d20af3fd0447c6d1a8a02773c9844`. Its Mathlib pin is `51e6992efd06126df61a496bebf8f49482a4e129`. All other dependencies use that project's pinned `lake-manifest.json`. The project is released under Apache-2.0 with its own notices.

The actual density endpoints are `Zeta23.thmB₀_mult` and `Zeta23.ThmD.thmD₀_simple_mult`. The constant identity is `Zeta23.ThmD.HD_one`. No `Challenge`, `Solution`, comparator placeholder, added axiom or changed zero definition is imported by these modules.

The local replay uses a disclosed import-only source variant. Six bare `import Mathlib` lines are replaced by specific genuine pinned Mathlib imports; every mathematical declaration and proof script is unchanged. The original checkout is preserved. The chosen closure has 140 project modules. Seven uncached Mathlib modules were compiled locally against the existing pinned dependencies. Complete cached Mathlib artifacts are provided by manifest-recorded, read-only file links, so the compiler sees one complete namespace. New compiler outputs are regular owned files. This arrangement avoids both a fabricated Mathlib module and stale objects for changed source dependencies.

The selected 140-module closure reuses 59 verified unchanged cached source modules and freshly compiles the remaining 81. None of the reused modules depends on one of the six altered imports. Together with seven missing Mathlib modules and eleven consumer/audit components, the targeted replay completed 99 jobs. The eight published companion modules then passed a separate root helper run. The final import map, source hashes and recorded audit scope accompany this directory. This is a targeted check through an import variant, not an unchanged-source full build, a byte-identical proof-object claim, or a run of the upstream comparator.

## Replaying the companion checks

First prepare the pinned upstream project and its actual `Zeta23.ThmD.Mult` endpoint with the pinned runtime and dependencies. A normal upstream build of that selected endpoint is sufficient; our import variant is not required when an unchanged upstream build is available. Building upstream may need cache downloads and substantial storage. The helper below does not perform that dependency preparation.

After preparation, run from any directory, substituting absolute paths:

```sh
python3 /path/to/proofs/formalization/verification/anthropic-shared-ordinate/audit_modules.py \
  --project /path/to/formal-math/zeta23 \
  --lean /path/to/lean-4.33.0-rc2/bin/lean \
  --output /path/to/new-companion-audit
```

For a reviewed import-variant object provider, also pass `--source-objects /path/to/variant/overlay`. Its source and dependency provenance are separate prerequisites; a command-line directory is not proof of that provenance. The helper checks the source, Mathlib and compiler pins, uses only one selected Zeta23 provider, compiles all eight companion modules in dependency order, and rejects any printed axiom outside `propext`, `Classical.choice`, `Quot.sound`. It records source, object and log hashes in `audit.json`.

Use a new output directory. The helper does not clone or download, change a toolchain, build upstream, modify the source checkout, or write into this repository's default Lean build. Compiler success and the recorded axiom audits are the acceptance evidence for the companion modules. The upstream build and import-variant byte/provenance audit remain separate evidence.
