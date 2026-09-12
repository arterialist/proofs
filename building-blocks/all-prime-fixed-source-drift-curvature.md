# All-prime completion of the actual two-port drift-curvature identity

This proves the infinite-prime passage left open in the [finite-prime potential construction](positive-primitive-two-port-drift-curvature.md), for each fixed natural source
cutoff $N\ge2$. It also identifies the metric contact term as the difference
between the original mixed energy and twice the unit-step energy. There is
no uniform-in-$N$ assertion and no sign claim for the resulting full
curvature pairing.

## 1. A measure-convolution domain for both original prime ports

All functions in this section are on the entire real age axis. Let
$$
B_P=\sum_{p\le P}B_p,\qquad B=\sum_pB_p,\qquad
 B_p(v)=e^{v/2}p^{-\lfloor v/\log p\rfloor-1}
                  1_{v\ge\log p}.
 \tag{1}
$$
The [completed seed theorem](positive-successor-seed-jump-process.md) gives $B\ge0$, $B\in L^2$, and
$$
\epsilon_P:=\|B-B_P\|_2\longrightarrow0,\qquad
 \epsilon_P=O((\log P)^{-1/2}).
 \tag{2}
$$
Every proper power remains in (1). Let $\check B(v)=B(-v)$.
For a real $f\in L^1(\mathbb R)\cap BV(\mathbb R)$, its whole-line
distributional derivative $Df$ is a finite signed measure. Define
$$
\mu_\pm(f)=\tfrac12 f(v)\,dv\ \pm Df,\qquad
 M(f)=\tfrac12\|f\|_1+|Df|(\mathbb R).
 \tag{3}
$$
Young's inequality for a finite measure and an $L^2$ function gives
$$
\|B*\mu_\pm(f)\|_2\le \|B\|_2 M(f).
 \tag{4}
$$
For finite $P$, the original operators are
$$
K_P=B_P*,\quad A_P=(\tfrac12-D)K_P,\quad
 A_P^*=K_P^*(\tfrac12+D).
$$
Distributional convolution, first on compact smooth tests, proves
$$
A_P f=B_P*\mu_-(f),\qquad
 A_P^*f=\check B_P*\mu_+(f).
 \tag{5}
$$
Both are $L^2$ identities. In particular, their all-prime limits exist
in the original physical $L^2$ coordinate under the unitary critical map:
$$
A_\infty f=B*\mu_-(f),\qquad
 A_\infty^\dagger f=\check B*\mu_+(f),
 \tag{6}
$$
$$
\|A_Pf-A_\infty f\|_2+
 \|A_P^*f-A_\infty^\dagger f\|_2
 \le 2\epsilon_P M(f).
 \tag{7}
$$
The dagger denotes this limit of the original adjoint ports, not a claim
that an everywhere bounded $L^2$ operator $A_\infty$ exists. For
$f,g\in L^1\cap BV\cap L^2$, passage from the finite-prime identities gives
$\langle A_\infty f,g\rangle=\langle f,A_\infty^\dagger g\rangle$.
Thus the original adjoint pairing is retained on this common domain.
This domain contains the compactly supported smooth functions and is
dense in $L^2$. Therefore $A_\infty$, regarded as an operator on
this domain, is closable; the common domain lies in its Hilbert
adjoint domain and the adjoint equals $A_\infty^\dagger$ there.
No larger maximal domain is identified by this argument.

## 2. The actual fixed natural sources satisfy the domain

Set $E_N=\psi(N)-N$, and use the literal natural source
$$
a_N(v)=e^{-v/2}
 [\psi(\min(e^v,N))-\min(e^v,N)]1_{v\ge0}.
 \tag{8}
$$
This is the critical lift of the original physical source with its
frozen numerator. It has finitely many prime-power jumps, the initial
jump $-1$, smooth pieces on the remaining finite cells, and tail
$E_Ne^{-v/2}$. Hence $a_N\in L^1\cap BV\cap L^2$.

