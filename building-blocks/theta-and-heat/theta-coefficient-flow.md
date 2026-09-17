# A coefficient constraint for descending theta heat flow

Written mathematics with a passing FLINT/Arb certificate and exact symbolic checks. The finite statements below have been independently reviewed. No Lean or all-degree zero-reality theorem is asserted.

The simple sign hypothesis fails on actual coefficients: the normalized quadratic Jensen discriminant increases with heat time, including throughout the certified interval below. A neighboring-defect comparison repairs this to a useful one-sided Grönwall inequality. A cubic discriminant has a natural reciprocal-defect normalization whose derivative has the favorable sign under two further local constraints. Full-tail ball calculations verify these constraints for every time in $[0,1/2]$ and shifts $0\le n\le8$. Their extension to arbitrary shifts and degrees remains unproved. The evolution of the repair itself exposes a fourth-cumulant term.

## 1. Actual coefficients and unconditional moment identities

Retain exactly the kernel and convention of [the actual theta heat construction](theta-heat-collision.md):

$$
\Phi(u)=\sum_{m=1}^{\infty}
 (2\pi^2m^4e^{9u}-3\pi m^2e^{5u})e^{-\pi m^2e^{4u}},
\qquad
H_t(z)=\int_0^\infty e^{tu^2}\Phi(u)\cos(zu)\,du.
\tag{C1}
$$

