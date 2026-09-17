# Lost--retained prime arrivals under boundary displacement

This note consumes [theta ground physical mass concentration](theta-ground-physical-mass-concentration.md) and [theta ground symmetric prime displacement](theta-ground-symmetric-prime-displacement.md). It proves a fixed-core estimate for the actual signed arrival difference, then separates it from what the proved concentration and relative logarithmic energy can imply uniformly as the core grows.

Let $g=\Phi\psi1_{(R,\infty)}$, extended by zero, and define
$$
\mathcal D_R(t)=\int_R^{R+t}g(w)
 \sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 [g(\log n-w)-g(\log n-w+2t)]\,dw.
\tag{1}
$$
This is exactly the signed prime term appearing with factor four in the boundary identity (18) of the symmetric-displacement source. The two arguments retain the actual lost and retained supports. All prime powers are included.

## A fixed-core bound for the actual ground

Fix a sufficiently small $t_0>0$. Boundedness of the actual ground and the theta tail give the finite constant
$$
M_{R,t_0}=P_\infty\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 \sup_{\substack{R\le w\le R+t_0\\0\le s\le2t_0}}
 \Phi(\log n-w+s)\,1_{\{\log n-w+s>R\}}<\infty.
\tag{2}
$$
For large $n$, the supremum is bounded by a polynomial in $n$ times $\exp(-c_{R,t_0}n^2)$. The finitely many remaining terms cause no problem. Thus both complete arrival rows in (1) lie between zero and $M_{R,t_0}$.

The established actual boundary estimate
$g(R+y)\le C_R/\sqrt{\log(a_R/y)}$
therefore gives
$$
\boxed{\quad
|\mathcal D_R(t)|
 \le M_{R,t_0}\int_R^{R+t}g(w)\,dw
 \le \frac{C_RM_{R,t_0}\,t}{\sqrt{\log(a_R/t)}},
\quad 0<t<\min(t_0,a_R/e).
\quad}
\tag{3}
$$
The factor is $M_{R,t_0}$, since the difference of two numbers in $[0,M_{R,t_0}]$ has magnitude at most $M_{R,t_0}$.

This estimate is unconditional for each fixed actual ground. It is stronger than an $O_R(t)$ estimate for the prime part alone. It provides no sign, and its constants are not uniform after division by
$$
G_-^2=\left(\int_R^\infty e^{u/2}g(u)\,du\right)^2.
$$
The next result shows why the proved concentration and relative logarithmic-energy inputs cannot alone supply that uniform normalized control.

## A prime-grid obstruction with all those concentration inputs

Choose a fixed real, nonnegative, even
$\chi\in C_c^\infty(-1,1)$ with $\|\chi\|_2=1$, and put
$\chi_h(u)=h^{-1/2}\chi(u/h)$.
Let $q=2^j$ tend to infinity, so this construction uses genuine prime powers with $\Lambda(q)=\log2$. Set
$$
t=q^{-2},\qquad h=t/100,\qquad
R=\tfrac12\log q-2t,\qquad a=R+t/2,
$$
$$
b_+=\log q-a=R+7t/2,\qquad
b_-=\log q-a+2t=R+11t/2.
$$
Define two positive-half profiles
$$
g_\pm(u)=A_\pm[\chi_h(u-a)+\chi_h(u-b_\pm)],
\tag{4}
$$
and reflect them evenly to the full exterior. Choose $A_\pm>0$ so that the corresponding theta potentials
$\psi_\pm=(g_\pm+g_\pm^\vee)/\Phi$ have $L^2(\nu)$-norm one.

These profiles have the following properties.

Their support is contained in $R<|u|<R+6t$. Thus both the normalized ground-type probability $\psi_\pm^2\nu$ and the physical probability proportional to $g_\pm+g_\pm^\vee$ have zero mass outside that strip. Since
$t=q^{-2}\ll e^{-\sqrt R/8}$, they satisfy the stated shrinking concentration estimate, including every fixed exponential tail weight.

They are smooth, nonnegative, even after reflection, and admissible in the actual theta form. They vanish in a neighborhood of the hard boundary, so they also satisfy the stated boundary upper estimate with a finite constant. No discontinuous point sampling is used.

Their relative logarithmic Fourier energy obeys
$$
\frac{\|g_\pm+g_\pm^\vee\|_{\mathcal H}^2}
     {\|g_\pm+g_\pm^\vee\|_2^2}
 \le C_\chi[1+\log(1/h)]=O(\log q)=O(R).
\tag{5}
$$
To prove (5), scale the Fourier transform of each bump, use
$\log(2+|\eta|/h)\le\log(1/h)+\log(2+|\eta|)$, and bound the square of the four-bump sum by four times the sum of its squares. Their supports are disjoint, so the denominator is exactly $4A_\pm^2$. Consequently these profiles satisfy the actual relative bound $Ce^R$ with room to spare. They also satisfy the physical mass lower bound of the concentration source: their $L^1/L^2$ ratio is a fixed multiple of $\sqrt h$, much larger than $\exp(-Ce^R)$.

