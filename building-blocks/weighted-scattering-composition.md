# A weighted composition bound requires a commutator correction

This is a written mathematical proof, not a Lean theorem. The [semilocal foundation](semilocal-weighted-scattering.md) fixes the negative-frequency Hardy projection, trace normalization and ordinary localized trace domains. No priority claim is made for these operator calculations.


For a nonnegative weight $\chi$, define
$$
\tau_\chi(U)=\operatorname{Tr}(M_\chi|\Delta_U|),\qquad
N_\chi(U)=\|M_\chi\Delta_U\|_1,
\qquad W=M_{\sqrt\chi}.
$$
Assume the displayed localized operators are trace class, as established in the linked foundation for the smooth multipliers and Schwartz weights under consideration. For scalar unitary multipliers the cocycle gives the genuine subadditivity
$$
N_\chi(UV)\le N_\chi(U)+N_\chi(V).
\tag{27.1}
$$
Indeed $M_\chi V^*(\Delta_U)V=V^*(M_\chi\Delta_U)V$, and trace norm is unitarily invariant.

Functional calculus and positive-product traces give
$$
\boxed{
\tau_\chi(U)\le N_\chi(U)
\le\tau_\chi(U)+c_\chi(U),\qquad
c_\chi(U)=\|W[W,|\Delta_U|]\|_1.
}
\tag{27.2}
$$
For the upper bound use
$M_\chi|\Delta_U|=W|\Delta_U|W+W[W,|\Delta_U|]$.
The first term is positive with trace $\tau_\chi(U)$; both terms are trace class. Also $\|M_\chi|\Delta_U|\|_1=\|M_\chi\Delta_U\|_1$, by extending the sign of $\Delta_U$ to a unitary on its kernel. Therefore
$$
\tau_\chi(UV)\le\tau_\chi(U)+\tau_\chi(V)
+c_\chi(U)+c_\chi(V).
\tag{27.3}
$$
The correction is not removed by scalar commutation of $U,V,W$, because the absolute defect also depends on the nonlocal Hardy projection.

In fact the inequality with both corrections omitted is false within this scalar class, even with the reality symmetry of the local factors and with actual compact pole-null theta weights. Here is a constructive counterexample. Set
$$
z(t)=\frac{t-i}{t+i},\qquad
b(t)=i(z-\bar z)=\frac{4t}{1+t^2},\qquad
c(t)=-i(z^2-\bar z^2)=\frac{8t(1-t^2)}{(1+t^2)^2},
$$
$$
\chi(t)=
\begin{cases}\exp[-1/(1-16t^2)],&|t|<1/4,\\0,&|t|\ge1/4.\end{cases}
$$
Take $U=M_{e^{i\varepsilon b}}$, $V=M_{e^{i\varepsilon c}}$. Their odd real phases imply $u(-t)=\overline{u(t)}$, and similarly for $v$.

Under the unitary Cayley identification with the circle, let $A_h=-i[P,M_h]$. The actual finite-rank Hardy commutators for $b$ and $c$ have absolute-value diagonal densities $2$ and $4$, relative to $d\theta/(2\pi)$. For their sum, the two nonzero Hankel blocks are $iK$ and $-iK$, where
$$
K=\begin{pmatrix}-1&1\\1&0\end{pmatrix},\qquad
|K|=\frac1{\sqrt5}\begin{pmatrix}3&-1\\-1&2\end{pmatrix}.
$$
The combined absolute diagonal density is $(10-4\cos\theta)/\sqrt5$. On $|t|<1/4$,
$\cos\theta=(t^2-1)/(t^2+1)\le-15/17$, so its excess over $2+4$ is greater than $1/25$. Using $d\theta/(2\pi)=dt/[\pi(1+t^2)]$, the weighted excess is greater than $1/3200$.

