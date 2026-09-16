# The first admitted mode controls two complete fixed-clock signs

At the literal integer clock \(X=2\), the first admitted mode \(k=1\)
already has the sign of the **complete** admission-energy increment at
both \(p=5\) and \(p=23\). The infinite \(k\geq2\) packet has the
opposite sign at each stage, but its separately certified interval is
too small to reverse either principal sign. This is a finite arithmetic
finding, not an eventual prime-sign statement.

Use the exact Green atom, coefficient \(A_D\), and moving old packet
\(D=p^-\#\) from the [full moving-prime audit](post-branch-moving-prime-x2-sign.md).
Write \(q=e^{-1}\), \(h=(\log2)/2\), and
\(U=h\sum_{m\geq1}A_D(m)v_m\) for the old complete row. The new row
splits into \(V_1=-hv_p\) and
\(V_{\geq2}=-h\sum_{k\geq2}A_D(k)v_{pk}\). Thus

\[
\begin{aligned}
\Delta\mathcal E_{2,p}&=P_p+Q_p,\\
P_p&=\|V_1\|^2+2\langle U,V_1\rangle,\\
Q_p&=\|V_{\geq2}\|^2
       +2\langle V_1,V_{\geq2}\rangle
       +2\langle U,V_{\geq2}\rangle.                    \tag{1}
\end{aligned}
\]

There are no other old-source, new-source, endpoint, or orientation
terms. With \(S_D(p)\), \(F_D^{\leq p}(q)\), and \(R_D(p;q)\) as in
the moving-prime audit, the closed \(m=p\) endpoint belongs to both
\(S_D\) and \(F_D^{\leq p}\), and the exact principal split is

\[
\begin{aligned}
P_p={}&\underbrace{h^2q^p(1-q^p)}_{\text{self}}
\underbrace{-2h^2q^p S_D(p)}_{\text{doubled-Möbius prefix}}\\
&+\underbrace{2h^2q^pF_D^{\leq p}(q)}_{\text{Abel past}}
\underbrace{-2h^2q^p(1-q^p)R_D(p;q)}_{\text{Abel future}}.
                                                               \tag{2}
\end{aligned}
\]

The [directed interval checker](verification/post_branch_principal_mode_x2.py)
evaluates every finite polynomial using rational enclosures of
\(q\) and \(h\), then enlarges the intervals by explicit bounds for
all omitted source coefficients. The following endpoints are rational
decimals; scientific notation applies to each endpoint separately.

| Complete component | \(p=5\), \(D=6\) | \(p=23\), \(D=9{,}699{,}690\) |
|:--|--:|--:|
| \(S_D(p)\) | \(-3\) | \(1\) |
| Self | \([8.038636025614132358,8.038636025614132359]10^{-4}\) | \([1.232587749252757332,1.232587749252757332]10^{-11}\) |
| Prefix | \([4.855900414997570167,4.855900414997570167]10^{-3}\) | \([-2.465175498758488006,-2.465175498758488006]10^{-11}\) |
| Abel past | \([2.043234604979543693,2.043234604979543693]10^{-4}\) | \([3.027406451369890469,3.027406451369890469]10^{-12}\) |
| Abel future | \([-1.001402143451545296,-1.001402143451545296]10^{-3}\) | \([-5.637546923997488384,-5.637546923997488383]10^{-12}\) |
| \(P_p\), full \(k=1\) | \([4.862685334605392476,4.862685334605392477]10^{-3}\) | \([-1.493601796768490466,-1.493601796768490466]10^{-11}\) |
| \(Q_p\), full \(k\geq2\) | \([-1.077870243066713727,-1.077870243066713726]10^{-5}\) | \([1.281873233049353907,1.281955447390221157]10^{-20}\) |
| \(P_p+Q_p\) | \([4.851906632174725339,4.851906632174725339]10^{-3}\) | \([-1.493601795486617233,-1.493601795486535018]10^{-11}\) |

The apparently equal displayed endpoints in several rows conceal
smaller, directed interval widths. In particular, the \(p=23\)
remainder is **positive**, but eight orders of magnitude below the
negative principal mode. The signs in the last two rows are strict.
At \(p=5\), \(S_D(5)=-3\) contributes positively; at \(p=23\),
\(S_D(23)=1\) contributes negatively. The Abel past/future and the
entire \(k\geq2\) packet have been kept, so the prefix explains the
observed finite reversal without being promoted to a universal sign
criterion.

For completeness, the checker truncates the old row at \(m\leq120\).
It truncates the new packet at \(k\leq80\) for \(p=5\), and at
\(k\leq5\) for \(p=23\). Let \(T=\tau(D)\), \(r_0=5/8\), and choose
\(s_0=1/10\) at \(p=5\), \(s_0=1/90000\) at \(p=23\). Rational
exponential intervals verify \(q^{1/2}<r_0\) and
\(q^{p/2}<s_0\). The Abel-future piece in (2) has absolute
unscaled tail at most

\[
\eta_F\leq {2T(3/8)^{121}\over1-3/8},                  \tag{3}
\]

which is below \(3.673\cdot10^{-51}\) at \(p=5\) and
\(2.351\cdot10^{-49}\) at \(p=23\). For the remainder, set

\[
N_o={Tr_0\over1-r_0},\quad
\eta_o={Tr_0^{121}\over1-r_0},\quad
N_r={Ts_0^2\over1-s_0},\quad
\eta_r={Ts_0^{K+1}\over1-s_0}.
\]

The discrepancy in \(Q_p\) is at most

\[
2N_r\eta_r+\eta_r^2+2s_0\eta_r
+2\eta_oN_r+2N_o\eta_r+2\eta_o\eta_r.               \tag{4}
\]

This is below \(1.898\cdot10^{-25}\) and
\(4.111\cdot10^{-25}\), respectively. Bounds (3)–(4) use only
\(|A_D(n)|\leq T\), \(\|v_m\|\leq q^{m/2}\), and \(h<1\).
The checker also asserts coefficientwise equality between (2), the
direct principal Green polynomial, and the directly assembled complete
polynomial before interval evaluation.
