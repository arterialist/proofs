# The actual even Goldbach centered triangle is negative at 118

Let \(\Lambda\) be the von Mangoldt function, including all prime powers, and put
\(r(n)=2\mathbf 1_{n\text{ odd}}\). The zero-phase specialization of the
parity-centered Hermitian Goldbach triangle is

\[
C_{\rm even}(N;0)
 =\sum_{\substack{a,b\geq1\\a+b\leq N\\a+b\ \mathrm{even}}}
      (\Lambda(a)-r(a))(\Lambda(b)-r(b)).
\]

For the actual source,

\[
\boxed{C_{\rm even}(118;0)<-25.}
\]

This is a finite counterexample to the proposed global nonnegativity of the
parity-centered cumulative triangle. It refutes neither an eventual sign nor
any RH-equivalent critical error estimate.

The [Lean certificate](BuildingBlocks/GoldbachEvenPhaseCounterexample.lean)
uses the exact finite definition in
[`GoldbachEvenPhaseCenterFinite.lean`](BuildingBlocks/GoldbachEvenPhaseCenterFinite.lean).
It retains all 3,481 ordered pairs with even total at most 118, including
the endpoints and every prime power. For each prime \(p\leq117\), it bounds
\(\log p\) against a four-decimal rational table. The bound splits
\(p=2^k/(1-x)\), with \(k=\lfloor\log_2p\rfloor\), and applies the finite
20-term Taylor remainder for \(-\log(1-x)\) together with mathlib's certified
bounds on \(\log 2\). This gives a uniform error below \(10^{-4}\) for every
von Mangoldt weight in the triangle.

Replacing each \(\Lambda(n)\) by its rational table value gives the exact
rational triangle

\[
C_{\rm rat}(118)=-\frac{2\,924\,955\,171}{100\,000\,000}
                 =-29.24955171.
\]

Both centered factors are bounded in absolute value by 6. Thus a single
ordered pair changes by at most \(12\cdot10^{-4}\), and the complete error
is at most \(3481\cdot12\cdot10^{-4}=4.1772\). Consequently
\(C_{\rm even}(118;0)\leq-25.07235171<-25\). The finite rational computation
and cardinality are checked by Lean's `native_decide`; the exported theorem's
axiom report includes the standard `Lean.ofReduceBool` and
`Lean.trustCompiler` computation axioms, as well as Lean's usual logical
axioms. No additional mathematical axiom or RH premise is introduced.
