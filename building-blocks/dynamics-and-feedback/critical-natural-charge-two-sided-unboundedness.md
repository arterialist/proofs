# Two-sided unboundedness of the actual critical natural charge

Written proof. Conditional conclusions retain their stated RH hypotheses; none proves an unconditional RH-scale bound. Classical explicit-formula, zero-counting, Fourier and operator tools are attributed below and in the linked dependencies.

For the natural, right-continuous cutoff, put
$$
 M(x)=\sum_{n\le x}\frac{\Lambda(n)}{\sqrt n}-2\sqrt x+1
 \qquad(x\ge1).
 \tag{1}
$$
The sum includes every prime power. In particular, $M(1)=-1$.

**Theorem.** Unconditionally,
$$
 \limsup_{x\to\infty}M(x)=+\infty,\qquad
 \liminf_{x\to\infty}M(x)=-\infty.
 \tag{2}
$$
Both statements remain true when $x$ is restricted to integers. Neither RH nor linear independence of zero ordinates is a hypothesis. The proof gives no effective relation between the height of a large charge and its magnitude.

The mechanism has two parts. An eventual one-sided bound would force RH by positivity of a Laplace transform. Under RH, positive smoothing with compact Fourier support isolates a finite sine polynomial. This polynomial has large values of both signs at two short, opposite times, and simultaneous recurrence moves those same configurations arbitrarily far to the right.

## 1. The exact seeded transform

Write
$$
 m(v)=
 \begin{cases}M(e^v),&v\ge0,\\0,&v<0.\end{cases}
$$
The actual signed innovation on $[1,\infty)$ is
$$
 d\nu(t)=-\delta_1(dt)+\sum_{n\ge2}\Lambda(n)\delta_n(dt)
              -\mathbf1_{(1,\infty)}(t)\,dt,
 \qquad
 M(x)=\int_{[1,x]}t^{-1/2}\,d\nu(t).
 \tag{3}
