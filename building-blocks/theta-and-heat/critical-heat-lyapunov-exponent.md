# A single Lyapunov exponent for the centered Goldbach heat source

Let

$$
C(t)=\sum_{n\ge1}\Lambda(n)e^{-nt}-(1+t^{-1})e^{-t},
\qquad t>0.
\tag{1}
$$

Its Mellin transform is

$$
\int_0^\infty C(t)t^{s-1}\,dt
=\Gamma(s)\left[-\frac{\zeta'(s)}{\zeta(s)}-\frac{s}{s-1}\right]
\qquad(\Re s>1).
\tag{2}
$$

The square $C(t)^2$ is the positive centered additive-Goldbach heat
source.  Define its logarithmic-time profile and accumulated energy by

$$
b(v)=e^{-v/2}C(e^{-v}),\qquad
\mathscr A(T)=1+\int_0^T|b(v)|^2\,dv
=1+\int_{e^{-T}}^1|C(t)|^2\,dt.
\tag{3}
$$

Finally put

$$
\lambda_*=\limsup_{T\to\infty}\frac{\log\mathscr A(T)}T.
\tag{4}
$$

The added one only avoids an irrelevant logarithm at a zero value.

Write
$$
\Theta=\sup\{\Re\rho:\zeta(\rho)=0,\ 0<\Re\rho<1\}.
$$
The functional equation gives $1/2\le\Theta\le1$. No zero attaining
the supremum is assumed.

## Theorem

Unconditionally $0\le\lambda_*\le1$, and in fact

$$
\boxed{\lambda_*=2\Theta-1.}
\tag{5a}
$$
In particular,

$$
\boxed{\mathrm{RH}\quad\Longleftrightarrow\quad\lambda_*=0.}
\tag{5}
$$

More precisely, every nontrivial zero $\rho=\beta+i\gamma$ with
$\beta>1/2$ forces

$$
\boxed{\lambda_*\ge2\beta-1.}
\tag{6}
$$

### Laplace-energy identity

For every real $q>1$ for which either side is finite, the change
$t=e^{-v}$ gives

$$
\boxed{
\int_0^\infty |b(v)|^2e^{-(q-1)v}\,dv
=\int_0^1|C(t)|^2t^{q-1}\,dt.
}
\tag{7}
$$

Thus, with $q=2\sigma$, the right side is precisely the small-$t$ part
of the positive Mellin--Plancherel energy

$$
J_\sigma=\int_0^\infty|C(t)|^2t^{2\sigma-1}\,dt.
\tag{8}
$$

The large-$t$ part is finite for every real $\sigma$, because $C$ decays
exponentially there.

### RH implies zero exponential growth

Under RH,

$$
C(t)=O(t^{-1/2}\log^2(2/t))\qquad(0<t\le1).
$$

Consequently $b(v)=O((1+v)^2)$ and

$$
\mathscr A(T)=O((1+T)^5).
\tag{9}
$$

This proves $\lambda_*=0$.

The [critical mean-square law](../goldbach/centered-goldbach-heat-critical-mean-square-law.md) sharpens this conditional bound to an exact linear asymptotic for the same centered source, without assuming simplicity or linear independence of zero ordinates. Its proof uses the Gamma-smoothed zero expansion; the unconditional linear upper bound remains equivalent to RH.

### Zero exponential growth implies RH

Assume $\lambda_*=0$.  For every $\epsilon>0$, the definition of the
limsup and monotonicity of $\mathscr A$ give a constant $K_\epsilon$ such
that

$$
\mathscr A(T)\le K_\epsilon e^{\epsilon T}
\qquad(T\ge0).
\tag{10}
$$

Let $\sigma>1/2$ and choose $0<\epsilon<2\sigma-1$.  Integration by
parts against the nonnegative measure
$d\mathscr A(v)=|b(v)|^2dv$ gives

$$
\begin{aligned}
\int_0^\infty e^{-(2\sigma-1)v}\,d\mathscr A(v)
&=(2\sigma-1)\int_0^\infty
 e^{-(2\sigma-1)v}[\mathscr A(v)-1],dv\\
&<\infty.
\end{aligned}
\tag{11}
$$

Equations (7)--(8) show that $J_\sigma<\infty$.  This holds for every
$\sigma>1/2$.  Cauchy--Schwarz then makes the Mellin integral in (2)
locally normally convergent on every half-plane $\Re s>\sigma$.
Therefore the compensated logarithmic derivative in (2) is holomorphic
throughout $\Re s>1/2$, excluding every zeta zero there.  The functional
equation proves RH.

### An off-critical zero forces positive growth

Suppose a zero has real part $\beta>1/2$ and, contrary to (6), that
$\lambda_*<2\beta-1$.  Choose a real number

$$
\lambda_*<a<2\beta-1
$$

and put $\sigma=(1+a)/2<\beta$.  The same integration-by-parts argument,
now using any exponential bound strictly between $\lambda_*$ and $a$,
proves $J_\sigma<\infty$.  The preceding Mellin argument continues the
compensated logarithmic derivative holomorphically to $\Re s>\sigma$,
which contains the alleged zero.  This contradiction proves (6).

Finally, the elementary estimate $C(t)=O(t^{-1}\log(2/t))$ gives
$|b(v)|^2=O(e^v(1+v)^2)$ and hence $\lambda_*\le1$.  Monotonicity and
$\mathscr A\ge1$ give $\lambda_*\ge0$.

### Exact calibration by the zero abscissa

When $\Theta>1/2$, take the supremum of (6) over all zeros with
$\Re\rho>1/2$; when $\Theta=1/2$, use $\lambda_*\ge0$. Either way
$\lambda_*\ge2\Theta-1$, even if no zero attains $\Theta$. For the reverse
bound use the complete explicit formula for the actual Chebyshev function,
including all prime powers. The [zero-abscissa discrepancy proof](../weil-and-spectral/zero-abscissa-scattering-growth.md)
derives from [Dudek's truncated explicit formula, Theorem 2.1](https://arxiv.org/pdf/1401.4233)
the uniform estimate
$$
\psi(x)-x=O\bigl(x^\Theta\log^2(2x)\bigr)
\qquad(x\ge1).
\tag{15}
$$
The exact Stieltjes identity for this centering, with its lower endpoint
retained, is
$$
C(t)=t\int_1^\infty(\psi(x)-x)e^{-tx}\,dx.
\tag{16}
$$
For $0<t\le1$, substitute $u=tx$ in (16). The elementary inequality
$\log(2u/t)\le\log(2/t)+\log(1+u)$, valid for $u\ge t$, and the finite
Gamma moments of $u^\Theta e^{-u}$ give
$$
|C(t)|\ll t^{-\Theta}(1+\log(1/t))^2.
\tag{17}
$$
Consequently
$$
|b(v)|^2\ll e^{(2\Theta-1)v}(1+v)^4,
\qquad
\mathscr A(T)\ll 1+(1+T)^5e^{(2\Theta-1)T}.
\tag{18}
$$
Taking logarithms and dividing by $T$ proves
$\lambda_*\le2\Theta-1$, including the endpoint $\Theta=1/2$.
Together with (6) this proves (5a). The equality identifies the exact
exponential rate of the **actual** centered Goldbach heat energy; it does
not determine $\Theta$ or supply the missing RH-scale upper bound.

## Finite-scale formulation

The criterion $\lambda_*=0$ is equivalently

$$
\boxed{
\forall\epsilon>0\ \exists K_\epsilon:\quad
\int_{e^{-T}}^1|C(t)|^2dt\le K_\epsilon e^{\epsilon T}
\quad(T\ge0).
}
\tag{12}
$$

It contains no complex variable and no limit over individual zeros.  The
infinite RH boundary is replaced by the assertion that one positive,
monotone energy has zero exponential growth.  This is suited to a
submultiplicative or renormalization argument: any arithmetic transfer
inequality forcing

$$
\mathscr A(T+U)\le e^{o(T+U)}
\bigl(\mathscr A(T)+\mathscr A(U)\bigr)
$$

uniformly across scales would make the Lyapunov exponent vanish and would
therefore prove RH.

## A doubling theorem is sufficient and equivalent

The preceding suggestion can be reduced to one explicit inequality:

$$
\boxed{
\mathrm{RH}\quad\Longleftrightarrow\quad
\exists C,K,T_0>0\ \forall T\ge T_0:\quad
\mathscr A(2T)\le CT^K\mathscr A(T).
}
\tag{13}
$$

Under RH, (9) and $\mathscr A(T)\ge1$ give (13), for example with
$K=5$ after increasing $C$.

Conversely, assume the doubling inequality.  Set $T_j=2^jT_0$ and
$L_j=\log\mathscr A(T_j)$.  Iteration gives

$$
L_{j+1}\le L_j+\log C+K\log T_j,
$$

and therefore

$$
L_j\le L_0+j\log C+Kj\log T_0
+\frac{K\log2}{2}j(j-1)=O(j^2).
\tag{14}
$$

Since $T_j=2^jT_0$, one has $L_j/T_j\to0$.  For an arbitrary
$T_j\le T<T_{j+1}$, monotonicity gives

$$
0\le\frac{\log\mathscr A(T)}T
\le\frac{L_{j+1}}{T_j}\longrightarrow0.
$$

Thus $\lambda_*=0$, and (5) proves RH.

This identifies a specific renormalization target.  One need not prove a
square-root estimate for $\psi(x)-x$ directly.  It is enough to show that
doubling the logarithmic observation horizon can increase the accumulated
centered-Goldbach heat energy by at most a fixed polynomial in that
horizon.  Any fixed exponential amplification is forbidden; polynomial
losses of arbitrary fixed degree are harmless.