This strict first-order excess persists at a nonzero explicit parameter. Duhamel gives, for $h=b,c,b+c$,
$$
\left\|\frac{\Delta_{e^{i\varepsilon h}}}{\varepsilon}-A_h\right\|_1
\le32\varepsilon.
$$
Each $A_h$ has rank at most four and trace norm at most eight. For $0<\varepsilon\le1/32$, operator square-root continuity bounds the modulus difference in operator norm by $24\sqrt\varepsilon$. Compress to the rank-four range of $A_h$: its trace-norm error is at most $96\sqrt\varepsilon$, the complementary positive trace is at most $128\sqrt\varepsilon$, and positivity bounds the two off-diagonal blocks together by $68\varepsilon^{1/4}$. Thus the total modulus error in trace norm is at most $300\varepsilon^{1/4}$. For $\varepsilon=10^{-40}$, the sum of the three weighted errors is at most $9\cdot10^{-8}<1/3200$. Hence
$$
\tau_\chi(UV)>\tau_\chi(U)+\tau_\chi(V).
\tag{27.4}
$$

Use the theta kernel $\Phi$ from the [theta normalization](theta-derivative-kernel-logconcavity.md). To make the weight itself admissible, let $H(t)=\sqrt{\chi(t)}/(t^2+1/4)$, take its even real inverse Fourier transform $g$, and choose even compact smooth cutoffs $g_R(x)=\eta(x/R)g(x)$ tending to $g$ in Schwartz topology. Put $f_R=(-D^2+1/4)g_R$, $h_R=f_R/\Phi$. Then $h_R$ is compact smooth even, both pole evaluations of $F_R=\widehat f_R$ vanish exactly, and $|F_R|^2\to\chi$ uniformly. The three defects in (27.4) are globally trace class by the same Duhamel argument. Their weighted traces therefore converge under this uniform approximation, so the strict failure persists for some finite $R$.

The counterexample uses explicit scalar Hardy multipliers, not the particular arithmetic local factors. It shows that their scalar nature, reality symmetry and admissible test class do not alone prove an uncorrected weighted triangle. Equations (27.1)–(27.3) preserve a usable composition mechanism, with its missing nonlocal cost stated exactly.


## The correction for an actual prime


Assume $\chi\ge0$, $W=M_{\sqrt\chi}$, and
$C_W=\|W[W,P]\|_1<\infty$.
The exact one-prime decomposition gives a quantitative bound on the correction in (27.2). Put $r=p^{-1/2}$, $L=\log p$, $Z=M_{e^{itL}}$, and $P_I=P-Z^*PZ$, corresponding physically to $I=(0,L)$. The [exact prime fibers](exact-prime-scattering-fibers.md), equation (24.2), give
$$
|\Delta_p|=r(P_I+M_\alpha P_IM_\alpha^*),\qquad
\alpha(t)=\frac{\sqrt{1-r^2}e^{itL}}{1-r e^{itL}},
\quad\|\alpha\|_\infty^2=\frac{1+r}{1-r}.
$$
Since $W$ commutes with $Z$,
$\|W[W,P_I]\|_1\le2C_W$.
It also commutes with $M_\alpha$. Consequently
$$
\boxed{c_\chi(p)\le\frac{4r}{1-r}C_W.}
\tag{28.1}
$$
No arithmetic phase or cross term has been replaced by an independence assumption.

The [exact prime densities](exact-prime-scattering-fibers.md) also give
$$
\left|\tau_\chi(p)-\frac{rL}{\pi}\int\chi\right|
\le\frac{r^2L}{\pi(1-r)}\|\chi\|_1,
\qquad
\tau_\chi(p)\ge\frac{rL}{\pi(1+r)}\int\chi.
\tag{28.2}
$$
For nonzero $\chi$, the ratio is therefore controlled by
$$
\frac{c_\chi(p)}{\tau_\chi(p)}
\le\frac{4\pi(1+r)C_W}{(1-r)L\int\chi}.
\tag{28.3}
$$
Thus the retained local commutator cost has no $\log p$ factor, while the principal one-prime trace contribution does. This is a constructive repair of the failed general weighted triangle for the actual local factors. The modulus-regularity argument below proves its trace-class hypothesis for the actual weights, including at real zeros. The all-prime signed consumer remains a separate obligation.


