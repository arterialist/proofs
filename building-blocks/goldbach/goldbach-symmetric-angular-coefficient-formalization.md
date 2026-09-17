# Symmetric angular coefficients for odd-centered Goldbach pairs

For a positive integer total N, use the literal ordered positive pairs
a in Icc 1 (N-1), b=N-a. The odd-centered source is o(a)=Lambda(a)-2
on odd a and zero otherwise. In particular o(1)=-2. Every odd prime
power remains in Lambda.

For any real finite weight w with w(N-a)=w(a) on this interval,
the compiled module BuildingBlocks/GoldbachWeightedOddPairs.lean
proves, for even N,

    sum o(a)o(N-a)w(a)
      = sum [odd a and odd (N-a)] Lambda(a)Lambda(N-a)w(a)
        -4 sum [odd a] Lambda(a)w(a)
        +4 sum [odd a] w(a).

This follows by the pointwise centered product expansion and the exact
reflection bijection a -> N-a. It requires neither positivity of the
weight nor a prime representation. Thus it applies to the symmetric
angular kernels in Agent3's written balanced-window energy identity,
including its clipped finite-horizon kernel, once their symmetry is
supplied. Those analytic kernels and the integral identity are still
written mathematics, not defined or proved by this Lean module.

Harvey's GoldbachOddPairs.lean also evaluates the unweighted odd count
at N=2m to m, including m=0. Its exact unweighted identity is therefore
A(2m)=Rodd(2m)-4 oddWeight(2m)+4m. The centered state-one pair gives
A(2)=4. This is a coefficient identity, not Goldbach existence or an
RH-strength estimate.

Root independently compiled the weighted module without warnings.
Its A_even theorem depends only on propext, Classical.choice and
Quot.sound. No new mathematical axioms or unfinished proofs were added.
