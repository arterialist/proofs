# Successor transport preserves the critical heat Lyapunov exponent

This note connects the literal positive successor transport of the full
prime-power counting measure to the centered heat criterion. The result is
unconditional. It identifies the transported centered source exactly and
proves that its difference from the original source has finite critical
energy.

Write
$$
 P(t)=\sum_{n\ge2}\Lambda(n)e^{-nt},\qquad
 P_0(t)=(1+t^{-1})e^{-t},\qquad C(t)=P(t)-P_0(t).
\tag{1}
$$
The original logarithmic heat profile and energy are
$$
 b(v)=e^{-v/2}C(e^{-v}),\qquad
 \mathscr A(T)=1+\int_0^T|b(v)|^2\,dv.
\tag{2}
$$
Every prime power is included in P.

Let
$$
 K_n=\left(1-\frac1n\right)\delta_{n-1}
       +\mathbf1_{x\ge n-1}\frac{dx}{(x+1)^2},
\qquad
 \mu_S=\sum_{n\ge2}\Lambda(n)K_n.
\tag{3}
$$
Each $K_n$ is the full probability kernel of the literal successor. Its
cumulative function is $x/(x+1)$ on $x\ge n-1$. Define
$$
 P_S(t)=\int_{[1,\infty)}e^{-tx}\,\mu_S(dx),\qquad
 C_S(t)=P_S(t)-t^{-1}.
\tag{4}
$$
The baseline $t^{-1}$ is the Laplace transform of the transported
continuous density on the full additive half-line.

## 1. Exact Volterra formula

For $y>0$, put
$$
 E_1(y)=\int_y^\infty\frac{e^{-u}}u\,du.
$$
Stieltjes integration by parts against the cumulative function of $K_n$
gives
$$
\widehat K_n(t)
=t\int_{n-1}^\infty e^{-tx}\frac{x}{x+1}\,dx
=e^{-t(n-1)}-te^tE_1(nt).
\tag{5}
$$
All terms are nonnegative before the final algebra, so Tonelli justifies
summing them. Since
$$
\sum_{n\ge2}\Lambda(n)E_1(nt)
=\int_t^\infty\frac{P(u)}u\,du,
$$
we obtain
$$
\boxed{
P_S(t)=e^t\left[P(t)-t\int_t^\infty\frac{P(u)}u\,du\right].
}
\tag{6}
$$

The chosen original baseline has the exact primitive
$$
t\int_t^\infty\frac{P_0(u)}u\,du=e^{-t},
\tag{7}
$$
because
$$
\frac{P_0(u)}u=e^{-u}(u^{-1}+u^{-2})
=-\frac d{du}\left(\frac{e^{-u}}u\right).
$$
Substitution into (6) yields the centered identity
$$
\boxed{
C_S(t)=e^t\left[
C(t)-t\int_t^\infty\frac{C(u)}u\,du
\right].
}
\tag{8}
$$
This is an amplitude identity, before squaring the additive heat source.
It retains the lower endpoint and the complete continuous tail of every
$K_n$.

## 2. The critical profiles differ by an $L^2$ function

Set
$$
b_S(v)=e^{-v/2}C_S(e^{-v}).
\tag{9}
$$
Changing $u=e^{-w}$ in (8) gives the exact logarithmic formula
$$
\boxed{
b_S(v)=e^{e^{-v}}\left[
b(v)-e^{-3v/2}\int_{-\infty}^v e^{w/2}b(w)\,dw
\right].
}
\tag{10}
$$

The difference in (10) has finite critical energy:
$$
\boxed{b_S-b\in L^2((0,\infty),dv).}
\tag{11}
$$
Here is a direct unconditional proof. The elementary estimate
$\Lambda(n)\le\log n$ gives
$$
P(t)=O(t^{-1}\log(2/t)),\qquad 0<t\le1,
$$
and hence
$$
|b(v)|\le C e^{v/2}(1+v),\qquad v\ge0.
\tag{12}
$$
For $w<0$, exponential heat decay makes
$$
K_-:=\int_{-\infty}^0 e^{w/2}|b(w)|\,dw
=\int_1^\infty\frac{|C(u)|}{u}\,du<\infty.
\tag{13}
$$
Equations (12)--(13) imply
$$
\left|e^{-3v/2}\int_{-\infty}^v e^{w/2}b(w)\,dw\right|
\le C e^{-v/2}(1+v).
\tag{14}
$$
Also $e^{e^{-v}}-1=O(e^{-v})$, so
$$
|(e^{e^{-v}}-1)b(v)|
\le C e^{-v/2}(1+v).
\tag{15}
$$
Together, (10), (14), and (15) prove (11). No PNT or RH estimate is used.

