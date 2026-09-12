# Positive successor potential and the complete two-port curvature readout

This written proof fixes an actual natural cutoff $N\ge2$ and a finite admitted prime set. It retains positive potentials, both original prime ports, the full midpoint increments and the metric contact terms. The subsequent [fixed-source all-prime proof](all-prime-fixed-source-drift-curvature.md) and [uniform correction theorem](full-prime-successor-potential-midpoint.md) justify their separate limiting passages. No sign of the full curvature pairing follows.

## 1. Actual source, two ports and domains

Use the unitary critical coordinate map $U:L^2((0,\infty),dx)\to L^2(\mathbb R,dv)$,
$$
(Uf)(v)=e^{v/2}f(e^v),\qquad
 g_N(x)=1_{x\ge1}\frac{\psi(\min(x,N))-\min(x,N)}x,
 \quad a_N=Ug_N.
$$
Let $C=S-a_0\delta$ be the actual compensated causal successor, and put
$$
P_N(v)=\int_{-\infty}^v(C-I)a_N(u)du.
$$
The [natural-source primitive theorem](natural-cutoff-successor-primitive.md) gives $P_N(v)>0$ for $v>0$, $P_N=0$ for $v\le0$, and exponential decay. In particular $P_N\in H^1(\mathbb R)$, with distributional derivative
$$
P_N'=Ca_N-a_N.                                           \tag{1}
$$
There is no atom in this first derivative because $P_N(0)=0$. This does not authorize deleting atoms in higher derivatives.

Retain the complete prime seed
$$
B_S(v)=\sum_{p\in S}e^{v/2}p^{-\lfloor v/\log p\rfloor-1}
                   1_{v\ge\log p},\quad K_Sf=B_S*f,
 \quad H=\tfrac12-\partial_v,\quad A_S=HK_S.
$$
For finite $S$, $B_S$ is nonnegative and belongs to $L^1\cap BV$, including every proper power. Consequently $K_S$ and $K_S^*$ are bounded on $L^2$. The combined multiplier $A_S$ is bounded as well, or directly its kernel is the finite signed measure $B_S\,dv/2-dB_S$. The adjoint is the original physical $L^2$ adjoint,
$$
A_S^*=K_S^*H^*,\qquad H^*=\tfrac12+\partial_v.
$$
Define the actual signed causal and anticausal columns
$$
y_+=-A_Sa_N,\quad y_-=-A_S^*a_N,
 \quad y_+^C=-A_SCa_N,\quad y_-^C=-A_S^*Ca_N,
 \quad r_+=K_SP_N,\quad r_-=K_S^*P_N.                     \tag{2}
$$
Both $r_+$ and $r_-$ are nonnegative almost everywhere. They belong to $H^2$: convolution preserves $H^1$, while their second derivatives are convolutions of the finite measures $dB_S$ or its reflection with $P_N'\in L^2$. All four $y$ columns belong to $L^2$. The anticausal potential $r_-$ is retained on the entire real age axis; its negative-age part is not projected away.

Commutation of constant-coefficient differentiation with convolution, using (1), proves
$$
\boxed{\begin{aligned}
 y_+^C-y_+&=(\partial_v^2-\tfrac12\partial_v)r_+,\\
 y_-^C-y_-&=-(\partial_v^2+\tfrac12\partial_v)r_-.
\end{aligned}}                                          \tag{3}
$$
These are $L^2$ identities and distributional identities. They describe opposite drift-diffusion potentials for the actual two ports. Each potential is nonnegative because the actual successor primitive is nonnegative. No positivity of the original signed prime operator is asserted.

## 2. The original metric and exact quadratic changes

On the original additive coordinate use
$$
\mathcal E(f)=\langle f,\mathcal Lf\rangle,
 \qquad \mathcal Lf=4f-\mathsf K*f,\qquad
 \mathsf K(z)=\min(1,|z|^{-2}),
$$
with $f$ extended by zero to the negative half-line. Put $\widehat L=U\mathcal L U^{-1}$, a bounded self-adjoint operator. Its exact kernel is
$$
(\widehat Lf)(v)=4f(v)-\int_{\mathbb R}G(v,w)f(w)dw,
 \qquad G(v,w)=e^{(v+w)/2}\mathsf K(e^v-e^w).             \tag{4}
$$
In particular the diagonal $4I$ and the interface $|e^v-e^w|=1$ remain.

For real functions write $B_E(f,g)=\langle f,\widehat Lg\rangle$ in age coordinates. The exact anticausal square difference, including its full quadratic increment, is
$$
\boxed{B_E(y_-^C,y_-^C)-B_E(y_-,y_-)
=-\left\langle r_-,(\partial_v^2-\tfrac12\partial_v)
                     \widehat L(y_-^C+y_-)\right\rangle.} \tag{5}
$$
The right pairing is $H^2$ against $H^{-2}$, equivalently the $L^2$ pairing of $(D^2+D/2)r_-$ with the displayed force. It need not be an ordinary integral against a pointwise curvature function. Equation (3), self-adjointness, and integration by parts prove (5) without a boundary truncation.

For the complete mixed term put $m_+=(y_+^C+y_+)/2$ and $m_-=(y_-^C+y_-)/2$. Polarization gives
$$
\boxed{\begin{aligned}
 B_E(y_+^C,y_-^C)-B_E(y_+,y_-)
={}&\left\langle r_+,(\partial_v^2+\tfrac12\partial_v)
                         \widehat Lm_-\right\rangle\\
 &-\left\langle r_-,(\partial_v^2-\tfrac12\partial_v)
                         \widehat Lm_+\right\rangle.
\end{aligned}}                                           \tag{6}
$$
Indeed $B_E(\Delta y_+,m_-)+B_E(m_+,\Delta y_-)$ is the entire difference, not merely its linearization. Its two halves of $B_E(\Delta y_+,\Delta y_-)$ add to the required complete quadratic term. Equations (5)--(6) apply directly to the actual finite-source, finite-prime columns (2).

