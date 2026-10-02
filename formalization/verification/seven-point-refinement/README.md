# Seven-point refinement verification

This package accompanies the [spectral-envelope note](../../../building-blocks/zeta-and-zeros/seven-point-refinement-certificate-and-spectral-envelope.md).
The [Lean scalar theorem](../../BuildingBlocks/FiniteSpectralEnvelope.lean)
and [six-declaration axiom audit](../FiniteSpectralEnvelopeAudit.lean) are
separate from the global Arb certificate and the written zero-count deduction.
No improved actual-zeta density theorem or RH theorem is claimed to be
kernel checked by this package.

The frozen verifier is Uwe Schwarz's MIT-licensed derivative artifact at
[`e2453c1cafc1387ef553fe6bee74d1f5223ba801`](https://github.com/uwe-schwarz/zeta-simple-zeros-673026/tree/e2453c1cafc1387ef553fe6bee74d1f5223ba801).
It proves, by the reviewed interval cover, the six-gap inequality
`F6 >= 382623/100000000` for every nonnegative real gap vector. All 21
overlap terms, zero gaps, removable sinc points and the unbounded pressure
tail remain. The constant check consumes that finite premise; it does not
prove the premise by itself.

## Replays and trust boundary

Two completed runs used CPython 3.13.12 and 3.12.12 with python-flint 0.9.0
on the same macOS arm64 host. Both exited zero, closed all 729 initial boxes,
visited 980069 nodes, and matched all 20 deterministic committed fields,
including the verifier hash. The interval-table hashes and raw finite reports
are in [verified-replays.json](verified-replays.json).

The coverage and enclosure logic was independently reviewed before execution.
Python, binary64 conversions with directed widening, python-flint, FLINT/Arb,
the reviewed source, OS and hardware remain in the trust base. These are two
replays of one implementation, not two independent interval algorithms.
The global kernel inequality is not a Lean theorem in this package.

## Portable replay

Use an existing Git checkout of the frozen source and an existing CPython
interpreter with python-flint **0.9.0**. The controller does not install,
download or modify upstream source. For example:

```sh
git clone https://github.com/uwe-schwarz/zeta-simple-zeros-673026.git /tmp/zeta-refinement
git -C /tmp/zeta-refinement checkout e2453c1cafc1387ef553fe6bee74d1f5223ba801
python3 formalization/verification/seven-point-refinement/replay_refinement.py /tmp/zeta-refinement --python /absolute/existing/flint-python > replay.json
```

The controller checks the source HEAD and ten source hashes, copies only
reviewed bytes to a temporary directory, verifies the selected runtime and
enabled assertions, runs the exact constant check, then completes the global
certificate. It rechecks source identity afterward. The result includes
commands, exit codes, stdout/stderr, runtime and timing. A failed job, target,
report type, key, hash or deterministic field fails the replay.

For a saved raw **finite** report, comparison mode performs no new proof run:

```sh
python3 formalization/verification/seven-point-refinement/replay_refinement.py --compare-only finite-report.json
```

Its output explicitly sets `certificate_replayed=false` and
`source_verified=false`. A matching saved report establishes consistency,
not a new certificate execution.

## Lean check

From the repository's unchanged Lean 4.24 project:

```sh
lake build BuildingBlocks.FiniteSpectralEnvelope
lake env lean formalization/verification/FiniteSpectralEnvelopeAudit.lean
```

The scalar theorem covers every zero-sum real vector of length at least two
and its nonnegative cost compensation, with no positivity or energy-cap
hypothesis on the vector. Its six transitive axiom lists contain only
`propext`, `Classical.choice` and `Quot.sound`.

The matrix spectral interpretation, pinching, refined rank--trace assembly,
actual Gram limit, endpoint bookkeeping and improved zero-count deduction
remain written mathematics. The pinned upstream tree excludes its generated
Lean source and objects, so private build attestations cannot supply that
missing proof closure. Its original analytic foundation and verifier lineage
are credited in the accompanying note. No numerical-record or authorship
priority claim is made. The full signed prime-error bound and RH remain open.
