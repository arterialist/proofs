# Finite-scale centered Goldbach energy survives the factorial cofactor

RH Proof research note, 16 September 2026. This uses the actual full-clock Binet cofactor from the [factorial cone](full-factorial-clock-binet-residual-zero-detecting-cone.md). It gives an unconditional, quantitative comparison of the *centered additive heat energy* before and after all multiplicative cofactor histories are admitted. The estimate holds at every heat cutoff, not just in a limiting half-plane. It neither bounds that energy at the RH scale nor proves Goldbach existence.

Put \(a(n)=\Lambda(n)-1\) for every \(n\ge1\), including \(a(1)=-1\), and

\[
 D(t)=\sum_{n\ge1}a(n)e^{-nt},\qquad t>0.
 \tag{1}
\]

This is the existing complete centered Goldbach heat source. The Binet residual is \(r(m)<0\), and \(v(m)=-r(m)>0\). Its previously proved written bounds are

\[
 \frac1{504}<v(1)<\frac1{360},\qquad
 \sum_{m\ge2}m v(m)<\frac{13}{7200},\qquad
 v(1)-\sum_{m\ge2}m v(m)>\frac1{5600}.
 \tag{2}
\]

Define the full-history centered source and its heat transform by

\[
 d_v(n)=\sum_{m\mid n}v(m)\bigl(\Lambda(n/m)-1\bigr)
       =(v*\Lambda)(n)-\sum_{m\mid n}v(m),
 \qquad D_v(t)=\sum_{n\ge1}d_v(n)e^{-nt}.
 \tag{3}
\]

The reference term in (3) is the **complete divisor sum** of the cofactor, not a single constant density atom. In particular, \(d_v(1)=-v(1)\). Absolute convergence for each \(t>0\) and divisor regrouping give the exact dilation law

\[
 \boxed{D_v(t)=\sum_{m\ge1}v(m)D(mt).} \tag{4}
\]

The signed ordered additive coefficient at total \(k\ge2\) is

\[
 C_v(k)=\sum_{a+b=k}d_v(a)d_v(b)
 =\sum_{ma+nb=k}v(m)v(n)
      \bigl(\Lambda(a)-1\bigr)\bigl(\Lambda(b)-1\bigr),
 \tag{5}
\]

with all four indices positive. Every prime power, direct \(m=n=1\) history, mixed dilation, and additive endpoint remains. The coefficients \(C_v(k)\) need not be positive; the positivity is the full heat square

\[
 D_v(t)^2=\sum_{k\ge2}C_v(k)e^{-kt}\ge0.
 \tag{6}
\]

## A uniform energy gap at every heat horizon

For \(\sigma\ge0\) and \(\varepsilon>0\), write

\[
 \|F\|_{\sigma,\varepsilon}
 =\left(\int_\varepsilon^\infty
       t^{\sigma-1}|F(t)|^2\,dt\right)^{1/2}.
\]

The integral is finite for \(F=D\) and \(F=D_v\) at each positive cutoff. A dilation has the exact norm

\[
 \|D(m\cdot)\|_{\sigma,\varepsilon}
 =m^{-\sigma/2}\|D\|_{\sigma,m\varepsilon}
 \le m^{-\sigma/2}\|D\|_{\sigma,\varepsilon}.
 \tag{7}
\]

The triangle inequality applied to (4), then the reverse triangle inequality applied to its direct \(m=1\) term, therefore give

\[
 \left(v(1)-\sum_{m\ge2}v(m)m^{-\sigma/2}\right)
 \|D\|_{\sigma,\varepsilon}
 \le\|D_v\|_{\sigma,\varepsilon}
 \le
 \left(v(1)+\sum_{m\ge2}v(m)m^{-\sigma/2}\right)
 \|D\|_{\sigma,\varepsilon}.
 \tag{8}
\]

The infinite triangle passage is legitimate: (2) makes the series of dilation norms summable, and the \(L^2\) limit agrees with the pointwise absolutely convergent series (4). Since \(m^{-\sigma/2}\le1\le m\), (2) yields the explicit **unconditional finite-scale coercivity**

\[
 \boxed{\frac1{5600}\|D\|_{\sigma,\varepsilon}
 \le\|D_v\|_{\sigma,\varepsilon}
 \le\frac{11}{2400}\|D\|_{\sigma,\varepsilon}}
 \qquad(\sigma\ge0,\ \varepsilon>0).
 \tag{9}
\]

The upper constant uses \(1/360+13/7200=11/2400\). Thus the positive heat energy of the centered full-history source cannot hide an original centered Goldbach fluctuation, even at a finite horizon. This is a norm inequality, not a pointwise lower bound on \(D_v(t)^2\) or a sign for any coefficient \(C_v(k)\).

At \(\sigma>2\), the bound \(|d_v(n)|\le(1+\log n)\sum_m v(m)\) makes the ordered pair series absolutely convergent: at total \(k\), its absolute numerator is \(O(k\log^2 k)\). The gamma integral therefore justifies the original, uncontinued Mellin identity

\[
 \int_0^\infty t^{\sigma-1}D_v(t)^2dt
 =\Gamma(\sigma)\sum_{k\ge2}\frac{C_v(k)}{k^\sigma}.
 \tag{10}
\]

For \(1<\sigma<2\), equation (10) is **not** being used as an absolutely convergent coefficient series. Letting \(\varepsilon\downarrow0\) in (9) shows instead that the positive integral for \(D_v\) is finite exactly when the existing centered heat integral for \(D\) is finite. The latter is finite for every \(\sigma>1\) if and only if RH: the [centered Goldbach heat criterion](centered-goldbach-heat-lyapunov.md) gives the zero-growth exponent at \(\sigma=1\), and integration by parts converts zero growth into finiteness at every \(\sigma>1\). Conversely, finiteness at every \(\sigma>1\) bounds the critical energy by \(O_\sigma(e^{(\sigma-1)T})\), forcing zero exponent. Equivalently, the critical logarithmic-time Lyapunov exponent is unchanged: at \(\sigma=1\), the substitution \(t=e^{-v}\) turns the truncated energy into \(\int_0^T e^{-v}|D(e^{-v})|^2dv\), and (9) compares this with the cofactor version by constants independent of \(T\).

The gap in (9) is an actual arithmetic constraint derived from the Binet cofactor's first-coefficient dominance. It transfers any future RH-strength *upper* estimate for \(D_v\) back to the original centered Goldbach source, with an explicit constant. It does not supply that upper estimate. Coefficientwise positivity would be a different and stronger mechanism; (6) alone does not provide it, and the direct weight concentrated at \(m=1\) already inherits the negative total-four coefficient in [the centered Goldbach obstruction](centered-goldbach-positive-transfer-obstruction.md).

[FactorialBinetCenteredGoldbachFinite.lean](BuildingBlocks/FactorialBinetCenteredGoldbachFinite.lean) compiles the exact divisor-reference subtraction in (3), the negative \(n=1\) endpoint, the direct-versus-proper cofactor split, and the full ordered four-index expansion in (5), with only Lean's standard axioms. The Binet coefficient bounds, infinite dilation interchange, norm inequality (9), and analytic statement (10) are written proofs here, not compiled Lean theorems.