If $(D^2-D/2)\widehat L(y_-^C+y_-)$ were a nonnegative measure with a finite $r_-$ integral, (5) would give an energy decrease. The [actual cutoff-2 calculation](actual-finite-history-curvature-domains.md) disproves this measure hypothesis. Positivity of $r_-$ alone leaves the distributional pairing unsigned.

## 3. Exact metric derivatives expose the ordinary successor again

The curvature in (5)--(6) cannot be evaluated by commuting $\widehat L$ through differentiation. Its first two commutators have explicit bounded kernels. Write $d=e^v-e^w$ and
$$
G_{<}(v,w)=G(v,w)1_{|d|<1},\quad
 G_{>}(v,w)=G(v,w)1_{|d|>1}.
$$
Define the integral operators
$$
J=-G_<+G_>,\qquad
 T_1(v,w)=e^{(v+w)/2}\{\delta(d-1)+\delta(d+1)\},
 \qquad J_2=-G+2T_1.                                    \tag{7}
$$
Here $T_1$ is a distributional kernel, not a pointwise function. Direct differentiation in the common scale direction gives
$$
\boxed{[\partial_v,\widehat L]=J,\qquad
       [\partial_v,J]=J_2.}                            \tag{8}
$$
For the first identity, integration by parts in $w$ shows that the commutator kernel is $-(\partial_v+\partial_w)G$. Away from $|d|=1$ this is $-G$ inside and $+G$ outside. There is no interface atom at this first step because the original kernel is continuous. For the second identity the piecewise kernel $J$ jumps by $2G$ at $|d|=1$, producing exactly $2T_1$. Away from that interface its derivative is $-G$ on both sides. This proves (8) with all contact distributions retained.

The operators in (7) are bounded. Under the unitary coordinate map, $G_<$ and $G_>$ are compressions of convolution with the kernels $\mathbf1_{|x|<1}$ and $|x|^{-2}\mathbf1_{|x|>1}$, each of $L^1$ norm $2$. $T_1$ is the compression of the sum of additive translations by +1 and -1, and has norm at most 2. Thus (8) extends from smooth compact inputs in the graph sense.

Its literal action in physical age is
$$
\begin{aligned}
(T_1f)(v)={}&\sqrt{\frac{e^v}{e^v+1}}
 f(\log(e^v+1))\\
&+1_{e^v>1}\sqrt{\frac{e^v}{e^v-1}}
 f(\log(e^v-1)).
\end{aligned}                                           \tag{9}
$$
These are the ordinary successor and predecessor with their exact critical Jacobians. The first term is not silently restricted to $v\ge0$. Compressing it to the original causal source gives the usual causal successor and a separate initial strip. The negative-age anticausal column in (2) therefore requires the full version (9).

For $\epsilon\in\{-1,1\}$, (8) gives the exact curvature decomposition
$$
\boxed{(\partial^2+\tfrac\epsilon2\partial)\widehat L
=\widehat L(\partial^2+\tfrac\epsilon2\partial)
 +2J\partial+J_2+\tfrac\epsilon2J.}                    \tag{10}
$$
The identity holds first on $H^2$ and then as a distribution identity on the $L^2$ forces used in (5)--(6). Thus even when a whole-column expression is only distributional, its interface part is explicitly the retained successor/predecessor operator. No contact term is inferred to be positive after pairing with a signed actual force.

As a normalization check, let $L_{\rm short}=2I-G_<$ be the short-additive-increment energy operator. Then
$$
J+\widehat L=2L_{\rm short}.
$$
This is the same original-metric scale identity underlying the positive short-increment restoration law. It has now entered the actual two-port successor comparison through (10), rather than through a different Hilbert metric.

## 4. The discriminating arithmetic question

Equations (3), (5), (6), and (10) supply a finite-source comparison that uses the proved positive successor primitive. They preserve both ports, original metric, all admitted proper powers, contact distributions and quadratic terms. The remaining question is the sign or a usable quantitative bound for these actual weighted drift curvatures. Generic operator positivity, the nonnegative potentials alone, or the signed inverse identity $\mu*\eta=\delta_0$ do not settle it.

A complete original W comparison would additionally retain its reflected bilinear readout, same-prime subtraction and initial source terms. The present identities do not replace W by an anticausal Hermitian square. Likewise $Ca_N$ and $a_N$ have the same retained source-zero data in the completed limit; this one-step comparison does not remove that data. The [all-prime fixed-source proof](all-prime-fixed-source-drift-curvature.md) supplies the separate convergence estimate, while the [uniform correction theorem](full-prime-successor-potential-midpoint.md) controls the successor increment as the source cutoff grows. Neither conclusion signs the midpoint forces.


## 5. Contact completion and the actual obstruction

The [fixed-source companion](all-prime-fixed-source-drift-curvature.md) proves the exact contact identity and its continuous original-energy extension. The [uniform correction proof](full-prime-successor-potential-midpoint.md) retains the maximal original multiplier domains and joint source/prime convergence. The [finite-history curvature calculation](actual-finite-history-curvature-domains.md) proves that the literal prime-2, cutoff-2 force contains a nonzero derivative of a Dirac mass. Its integrated pairing is defined, but that curvature is not a positive measure.

The construction uses classical distributional convolution, Young's inequality and midpoint polarization. The explicit common-scale metric derivative supplies the ordinary successor contact. These are written operator identities; no literature-priority claim or full Weil sign is asserted.