For $x=e^v\ge1$, let
$$
(Sa_N)(v)=\sqrt{\frac{x}{x+1}}a_N(\log(x+1)),\qquad
 b_N=Ca_N=Sa_N-\kappa_N a_0,\quad
 a_0(v)=e^{-v/2}1_{v\ge0}.
 \tag{9}
$$
The function $b_N$ has finitely many shifted prime-power jumps and
the retained initial value. On the terminal interval $x+1\ge N$,
$$
b_N(v)=E_N\frac{\sqrt x}{x+1}-\kappa_Nx^{-1/2}.
 \tag{10}
$$
This tail and its classical derivative are absolutely integrable.
The other cells are bounded smooth intervals with finitely many finite
jumps. Thus $b_N\in L^1\cap BV\cap L^2$, including all whole-line
endpoint atoms in its distributional derivative.

Put $d_N=b_N-a_N=P_N'$. The [natural-source primitive theorem](natural-cutoff-successor-primitive.md)
supplies $P_N(0)=0$, $P_N>0$ on $(0,\infty)$, and an exponentially
decaying tail; in particular $P_N\in L^1\cap L^2$.
The preceding domain facts give
$$
d_N\in L^1\cap BV\cap L^2,\qquad
 DP_N=d_N\,dv,\qquad D^2P_N=Dd_N
 \text{ is a finite signed measure}.
 \tag{11}
$$
There is no atom in $DP_N$. There generally is an initial atom and
there are shifted prime-power atoms in $D^2P_N$, all retained in
the finite measure $Dd_N$.

## 3. Positive potentials converge in $H^2$

Define the full causal and anticausal potentials
$$
r_+=B*P_N,\qquad r_-=\check B*P_N.
 \tag{12}
$$
Young's inequality applied to $P_N\,dv,d_N\,dv,Dd_N$ proves
$$
D^j r_\pm\in L^2,\quad 0\le j\le2,\qquad r_\pm\in H^2(\mathbb R).
 \tag{13}
$$
Here the first derivative uses $B*d_N$ or $\check B*d_N$, and the
second uses $B*Dd_N$ or $\check B*Dd_N$; differentiation has been
placed on the actual finite-source potential, without demanding finite
total variation of the infinite-prime seed.

Moreover $r_\pm\ge0$ almost everywhere, by $B,P_N\ge0$.
The anticausal potential remains on the entire real axis. If
$r_{\pm,P}$ are defined with $B_P$, then, for the sum of the
three derivative norms,
$$
\sum_{j=0}^2\|D^j(r_{\pm,P}-r_\pm)\|_2
 \le\epsilon_P
 [\|P_N\|_1+\|d_N\|_1+|Dd_N|(\mathbb R)].
 \tag{14}
$$
Thus convergence is in $H^2$, with a finite constant depending
on the fixed actual $N$.

Let
$$
y_+=-A_\infty a_N,\quad y_+^C=-A_\infty b_N,\qquad
 y_-=-A_\infty^\dagger a_N,\quad
 y_-^C=-A_\infty^\dagger b_N .
 \tag{15}
$$
All are $L^2$ by (6), and are the limits of the complete finite-prime
ports by (7). The exact drift identities therefore hold in $L^2$:
$$
y_+^C-y_+=(D^2-\tfrac12D)r_+,\qquad
 y_-^C-y_-=-(D^2+\tfrac12D)r_-.
 \tag{16}
$$
They follow either from (6), (11), and (12), or by the $H^2/L^2$
limits of the finite-prime identities.

## 4. The full original-metric comparisons pass to the limit

For physical functions extended by zero to the negative half-line,
$$
\mathcal E(f)=\int_0^1\|\Delta_hf\|_2^2\,dh+
              \int_1^\infty\|\Delta_hf\|_2^2\,\frac{dh}{h^2}.
 \tag{17}
