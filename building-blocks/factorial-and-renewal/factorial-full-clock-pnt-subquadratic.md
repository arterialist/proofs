# PNT subquadratic bound for the complete factorial clock and signed work

## Status and scope

This is an unconditional written proof from the classical prime number theorem. It keeps the full positive clock, every natural quotient, every Möbius coefficient, and the birth at (n=1). It proves a strict asymptotic improvement over the elementary quadratic energy envelope, but it supplies no fixed power saving and does not prove RH. No originality claim is made.

For (N\ge 0), put

\[
 g_N(t)=\sum_{n\le N}\mu(n)\bigl(1-e^{-\lfloor N/n\rfloor t}\bigr),
 \qquad
 Q_N=\int_0^\infty g_N(t)^2w(t)\,dt,
\]

where

\[
 w(t)=\frac1{t^2}-\frac1{t(e^t-1)}>0 \qquad (t>0).
\]

The claim is

\[
 \boxed{Q_N=o(N^2).}
 \tag{1}
\]

If \(\delta_n=g_n-g_{n-1}\) for (n\ge1), (g_0=0), and

\[
 V_N=\sum_{n=1}^N\|\delta_n\|_w^2,
 \qquad
 W_N=\sum_{n=1}^N\langle g_{n-1},\delta_n\rangle_w,
\]

then the exact square telescope (Q_N=V_N+2W_N), together with the elementary complete-birth bound

\[
 V_N\le(\log2)N(1+\log N)^3=o(N^2),
\]

gives

\[
 \boxed{|W_N|=o(N^2).}
 \tag{2}
\]

The first term is retained: \(\delta_1(t)=1-e^{-t}\), its work pairing with (g_0) is zero, and its nonzero square remains in (V_N).

## Exact Abel history

Let (M(x)=\sum_{n\le x}\mu(n)), and fix (t>0). With (z=e^{-t}\in(0,1)), finite geometric expansion gives

\[
\begin{aligned}
 g_N(t)
 &=\sum_{n\le N}\mu(n)(1-z^{\lfloor N/n\rfloor})\\
 &=(1-z)\sum_{j=1}^N z^{j-1}
   M\!\left(\left\lfloor\frac Nj\right\rfloor\right).
\end{aligned}
\tag{3}
\]

All sums are finite. The condition \(j\le\lfloor N/n\rfloor\) is exactly (n\le\lfloor N/j\rfloor), so no quotient endpoint is changed.

The elementary bound \(|M(y)|\le y\) yields, for every (N\ge1),

\[
 \frac{|g_N(t)|}{N}
 \le (1-z)\sum_{j\ge1}\frac{z^{j-1}}j
 = (e^t-1)\bigl[-\log(1-e^{-t})\bigr]
 =:F(t).
\tag{4}
\]

For each fixed (j\), the prime number theorem in its equivalent Möbius form (M(x)=o(x)) gives

\[
 \frac{M(\lfloor N/j\rfloor)}N\longrightarrow0.
\]

After extending the finite summand in (3) by zero for (j>N), its absolute value is bounded by (z^{j-1}/j). Dominated convergence on counting measure therefore proves

\[
 \frac{g_N(t)}N\longrightarrow0
 \qquad\text{for every fixed }t>0.
\tag{5}
\]

## One integrable full-clock majorant

For (0<t\le1),

\[
 e^t-1\le et,
 \qquad
 1-e^{-t}\ge\frac t2,
\]

and hence

\[
 F(t)\le et\log\frac2t.
\tag{6}
\]

For (t\ge1), the inequality \(-\log(1-u)\le u/(1-u)), (0<u<1), gives (F(t)\le1). The original compensated density obeys

\[
 0<w(t)\le\frac1{2t},
 \qquad
 w(t)\le\frac1{t^2}.
\tag{7}
\]

Consequently

\[
 \left(\frac{g_N(t)}N\right)^2w(t)
 \le
 \begin{cases}
 \dfrac{e^2}{2}\,t\log^2(2/t),&0<t\le1,\\[4pt]
 t^{-2},&t\ge1.
 \end{cases}
\tag{8}
\]

This majorant is integrable on the entire positive axis. Its integral is

\[
 C_0=1+\frac{e^2}{2}
 \left(\frac{(\log2)^2}{2}+\frac{\log2}{2}+\frac14\right)<\infty.
\tag{9}
\]

Equations (5), (8), and dominated convergence in (t) prove (1).

## Signed-work consequence and exact gap

The complete birth identity and full-clock integrability give

\[
 Q_N=V_N+2W_N.
\tag{10}
\]

Since (Q_N\ge0), (V_N\ge0), (Q_N=o(N^2)), and (V_N=o(N^2)),

\[
 |W_N|=\frac12|Q_N-V_N|
 \le\frac12(Q_N+V_N)=o(N^2).
\]

In particular, the signed work on any dyadic block is also (o(X^2)):

\[
 \sum_{X<n\le2X}\langle g_{n-1},\delta_n\rangle_w
 =W_{2X}-W_X=o(X^2).
\tag{11}
\]

The RH consumer requires the much stronger one-sided estimate (W_N\le C_\varepsilon N^{1+\varepsilon}) for every \(\varepsilon>0\). The PNT argument above gives no bound (O(N^{2-\eta})) with a fixed \(\eta>0\). Thus (2) is an unconditional signed full-clock inequality, while the missing fixed power saving remains explicit.

The sharper reviewed estimate (V_N\le27N/4) gives the same conclusion, but is not needed for (2).

## Existing formal components

[FactorialIntegerBirth.lean](../../formalization/BuildingBlocks/FactorialIntegerBirth.lean) compiles the exact birth and pointwise signed-work telescope. [FactorialKernelDictionary.lean](../../formalization/BuildingBlocks/FactorialKernelDictionary.lean) identifies the complete positive-clock norm with the factorial kernel energy. The Abel identity, PNT limit, full-clock dominated-convergence argument, and asymptotic conclusions (1)--(2) are written mathematics here; no Lean formalization of those analytic steps is claimed.