Here $\Phi$ is the actual positive even modular theta kernel, with all lattice terms retained. It decays superexponentially, $\partial_tH=-H_{zz}$, and
$H_0(z)=\xi(1/2+iz/2)/8$. Thus increasing $t$ is the backward heat direction. These conventions are the ones in the [Rodgers–Tao defining integral](https://arxiv.org/abs/1801.05914); the preceding report derives the normalization from the arithmetic theta series.

Write

$$
\mu_n(t)=\int_0^\infty u^{2n}e^{tu^2}\Phi(u)\,du,
\qquad
\gamma_n(t)=\frac{n!}{(2n)!}\mu_n(t)>0.
$$

Termwise integration on compact parameter sets gives

$$
H_t(i\sqrt z)=\sum_{n\ge0}\gamma_n(t)\frac{z^n}{n!},
\qquad \mu_n'=\mu_{n+1},\qquad
\gamma_n'=(4n+2)\gamma_{n+1}.
\tag{C2}
$$

The first expression is entire and independent of the choice of square root because the original cosine is even. The factorial normalization is essential for the last identity.
Indeed, differentiating the moment gives
$\gamma_n'=\frac{n!}{(2n)!}\frac{(2n+2)!}{(n+1)!}\gamma_{n+1}=(4n+2)\gamma_{n+1}$.

Set

$$
r_n=\frac{\gamma_{n+1}}{\gamma_n},\qquad
\delta_n=1-\frac{\gamma_n\gamma_{n+2}}{\gamma_{n+1}^2}
=1-\frac{r_{n+1}}{r_n}.
\tag{C3}
$$

The degree-two Jensen polynomial is
$\gamma_n+2\gamma_{n+1}X+\gamma_{n+2}X^2$, with discriminant
$4\gamma_{n+1}^2\delta_n$. Thus $\delta_n$ is a scale-invariant normalized discriminant. Its sign is not supplied by positivity of $\mu_n$ alone.

For clarity about what the moment structure does supply, put $a=4n+2$, $\alpha=n+1/2$, and use the probability measure proportional to

$$
x^{n-1/2}e^{tx}\Phi(\sqrt x)\,dx,\qquad x>0.
$$

Let its mean, variance, and third cumulant be $m,V,\kappa_3$. Then

$$
m=\frac{\mu_{n+1}}{\mu_n}=a r_n,
\qquad r_n'=\frac V a>0,
\qquad
\delta_n=\frac{1-\alpha V/m^2}{\alpha+1}.
\tag{C4}
$$

In particular, for every real time,

$$
\delta_n<\frac1{\alpha+1}=\frac2{2n+3},
\tag{C5}
$$

strictly, since the actual probability measure has positive variance. This is an upper bound, not a proof of $\delta_n>0$. The unconditional increase of $r_n$ will make the eventual Grönwall bound explicit.

## 2. The quadratic evolution and the first failed sign

Define the two minors

$$
T_n=\gamma_{n+1}^2-\gamma_n\gamma_{n+2},\qquad
U_n=\gamma_{n+1}\gamma_{n+2}-\gamma_n\gamma_{n+3}.
$$

Direct use of C2 gives

$$
T_n'=(4n+10)U_n,
\qquad
U_n=\frac{\gamma_{n+2}T_n+\gamma_nT_{n+1}}{\gamma_{n+1}}.
\tag{C6}
$$

Thus the raw quadratic minors form a cooperative evolution in increasing time. At a hypothetical boundary $T_n=0<T_{n+1}$, their vector field points into positivity when time increases and out of it when time decreases. That boundary observation alone is not an actual negative-coefficient example.

After normalizing, the exact equation is

$$
\boxed{\quad
\delta_n'=r_n(1-\delta_n)
\{(4n+10)(1-\delta_n)\delta_{n+1}-(4n+2)\delta_n\}.
\quad}
\tag{C7}
$$

The mixed term has the next normalized discriminant, with a positive coefficient in increasing time. The original candidate $\delta_n'\le0$, which would directly favor descent, is false for the actual kernel.

For an explicit derivation of C7, $q_n=1-\delta_n=r_{n+1}/r_n$ satisfies
$q_n'/q_n=(4n+10)r_{n+2}-2(4n+6)r_{n+1}+(4n+2)r_n$.
Substitute $r_{n+1}=r_n(1-\delta_n)$ and
$r_{n+2}=r_n(1-\delta_n)(1-\delta_{n+1})$, and use $\delta_n'=-q_n'$.

At $t=0,n=0$, the certified values are

$$
\delta_0=0.06963238060969086949\ldots,
\qquad
\delta_0'=0.00220345071274499217\ldots>0.
\tag{C8}
$$

The derivative is certified positive throughout $0\le t\le1/2$, for all nine shifts tested below. This is a discriminating calculation with C1, not an example from another positive kernel.

### A one-sided repair

Test the more precise neighboring-defect hypothesis

$$
0<\delta_{n+1}\le\delta_n<1.
\tag{C9}
$$

Substitution in C7 gives

$$
\begin{split}
\delta_n'
&\le r_n(1-\delta_n)\delta_n\{8-(4n+10)\delta_n\}\\
&\le8r_n\delta_n.
\end{split}
\tag{C10}
$$

This is usable in decreasing time. If C9 holds on a positive interval $[t,T]$, integration gives

$$
\delta_n(t)\ge\delta_n(T)
\exp\left(-8\int_t^T r_n(s)\,ds\right)
\ge\delta_n(T)e^{-8(T-t)r_n(T)}.
\tag{C11}
$$

The second inequality uses C4. For each fixed $n$, $r_n$ is finite and continuous on compact time intervals because the actual moments are finite and positive. Here is the nonvanishing argument explicitly. Start with independently known $\delta_n(T)>0$, and work only on its connected positive component ending at $T$. Assume the comparison $\delta_{n+1}\le\delta_n$ is independently controlled on that component. The lower inequality $\delta_{n+1}>0$ in C9 is not needed for the upper estimate C10. C11 bounds $\delta_n$ away from zero as one approaches any finite left endpoint, contradicting a first zero there. The division by $\delta_n$ in the logarithmic integration is thus justified on the component before concluding its extension. It is not necessary to assume $\delta_n'\le0$.

C9 is not a consequence derived here from moment positivity. Its appearance is a concrete extra condition, and C7 does not automatically preserve it in decreasing time. The full-interval calculation below verifies it in a finite shift range.

## 3. A cubic discriminant and its next mixed term

The next Jensen polynomial is

$$
J_{n,3}(X)=\gamma_n+3\gamma_{n+1}X+3\gamma_{n+2}X^2+\gamma_{n+3}X^3.
$$

Its discriminant is exactly

$$
\operatorname{Disc}(J_{n,3})=27D_n,
\qquad D_n=4T_nT_{n+1}-U_n^2.
\tag{C12}
$$

This is the first nontrivial higher-minor repair of C6. With
$V_n=\gamma_{n+2}^2-\gamma_n\gamma_{n+4}$, differentiation gives

$$
U_n'=(4n+14)V_n-8T_{n+1},
$$

$$
D_n'=2(4n+14)
\{2U_nT_{n+1}+2T_nU_{n+1}-U_nV_n\}.
\tag{C13}
$$

The new term $-U_nV_n$ retains $\gamma_{n+4}$, with its actual arithmetic value. The coefficient of $\gamma_{n+4}$ after expansion is

$$
2(4n+14)
\{-2\gamma_{n+1}^3+3\gamma_n\gamma_{n+1}\gamma_{n+2}-\gamma_n^2\gamma_{n+3}\}.
\tag{C14}
$$

It does not vanish identically. Thus the raw cubic discriminant does not evolve as a function of its four defining coefficients alone. C13 contains a difference of products, rather than a sum with one sign.

## 4. A reciprocal-defect normalization that survives the test

Where $\delta_n,\delta_{n+1}>0$, put

$$
\lambda_n=\frac1{\delta_n},\qquad s_n=\lambda_{n+1}-\lambda_n,
\qquad
\Omega_n=2(\lambda_n+\lambda_{n+1})-1-s_n^2.
\tag{C15}
$$

This normalization follows directly from the cubic discriminant. Set
$d=\delta_n,e=\delta_{n+1},q=1-d$ and rescale $X$ by $r_n$. Then

$$
\gamma_n^{-1}J_{n,3}(X)=1+3y+3q y^2+q^2(1-e)y^3,
\qquad y=r_nX.
$$

The ordinary cubic discriminant formula for this polynomial gives

$$
\frac{\operatorname{Disc}(J_{n,3})}
 {27\gamma_n^4r_n^6q^2}
=4de-(d+e-de)^2=d^2e^2\Omega_n.
\tag{C16}
$$

Every divisor used here is positive in the stated region. The transformation changes the size, not the sign, of the cubic discriminant. It is determined by neighboring dimensionless defects; it does not insert an arbitrary time-dependent factor.

Define

$$
v_n=-\lambda_n'=\frac{\delta_n'}{\delta_n^2}.
$$