$$
Its bounded positive operator on $L^2(0,\infty)$ is the compression
of $L=4I-\mathsf K*$, with $\mathsf K(x)=\min(1,|x|^{-2})$.
The norm is at most $8$. Let $\widehat L=ULU^{-1}$ under
$(Uf)(v)=e^{v/2}f(e^v)$, and write
$\mathcal B_E(u,z)=\langle u,\widehat Lz\rangle$.
Let $m_\pm=(y_\pm^C+y_\pm)/2$.

Self-adjointness, (16), and distributional integration by parts give
the exact all-prime anticausal square comparison
$$
\mathcal B_E(y_-^C,y_-^C)-\mathcal B_E(y_-,y_-)
 =-\langle r_-,(D^2-\tfrac12D)\widehat L(y_-^C+y_-)\rangle,
 \tag{18}
$$
and the complete mixed comparison
$$
\begin{split}
 \mathcal B_E(y_+^C,y_-^C)-\mathcal B_E(y_+,y_-)
 ={}&\langle r_+,(D^2+\tfrac12D)\widehat Lm_-\rangle\\
 &-\langle r_-,(D^2-\tfrac12D)\widehat Lm_+\rangle .
 \end{split}
 \tag{19}
$$
The right sides mean $H^2,H^{-2}$ pairings, equivalently the
corresponding $L^2,L^2$ pairings after moving derivatives onto
$r_\pm$. Both converge from finite $P$, since $r_{\pm,P}\to r_\pm$
in $H^2$, all forces converge in $L^2$, and $\widehat L$ is
bounded. The midpoint forces keep the entire quadratic increment,
not only a linearization. These facts settle the all-prime passage
in the finite-prime identities for each fixed $N$.

## 5. The contact curvature is an exact unit-step energy defect

