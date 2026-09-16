# The literal successor shift of centered Goldbach heat

The source sequence is $a_n=\Lambda(n)-1$. Fix a finite cutoff $Y$ and
write

$$
D_Y(t)=\sum_{n=1}^Y a_ne^{-nt},\qquad
D_Y^+(t)=\sum_{n=1}^Y a_{n+1}e^{-nt},\qquad
V_Y(t)=\sum_{n=1}^Y(\Lambda(n+1)-\Lambda(n))e^{-nt}.
\tag{1}
$$

The successor shift keeps the same number of source terms and exposes
$a_{Y+1}$; it does not silently change the upper cutoff. Centering cancels
in the discrete derivative, so $D_Y^+=D_Y+V_Y$. Reindexing the finite sum
gives a second exact identity:

$$
\boxed{
D_Y^+(t)=e^tD_Y(t)-a_1+a_{Y+1}e^{-Yt}
=e^tD_Y(t)+1+a_{Y+1}e^{-Yt}.
}
\tag{2}
$$

Both the initial atom $a_1=-1$ and the new upper endpoint are essential.
The formula uses actual von Mangoldt weights, including every prime power.

For $T\geq0$ let $I_T=[e^{-2T},e^{-T}]$ and let
$S_Y(T)=\int_{I_T}D_Y(t)^2dt$ be the original finite heat shell. The
shifted shell $S_Y^+(T)=\int_{I_T}D_Y^+(t)^2dt$ satisfies

$$
\boxed{
S_Y^+(T)-S_Y(T)
=2\int_{I_T}D_Y(t)V_Y(t)\,dt
 +\int_{I_T}V_Y(t)^2\,dt.
}
\tag{3}
$$

The last term is nonnegative. The first is a signed covariance, and the
identity gives no one-sided comparison with the earlier horizon
$A_Y(T)=1+\int_{e^{-T}}^1D_Y(t)^2dt$. In particular, no polynomial
doubling assumption is used.

## Additive totals and a certified sign obstruction

For each $N$, keep the literal conditions $1\leq m,n\leq Y$ and
$m+n=N$. Let $c_Y(N)$ be the original centered convolution, $c_Y^+(N)$
the convolution of $a_{m+1},a_{n+1}$, and put

$$
\begin{aligned}
C_Y(N)&=\sum_{m+n=N}\bigl(a_m\delta_n+\delta_m a_n\bigr),\\
W_Y(N)&=\sum_{m+n=N}\delta_m\delta_n,\\
\delta_n&=\Lambda(n+1)-\Lambda(n).
\end{aligned}
\tag{4}
$$

Then $c_Y^+(N)-c_Y(N)=C_Y(N)+W_Y(N)$ at *every* bounded additive total.
The two mixed terms stay ordered. For $Y=1$, the total-two difference is

$$
c_1^+(2)-c_1(2)=(\log2)^2-2\log2<0.
\tag{5}
$$

For $Y=3$, the total-four difference is

$$
c_3^+(4)-c_3(4)=(\log2-1)^2+(\log3)^2-1>0.
\tag{6}
$$

The second calculation retains the $4=2^2$ prime-power coefficient and
the ordered endpoint pairs. Thus even the coefficient-level successor
transfer has both signs in the first few totals. The analytic shell kernel
$K_T(N)=(e^{-Ne^{-2T}}-e^{-Ne^{-T}})/N$ is nonnegative for $T\geq0$;
positive kernel weights cannot remove this arithmetic sign conflict.

As a numerical diagnostic with the literal von Mangoldt values, Simpson
quadrature of (3) gives $S_{30}^+(1)-S_{30}(1)\approx-0.20741194$ and
$S_{30}^+(5)-S_{30}(5)\approx0.00413101$. This illustrates that the full
shifted-shell difference can change sign with the horizon. These two
quadrature values are not Lean-certified sign theorems and are not used in
any proof.

[CenteredGoldbachSuccessorHeatFinite.lean](BuildingBlocks/CenteredGoldbachSuccessorHeatFinite.lean)
formalizes (1)--(6), including the endpoint identity, exact shell
covariance, coefficient identity, and the opposite signs in (5)--(6).
The public theorem axiom checks list only `propext`, `Classical.choice`,
and `Quot.sound`. The module neither assumes nor proves a scale comparison
for the original centered heat energy.