C7 supplies its value from the actual coefficients. Differentiating C15 gives the exact identity

$$
\Omega_n'=2\{-(1+s_n)v_n+(s_n-1)v_{n+1}\}.
\tag{C17}
$$

Here is a specific sufficient hypothesis to test:

$$
1\le s_n\le3,\qquad 0<v_n,\qquad v_{n+1}\le2v_n.
\tag{C18}
$$

It implies

$$
\Omega_n'\le2(s_n-3)v_n\le0.
\tag{C19}
$$

Thus $\Omega_n(t)\ge\Omega_n(T)$ when descending through an interval where C18 holds. This argument requires $\delta_n,\delta_{n+1}>0$ independently throughout that interval, for example from the separate quadratic barrier, before forming reciprocals. It does not use cubic positivity to assume these denominators stay nonzero. There is also a static consequence. By C5, positivity of $\delta_n$ gives $\lambda_n>n+3/2$. Under $1\le s_n\le3$,

$$
\Omega_n=4\lambda_n+2s_n-1-s_n^2>4n+2>0.
\tag{C20}
$$

C18 therefore has meaningful content beyond merely asserting a positive cubic discriminant. It bounds a discrete slope and the ratio of two reciprocal-defect decay rates. These are the quantities tested in the calculation.

### Why this has not closed the whole evolution

The extra constraints have their own evolution. First,

$$
s_n'=v_n-v_{n+1}.
\tag{C21}
$$

The actual certificate below proves $v_{n+1}>v_n$ in its finite range. Hence $s_n$ increases when time decreases, consuming part of the upper margin $3-s_n$. C18 alone does not prevent that margin from reaching zero elsewhere.

The rate $v_n$ also exposes a higher cumulant. With the probability measure in C4 and its fourth cumulant $\kappa_4$, exponential tilting gives $m'=V$, $V'=\kappa_3$, and $\kappa_3'=\kappa_4$. Consequently,

$$
\delta_n'=\frac\alpha{\alpha+1}\frac{2V^2-m\kappa_3}{m^3},
\tag{C22}
$$

$$
\delta_n''=\frac\alpha{\alpha+1}
\left(\frac{6V\kappa_3}{m^3}-\frac{6V^3}{m^4}-\frac{\kappa_4}{m^2}\right),
$$

