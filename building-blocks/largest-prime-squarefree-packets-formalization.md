# Largest-prime squarefree packet core

The standalone module [`LargestPrimeSquarefreePackets.lean`](BuildingBlocks/LargestPrimeSquarefreePackets.lean) formalizes the finite arithmetic core without assuming that Mathlib provides a largest-prime-factor function.

Mathlib 4.24 does not expose a declaration named `Nat.moebius`; its actual Möbius function is `ArithmeticFunction.moebius : ArithmeticFunction ℤ`. The module uses that function and its proved multiplicativity and prime-value lemmas.

For a squarefree integer `d` and prime divisor `q`, the module proves:

- `q ∤ d/q`, directly from the definition of `Squarefree`;
- `Coprime q (d/q)`;
- `moebius d = -moebius (d/q)`;
- unique existence of `m` with `q*m=d`, and a combined unique decomposition/sign theorem.

For a finite set `S` with a supplied label map `largest`, it defines the fiber with label `q` and its quotient packet. Assuming only that occurring labels are prime and divide their labeled integers, it proves the exact reindexing

```text
sum_{d in fiber q} μ(d) a(d)
  = sum_{m in quotientPacket q} -(μ(m) a(q*m)).
```

Finite fiberwise summation then gives the complete packet reconstruction. The final specialization takes `S` to the squarefree nonunit integers in `[A,B]` and labels in `[2,B]`. Primality, divisibility, and the label bounds are explicit hypotheses. Composite unused labels in `[2,B]` are handled as empty fibers, so no false blanket assertion that every integer in the label interval is prime is made.

Compilation succeeds in `/Users/arterialist/Projects/proofs`. Printed axiom reports contain only `propext`, `Classical.choice`, and `Quot.sound`; there is no `sorryAx` and no new axiom.
