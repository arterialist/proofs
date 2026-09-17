# An exact transform for the full W readout at diagonal process time

This written proof computes the transform of the literal diagonal-time readout, including the complete arithmetic $W$ and its same-prime subtraction. Subexponential bounds for arbitrarily small fixed process-time ratios would imply RH. Those bounds remain unproved. For sufficiently large ratios the same bound is already unconditional.

The general resolvent formula is classical. Kuznetsov–Kyprianou–Rivero, [*The theory of scale functions for spectrally negative Lévy processes*, Theorem 2.7(iv)](https://arxiv.org/pdf/1104.1280), give the positive-half-line resolvent density $q'(z)e^{-q(z)y}$. Apply it to $X_v=v-Z_{\theta v}$, where $Z$ is the subordinator with exponent $\Phi$. Its Laplace exponent is $s-\theta\Phi(s)$, and integration against a causal $w(y)$ gives (8) below in the initial real domain. The direct contour proof retained here also supplies the stated complex domains, the transformed arithmetic poles and the small-time quantifier. No priority or Lean formalization claim is made.

## 1. The complete prime process and its characteristic map

Retain the [complete prime-only finite-activity law](../successor-and-division/positive-successor-seed-jump-process.md)
$$
 \mu_t=e^{-\lambda t}\sum_{j\ge0}\frac{t^j}{j!}(F(v)dv)^{*j},
 \qquad \lambda=\int_0^\infty F(v)dv<\infty,
$$
where $F=B/v\ge0$ is the actual stepped prime density, with all proper powers. Its Laplace exponent is
$$
 \Phi(s)=\int_0^\infty(1-e^{-sv})F(v)dv,
 \qquad \Re s>0.
\tag{1}
$$
For every $r>0$, throughout the closed half-plane $\Re s\ge r$,
$$
 |\Phi(s)|\le2\lambda,\quad
 \Re\Phi(s)\ge\Phi(r)>0,\quad
 |\Phi'(s)|\le\Phi'(r)<\infty.
\tag{2}
$$
The derivative follows from the convergent integral $\Phi'(s)=\int e^{-sv}B(v)dv$. No finite unweighted mean of the complete process is assumed.

Fix $\theta>0$ with $\theta\Phi'(r)<1$. For every $z$ with $\Re z>r$, the equation
$$
 q_\theta(z)=z+\theta\Phi(q_\theta(z))
\tag{3}
$$
has a unique solution in $\Re s\ge r$. Indeed its right side maps that closed half-plane into itself and is a strict contraction by (2). Thus
$$
 q_\theta(z)-z=O(\theta\lambda),\quad
 q_\theta'(z)=\frac1{1-\theta\Phi'(q_\theta(z))},
\tag{4}
$$
and the implicit-function theorem makes $q_\theta$ holomorphic on $\Re z>r$. The characteristic map being inverted is
$$
 \chi_\theta(s)=s-\theta\Phi(s).
\tag{5}
$$
Uniqueness holds on the whole specified half-plane, not merely near a chosen pole.

## 2. Exact diagonal-time Laplace transform

Let $w$ be a continuous causal function of exponential order at most $1/2$, whose Laplace transform $\mathcal W(s)$ is holomorphic for $\Re s>1/2$ and satisfies
$$
 |\mathcal W(s)|\le C_R(1+|s|)^{-2}
 \quad(\Re s\ge R),\qquad R>1/2.
\tag{6}
$$
The actual normalized $W$ below has these properties. Define the literal diagonal observation
$$
 d_\theta(v)=(T_{\theta v}w)(v),\qquad v\ge0.
