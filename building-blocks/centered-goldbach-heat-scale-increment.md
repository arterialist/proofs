# The exact finite centered-Goldbach heat increment

This note isolates what ordinary Goldbach positivity does, and does not do,
for the centered heat energy when the logarithmic horizon changes from
$T$ to $2T$. Everything below is finite. In particular, totals near the
cutoff retain their truncated additive endpoints.

Fix $Y\geq 1$ and put

$$
a_n=\Lambda(n)-1\qquad(1\leq n\leq Y),
\qquad
D_Y(t)=\sum_{1\leq n\leq Y}a_ne^{-nt}.
$$

For $2\leq N\leq 2Y$, define the literal bounded convolution

$$
c_Y(N)=\sum_{\substack{1\leq m,n\leq Y\\m+n=N}}a_ma_n.
$$

The finite horizon functional is

$$
A_Y(T)=1+\sum_{N=2}^{2Y}c_Y(N)
 \frac{e^{-Ne^{-T}}-e^{-N}}{N}.
$$

No limiting exchange is needed to obtain

$$
\boxed{
A_Y(2T)-A_Y(T)
=\sum_{N=2}^{2Y}c_Y(N)K_T(N)
=\int_{e^{-2T}}^{e^{-T}}D_Y(t)^2\,dt,
}
\tag{1}
$$

where

$$
K_T(N)=\frac{e^{-Ne^{-2T}}-e^{-Ne^{-T}}}{N}.
\tag{2}
$$

For $T\geq0$, $K_T(N)\geq0$. Equation (1) therefore also records the
nonnegativity of the complete shell, although individual centered
coefficients can have either sign.

## The complete additive expansion

Define four cutoff-sensitive coefficients:

$$
\begin{aligned}
P_Y(N)&=\sum_{\substack{1\leq m,n\leq Y\\m+n=N}}
          \Lambda(m)\Lambda(n),\\
L_Y(N)&=\sum_{\substack{1\leq m,n\leq Y\\m+n=N}}\Lambda(m),\\
R_Y(N)&=\sum_{\substack{1\leq m,n\leq Y\\m+n=N}}\Lambda(n),\\
Q_Y(N)&=\#\{(m,n):1\leq m,n\leq Y,\ m+n=N\}.
\end{aligned}
\tag{3}
$$

Expanding $(\Lambda(m)-1)(\Lambda(n)-1)$ gives

$$
\boxed{c_Y(N)=P_Y(N)-L_Y(N)-R_Y(N)+Q_Y(N).}
\tag{4}
$$

Consequently the scale increment is exactly

$$
\boxed{
A_Y(2T)-A_Y(T)
=\mathcal P_Y(T)-\mathcal L_Y(T)-\mathcal R_Y(T)+\mathcal Q_Y(T),
}
\tag{5}
$$

where each calligraphic term is the sum of the corresponding coefficient
in (3) against $K_T(N)$ over $2\leq N\leq2Y$.

These are von Mangoldt sums, so every prime power is retained with its
literal weight. Nothing in (3)--(5) replaces $\Lambda$ by a prime
indicator. The bounded conditions $m,n\leq Y$ also remain in force at the
upper endpoint. More explicitly, when $2\leq N\leq2Y$ the permitted
first index lies in
$\max(1,N-Y)\leq m\leq\min(Y,N-1)$, with $n=N-m$.
Thus $Q_Y(N)=\min(Y,N-1)-\max(1,N-Y)+1$ and each marginal sums $\Lambda$
only over this moving interval. The corresponding full $\psi(N-1)$
formula is valid only before the cutoff clips this interval.

The parity decomposition is equally literal:

$$
A_Y(2T)-A_Y(T)
=\sum_{\substack{2\leq N\leq2Y\\N\ \mathrm{even}}}c_Y(N)K_T(N)
 +\sum_{\substack{2\leq N\leq2Y\\N\ \mathrm{odd}}}c_Y(N)K_T(N).
\tag{6}
$$

Thus an even-Goldbach assertion does not remove the odd class or the
cutoff transition layer.

## Positivity audit

All four raw coefficients in (3) are nonnegative. For $T\geq0$, this
implies $\mathcal P_Y,\mathcal L_Y,\mathcal R_Y,\mathcal Q_Y\geq0$.
Ordinary Goldbach existence can make selected even coefficients
$P_Y(N)$ strictly positive. That adds no control in the direction needed
for a doubling estimate, because the desired comparison is an upper bound
for the complete expression (5).

Coefficientwise one may discard the negative marginals and obtain

$$
c_Y(N)\leq P_Y(N)+Q_Y(N).
\tag{7}
$$

This is valid but loses the cancellation of the average prime density by
$L_Y+R_Y$. The lost quantity is exactly the signed compensation

$$
-\mathcal L_Y(T)-\mathcal R_Y(T)+\mathcal Q_Y(T).
\tag{8}
$$

Goldbach positivity addresses only $\mathcal P_Y(T)$. It supplies neither
an upper bound for that packet nor a comparison of (8) with the previous
heat horizon. Hence equations (1)--(8) do not prove polynomial doubling.
They identify the full finite obstruction without suppressing endpoints,
parity, or prime powers.

## Lean scope

[CenteredGoldbachHeatScaleIncrementFinite.lean](BuildingBlocks/CenteredGoldbachHeatScaleIncrementFinite.lean)
formalizes equations (1), (2), and (4)--(7), including the four-term shell
decomposition, the exact even/odd split, raw coefficient nonnegativity, and
kernel nonnegativity. Its public theorem checks use only `propext`,
`Classical.choice`, and `Quot.sound`.

The module makes no infinite-series claim and assumes no polynomial
doubling estimate. In particular, it records a finite consequence of the
literal von Mangoldt coefficients, not an unconditional bound toward RH.
