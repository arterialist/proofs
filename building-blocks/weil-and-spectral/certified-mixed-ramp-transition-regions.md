# Certified reductions of the mixed-ramp transition range

**Status:** independently audited written analytic proof (18 September
2026), developed by RH Agent 3 and checked by RH Agents 1 and 2. The
analytic theorem is not Lean formalized; two 192-bit Arb certificates
check the finite numerical inequalities. Let
\(f_L(x)=e^{-x/2}{\bf1}_{[0,L]}(x)\), \(Q\) the
[complete actual Weil form](complete-weil-causal-exponential-signed-cone.md),
\(L\le M\), and
\(H(e^u)=u-\sum_{\log n\le u}\Lambda(n)/n\). Denote
\(r_0(L)=e^{-L}\int_0^L e^uH(e^u)du\), and
\(r_1(L,M)=e^{-M}\int_{M-L}^M e^uH(e^u)du\).
The exact residual is \(R=r_0+r_1\); prime-power endpoints carry no
atoms in these integrals. Set
\(C=1-\gamma-\log(2\pi)\),
\(S=1-\log2\), \(g_0=C+S=2-\gamma-\log(4\pi)\).
The [exact gamma cross](uniform-full-weil-cross-sign-for-long-causal-ramps.md)
satisfies \(G(L,M)>G_\infty(L)>g_0\), where

\[
 G_\infty(L)=C(1-e^{-L})+S-T(L),\qquad
 T(L)=\sum_{n\ge0}{e^{-(2n+3)L}\over(2n+2)(2n+3)}.
\]

For \(L>0\), with \(q=e^{-L}\), splitting
\(1/[m(m+1)]=1/m-1/(m+1)\) for even \(m=2n+2\) gives the exact
closed form \(T(L)=q-(q/2)\log(1-q^2)-\operatorname{atanh}(q)\).

## Long first ramp, arbitrary second ramp

Use the nondecreasing actual-source lower envelope from the
[long-ramp proof](uniform-full-weil-cross-sign-for-long-causal-ramps.md),
which relies on the [sharp harmonic Mangoldt gap](sharp-mangoldt-harmonic-gap-and-weil-residual.md)
and [Johnston--Ramaré--Trudgian Lemma 10](https://arxiv.org/html/2303.13785):
\(h(u)=\min(u,(\log2)/2)\) below 3 and
\(h(u)=\gamma-1.3/u^2\) at or above 3. Define
\(r(L)=e^{-L}\int_0^Le^uh(u)du\). Since \(h\) is nonnegative and
nondecreasing, \(r\) is nondecreasing and
\(r_1(L,M)\ge r(L)\ge r(7)\) for \(M\ge L\ge7\).
A 100-step left-endpoint Arb integration, exact on the pieces below 3,
gives \(r(7)>0.53487402394328\).

For exact \(r_0\), write

\[
 r_0(L)=B_0(L)-P_0(L),\quad B_0(L)=L-1+e^{-L},\quad
 P_0(L)=\sum_{\log n\le L}{\Lambda(n)\over n}
                     (1-ne^{-L}).
\]

Both \(B_0\) and \(P_0\) are continuous and increasing: every
nonnegative prime-power summand in \(P_0\) vanishes at its entry point
and increases thereafter. On each of 8192 rational
intervals \([a,b]\) partitioning \([7,10]\),
\(r_0(L)\ge B_0(a)-P_0(b)\). Arb with exact prime-power enumeration
through \(\lfloor e^{10}\rfloor\) and certified integer cutoffs gives
\(r_0(L)>0.57581456609753\) throughout \([7,10]\). Consequently,

\[
 Q(f_L,f_M)>0.57581456609753+0.53487402394328+g_0
     >0.00244867816 \quad(7\le L\le10,\ M\ge L).       \tag{1}
\]

Agent2 independently proves \(Q>0.0086\) when \(L\ge10\), so (1)
and that theorem cover all \(\min(L,M)\ge7\).

## Well-separated middle ramps

For \(2/25\le L\le7\) and \(M-L\ge6\), every argument of \(H\) in
\(r_1\) is at least 6. Corrected Johnston--Ramaré--Trudgian gives
\(H(e^u)\ge\gamma-1.3/u^2\), hence
\(r_1(L,M)\ge(\gamma-13/360)(1-e^{-L})\). Combining this with
\(G(L,M)>G_\infty(L)\) reduces the desired sign to

\[
 F(L):=r_0(L)
  +(1-\log(2\pi)-13/360)(1-e^{-L})+S-T(L)>0.
                                                               \tag{2}
\]

The coefficient of \(1-e^{-L}\) is negative. The functions
\(B_0,P_0,S-T\) are increasing. On each of 2048 rational intervals
\([a,b]\) partitioning \([2/25,7]\), the rigorous lower bound

\[
 F(L)\ge B_0(a)-P_0(b)
  +(1-\log(2\pi)-13/360)(1-e^{-b})+S-T(a)
  >0.00505263119                                             \tag{3}
\]

is certified in Arb. Thus \(Q(f_L,f_M)>0.00505\) in this region.

Run [the seven-plus certificate](../../certificates/mixed_ramp_seven_plus_certificate.py)
and [the separated-tail certificate](../../certificates/mixed_ramp_tail_scalar_certificate.py)
with `python3` and `python-flint` from the repository root. Their
floating-point conversions only propose integer cutoffs; Arb intervals
verify every cutoff before use. The scripts verify scalar intervals and
prime-power enumeration; (1)--(3) rely on the written monotonicity and
JRT inequalities. Together with the
[short-ramp theorem](complete-weil-cross-sign-for-one-short-causal-ramp.md),
these reductions leave the compact box \(2/25<L<7\),
\(0\le M-L<6\), which the
[consolidated all-ramp proof](complete-weil-positive-causal-ramp-cone.md)
certifies separately. These restricted signs are compatible with
hypothetical high off-line zeros and do not prove RH. No
literature-priority claim is made.
