# Large-clock LCM source and terminal reserve

This independently reviewed note continues the actual small-leg calculation on the clock band
\(t\ge N^{-1/2}\). It uses the literal Möbius response, the literal weight

\[
w(t)=t^{-2}-[t(e^t-1)]^{-1},
\]

and every ordered pair with \(\operatorname{lcm}(d,e)>N\). It does not use RH, a Mertens decay estimate, or a sign assumption. A bounded worker derived the quotient correlation and terminal estimates; root checked their arithmetic identities, constants, domains, and consequences before publication. The exact finite LCM class, interior Mertens sum, terminal boundary identity (8), and its nonnegativity are now compiled in `FactorialTerminalReserve.lean`; the analytic tail bounds remain written.

Write

\[
R_N(t)=\sum_{n\le N}\mu(n)(1-e^{-\lfloor N/n\rfloor t}),
\quad M(x)=\sum_{n\le x}\mu(n),
\quad c(t)=1-e^{-t},
\]

and

\[
\Phi_N=\sum_{d=2}^N\varphi(d),\qquad
W_N(e)=\sum_{d\le N\atop\operatorname{lcm}(d,e)>N}\varphi(d).
\]

Thus \(0\le W_N(e)\le\Phi_N\), and the actual totient source is

\[
T_N(t)=\sum_{e=2}^NW_N(e)h_e(t).
\]

The weights are explicit arithmetic data:

\[
W_N(e)=\Phi_N-
 \sum_{d\le N\atop \operatorname{lcm}(d,e)\le N}\varphi(d).
\tag{1}
\]

For example, if \(N/2<e\le N\), the interior condition forces \(d\mid e\), so

\[
W_N(e)=\Phi_N-(e-1).
\tag{2}
\]

This already shows why the large-clock source is not a generic convolution. Its terminal part contains incomplete, linearly weighted Möbius sums near the top of the interval.

## Exact quotient expansion

The full successor divisor histories give, with \(q=e/d\),

\[
h_e(t)=c(t)\sum_{q\mid e}\mu(e/q)e^{-(q-1)t}.
\]

Summing first over the quotient gives the exact response identity

\[
\frac{R_N(t)}{c(t)}
 =\sum_{q=1}^N e^{-(q-1)t}M(\lfloor N/q\rfloor). \tag{3}
\]

The corresponding exact source identity is

\[
\frac{T_N(t)}{c(t)}
 =\sum_{q=1}^N e^{-(q-1)t}S_N(q),\qquad
S_N(q)=\sum_{m\le N/q}\mu(m)W_N(qm). \tag{4}
\]

Using (1), the new actual correlation can also be written

\[
S_N(q)=\Phi_NM(\lfloor N/q\rfloor)
 -\sum_{d=2}^N\varphi(d)
   \sum_{m\le N/q\atop\operatorname{lcm}(d,qm)\le N}\mu(m). \tag{5}
\]

Equations (3) to (5) hold on the entire positive clock. At
\(t=N^{-1/2}\), the coefficients with \(q\lesssim\sqrt N\) have not decayed by a fixed exponential factor. An absolute estimate only gives

\[
|S_N(q)|\le\Phi_N\lfloor N/q\rfloor
\]

and hence

\[
\left|\sum_{q=2}^Ne^{-(q-1)t}S_N(q)\right|
 \le\Phi_NN\sum_{q=2}^N\frac{e^{-(q-1)t}}q. \tag{6}
\]

The sum on the right is of order \(\log(1/t)\) when \(t\) is small. At the requested lower endpoint this costs order \(\log N\). Thus absolute divisor counting does not isolate the terminal source on the whole band. One must bound cancellation in the specific family \(S_N(q)\), or its correlation with the family \(M(\lfloor N/q\rfloor)\) in (3). This is a precise arithmetic obstruction, not a defect of the small-clock Taylor remainder.

## Exact terminal cancellations

The \(q=1\) coefficient in (4) has a stronger identity:

\[
S_N(1)=\sum_{e\le N}\mu(e)W_N(e)=\Phi_NM(N). \tag{7}
\]

Here is a direct complete-class proof. The cumulative weighted interior sum over divisors of an integer \(k>1\) is

\[
\sum_{d,e\mid k\atop d>1}\varphi(d)\mu(e)
 =(k-1)\sum_{e\mid k}\mu(e)=0.
\]

It is also zero at \(k=1\). Möbius inversion over the LCM classes therefore says that every complete terminal weighted interior class vanishes. The total ordered rectangle is \(\Phi_NM(N)\), so the escaping part is exactly (7). This proof uses the actual totient and Möbius factors.

The ordinary escaping terminal reserve is

\[
\sum_{d,e\le N\atop\operatorname{lcm}(d,e)>N}\mu(d)\mu(e)
 =M(N)^2-M(N)=M(N)(M(N)-1)\ge0. \tag{8}
\]

Indeed, the cumulative unweighted terminal class over divisors of \(k\) is
\((\sum_{d\mid k}\mu(d))^2=1_{k=1}\). Inversion makes the exact LCM class at \(k\) equal to \(\mu(k)\). Hence the complete interior sum through \(N\) is \(M(N)\), which proves (8). The nonnegativity follows because \(M(N)\) is an integer. No sign sector has been removed.