$$
v_n'=\frac{\delta_n''}{\delta_n^2}
-\frac{2(\delta_n')^2}{\delta_n^3}.
\tag{C23}
$$

The exact surviving term is
$-\alpha\kappa_4/((\alpha+1)m^2\delta_n^2)$, together with the displayed mixed variance/skewness terms. A fourth cumulant is not a nonnegative fourth central moment. Controlling the derivative of $v_{n+1}/v_n$ requires its next shifted version and thus coefficients through $\gamma_{n+5}$. No arithmetic inequality bounding these terms uniformly has been derived here.

This is a specific cumulant repair attempt, not a claim that ordinary moment positivity closes the hierarchy. C9 and C18 are plausible sufficient constraints, proved in the bounded region below and still unproved globally.

## 5. Certified finite region for the actual coefficients

The certificate proves the following statements simultaneously for every real $t\in[0,1/2]$ and every integer $n\in\{0,\ldots,8\}$:

$$
\begin{gathered}
0<\delta_{n+1}<\delta_n<1,
\qquad 0<\delta_n'<8r_n\delta_n,\\
1<s_n<3,
\qquad 0<v_n<v_{n+1}<2v_n,\\
\Omega_n>0,\qquad\Omega_n'<0.
\end{gathered}
\tag{C24}
$$

It therefore verifies the descending bounds C11 and C19 throughout this finite shift range. These checks retain the full arithmetic series using explicit error bounds. They are not point samples extrapolated across time.

The boundary data at $T=1/2$ are independently available from the endpoint moment integrals, with no descent or zero-reality premise. For $0\le n\le8$, those balls give $\delta_n(T)>0.0305$, $\delta_{n+1}(T)>0.0287$, and $\Omega_n(T)>54.07$. The program separately evaluates and checks positivity of the quadratic discriminant $4T_n(T)$ and the cubic discriminant $27D_n(T)$ directly from the endpoint $\gamma$'s, retaining their enclosing balls. Thus both the quadratic start and the cubic start are independently positive. For the finite certificate, nonvanishing of the required adjacent defects on the whole interval is also checked directly by C24; it is not inferred by dividing through a potentially vanishing defect.

Some certified endpoint values, abbreviated here, are

| $(t,n)$ | $\delta_n$ | $\delta_n'/(r_n\delta_n)$ | $\Omega_n$ | $\Omega_n'$ |
|---|---:|---:|---:|---:|
| $(0,0)$ | 0.06963238060969 | 5.478305475217 | 54.95846477978 | -1.767316944582 |
| $(1/2,0)$ | 0.07074565815721 | 5.448716536344 | 54.07969080756 | -1.747784950608 |
| $(1/2,8)$ | 0.03056568934179 | 4.110400084706 | 129.6145089634 | -2.117718309811 |

The certificate computes full enclosing balls. Across every certified time cell and shift, conservative strict margins include

$$
\begin{gathered}
\delta_n>0.0303,\quad \delta_n-\delta_{n+1}>0.00182,
\quad \delta_n'>0.00049,\\
3-s_n>0.422,\quad v_{n+1}/v_n-1>0.0051,
\quad 2-v_{n+1}/v_n>0.964,\\
\Omega_n>54.07,\qquad -\Omega_n'>1.746.
\end{gathered}
\tag{C25}
$$

The margins are rounded down from the saved interval lower bounds. None is asserted beyond C24's finite region.

### Entire arithmetic tail and integration tail

The computation uses `python-flint` 0.9.0 at 100 decimal digits, or 336 bits, and the documented [Arb complex integration routine](https://python-flint.readthedocs.io/en/latest/acb.html#flint.acb.integral). The finite integrands are entire, so its analytic callback flag needs no branch-cut handling.

Retain $1\le m\le8$ and integrate on $[0,U]$, with $U=3/2$. The following bound covers all times $0\le t\le1$, which is wider than the certified interval. Since $u^2\le e^{4u}/16$ for $u\ge0$, put $c=\pi-1/16>0$. Then

$$
e^{tu^2}\Phi_m(u)
\le2\pi^2m^4e^{9u-cm^2e^{4u}}
\le2\pi^2m^4e^{-cm^2}e^{-(4cm^2-9)u}.
\tag{C26}
$$

The simple inequality used here follows from $e^{2u}\ge1+2u+2u^2>4u$. For the moment of order $k$, the entire omitted arithmetic sum is at most

$$
E_k^{\mathrm{arith}}
=\frac{4\pi^2\,9^4\,k!\,e^{-81c}}{(324c-9)^{k+1}}.
\tag{C27}
$$

Indeed, integrate C26 times $u^k$, bound its denominator at $m=9$, and use the geometric tail bound for $m^4e^{-cm^2}$. Consecutive terms have ratio at most $(10/9)^4e^{-19c}<1/2$.

For each retained lattice term, write $u=U+w$ and use $e^{4u}\ge e^{4U}(1+4w)$. The omitted integration tail is at most

$$
E_k^{\mathrm{int}}
=\sum_{m=1}^8 2\pi^2m^4e^{9U-cm^2e^{4U}}
\sum_{j=0}^k\binom kj
\frac{U^{k-j}j!}{(4cm^2e^{4U}-9)^{j+1}}.
\tag{C28}
$$

These are finite positive expressions evaluated with balls. The certificate adds an error ball of radius $E_k^{\mathrm{arith}}+E_k^{\mathrm{int}}$ to every finite moment integral. For the moment indices used here, $0\le n\le23$ and $k=2n$, the saved bounds range from approximately $1.266\times10^{-106}$ at $k=0$ to $1.180\times10^{-186}$ at $k=46$. The program uses each individual bound, not those decimal summaries.

Finite integration is split into twelve intervals of length $1/8$, with requested absolute tolerance $10^{-85}$ and relative tolerance $10^{-80}$. The returned enclosures, not the requested tolerances, are carried into all later calculations.

### A Taylor enclosure covers every time, not just the endpoints

The program computes full-tail balls for $\mu_j(0)$ and $\mu_j(1/2)$, for $0\le j\le23$. For $0\le t\le T=1/2$, positive moments and $\mu_j'=\mu_{j+1}$ give

$$
\mu_n(t)=\sum_{j=0}^{10}\frac{\mu_{n+j}(0)}{j!}t^j+R_n(t),
\qquad
0\le R_n(t)\le\frac{T^{11}}{11!}\mu_{n+11}(T).
\tag{C29}
$$

This is Taylor's theorem with an increasing positive derivative. It applies to every moment needed for C24. Interval Horner evaluation of the polynomial on a time interval, enlarged by the C29 remainder ball, encloses the actual moment for every time in that interval.

Starting from $[0,1/2]$, the program bisects any cell where an interval sign comparison is inconclusive. The final calculation accepts 32,768 cells, with maximum bisection depth 15. They cover the interval exactly; in this run all cells have length $2^{-16}$. Each accepted cell checks every strict inequality in C24 for every listed shift. The calculation retains conservative lower bounds for the margins over all accepted cells. The interval subdivision proves no assertion outside this time/shift rectangle.

The numerical certificate relies on the correctness of FLINT/Arb and these written tail and Taylor arguments. It is not a Lean theorem. The independent calculation checked the same full time interval using direct Taylor sums and alternate derivative formulas.

## Reproduction

The [complete arithmetic certificate](../../certificates/theta_coefficient_flow.py) runs with `python-flint==0.9.0`. The [exact algebra checks](../../certificates/theta_coefficient_flow_symbolic.py) run with `sympy==1.14.0`. Both pass. The certificates derive the full-tail enclosures and retain every strict assertion; they require no saved numerical data or private dependency directory. Their analytic inputs are proved above. This is computer-assisted written mathematics using FLINT/Arb.

## Decision and the exact remaining obligation

The construction yields two useful conditional estimates and a finite actual verification, rather than an all-degree preservation theorem. C8 refutes simple favorable monotonicity of the normalized quadratic discriminant. C9 repairs it to the descending Grönwall estimate C11. C18 gives a higher-degree repair with the favorable cubic estimate C19. The actual coefficient certificate verifies both repairs throughout the stated nonnegative-time interval for nine shifts.

The next mathematical obligation is to establish the neighboring comparison C9 and suitable controls of C18 for the actual theta moments for arbitrary $n$, without relying on bounded numerical interpolation. The cumulant formula C23 identifies what must be controlled to keep that proposed constraint set valid. The certified increase of $s_n$ in decreasing time shows why simply postulating that the constraints preserve themselves would be a mistake.

Even proving C9 and C18 for all shifts would address only degrees two and three. A full route would need constraints for arbitrary Jensen degree, including every additional mixed minor introduced by differentiation, and a justified descent through the whole interval to zero. The quantifiers must cover every degree and shift; any finite-approximation approach must control the resulting limits, and any Grönwall coefficients must remain integrable on the required time interval. No assertion about reality of all zeros, no all-degree hyperbolicity result, and no RH conclusion follows from C24.
