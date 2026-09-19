# Published-history quality control: segment 1

This review covers the 328 commits from `76ea442399f98b6e6d6931df171ef0c0bba0c96b` through `63e8af7271bfc9944dbcc8206c57c08f286c115f` at frozen baseline `356d968c7ac34a23113d6fe0a5e10217cef4316c`. Its commit ledger is exhaustive. The theorem-level checks follow each substantive change into the current file and record exact evidence for material findings; the ledger is not presented as if an inventory or a successful Lean build alone proved correctness. Catalogs, first-formalization claims, and recent `RiemannZeta`/`Chirped` synthesis prose were audited by parallel reviewers and are outside this note's correction scope.

## Corrections

- **Malformed odd-prime window definition (`a4128b66`).** The displayed index for `K_m^{odd}` omitted the condition that `p` is prime and appeared to require the lag `m` to be prime. The corrected sum is over `p != 2`, `p` prime, and `k >= 1`. This restores the definition used by the subsequent prime-power support and binary-exclusion arguments.
- **Duplicated finite-scattering proof (`5ee22563`).** `compact-local-scattering-no-contraction.md` contained the same finite packet calculation twice. The earlier copy also said the physical and coefficient identities were unformalized, while the later copy correctly links the compiled packet, coefficient, and operator modules. The duplicate and stale statement were removed without changing the theorem.
- **Stale factorial formalization ledgers (`a3e48bd8`, `2ee936a9`, `8bb232ff`, `8f6b9e8c`, `12025a33`).** The notes now record that quotient constraints, finite renewal, the cutoff-13 sign change, actual integer birth, divisor support, birth and pointwise work telescoping, collision bounds, the linear interior comparison, and one-sided boundary/energy transfers compile. The Abel polynomial, complete divisor-pair parametrization, integrated total-birth budget, and final arithmetic signed boundary/work estimates remain written or open as stated.
- **Inflated headings (`f30c4aa4`, `b0ea82cf`).** “Retains every zero” was replaced by the proved nonvanishing property of the filter. “Full theta killed-core return operator” was narrowed to the compact-core exterior return operator. The body already preserved the missing growth and sharp-comparison hypotheses.

## Historical error already repaired

Commit `0dc06794` split a state allocation into prime and composite sectors and omitted `n=1`. That omission changes the leading compensation by `x^2 log(x)/2 + x^2/4`. Commit `284292e0` already restored

$$
B_{\{1\}}(x)=(x-1)[x+R(x-1)]
 =\frac{x^2\log x}{2}+\frac{x^2}{4}-\frac14
$$

and the exact identity `W=B_{\{1\}}+B_P+B_C`. The frozen baseline is correct; the ledger records this as a historical correction.

## Simplification and verification boundary

The duplicated 58-line scattering proof was removed. A further safe refactor is available: `ZetaPole.lean` and `LogDerivativePole.lean` repeat the local factorization-to-log-derivative calculation. Reuse requires moving the generic lemma below both modules because the present import graph would otherwise cycle; this audit records the opportunity without changing that dependency graph.

The audit found no other surviving theorem-level sign, normalization, endpoint, domain, or cited-literature error in this assigned segment. That statement is scoped to the frozen files and assigned commits. Conditional implications remain conditional: compilation validates the implications and finite identities, not their open RH-strength arithmetic inputs.