$$
For $\Re z>1/2$, absolute convergence and Fubini give
$$
 \mathcal M(z):=\int_0^\infty e^{-zv}m(v)\,dv
 =\frac1z\left[
 -1-\frac{\zeta'}{\zeta}(z+\tfrac12)
       -\frac1{z-\tfrac12}\right].
 \tag{4}
$$
For example, each atom at $n$ contributes
$\Lambda(n)n^{-1/2}\int_{\log n}^{\infty}e^{-zv}\,dv
=\Lambda(n)n^{-z-1/2}/z$.
The initial atom is responsible for the $-1/z$ term in (4).

The apparent singularity at $z=1/2$ cancels, because
$-\zeta'/\zeta(s)=1/(s-1)+O(1)$ at $s=1$.
There are no real zeta zeros with $s>1/2$: on $0<s<1$,
the alternating eta series is positive and
$\zeta(s)=\eta(s)/(1-2^{1-s})<0$, while $\zeta(s)>0$ for $s>1$.
Consequently (4) is holomorphic near every positive real $z$.

If $\rho$ is a nontrivial zero of multiplicity $m_\rho$ and
$\Re\rho>1/2$, then $z_\rho=\rho-1/2\ne0$ is a genuine pole of (4), with residue
$$
 \operatorname{Res}_{z=z_\rho}\mathcal M(z)
       =-\frac{m_\rho}{z_\rho}.
 \tag{5}
$$
No assumption about simplicity or a rightmost zero is being made.

## 2. Why either eventual one-sided bound would imply RH

We use the following elementary Laplace-abscissa fact.

**Lemma.** Let $h\ge0$ be locally integrable on $[0,\infty)$, with a finite real abscissa of convergence $\sigma_c$ for its Laplace integral. The Laplace transform cannot be holomorphic in a neighborhood of the real point $\sigma_c$.

**Proof.** Suppose it were holomorphic in a disk about $\sigma_c$, as well as on $\Re z>\sigma_c$. For sufficiently small $\delta>0$, their union contains the disk of radius $2\delta$ about $\sigma_1=\sigma_c+\delta$. At $\sigma_1$, differentiation under the integral is valid and
$$
 H(\sigma_1-u)
 =\sum_{j\ge0}\frac{u^j}{j!}
       \int_0^\infty v^j e^{-\sigma_1v}h(v)\,dv
 \qquad(0\le u<2\delta).
$$
Choose $\delta<u<2\delta$. The analytic Taylor series converges, and every term on the right is nonnegative. Tonelli identifies its sum with
$\int_0^\infty e^{-(\sigma_1-u)v}h(v)\,dv<\infty$,
contradicting $\sigma_1-u<\sigma_c$. $\square$

Suppose, for example, that $m(v)\le B$ for $v\ge v_0$, and set
$h(v)=(B-m(v))\mathbf1_{[v_0,\infty)}(v)\ge0$.
Its transform agrees initially with
$$
 \frac{B e^{-v_0z}}z-\mathcal M(z)
          +\int_0^{v_0}e^{-zv}m(v)\,dv.
 \tag{6}
$$
An elementary bound $|m(v)|\ll(1+v)e^{v/2}$ ensures convergence for real $z>1/2$.
If RH fails, symmetry supplies a zero $\rho$ with $\Re\rho>1/2$.
The pole (5), which is not canceled by the other terms in (6), forces
$\sigma_c\ge\Re\rho-1/2>0$: otherwise the Laplace integral would be holomorphic at that pole, contradicting meromorphic uniqueness.
Thus $\sigma_c$ is finite and positive.
But (6) is holomorphic near every positive real point, contradicting the lemma.

The same proof with
$h(v)=(m(v)-B)\mathbf1_{[v_0,\infty)}(v)$
handles an eventual lower bound. Therefore
$$
 \text{either eventual one-sided bound for }m
       \quad\Longrightarrow\quad \mathrm{RH}.
 \tag{7}
$$
This implication alone does not prove (2); we next rule out both bounds under RH.

## 3. A rigorous finite-frequency formula under RH

Assume RH in this section. The standard consequence
$\psi(x)-x=O(\sqrt x\log^2(2x))$, followed by Abel summation in (3), gives
$$
 m(v)=O((1+v)^3)\qquad(v\ge0).
 \tag{8}
$$
Only polynomial growth is needed. It can also be obtained directly, with power $2$, from the weighted explicit formula stated in the source discussion below.
Thus the causal function $m$ is a tempered distribution.

Use the Fourier convention
$\widehat f(\xi)=\int_{\mathbb R}e^{-i\xi v}f(v)\,dv$.
Let $K$ be an even, nonnegative Schwartz function satisfying
$$
 \int_{\mathbb R}K=1,\qquad
 \widehat K\in C_c^\infty((-1,1)),\qquad
 \widehat K\ge0.
 \tag{9}
$$
Such a kernel exists: choose a nonzero even nonnegative
$b\in C_c^\infty((-1/2,1/2))$, let $g=\mathcal F^{-1}b$, and normalize $K=g^2/\int g^2$.
Then $\widehat K$ is a positive constant times $b*b$.
There are fixed $a\in(0,1)$ and $c_0>0$ with
$$
 \widehat K(\xi)\ge c_0\quad (|\xi|\le a).
 \tag{10}
$$
Set $K_T(v)=T K(Tv)$, so $\widehat K_T(\xi)=\widehat K(\xi/T)$.

Let the distinct positive ordinates of zeros on the critical line be $\gamma$, with multiplicities $m_\gamma$. Define
$$
 C=1-\frac{\zeta'}{\zeta}(\tfrac12).
 \tag{11}
$$
This is the residue of (4) at zero. For every fixed $T>0$,
$$
 (K_T*m)(v)
 = C-2\sum_{0<\gamma<T}
     \frac{m_\gamma\,\widehat K(\gamma/T)}{\gamma}\sin(\gamma v)
       +o_T(1)
 \qquad(v\to+\infty).
 \tag{12}
$$
The sum is finite. A term with ordinate at a support endpoint has zero coefficient.

Here is a boundary-distribution proof that preserves the causal endpoint.
Choose $T_*>T$ away from zero ordinates, and remove from $\mathcal M$ the principal parts at zero and at all $i\gamma$, $0<|\gamma|<T_*$:
$$
 H_T(z)=\mathcal M(z)-\frac Cz
       -\sum_{0<|\gamma|<T_*}
              \frac{-m_\gamma/(i\gamma)}{z-i\gamma}.
 \tag{13}
$$
Under RH this is holomorphic in a neighborhood of the compact segment
$i[-T,T]$. The zeta pole has already canceled in (4); the trivial-zero poles lie strictly to the left and remain part of the holomorphic remainder near this segment.
No infinite zero sum has been exchanged with an integral.

For $\epsilon>0$,
$\widehat{e^{-\epsilon v}m(v)}(\xi)=\mathcal M(\epsilon+i\xi)$.
By (8), these Fourier transforms converge in tempered distributions as
$\epsilon\downarrow0$ to $\widehat m$.
After multiplication by $\widehat K_T$, the remainder in (13) converges in $C_c^\infty$ to
$\widehat K_T(\xi)H_T(i\xi)$, whose inverse transform $g_T$ is Schwartz.
Each polar term has the exact inverse
$$
 \mathcal F^{-1}\!\left[\lim_{\epsilon\downarrow0}
       \frac1{\epsilon+i(\xi-\gamma)}\right](v)
       =\mathbf1_{[0,\infty)}(v)e^{i\gamma v}.
 \tag{14}
$$
It follows, first as distributions and then as continuous functions, that
$$
 \begin{split}
 (K_T*m)(v)
 ={}&C\int_0^\infty K_T(v-u)\,du\\
 &+\sum_{0<|\gamma|<T_*}
     \frac{-m_\gamma}{i\gamma}
       \int_0^\infty K_T(v-u)e^{i\gamma u}\,du+g_T(v).
 \end{split}
 \tag{15}
$$
The first integral tends to $1$. For each of the finitely many other integrals,
$$
 \int_0^\infty K_T(v-u)e^{i\gamma u}\,du
 =e^{i\gamma v}\int_{-\infty}^{v}K_T(s)e^{-i\gamma s}\,ds
 =e^{i\gamma v}\widehat K_T(\gamma)+O_{T,A}(v^{-A})
 \tag{16}
$$
for every fixed $A>0$. Combining the conjugate poles gives precisely the negative sine sign in (12).
Thus the error there is in fact rapidly decreasing for each fixed $T$.
All initial-time terms and the regular contributions of the pole and trivial zeros are included in (15).

## 4. Large opposite values without independent phases

Write the finite trigonometric polynomial on the right of (12) as $P_T(v)$.
Fix $0<b_0\le\pi/2$ and put $v_T=b_0/T$.
For every $0<\gamma<T$,
$$
 \sin(\gamma v_T)\ge \frac{2b_0\gamma}{\pi T}\ge0.
 \tag{17}
$$
Let $N_+(u)$ count positive zero ordinates below $u$, with multiplicity.
The unconditional zero-counting asymptotic
$$
 N_+(u)\sim\frac{u}{2\pi}\log u
 \tag{18}
$$
and (10) give, for a fixed $c_1>0$ and all sufficiently large $T$,
$$
 C-P_T(v_T)
 \ge \frac{4b_0c_0}{\pi T}N_+(aT)
 \ge c_1\log T.
 \tag{19}
$$
Every term not used in this lower bound has the same sign.
Oddness of the sine sum gives the opposite inequality at $-v_T$:
$$
 P_T(v_T)\le C-c_1\log T,\qquad
 P_T(-v_T)\ge C+c_1\log T.
 \tag{20}
$$

For a fixed finite set of ordinates, there are arbitrarily large $h>0$ for which every $e^{i\gamma h}$ is arbitrarily close to $1$.
To see this without an independence premise, consider the integer-time sequence
$(e^{i\gamma_1 n},\ldots,e^{i\gamma_J n})$ in the compact torus.
One of its sufficiently small neighborhoods contains infinitely many terms.
Taking two such indices with an arbitrarily large difference gives the required positive $h$.
Letting the neighborhood shrink gives a sequence $h_j\to\infty$ with simultaneous convergence to the identity.

Consequently
$$
 P_T(h_j+v_T)\to P_T(v_T),\qquad
 P_T(h_j-v_T)\to P_T(-v_T).
 \tag{21}
$$
Both times are eventually positive. These are returns near configurations already lying on the same one-parameter orbit; no arbitrary target phase vector is prescribed.
Combining (12), (20), and (21) yields
$$
 \begin{split}
 \liminf_{v\to\infty}(K_T*m)(v)&\le C-c_1\log T,\\
 \limsup_{v\to\infty}(K_T*m)(v)&\ge C+c_1\log T.
 \end{split}
 \tag{22}
$$

## 5. Positivity transfers the contradiction to the actual charge

If $m(v)\le B$ for $v\ge v_0$, the positivity of $K_T$ implies
$$
 (K_T*m)(v)
 \le B\int_{v_0}^{\infty}K_T(v-u)\,du
       +\int_0^{v_0}K_T(v-u)m(u)\,du.
 \tag{23}
$$
The first integral tends to $1$, and the second tends to zero.
The latter is a compact initial-time integral of a locally bounded function; Schwartz decay suffices.
Therefore $\limsup_{v\to\infty}(K_T*m)(v)\le B$.
Choosing $T$ sufficiently large contradicts the second inequality in (22).
An eventual lower bound similarly contradicts the first inequality.

These contradictions prove the absence of eventual one-sided bounds under RH.
Together with (7), they prove (2) unconditionally.

For $n=\lfloor x\rfloor\ge1$, the prime-power sum is unchanged on
$[n,n+1)$, and
$$
 M(x)-M(n)=-2(\sqrt x-\sqrt n),\qquad
 |M(x)-M(n)|\le n^{-1/2}.
 \tag{24}
$$
Thus both unboundedness statements hold for the exact integer charges $M_N$.
The right-continuous rather than midpoint convention causes no loss.

## 6. Primary inputs and the scope of the construction

The bare oscillation conclusion has classical ancestry. Suzuki, *On variants of Chebyshev’s conjecture*, Ramanujan Journal **68**, 95 (2025), §1.1, equation (4), explicitly connects $\psi_{1/2}(x)-2\sqrt x$ to Littlewood’s oscillation theorem, citing Hardy–Littlewood, Acta Mathematica **41** (1916), Theorem 5.6. Suzuki’s equation (36) gives the full weighted explicit formula. Under RH the comparison is rigorous because
$$
 \sum_\rho\left|
 x^{\rho-1/2}\left(\frac1{\rho-1/2}-\frac1\rho\right)\right|
 =\frac12\sum_\rho\frac1{|\rho-1/2|\,|\rho|}<\infty
$$
uniformly in $x>1$. Thus Littlewood’s growing $\Omega_\pm(\log\log\log x)$ transfers under RH; §2 above supplies two-sided unboundedness when RH fails. The natural endpoint adjustment and $+1$ do not affect it. Our finite-frequency argument is an alternate proof, with explicit causal smoothing and no independence hypothesis, rather than a claim that bare charge oscillation is new. [Suzuki’s primary article](https://link.springer.com/article/10.1007/s11139-025-01238-9). The [published correction](https://link.springer.com/article/10.1007/s11139-025-01289-y) changes arithmetic-progression and Dirichlet-$L$ formulas; it does not change (4), (36), or this zeta comparison.

The weighted explicit formula is classical, not a new theorem claimed here.
Gorodetsky, *Smooth numbers and the Dickman $\rho$ function*, Lemma 5.2, equation (5.5), printed page 15, and Appendix A, gives a primary proof for
$\sum_{n\le x}'\Lambda(n)n^{-s}$, retaining the pole contribution, every nontrivial zero with multiplicity, all trivial zeros, and a quantitative truncation error. The prime means half weight at a prime-power endpoint; passing to (1) changes the value by at most $\log x/(2\sqrt x)$.
At $s=1/2$, RH and $T=x$, its zero sum is $O(\log^2 x)$, by partial summation of the zero count; the other terms are bounded. This justifies polynomial growth in (8) independently of a signed integration of oscillations.
The paper also uses the standard Landau oscillation mechanism in §5.1; our needed nonnegative-transform lemma is proved above.
[Primary paper](https://arxiv.org/pdf/2211.08973).

For (18), Trudgian, *An improved upper bound for the argument of the Riemann zeta-function on the critical line II*, Corollary 1 and equation (2.5), gives an unconditional $O(\log T)$ error in the Riemann–von Mangoldt count. Only its leading term is used here, not the numerical constants in the preprint.
[Primary paper](https://arxiv.org/pdf/1208.5846).

The useful construction is the finite-frequency causal formula (15) combined with positive smoothing and recurrence. The argument establishes an unconditional property of the actual charge and therefore rules out a uniform bound on its magnitude, including in literal successor limits which retain $M_N^2$. It does not establish RH, a bound for the coherent signed self-work, or a quantitative recurrence height.

## 7. A sharp unweighted signed-work consequence

This section concerns the literal scalar charge increments, not the process-weighted source work. Put
$$
 \delta_n=M_n-M_{n-1}
   =\frac{\Lambda(n)}{\sqrt n}
       -2(\sqrt n-\sqrt{n-1}),\quad n\ge2,
 \qquad
 Q_N=\sum_{n=2}^N\delta_n^2,\quad
 \mathcal W_N=\sum_{n=2}^N M_{n-1}\delta_n.
 \tag{25}
$$
The bound $\Lambda(n)\le\log n$ gives $\delta_n\to0$.
Together with (2), this implies that **every real number is a subsequential limit of $M_n$**. Indeed, for any real $a$ and any sufficiently late index, there are still later charges below and above $a$. Along a finite passage between two such indices, the first crossing of $a$ has distance at most the largest increment in that late tail. That supremum tends to zero as the starting index tends to infinity. In particular,
$$
 \liminf_{N\to\infty}M_N^2=0,\qquad
 \limsup_{N\to\infty}M_N^2=+\infty.
 \tag{26}
$$
These are subsequence statements; they give no density or prescribed growth rate for those subsequences.

The exact density cell in (25) satisfies
$$
 2(\sqrt n-\sqrt{n-1})=n^{-1/2}+O(n^{-3/2}).
$$
Consequently
$$
 Q_N=\sum_{n=2}^N\frac{(\Lambda(n)-1)^2}{n}+O(1)
     =\frac12(\log N)^2+O(\log N).
 \tag{27}
$$
Here is a direct justification of the leading constant. The classical bound
$\sum_{p\le x}(\log p)/p=\log x+O(1)$, followed by Stieltjes partial summation, gives
$$
 \sum_{p\le N}\frac{(\log p)^2}{p}
 =\log N\sum_{p\le N}\frac{\log p}{p}
       -\int_2^N\left(\sum_{p\le x}\frac{\log p}{p}\right)\frac{dx}{x}
 =\frac12(\log N)^2+O(\log N).
$$
Every proper-power contribution is retained in a bounded remainder, since
$\sum_p\sum_{j\ge2}(\log p)^2/p^j<\infty$.
Likewise $\sum_{n\le N}\Lambda(n)/n=\log N+O(1)$ and
$\sum_{n\le N}1/n=\log N+O(1)$.
Finally, replacing the exact cell by $n^{-1/2}$ in the square costs an absolutely convergent series bounded by
$C\sum_n(1+\log n)n^{-2}$. Thus (27) keeps both the continuum cell and all powers.

Squaring each actual admission, with the initial $M_1=-1$, gives
$$
 2\mathcal W_N=M_N^2-1-Q_N.
 \tag{28}
$$
Since $M_N^2\ge0$, (27) implies
$\liminf \mathcal W_N/(\log N)^2\ge-1/4$.
Choose the subsequence from (26) on which $M_N\to0$. Equation (28) supplies the reverse inequality. Therefore the sharp statement is
$$
 \boxed{\displaystyle
 \liminf_{N\to\infty}
       \frac{\mathcal W_N}{(\log N)^2}=-\frac14.}
 \tag{29}
$$
The same value is attained along a subsequence with $M_N\to a$, for each fixed real $a$. This is a signed-cocycle consequence of the actual history: its square loading grows, and arbitrarily late return near any fixed charge forces a matching negative accumulated unweighted work. No assertion about a continuous-path quadratic variation is involved.

There is also a precise consequence for the already proved retained-charge profile. In the normalization of
[signed source successor stabilization](../successor-and-division/signed-source-successor-stabilization.md), set
$$
 V(x)=\frac4{\pi^2}
       \frac{\operatorname{atanh}((1+x)^{-1/2})}{\sqrt{1+x}},
 \qquad
 \|V\|_2^2=\frac{28\zeta(3)}{\pi^4}.
$$
For each fixed $N$, that theorem gives
$\sqrt{k}(C^kg_N)(k\,\cdot)\to M_NV$ strongly in $L^2(0,\infty)$.
For any prescribed real $a$, first select $N_j\to\infty$ with $M_{N_j}\to a$; then select $k_j\to\infty$, separately for each fixed $N_j$, so that the preceding norm error is at most $1/j$.
It follows that
$$
 \sqrt{k_j}(C^{k_j}g_{N_j})(k_j\,\cdot)\longrightarrow aV
                 \quad\text{strongly in }L^2(0,\infty).
 \tag{30}
$$
Thus the sequential profile closure contains the entire real line of multiples of $V$, including zero and both orientations. This uses a chosen diagonal sequence, not a uniform estimate at a specified relation between $k$ and $N$.

**Why (29) is not a conclusion about the actual log-clock work.**
For the literal decreasing return weights
$\kappa_n=k_{c\log n}$, the corresponding scalar work has the different exact identity
$$
 \begin{split}
 2\sum_{n=2}^N\kappa_nM_{n-1}\delta_n
 ={}&\kappa_NM_N^2-\kappa_1M_1^2\\
 &+\sum_{n=2}^N(\kappa_{n-1}-\kappa_n)M_{n-1}^2
       -\sum_{n=2}^N\kappa_n\delta_n^2.
 \end{split}
 \tag{31}
$$
The accumulated clock-action sum is nonnegative and generally nonzero.
The complete actual source comparison also retains its endpoint errors and signed cell correction, as illustrated by the [complete source cocycle](growing-time-actual-source-cocycle.md).
Return of $M_N$ near zero gives no bound on the intermediate squares in (31).
Accordingly neither the negative subsequence in (29) nor the profile closure in (30) controls the sign or magnitude of the actual weighted work $W_X$. Controlling that additional clock action remains a separate mathematical problem.
