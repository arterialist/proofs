# Exact one-prime positive and negative contributions

This is a written mathematical proof, not a Lean theorem. The [semilocal foundation](semilocal-weighted-scattering.md) fixes the negative-frequency Hardy projection, trace normalization and ordinary localized trace domains. No priority claim is made for these operator calculations.


The actual local factor itself admits a complete calculation. Fix a prime $p$, put $r=p^{-1/2}$, $L=\log p$, and set
$$
u_p(t)=\frac{1-r e^{itL}}{1-r e^{-itL}},\qquad
\Delta_p=P-M_{u_p}^*PM_{u_p}.
$$
Use the Hardy kernel fixed in the linked foundation. This is the pure-prime factor; the archimedean factor is not included in this calculation.

Under the unitary transform $g(x)=(2\pi)^{-1/2}\int e^{itx}f(t)\,dt$, $P$ becomes $1_{x>0}$. Decompose $x=y+nL$, $0<y<L$, $n\in\mathbb Z$. This gives a direct integral over $L^2(0,L)$ of copies of $\ell^2(\mathbb Z)$, with no extra normalization factor. Let $(Sa)_n=a_{n+1}$. On each fiber,
$$
P=1_{n\ge0},\qquad U_p=(I-rS)(I-rS^*)^{-1}
=-rS+(1-r^2)\sum_{j\ge0}r^j(S^*)^j.
\tag{24.1}
$$
This convergent geometric series retains the full repeated-prime history.

The corner $C_p=PU_p(1-P)$ has entries
$(C_p)_{nm}=(1-r^2)r^{n-m}$ for $n\ge0,m\le-1$.
With normalized vectors
$$
a_+(n)=\sqrt{1-r^2}\,r^n\ (n\ge0),\qquad
v_-(-k)=\sqrt{1-r^2}\,r^{k-1}\ (k\ge1),
$$
one has $C_p=r|a_+\rangle\langle v_-|$. Thus the corner has the single singular value $r$ per fiber. On the nonzero defect space $\operatorname{span}\{e_0,v_-\}$,
$$
\Delta_p=
\begin{pmatrix}r^2&-r\sqrt{1-r^2}\\-r\sqrt{1-r^2}&-r^2\end{pmatrix},
\qquad
|\Delta_p|=r(|e_0\rangle\langle e_0|+|v_-\rangle\langle v_-|).
\tag{24.2}
$$
Its nonzero eigenvalues are $\pm r$. Globally these have the continuous multiplicity space $L^2(0,L)$; neither this corner nor these defect parts is compact. This does not contradict the compact negative part after the archimedean factor is included.

Writing $z=e^{itL}$, normalized eigenvectors produce the amplitudes
$$
g_+(t)=\sqrt{\frac{1+r}{2}}\frac{1-z}{1-rz},\qquad
g_-(t)=\sqrt{\frac{1-r}{2}}\frac{1+z}{1-rz}.
$$
The maps
$$
J_\pm a(t)=\frac{g_\pm(t)}{\sqrt{2\pi}}
\int_0^L e^{-ity}a(y)\,dy
$$
are isometries from $L^2(0,L)$, and $(\Delta_p)_\pm=rJ_\pm J_\pm^*$. Consequently their localized trace densities are
$$
\boxed{
d_{p,\pm}(t)=\frac{L}{4\pi}
\left[r(1+P_r(tL))\pm(1-P_r(tL))\right],
\qquad P_r(\theta)=\frac{1-r^2}{1-2r\cos\theta+r^2}.
}
\tag{24.3}
$$
For a nonnegative Schwartz weight $\chi$,
$\operatorname{Tr}(M_\chi(\Delta_p)_\pm)=\int\chi(t)d_{p,\pm}(t)\,dt$.
One direct verification uses the positive sandwich
$M_{\sqrt\chi}(\Delta_p)_\pm M_{\sqrt\chi}$: the corresponding $M_{\sqrt\chi}J_\pm$ is Hilbert–Schmidt, with squared norm $L/(2\pi)\int\chi|g_\pm|^2$. The unsandwiched ordinary trace agrees; its trace-class property follows from the same divided-difference argument as in the [semilocal foundation](semilocal-weighted-scattering.md), which also applies to this smooth bounded pure-prime multiplier.

Nonnegativity is explicit in
$$
d_{p,+}(t)=\frac{rL(1+r)}{2\pi}
\frac{1-\cos(tL)}{1-2r\cos(tL)+r^2},\qquad
d_{p,-}(t)=\frac{rL(1-r)}{2\pi}
\frac{1+\cos(tL)}{1-2r\cos(tL)+r^2}.
\tag{24.4}
$$
Both have periodic mean $rL/(2\pi)$, while their signed difference is the exact local logarithmic derivative
$$
d_{p,+}(t)-d_{p,-}(t)
=\frac{L}{2\pi}(1-P_r(tL))
=-\frac1\pi\sum_{k\ge1}\frac{\log p}{p^{k/2}}\cos(tk\log p).
\tag{24.5}
$$
The positive and negative contributions select different phases of the same complete prime-power factor.

For two unitary factors the exact cocycle is
$$
P-(UV)^*P(UV)=(P-V^*PV)+V^*(P-U^*PU)V.
\tag{24.6}
$$
For multiplication factors and Schwartz weights, cyclicity of the justified trace makes the signed weighted traces add. Their canonical positive and negative spectral parts do not follow an additive rule. Squaring (24.6) retains both products between its two selfadjoint summands; ignoring them would change the arithmetic multiplier's defect. The [mixed-moment calculation](two-prime-mixed-scattering.md) treats this interaction for the first two distinct primes.
