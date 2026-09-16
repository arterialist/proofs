# A terminal-prime graph gap for moderate-frequency odd Weil tests

The full prime graph can have very small relative energy at arbitrarily late Kronecker returns. This note gives a complementary **unconditional, carrier-limited** statement for the actual odd Weil prime-power graph. It controls a specified oscillatory family, not every odd test, and does not prove Weil positivity or RH.

Let (a\to\infty), (Z_a=a+\sinh a), and (\phi(x)=\cosh(x/2)). Let (D_a) be the positive weighted graph deficit from the [prime graph identity](prime-shift-weighted-schur-window-asymptotic.md), retaining every admitted prime power. For a carrier (t=t(a)\to\infty), begin with
\[
F^0_{a,t}(x)=\sqrt{2/Z_a}\,\phi(x)\sin(tx)\mathbf1_{(-a,a)}(x).
\]
On the positive half-line put (u^0=\sqrt2 F^0|_{(0,a)}) and (h(x)=\sqrt2\sinh(x/2)). Orthogonally project (u^0) off (h), normalize in (L^2(0,a)), and form its normalized odd extension (F_{a,t}). Thus (F_{a,t}) satisfies the exact odd-sector pole condition.

**Theorem.** If (t(a)\to\infty) and (t(a)\le\exp(\tfrac14\sqrt a)), then
\[
D_a[F_{a,t}]\ge
\left(\frac2e-\frac3{e^2}-o(1)\right)e^a,
\qquad \frac2e-\frac3{e^2}=0.32975\ldots.
\tag{1}
\]
Only primes in the terminal band (e^{2a-2}<p<e^{2a-1}) are needed for this lower bound; all other prime and prime-power edges have nonnegative graph energy. For each (a), these tests can be approximated by compact smooth odd pole-null tests without changing the asymptotic bound.

**Proof.** Write (v=2a-\log p\in(1,2)) and (\ell=\log p). The exact edge overlap is
\[
I_a(\ell)=\int_{-a}^{a-\ell}\phi(x)\phi(x+\ell)\,dx
=\sinh(v/2)+(v/2)\cosh(a-v/2).
\tag{2}
\]
The oscillatory integral obtained by inserting (\cos(2tx+t\ell)) is (O(e^a/t)), uniformly for (1\le v\le2), by one integration by parts. Inserting (2) into the graph identity and using (Z_a\sim e^a/2) shows that the terminal-prime contribution for (F^0_{a,t}) is
\[
e^{-a}\!\sum_{e^{2a-2}<p<e^{2a-1}}
(\log p)v\bigl(1-\cos(t\log p)\bigr)
+O(e^a/t)+o(e^a).
\tag{3}
\]
The (o(e^a)) term from the nonoscillatory edge approximation is uniform in (t).

Set (\vartheta(x)=\sum_{p\le x}\log p). [Trudgian's explicit prime-number-theorem bound](https://arxiv.org/pdf/1401.2689) gives
\[
\vartheta(x)=x+O\!\left(x(\log x)^{1/4}
e^{-\sqrt{(\log x)/6.455}}\right).
\]
Stieltjes integration on the terminal band therefore gives
\[
e^{-2a}\!\sum_p(\log p)v
\longrightarrow \int_1^2v e^{-v}\,dv
=\frac2e-\frac3{e^2},
\tag{4}
\]
where the sum has the range in (3). The same integration with (p^{it}) gives a normalized bound
\[
O\!\left(t^{-1}+(1+t)a^{1/4}
e^{-\sqrt{2a/6.455}+o(\sqrt a)}\right)=o(1)
\tag{5}
\]
under the stated carrier range. Equations (3)--(5) prove (1) for (F^0).

Finally, (\|u^0\|_2=1+O(1/t)), (\|h\|_2^2=\sinh a-a), and direct integration gives
\[
\langle h,u^0\rangle=
\sqrt{2/Z_a}\,
\frac{\cosh a\sin(ta)-t\sinh a\cos(ta)}{1+t^2}.
\]
The pole projection and normalization change (F^0) by (O(1/t)) in (L^2). The full graph operator has norm (O(e^a)), so its quadratic form changes by (O(e^a/t)=o(e^a)). Compact smoothing followed by a one-dimensional pole correction gives the asserted dense-test version at each (a). This proves the theorem.

The range (\log t\lesssim\sqrt a) is far below the (\log t\asymp e^a) scale at which archimedean energy can pay the full prime row. Thus (1) rules out near-nullity for this moderate-carrier family but supplies no RH-scale all-test inequality. The [growing exceptional-prime construction](odd-prime-graph-growing-exceptional-phase-obstruction.md) can use arbitrarily later carriers and is consistent with (1).
