# Exact frozen-birth work in the original metric

Developed in the RH Proof branch, with Lean implementation by Harvey and independent mathematical review and compilation by RH Proof. Written analytic claims are distinguished from compiled statements below; no novelty claim is made.

Written mathematics, with the full frozen-source norm decomposition
compiled in `BuildingBlocks/ChargeFrozenMetric.lean`. The literal
birth branches, full square integrability and ramp-plus-terminal
square-integral split are now compiled in
`BuildingBlocks/ChargeFrozenBirthMetric.lean` and independently
parent-compiled without warnings, using only the standard Lean axioms.
The evaluated ramp and full evaluated birth-square identity are also
compiled in that module. The actual mixed product's integrability and
evaluated signed integral are now compiled in
`BuildingBlocks/ChargeFrozenBirthWork.lean`, independently
parent-compiled without warnings and with only standard Lean axioms.
The combined norm-increment identity is now independently compiled
in that work module as well. The integer-cell norm sum and process
action bound below remain written proofs. No RH bound is assumed or
proved.

Write E_N=psi(N)-N, l_N=Lambda(N+1), x=exp(v), and
b_N=a_(N+1)-a_N for the literal causal frozen sources. For N>=2,
the actual complete Mangoldt successor identity gives

\[
b_N(v)=x^{-1/2}
\begin{cases}
0,&x\le N,\\
-(x-N),&N<x<N+1,\\
l_N-1,&x\ge N+1.
\end{cases}
\]

The jump at N+1 includes every prime power. The continuum ramp is
present even at a composite with Lambda(N+1)=0. Negative ages and
the origin have zero birth difference. The endpoint x=N+1 belongs
to the last branch.

Because dv=dx/x, define

\[
J_N=\int_N^{N+1}\frac{(x-N)^2}{x^2}\,dx
=1+\frac{N}{N+1}-2N\log(1+1/N).
\]

Its integral representation gives 0<J_N<=1/(3N^2). Direct
integration of the birth and its interaction with the frozen past
then yields

\[
\|b_N\|^2=J_N+\frac{(l_N-1)^2}{N+1},
\]
\[
\langle a_N,b_N\rangle
=E_N\left[\frac{l_N}{N+1}-\log(1+1/N)\right].
\]

For the second identity the ramp integral is
integral_N^(N+1)(x-N)/x^2 dx=log(1+1/N)-1/(N+1).
Adding the terminal interaction E_N(l_N-1)/(N+1) gives the stated
coefficient. Thus the exact two mixed orders are retained in

\[
\|a_{N+1}\|^2-\|a_N\|^2
=2E_N\left[\frac{l_N}{N+1}-\log(1+1/N)\right]
+J_N+\frac{(l_N-1)^2}{N+1}.
\]

This is an identity for frozen sources, not the spatial successor
operator S and not a process-time dissipation formula.

There is also a finite formula for the same full norm. On each
integer cell k<x<k+1, psi(x)=psi(k), so

\[
\|a_N\|^2
=\sum_{k=1}^{N-1}\left[
\frac{\psi(k)^2}{k(k+1)}
-2\psi(k)\log(1+1/k)+1\right]+\frac{E_N^2}{N}.
\]

Every bracket is a nonnegative cell integral. In particular the
k=1 cell is 1, since psi(1)=0, and no origin cell is deleted.

The ramp costs have a finite sum. Moreover Lambda(n)<=log(n)
shows sum_N ||b_N||^2/N<infinity. Consequently, for any causal
L2-contractive process T_s with Gamma(F)<=4lambda||F||^2 and
clock intervals I_N=[c log N,c log(N+1)],

\[
\sum_{N\ge2}\int_{I_N}\Gamma(T_s b_N)ds
\le4\lambda c\sum_{N\ge2}\frac{\|b_N\|^2}{N}<\infty.
\]

Finite birth-loading action does not prove finite action of the
accumulated source. Its coherent cross terms remain. Even before
processing, the exact signed interaction above depends on E_N;
the positive injection cost alone cannot pay that interaction or
give the required subpower norm bound.