The [original metric calculation](positive-primitive-two-port-drift-curvature.md#3-exact-metric-derivatives-expose-the-ordinary-successor-again) gives
$$
[D,\widehat L]=J,\qquad [D,J]=J_2=-G+2T_1,\qquad
 \widehat L=4I-G.
 \tag{20}
$$
Here $T_1$ is the sum of the physical successor and predecessor,
with their critical Jacobians and the full negative-age source
domain retained. Under $U$, the compressed operator
$2I-T_1$ is exactly the quadratic-form operator
$\Delta_1^*\Delta_1$ for the zero-extended physical function.
Indeed translations on the full line give
$$
\|\Delta_1f\|_2^2=2\|f\|_2^2-
  \langle f,(T_++T_-)f\rangle .
 \tag{21}
$$
Consequently, for $u=Uf$, $z=Ug$, the metric contact term is
exactly
$$
\boxed{\langle u,J_2z\rangle
 =\mathcal B_E(u,z)-2\langle\Delta_1f,\Delta_1g\rangle.}
 \tag{22}
$$
No sign of (22) is assumed. It compares the original average over
all additive increments with twice the unit increment singled out
by the ordinary successor.

These contact forms extend continuously to the original energy
completion, even when the physical functions cease to be $L^2$.
For $0<h<1$, the translation identity
$\Delta_1=\Delta_h+T_h\Delta_{1-h}$ gives
$$
\|\Delta_1f\|_2^2
 \le 2\|\Delta_hf\|_2^2+2\|\Delta_{1-h}f\|_2^2.
$$
Integration in $h$ yields
$$
\|\Delta_1f\|_2^2\le4\mathcal E_{\rm short}(f)
 \le4\mathcal E(f).
 \tag{23}
$$
Thus the bilinear form in (22) has the explicit bound
$$
|\langle u,J_2z\rangle|
 \le9\sqrt{\mathcal E(f)\mathcal E(g)}.
 \tag{24}
$$
Likewise $J+\widehat L=2\widehat L_{\rm short}$ gives the
continuous form $2\mathcal B_{\rm short}-\mathcal B_E$.
This extension concerns these bounded metric forms, not the
unbounded derivative pieces in (18)--(19) on arbitrary energy inputs.

The resulting all-prime fixed-source curvature identity remains
$$
(D^2+\tfrac{\varepsilon}2D)\widehat L
 =\widehat L(D^2+\tfrac{\varepsilon}2D)
  +2JD+J_2+\tfrac{\varepsilon}2J,\qquad \varepsilon=\pm1.
 \tag{25}
$$
The bounded commutators in (20), first proved on a smooth core, imply
$\widehat L:H^2\to H^2$ and $J:H^1\to H^1$. The first assertion
follows by applying the first commutator twice, using the second;
the second follows directly from $[D,J]=J_2$.
The self-adjoint kernels give the corresponding dual extensions to
$H^{-2}$ and $H^{-1}$. Thus each separated term on the right of
(25) has a defined Sobolev distributional meaning on the actual
$L^2$ midpoint forces, without assuming those forces themselves
belong to $H^2$.
Equations (18)--(25) now have a justified all-prime consumer on
the actual natural source. A signed estimate for their full
midpoint pairings remains unproved. The separate [uniform correction theorem](full-prime-successor-potential-midpoint.md) proves convergence of the successor increment; it does not assert convergence of the individual midpoint columns. The reflected W readout and its same-prime subtraction
have not been exchanged for these Hermitian energy expressions.


This is a short fixed-source application of classical convolution with finite derivative measures. It preserves that proof separately from the block-variation method needed for uniform source-cutoff control. The positive potential and the contact identity impose no sign on the full energy change.


## Formalized energy and contact forms

Three Lean modules formalize the energy estimates and physical kernel expansion used here. Their namespace is `BuildingBlocks.MixedEnergy`. The target builds and axiom checks passed; the checked theorems use only `propext`, `Classical.choice` and `Quot.sound`.

For measurable real $H$, with extended nonnegative energy allowed, [MixedEnergySuccessorStep](BuildingBlocks/MixedEnergySuccessorStep.lean) proves `unit_step_le_shortEnergy` and `unit_step_le_energy`:

$$
\int_{\mathbb R}|H(x)-H(x-1)|^2dx
\le4\mathcal E_{\rm short}(H)\le4\mathcal E(H).
$$

Its theorem `unit_step_memLp` gives the literal unit increment in $L^2$ when the energy is finite. Neither causality nor unweighted $H\in L^2$ is assumed.

[MixedEnergyBilinear](BuildingBlocks/MixedEnergyBilinear.lean) defines the measure

$$
d\lambda(h)=\mathbf1_{(0,1)}dh+\mathbf1_{(1,\infty)}\frac{dh}{h^2},
\qquad \lambda(\mathbb R)=2,
$$

and proves `energy_eq_gradient` for the literal gradient $H(x)-H(x-h)$ on $d\lambda(h)dx$. Its `bilinear_bound`, `unitPair_bound` and `contactForm_bound` prove the constants $1$, $4$ and $9$ in the corresponding Cauchy–Schwarz estimates. The formal contact form is exactly $\mathcal B_E-2\langle\Delta_1H,\Delta_1G\rangle$ on measurable finite-energy inputs.

[MixedEnergyKernel](BuildingBlocks/MixedEnergyKernel.lean) proves `bilinear_eq_symmetricKernelPair` and `contactForm_eq_kernel` for real unweighted $L^2$ inputs. The symmetric lag pairing is the literal integral of $H(x)[G(x-h)+G(x+h)]$ against $d\lambda(h)dx$. Thus the factor $4$ and the successor/predecessor kernel expansion are proved, including all integrability prerequisites. `energy_lt_top_of_memLp` gives finite mixed energy for measurable $L^2$ inputs.

The logarithmic conjugation, its distributional commutators, the actual prime-column limits and the identification of this kernel form with $J_2$ remain the written operator proofs above. The modules do not formalize a signed curvature inequality or an RH conclusion.