## Quantitative terminal domination

From the defining response,

\[
|R_N(t)-M(N)|
 =\left|\sum_{n\le N}\mu(n)e^{-\lfloor N/n\rfloor t}\right|
 \le Ne^{-t}. \tag{9}
\]

Using (4), (7), and \(W_N(e)\le\Phi_N\) gives, for \(t\ge1\),

\[
|T_N(t)-\Phi_NM(N)|\le2\Phi_NNe^{-t}. \tag{10}
\]

For completeness, the nonterminal part before the last simplification is at most

\[
c(t)\Phi_N\sum_{q=2}^N\lfloor N/q\rfloor e^{-(q-1)t}
 \le c(t)\Phi_NN\frac{e^{-t}}{2(1-e^{-t})}.
\]

The difference between \(c(t)\Phi_NM(N)\) and \(\Phi_NM(N)\) is at most \(\Phi_NNe^{-t}\). Since \(1-e^{-t}\ge1/2\) for \(t\ge1\), (10) follows.

Combining (9) and (10),

\[
|T_N(t)R_N(t)-\Phi_NM(N)^2|
 \le3\Phi_NN^2e^{-t},\qquad t\ge1. \tag{11}
\]

This is an actual large-clock correlation bound. Its main term is nonnegative and contains the square of the terminal Mertens value.

The signed escaping boundary row itself obeys a similar estimate. The exact source decomposition gives

\[
\mathcal B_N(t,t)=R_N(t)^2-\beta(t)R_N(2t),
\qquad \beta(t)=\frac{1-e^{-t}}{1+e^{-t}}.
\]

Equations (8), (9), and \(|1-\beta(t)|\le2e^{-t}\) imply

\[
|\mathcal B_N(t,t)-M(N)(M(N)-1)|
 \le5N^2e^{-t},\qquad t\ge1. \tag{12}
\]

This controls the complete ordered escaping boundary, including its signs, by its exact terminal reserve.

## Consequences on the original weight

For \(t\ge1\), convexity of the exponential gives

\[
e^t-1\ge t(e-1),
\]

so

\[
\frac{\kappa}{t^2}\le w(t)\le\frac1{t^2},
\qquad \kappa=1-\frac1{e-1}>0. \tag{13}
\]

Put \(L_N=1+\log(2N)\). Then \(L_N\ge N^{-1/2}\) and \(Ne^{-L_N}<1/2\). The positive energy on the requested large band satisfies

\[
\int_{N^{-1/2}}^\infty R_N(t)^2w(t)\,dt
 \ge\frac{\kappa}{L_N}
   (|M(N)|-1/2)_+^2. \tag{14}
\]

This follows by restricting the integral to \([L_N,\infty)\), applying (9), and integrating \(t^{-2}\).

The terminal source work has the unconditional lower bound

\[
\int_{L_N}^\infty T_N(t)R_N(t)w(t)\,dt
 \ge\frac{\kappa\Phi_NM(N)^2}{L_N}
 -\frac{3\Phi_NN^2e^{-L_N}}{L_N^2}. \tag{15}
\]

Likewise, the signed escaping boundary has

\[
\int_{L_N}^\infty\mathcal B_N(t,t)w(t)\,dt
 \ge\frac{\kappa M(N)(M(N)-1)}{L_N}
 -\frac{5N^2e^{-L_N}}{L_N^2}. \tag{16}
\]

The errors in (15) and (16) use
\(\int_L^\infty e^{-t}t^{-2}dt\le e^{-L}/L^2\).

These estimates are one-sided and useful, but in the opposite direction from an energy upper bound. They expose the terminal reserve that any upper-bound argument must pay for or correlate with the middle clock.

In particular, a bound

\[
\int_{N^{-1/2}}^\infty R_N(t)^2w(t)\,dt=O(N)
\]

would force, just from (14),

\[
|M(N)|=O(\sqrt{N\log N}). \tag{17}
\]

Thus a linear estimate on the large band already contains square-root-scale Möbius cancellation, up to a logarithm. No manipulation of complete LCM classes supplies (17) unconditionally.

## Remaining consumer

The exact unresolved middle-clock object is the correlation

\[
\int_{N^{-1/2}}^{L_N}
 c(t)^2
 \left(\sum_{q=1}^Ne^{-(q-1)t}S_N(q)\right)
 \left(\sum_{r=1}^Ne^{-(r-1)t}M(\lfloor N/r\rfloor)\right)
 w(t)\,dt. \tag{18}
\]

Every coefficient in (18) has the actual floor, totient, Möbius, and escaping-LCM restriction through (5). A useful upper estimate must exploit cancellation in this correlation while accommodating the positive terminal main term in (11). The absolute estimate (6) is too large, and the terminal reserve bounds (14) to (16) show that positivity cannot simply be discarded.

This gives a bounded conclusion. The quotient histories produce an exact new arithmetic correlation and a controlled terminal reserve. On \(t\ge L_N\), the reserve is explicit. On \(N^{-1/2}\le t\le L_N\), the required cancellation is exactly (18). Proving it at the strength needed for linear energy would already imply the Mertens constraint (17); this note does not prove that cancellation.