The compensated successor from the original source construction has
$$
\mu_C=\mu_S-\kappa\delta_1.
$$
Define
$$
C_C(t)=\int e^{-tx}\,\mu_C(dx)-t^{-1},\qquad
b_C(v)=e^{-v/2}C_C(e^{-v}).
$$
Then
$$
b_C(v)=b_S(v)-\kappa e^{-v/2}e^{-e^{-v}},
\tag{16}
$$
and therefore
$$
\boxed{b_C-b\in L^2(0,\infty).}
\tag{17}
$$
The signed compensating atom and its exact location remain visible.

## 3. Exact transfer of the RH growth criterion

For $\bullet=S,C$, put
$$
\mathscr A_\bullet(T)=1+\int_0^T|b_\bullet(v)|^2\,dv.
\tag{18}
$$
If $K_\bullet=\|b_\bullet-b\|_{L^2(0,\infty)}$, the triangle inequality
gives, uniformly for $T\ge0$,
$$
\boxed{
M_\bullet^{-1}\mathscr A(T)
\le\mathscr A_\bullet(T)
\le M_\bullet\mathscr A(T),\qquad
M_\bullet=2(1+K_\bullet^2).
}
\tag{19}
$$
The same constant works in both directions after interchanging the two
profiles.

It follows immediately that all three upper Lyapunov exponents agree:
$$
\boxed{
\limsup_{T\to\infty}\frac{\log\mathscr A_S(T)}T
=\limsup_{T\to\infty}\frac{\log\mathscr A_C(T)}T
=\limsup_{T\to\infty}\frac{\log\mathscr A(T)}T.
}
\tag{20}
$$
The established heat criterion therefore gives
$$
\boxed{
\mathrm{RH}
\quad\Longleftrightarrow\quad
\limsup_{T\to\infty}\frac{\log\mathscr A_S(T)}T=0
\quad\Longleftrightarrow\quad
\limsup_{T\to\infty}\frac{\log\mathscr A_C(T)}T=0.
}
\tag{21}
$$

The polynomial doubling formulation is also unchanged. For either
transported energy,
$$
\exists A,K,T_0>0\ \forall T\ge T_0:
\mathscr A_\bullet(2T)\le AT^K\mathscr A_\bullet(T)
\tag{22}
$$
holds if and only if the corresponding statement holds for
$\mathscr A$. This follows from the two fixed comparison constants in
(19). Hence (22) is equivalent to RH by the original heat theorem.

Pointwise, $C_S(t)^2$ is the centered additive-pair heat source of the
positive transported measure:
$$
C_S(t)^2=
\int e^{-tX}\,d(\mu_S*\mu_S)(X)
-2t^{-1}\int e^{-tx}\,\mu_S(dx)+t^{-2}.
\tag{23}
$$
Thus (20) is an exact additive-to-multiplicative critical-energy transfer,
not a signed continuation of a Goldbach Dirichlet series.

## 4. Scope

The successor changes the critical profile only by finite energy. This
explains, at the source level, why its cumulative Goldbach leakage has the
same critical order as the centered pair term but does not move the
Lyapunov exponent. The result transfers any unconditional doubling estimate
between the original and successor sources. It does not provide that
estimate.

In particular, positivity of $\mu_S$ does not imply a useful sign for the
centered square in (23) after expanding its cross terms. The unresolved
problem is still a uniform scale bound for one of the equivalent positive
energies in (18).

## Dependencies and formal scope

The probability kernels are those of the [literal successor counting transport](goldbach-literal-successor-counting-transport.md). The [critical heat theorem](critical-heat-lyapunov-exponent.md) supplies the RH equivalence, and the [centered additive heat identity](centered-goldbach-heat-lyapunov.md) supplies its Goldbach interpretation. Stieltjes integration by parts, Tonelli and the $L^2$ triangle inequality are classical tools. The exact amplitude transport and finite-energy comparison proved here remain written mathematics; the existing endpoint and compensation algebra in [GoldbachSuccessorTransfer.lean](BuildingBlocks/GoldbachSuccessorTransfer.lean) does not formalize these analytic statements.
