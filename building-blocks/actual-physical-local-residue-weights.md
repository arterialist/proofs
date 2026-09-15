# Actual physical weights and local zero coefficients

[ActualPhysicalResidues.lean](BuildingBlocks/ActualPhysicalResidues.lean) connects the literal bilateral Mellin transform and complete finite physical histories to the proved local logarithmic derivative of actual xi and zeta. These are local limits, not a global residue formula.

For continuous compactly supported f and g, the bilateral transforms are continuous at every complex argument. The proof restricts the actual integral to the compact topological support before applying the continuous parametric integral theorem. It then proves continuity of the reflected-conjugate weight
\[
W_{f,g}(z)=M_z(f)\overline{M_{-\bar z}(g)},\qquad F_{f,g}(s)=W_{f,g}(s-1/2).
\]
The same statements hold for actual complete finite history compositions, whose compact support and continuity are derived from the physical operators.

For every complex s, the actual finite xi multiplicity m(s) gives
\[
\lim_{w\to s,\ w\ne s}(w-s)F_{f,g}(w)\frac{\xi'(w)}{\xi(w)}
=m(s)F_{f,g}(s).
\]
For a finite set P of integer generators p>=2, at every depth M, the transformed coefficient is exactly
\[
m(s)\prod_{p\in P}V(p,s-1/2,M)V(p,1/2-s,M)\,F_{f,g}(s).
\]
The notation uses the published complete history multiplier, with the forward term and every backward term retained. The theorem requires only p>=2; when P consists of primes it applies directly. No condition on Re(s) is imposed for the xi statement. For actual zeta the corresponding limit is proved for Re(s)>0, s unequal to 1, using proved equality of actual xi and zeta multiplicities. These statements do not select critical-line zeros, discard multiplicities or replace complex paired weights by absolute squares off that line.

If both actual bilateral moments M_{-1/2}(f) and M_{1/2}(f) vanish, then F(0)=F(1)=0. Complete finite histories preserve these cancellations. The module proves the local coefficients of the literal weighted rational terms F(w)/w and F(w)/(w-1) are zero, both before and after the full history block. This does not yet prove those functions are removable at the endpoints or justify omitting their contour integrals. The complete xi right-boundary identity still retains 1/s+1/(s-1).

The signed scattering branch supplied these thirteen declarations. Root independently reviewed compact-support integration, the centered variable, actual multiplicity transfer, complete history products and the endpoint distinctions. These are formalizations of classical local analytic identities, with no novelty claim.

Root adds an existence consumer using the published narrow smooth pole-null carrier construction. It produces an actual compact smooth f with f(0)=1, support inside (-L/32,9L/32), and an integrable positive physical square integral, for which both weighted rational local coefficients vanish after every finite generator block and depth. Thus this instantiation uses a constructed nonzero test rather than assuming the pole-null family exists.

The proof establishes continuity of the physical weights. Their entire analyticity, weighted gamma growth and inversion, horizontal contour limits, zero counting, infinite residue-sum convergence, the complete explicit formula and the arithmetic sign estimate remain further obligations. No RH conclusion follows from these local identities or pole cancellations.

All fourteen printed declarations independently compile with only propext, Classical.choice and Quot.sound, without warnings in this module.