## Modulus regularity at real zeros


For every complex $F\in W^{2,1}(\mathbb R)$, let $w=|F|$ and $W=M_w$. Then the distributional second derivative of $w$ is a finite signed measure and
$$
\boxed{\|D^2|F|\|_{\rm TV}\le2\|F''\|_1.}
\tag{29.1}
$$
No smoothness of $|F|$ at a zero is assumed. To prove this, regularize
$w_\varepsilon=\sqrt{|F|^2+\varepsilon^2}-\varepsilon$,
$R_\varepsilon=\sqrt{|F|^2+\varepsilon^2}$.
Almost everywhere,
$$
w_\varepsilon''=
\frac{\Re(F''\overline F)}{R_\varepsilon}
+\frac{|F'|^2}{R_\varepsilon}
-\frac{\Re(F'\overline F)^2}{R_\varepsilon^3}.
$$
The last two terms together are nonnegative, so
$(w_\varepsilon'')_-\le|F''|$.
For fixed $\varepsilon$, all terms are integrable: $F'$ is bounded and integrable, hence square integrable. Also $|w_\varepsilon'|\le|F'|$, whose values tend to zero at both ends. Therefore $\int w_\varepsilon''=0$ and $\|w_\varepsilon''\|_1\le2\|F''\|_1$.
Since $0\le w_\varepsilon\le|F|$ and $w_\varepsilon\to|F|$ in $L^1$, passage in distributions proves (29.1), retaining possible cusp masses.

Define the real-line homogeneous Besov seminorm, in an equivalent difference form, by
$$
\mathcal B(w)=\int_0^\infty\frac{\|w(\cdot+2h)-2w(\cdot+h)+w\|_1}{h^2}\,dh.
$$
The measure bound gives
$\|\Delta_h^2w\|_1\le\min(h^2\|D^2w\|_{\rm TV},4\|w\|_1)$.
Splitting the integral at $H$ and optimizing yields
$$
\boxed{\mathcal B(|F|)\le4\sqrt{2\|F\|_1\|F''\|_1}.}
\tag{29.2}
$$

The precise imported operator theorem is the real-line Hilbert-transform commutator characterization in [Peller, *Besov spaces in operator theory*, Theorem 5.7 and section 2.2](https://arxiv.org/html/2402.09853v1#S5.SS3): at Schatten exponent one, the required symbol space is $B^1_1(\mathbb R)$. Its commutator norm is bounded by a fixed multiple of $\mathcal B$, with the Hardy-projection normalization absorbed into an absolute constant $C_H$. Here the symbol is bounded, hence BMO. This applies on the real line directly; no unverified Cayley-weight transformation is used. Equivalently, the norm bound follows from the characterization and closed graph on the homogeneous Besov space with its representative vanishing at infinity, which embeds continuously into $C_0$.

Consequently
$$
\|[W,P]\|_1\le C_H\mathcal B(w),\qquad
\boxed{C_W\le4\sqrt2 C_H\|F\|_\infty
\sqrt{\|F\|_1\|F''\|_1}.}
\tag{29.3}
$$
Combining with (28.1) proves
$$
c_{|F|^2}(p)\le16\sqrt2 C_H\frac{p^{-1/2}}{1-p^{-1/2}}
\|F\|_\infty\sqrt{\|F\|_1\|F''\|_1}.
\tag{29.4}
$$
This covers compact smooth physical pole-null tests and any other transforms satisfying the stated $W^{2,1}$ hypothesis. It requires neither RH nor any restriction on their real zeros. Schwartz-convergent canonical cutoffs have uniform constants in (29.3); arbitrary form convergence alone does not supply such a uniform bound. The result makes the corrected composition mechanism applicable to the actual test class and leaves its signed arithmetic use open.


The [literal second-increment criterion](successor-second-increment-trace-criterion.md) gives a separate quantitative version of the same real-line Besov input. The weighted trace $\tau_\chi$ here is distinct from the subadditive trace norm $N_\chi$ used in the [RH norm criterion](single-observation-scattering-criterion.md).