Normalization does not introduce a hidden sharp theta-weight variation. The actual weight $J=b/\Phi$ satisfies
$|(\log J)'|\le Cq$ on the support strip for large $q$. Hence
$$
J(u)/J(R)=1+O(qt)=1+O(q^{-1})
$$
uniformly there.

Nevertheless their complete signed prime differences are opposite:
$$
\boxed{\qquad
\mathcal D_R(t;g_+)=
 \frac{\Lambda(q)}{\sqrt q}A_+^2>0,\qquad
\mathcal D_R(t;g_-)=
 -\frac{\Lambda(q)}{\sqrt q}A_-^2<0.
\qquad}
\tag{6}
$$
Here is the exact support check. The lost strip contains only the bump centered at $a$. For $g_+$, the undisplaced argument at $n=q$ meets the other bump because $\log q-a=b_+$. The displaced argument is shifted by $2t$, so it misses both supports. For $g_-$, only the displaced argument meets the second bump.

Every possible contributing logarithm, including a lost-bump self interaction, lies within $6t$ of $\log q$. For sufficiently large $q$,
$$
6t<\tfrac12\min\{\log(q+1)-\log q,\ \log q-\log(q-1)\}.
$$
Thus the only integer index which could contribute is $q$. The self interaction would require $\log n$ within $2h$ of $\log q-3t$ or $\log q-5t$, and hence also vanishes. At the one retained interaction, evenness of $\chi$ makes its integral exactly $\|\chi_h\|_2^2=1$, proving (6). All other prime powers have been retained in the sum and eliminated by support, not discarded.

The same parameters also make the lost--lost collar prime-free:
$(2R-2t,2R)=(\log q-6t,\log q-4t)$
contains no logarithm of an integer. Thus this obstruction does not rely on a lost--lost prime edge.

Let $I_h=\int e^{hz/2}\chi(z)\,dz$. The exact positive-half weighted mass is
$$
G_{-,\pm}=A_\pm\sqrt h\,I_h
             (e^{a/2}+e^{b_\pm/2}).
$$
Dividing (6) by its square gives
$$
\boxed{\quad
\frac{\mathcal D_R(t;g_\pm)}{G_{-,\pm}^2}
=\pm\frac{\Lambda(q)}
 {\sqrt q\,h\,I_h^2(e^{a/2}+e^{b_\pm/2})^2}
\sim\pm\frac{\Lambda(q)}{4qh(\int\chi)^2}
=\pm\frac{25q\log2}{(\int\chi)^2}.
\quad}
\tag{7}
$$
Thus the normalized difference grows in magnitude even though the displacement tends to zero and the shell is narrower than the proved concentration scale.

Strict positivity almost everywhere, if desired as an additional comparison input, does not remove the example. Add to each profile an arbitrarily small positive smooth theta-decaying tail, with a boundary-flat factor, then renormalize. For each fixed $q$, the complete arrival functional is continuous under this particular tail perturbation by its uniform theta envelope. The coefficient can be chosen to preserve the strict sign and half the magnitude in (7), the relative energy estimate, and the stated weighted concentration bounds. This step asserts no eigenfunction property.

## What the obstruction does and does not establish

The profiles in (4) are not claimed to solve the killed ground equation or to have its minimizing Rayleigh value. The actual ground equation is precisely the additional input absent from the concentration and logarithmic-energy hypotheses isolated here. The sharp crossing estimates are properties of the actual kernels and remain true; they do not prohibit these test profiles.

Equations (6)--(7) prove that positivity, normalized and physical concentration on the stated shrinking shell, admissibility, boundary upper regularity with unspecified fixed-core constant, and the proved relative logarithmic-energy budget do not determine the sign of the lost--retained prime difference. They do not give a normalized $o(1)$ bound on it either. The sampling scale $h\asymp q^{-2}$ costs only $O(\log q)$ relative logarithmic energy, well below the available $O(\sqrt q)$ budget.

For the actual ground the fixed-core bound (3) remains valid. A uniform favorable sign in the symmetric boundary identity still requires a further use of the ground equation that controls the profile against this integer prime-power grid. Replacing the sampled profile by its density, or applying the concentration theorem only to fixed exponential test functions, does not supply that estimate.


## Attribution and formal scope

This is written mathematics, with no Lean formalization of the displayed domain, transport or sampling estimates. Fourier scaling and bump localization are classical. The counterprofiles use the actual prime-power grid but are not asserted to be ground eigenfunctions. No RH conclusion or passing full affine comparison is asserted.