\tag{7}
$$
For $R>1/2$ with $\theta\Phi'(R)<1$, and initially $\Re z>R$,
$$
 \boxed{\mathcal L d_\theta(z)=
 \frac{\mathcal W(q_\theta(z))}
 {1-\theta\Phi'(q_\theta(z))}.}
\tag{8}
$$

Here is a direct justification, including the time dependence. For every fixed $v\ge0$, inverse Laplace transformation of the full process gives
$$
 d_\theta(v)=\frac1{2\pi i}\int_{R-i\infty}^{R+i\infty}
 e^{[s-\theta\Phi(s)]v}\mathcal W(s)ds.
\tag{9}
$$
The integral is absolute by (6). It is the inverse transform of the actual 
convolution $T_t w$, evaluated at the specific $t=\theta v$; all process histories, including the no-jump history, remain in $e^{-t\Phi(s)}$.

On this vertical line, $\Re\Phi(s)\ge\Phi(R)>0$. Thus Fubini for $\Re z>R$ yields
$$
 \mathcal L d_\theta(z)=\frac1{2\pi i}
 \int_{R-i\infty}^{R+i\infty}
 \frac{\mathcal W(s)}{z-s+\theta\Phi(s)}ds.
\tag{10}
$$
Close this contour to the right. The characteristic equation has exactly one root there, $s=q_\theta(z)$, by (3); it lies strictly to the right of $R$ by (2). Its derivative is nonzero. The semicircular arc integral tends to zero, since the numerator is $O(|s|^{-2})$, the denominator has size comparable to $|s|$, and $\Phi$ is bounded on the half-plane. The closing orientation is clockwise; the residue of the denominator contributes the second minus sign. The result is exactly (8).

This proof neither exchanges a fixed-time signed inverse with a varying time nor differentiates a prime-kernel asymptotic.

## 3. Application to the original full W, including same-prime pairs

Use the [actual full readout](../zeta-and-zeros/actual-W-positive-primitive-analysis.md):
$$
 w(v)=e^{-3v/2}W(e^v)
 =\rho_*\{L_0(a*a)-\tau\}(v),
$$
$$
 a(v)=e^{-v/2}[\psi(e^v)-e^v]1_{v\ge0},\quad
 L_0=I-e^{-3v/2}1_{v\ge0}*,\quad
 \rho_*=\sum_{d\ge1}d^{-1}\delta_{\log d}.
\tag{11}
$$
The complete same-prime term is $\tau$, with its ordered-pair multiplicity. The seed, continuous density and all multiples are part of (11).

With $D(s)=-\zeta'(s)/\zeta(s)$, its transform in $\Re s>1/2$ is exactly
$$
 \mathcal W(s)=\zeta(s+1)\left[
 \frac{s+1/2}{s+3/2}A(s)^2
 -\frac{Q_{\rm same}(s+1/2)}{(s+1/2)(s+3/2)}
 \right],
$$
$$
 A(s)=\frac{D(s+1/2)}{s+1/2}-\frac1{s-1/2},\quad
 Q_{\rm same}(z)=\sum_p\frac{(\log p)^2}{(p^z-1)^2}.
\tag{12}
$$
For every $R>1/2$, absolute Dirichlet-series bounds give bounded $D(s+1/2)$, $Q_{\rm same}(s+1/2)$, and $\zeta(s+1)$ on $\Re s\ge R$. Thus (6) holds. The original convolutions are continuous and have exponential order at most $1/2$, as follows from Chebyshev's bound on the source and the finite local mass of $\rho_*$. Polynomial factors in that growth are harmless for every $R>1/2$.

The diagonal observation (7) is exactly the full evolved reflected readout
$$
 d_\theta(v)=\rho_*\left\{
 L_0[(T_{\theta v/2}a)*(T_{\theta v/2}a)]
 -T_{\theta v}\tau\right\}(v).
\tag{13}
$$
For each value of $v$, the time $\theta v/2$ is held fixed throughout the convolution on its right. One must not replace either convolved source by a function whose time changes with its integration variable. Formula (13) evolves the same-prime term with the correct doubled time.

## 4. A sufficient diagonal estimate and its exact off-line pole

Suppose the following estimate could be proved for arbitrarily small fixed $\theta>0$:
$$
 \boxed{\text{for every }\epsilon>0,\quad
 |d_\theta(v)|\le C_{\theta,\epsilon}e^{\epsilon v}
 \quad(v\ge0).}
\tag{14}
$$
It involves only the diagonal value at each $v$, rather than a whole-interval maximum at one common time. The exact transform (8) shows that (14) would imply RH.

To prove this implication, suppose there is an actual nontrivial zero
$\rho=1/2+\alpha+i\gamma$ with $\alpha>0$, of multiplicity $m\ge1$. Let $s_\rho=\alpha+i\gamma$. The actual transform (12) has the noncanceled double-pole coefficient
$$
 C_\rho=\frac{m^2\zeta(\rho+1/2)}{\rho(\rho+1)}\ne0
 \quad\text{at }s=s_\rho.
\tag{15}
$$
The same-prime series is holomorphic there, and $\zeta(\rho+1/2)\ne0$ by its Euler product.

Choose one of the arbitrarily small $\theta$ in (14) such that
$$
 \theta\Phi'(\alpha/2)<1,\qquad 2\lambda\theta<\alpha/2.
\tag{16}
$$
Then $q_\theta$ is holomorphic on $\Re z>\alpha/2$. The point
$$
 z_\rho=\chi_\theta(s_\rho)=s_\rho-\theta\Phi(s_\rho)
$$
satisfies $\Re z_\rho>\alpha/2$, and uniqueness in (3) gives
$q_\theta(z_\rho)=s_\rho$.
The right side of (8) consequently has the double-pole coefficient
$$
 \boxed{C_\rho[1-\theta\Phi'(s_\rho)]\ne0
       \quad\text{at }z=z_\rho.}
\tag{17}
$$
Indeed the inverse characteristic map changes a squared pole by
$[\chi_\theta'(s_\rho)]^2$, and the prefactor in (8) divides by one copy.

On the other hand, (14) makes the actual Laplace integral $\mathcal Ld_\theta$ holomorphic on $\Re z>0$. It agrees with (8) in an initial right half-plane by the proved integral identity. Meromorphic continuation on the connected half-plane $\Re z>\alpha/2$ therefore contradicts (17). This excludes every zero with real part greater than $1/2$; the actual functional equation supplies the other half.

The condition (14) remains the missing arithmetic estimate. The diagonal transform preserves a shifted, nonzero version of each off-line double pole. It does not eliminate the pole through smoothing, assume its location, or prove a sign for the full reflected product.

The construction is for the complete prime-only finite-activity process. No bounded inverse or holomorphic characteristic-map assertion for the full archimedean factor is added.

## 5. An unconditional diagonal bound and the necessary time quantifier

Chebyshev's bound gives $|a(v)|\le Ce^{v/2}$, so $|a*a(v)|\le Cv e^{v/2}$. The fixed filter $L_0$ preserves an upper envelope $C(1+v)e^{v/2}$. The complete same-prime term also obeys the coarse bound
$$
 0\le\tau(v)\le C(1+v)^2e^{v/2}.
$$
For example, bound its coefficient $(m-1)(\log p)^2$ by $\log^2(p^m)$, its nonnegative profile by one, and sum the resulting $\log^2 n/\sqrt n$ over all integers $n\le e^v$. The aggregation against $\rho_*$ then uses $\sum d^{-3/2}<\infty$. Thus the actual full readout satisfies
$$
 |w(v)|\le C(1+v)^2e^{v/2}.
\tag{18}
$$
Keeping the physical-age cutoff in the actual convolution, its diagonal satisfies
$$
 \begin{aligned}
 |d_\theta(v)|
 &\le C(1+v)^2 e^{v/2}
       \int_{[0,v]}e^{-u/2}\mu_{\theta v}(du)\\
 &\le C(1+v)^2\exp\{[1/2-\theta\Phi(1/2)]v\}.
 \end{aligned}
\tag{19}
$$
The extension of the positive integral to all ages is an inequality; no missing source ages are inserted into the defining readout.

In particular, for every $\theta\ge[2\Phi(1/2)]^{-1}$, the diagonal subexponential estimate (14) is already unconditional. A claim using only one unspecified diagonal time would therefore omit the essential small-time quantifier. The pole argument needs a sequence of fixed $\theta$ tending to zero, so that (16) can be met for any possible off-line zero. The argument and (19) concern this diagonal full-W readout; they do not determine the corresponding quantifier for the global frozen-source $L^2$ target, whose complete overflow and terminal tail are retained.

The [source-transfer theorem](../successor-and-division/short-time-source-and-W-successor-transfer.md) controls the change under the actual compensated successor with a common time on each source interval. That theorem and the literal diagonal calculation above retain different time quantifiers.
