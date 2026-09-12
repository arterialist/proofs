# Total clock dissipation and the actual signed birth work

Written proof. Conditional conclusions retain their stated RH hypotheses; none proves an unconditional RH-scale bound. Classical explicit-formula, zero-counting, Fourier and operator tools are attributed below and in the linked dependencies.

Fix $c>0$. Every norm below is the original source $L^2$ norm, in age coordinates under the established unitary map from physical $L^2([1,\infty),dx$). The process is the complete process $T_t$, with all prime powers and all history ages. Write
$$
 \psi(\xi)=\Re\Phi(i\xi),\qquad
 \Gamma(f)=\frac1{2\pi}\int_{\mathbb R}2\psi(\xi)|\widehat f(\xi)|^2\,d\xi.
$$
The [complete process symbol](fixed-observation-prime-heat.md) satisfies $0\le\psi\le2\lambda$, is comparable to $|\xi|$ on a fixed neighborhood of zero, and has a positive lower bound off that neighborhood. Its nonzero limiting value at high frequencies is retained throughout.

For the actual natural charge, let
$$
 m(v)=M(e^v)=\sum_{n\le e^v}\frac{\Lambda(n)}{\sqrt n}-2e^{v/2}+1,
 \qquad v\ge0.
$$
In particular $m(0)=-1$. Put $H_0=\int_0^1m(v)^2\,dv<\infty$. For $L\ge1$, use the actual real frozen cutoff
$$
 a^{(L)}(v)=e^{-v/2}E(\min(e^v,e^L))\mathbf1_{v\ge0},
 \qquad E(x)=\psi_{\rm arith}(x)-x.
$$
Here $\psi_{\rm arith}$ denotes the Chebyshev function, distinct from the process symbol. Define finite quantities
$$
 \mathscr D_c(R)=\int_1^R\Gamma(T_{cL}a^{(L)})\,dL,
 \qquad
 \mathscr J(R)=\int_1^R\frac{m(L)^2}{L^2}\,dL.
 \tag{1}
$$

The first result is the unconditional finite-prefix comparison
$$
 \boxed{\mathscr D_c(R)\le C_c(\mathscr J(R)+H_0),\qquad
 \mathscr J(R)\le C_c(\mathscr D_c(R)+H_0),\quad R\ge1.}
 \tag{2}
$$
In particular the actual total logarithmic-clock dissipation is finite if and only if RH holds. This does not prove that it is finite. The last section gives its consequence for the full signed birth work under RH.

## 1. Exact separation of terminal charge and its interior history

Extend $m$ by zero on negative ages, including its initial jump. Its Stieltjes derivative is exactly
$$
 dm=-\delta_0+\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}\delta_{\log n}
                         -e^{v/2}\mathbf1_{v>0}\,dv.
$$
Stop this signed measure at $L$, retaining an atom at $L$ when present. Convolution with $e^{-v/2}\mathbf1_{v\ge0}$ gives $a^{(L)}$. Equivalently the cumulative charge is $m(v)$ up to $L$ and the constant $m(L)$ thereafter. Stieltjes integration by parts, with $m(0-)=0$, gives the exact identity
$$
 \boxed{\widehat a^{(L)}(\xi)=
 \frac{m(L)e^{-i\xi L}+i\xi\int_0^L m(u)e^{-i\xi u}\,du}
 {1/2+i\xi}.}
 \tag{3}
$$
Thus the seed, every admitted prime power, the continuous density, and the frozen endpoint occur in (3). There is no new endpoint atom beyond the actual stopped measure. The two numerator terms are kept as a signed sum; they are not declared orthogonal.

Let $k_t=\|T_t(e^{-v/2}\mathbf1_{v\ge0})\|_2^2$. The exact differentiated Fourier formula implies
$$
 -k'_t=\frac1{2\pi}\int\frac{2\psi(\xi)e^{-2t\psi(\xi)}}{1/4+\xi^2}\,d\xi
 \le\frac C{(1+t)^2}.
 \tag{4}
$$
The bound follows by splitting the fixed small band and its complement, rather than differentiating a return asymptotic.

## 2. The upper bound retains the whole high-frequency part

On the small band, the multiplier
$2\psi(\xi)\xi^2e^{-2t\psi(\xi)}/(1/4+\xi^2)$
is at most $C|\xi|^3e^{-a t|\xi|}$. Off that band it is at most $Ce^{-a't}$, including arbitrarily high frequencies. Consequently
$$
 \sup_{\xi\in\mathbb R}
 \frac{2\psi(\xi)\xi^2e^{-2t\psi(\xi)}}{1/4+\xi^2}
 \le\frac C{(1+t)^3}.
 \tag{5}
$$
Apply $|p+q|^2\le2|p|^2+2|q|^2$ to the exact numerator (3), and Plancherel only to the actual interior function $m\mathbf1_{[0,L]}$. Equations (4)–(5) imply
$$
 \Gamma(T_{cL}a^{(L)})
 \le C_c\left[\frac{m(L)^2}{L^2}
                  +\frac1{L^3}\int_0^L m(u)^2\,du\right],\qquad L\ge1.
 \tag{6}
$$
The finite initial $L^2$ term is required here; an $L^1$-only assumption would not justify the high-frequency Plancherel bound. For the actual source it is precisely $H_0$.

Tonelli, on the finite prefix, gives
$$
 \int_1^R\frac1{L^3}\int_0^L m(u)^2\,du\,dL
 \le\frac12H_0+\frac12\mathscr J(R).
 \tag{7}
$$
This proves the first inequality in (2), without an assumed bound on any infinite source norm.

## 3. A finite Hardy inequality controls the signed interior term

Put $F(L)=\int_0^L|m(u)|\,du$. For any sufficiently small fixed $\epsilon>0$, retain only the frequencies $|\xi|\le\epsilon/L$ in the nonnegative dissipation integral. In (3), use
$$
 |p+q|^2\ge\tfrac12|p|^2-|q|^2,
 \qquad |q|\le|\xi|F(L).
$$
For the positive term use the lower bound on $\psi$, the lower bound $e^{-2cL\psi(\xi)}\ge e^{-2bc\epsilon}$, and the upper bound on $1/4+\xi^2$. For the negative term use the upper bound on $\psi$, $e^{-2cL\psi}\le1$, and $1/(1/4+\xi^2)\le4$. There are fixed positive constants $a_0,b_0,b_1$, independent of $L,c,\epsilon$, such that
$$
 \Gamma(T_{cL}a^{(L)})
 \ge a_0e^{-b_0c\epsilon}\epsilon^2\frac{m(L)^2}{L^2}
       -b_1\epsilon^4\frac{F(L)^2}{L^4}.
 \tag{8}
$$
This is a lower bound for the full dissipation. Contributions outside the retained band remain nonnegative; no process mode is removed from its definition.

The necessary Hardy estimate holds on each finite prefix:
$$
 \int_1^R\frac{F(L)^2}{L^4}\,dL
 \le\frac23F(1)^2+\frac89\mathscr J(R).
 \tag{9}
$$
Indeed, write $F(L)=F(1)+H(L)$, where $H(L)=\int_1^L|m(u)|\,du$. Integration by parts gives
$$
 I:=\int_1^R\frac{H(L)^2}{L^4}\,dL
 =-\frac{H(R)^2}{3R^3}
   +\frac23\int_1^R\frac{H(L)|m(L)|}{L^3}\,dL
 \le\frac23\sqrt{I\mathscr J(R)}.
$$
Thus $I\le4\mathscr J(R)/9$, including $I=0$; the inequality
$(F(1)+H)^2\le2F(1)^2+2H^2$ proves (9). The upper endpoint term has the favorable nonpositive sign and has been displayed explicitly.

Integrating (8) and using (9), choose $\epsilon=\epsilon(c)>0$ so small that
$$
 \frac89b_1\epsilon^4
 \le\frac12a_0e^{-b_0c\epsilon}\epsilon^2.
$$
All choices are independent of $R$. Since $F(1)^2\le H_0$, absorption proves the second inequality in (2). This is finite-prefix absorption and makes no finiteness assumption on $\mathscr J(\infty)$.

## 4. Return to the exact integer clock and full density cells

For the original admissions $t_n=c\log n$, define
$$
 D_n=\int_{t_{n-1}}^{t_n}\Gamma(T_s a_{n-1})\,ds,
 \qquad \mathbf D_c(N)=\sum_{n=2}^ND_n.
 \tag{10}
$$
Except at a set of endpoints of measure zero,
$$
 \mathbf D_c(N)=c\int_0^{\log N}
      \Gamma(T_{cL}a_{\lfloor e^L\rfloor})\,dL.
 \tag{11}
$$
If $n\le x<n+1$, the complete difference between the real frozen source at $x$ and the one at $n$ is the admitted continuum cell
$$
 a_x-a_n=-\int_n^x Uh_b\,db,
 \qquad h_b(y)=y^{-1}\mathbf1_{y\ge b}.
$$
It satisfies
$$
 \|a_x-a_n\|_2\le\int_n^x b^{-1/2}\,db\le n^{-1/2}.
 \tag{12}
$$
There is no prime-power atom inside this open cell. At its right endpoint the natural atom is included in the next source, exactly as in (10).

Since $\Gamma(f)\le4\lambda\|f\|_2^2$ and $T_t$ contracts,
$$
 \int_0^\infty\Gamma(T_{cL}(a^{(L)}-a_{\lfloor e^L\rfloor}))\,dL
 \le8\lambda.
 \tag{13}
$$
Here the same real-cutoff definition is used also on $0\le L<1$. Minkowski in the Hilbert space with square norm $\int\Gamma(\cdot)\,dL$ gives the precisely scaled inequality
$$
 \left|\sqrt{\mathbf D_c(N)/c}
 -\sqrt{\int_0^{\log N}\Gamma(T_{cL}a^{(L)})\,dL}\right|
 \le\sqrt{8\lambda}.
$$
The initial interval in (1) is restored in this display. Thus
$$
 \mathbf D_c(\infty)<\infty
 \quad\Longleftrightarrow\quad
 \mathscr D_c(\infty)<\infty
 \quad\Longleftrightarrow\quad
 \mathscr J(\infty)<\infty.
 \tag{14}
$$
This comparison retains the density-cell cross terms through a Hilbert-space norm inequality. It does not assert an unconditional absolute bound on the difference of the two squared actions.

## 5. The precise arithmetic input is equivalent to RH

The supporting lemma in [critical charge local square mean](critical-charge-local-square-mean.md) proves, under RH,
$$
 \sup_{V\ge0}\int_V^{V+1}m(v)^2\,dv<\infty.
 \tag{15}
$$
Its proof uses the exact weighted explicit formula, a smooth time cutoff, and the square-summable unit-frequency-bin coefficient bounds. It does not require independent ordinates, simple zeros, a zero-spacing estimate, or pointwise convergence of an infinite zero sum. Equation (15) immediately gives $\mathscr J(\infty)<\infty$.

Conversely, if $\mathscr J(\infty)<\infty$, weighted Cauchy–Schwarz makes
$\int_0^\infty e^{-zv}m(v)\,dv$ absolutely convergent and holomorphic for every $\Re z>0$. Derivatives are justified on compact sub-half-planes by the same estimate with extra powers of $v$. On $\Re z>1/2$ its exact seeded value is
$$
 \int_0^\infty e^{-zv}m(v)\,dv
 =\frac{-1-\zeta'/\zeta(z+1/2)-1/(z-1/2)}z.
 \tag{16}
$$
The pole of zeta at $z=1/2$ cancels the displayed rational term. Any nontrivial zero $\rho$ with $\Re\rho>1/2$ instead produces the nonzero residue $-m_\rho/(\rho-1/2)$, contradicting holomorphy. The functional equation therefore gives RH. Combining this with (14)–(15) proves
$$
 \boxed{\mathrm{RH}\quad\Longleftrightarrow\quad
      \sum_{n\ge2}\int_{c\log(n-1)}^{c\log n}
                   \Gamma(T_s a_{n-1})\,ds<\infty,
      \qquad\text{for each fixed }c>0.}
 \tag{17}
$$
An unconditional proof of the finiteness in (17) is not supplied here.

## 6. Conditional cancellation in the actual signed birth work

Use the exact original-space quantities
$$
 J_N=\|T_{c\log N}a_N\|_2^2,\quad
 W_N=\sum_{n=2}^N\Re\langle T_{c\log n}a_{n-1},T_{c\log n}V_n\rangle,
 \quad L_N=\sum_{n=2}^N\|T_{c\log n}V_n\|_2^2,
$$
where $V_n=a_n-a_{n-1}$ is the full actual cell. The seeded cocycle, including both mixed orders, is exactly
$$
 2W_N=J_N-1+\mathbf D_c(N)-L_N.
 \tag{18}
$$
The [complete loading asymptotic](growing-time-actual-source-cocycle.md) is
$$
 L_N=\frac{2\log N}{\pi^2c}+O_c((1+\log\log N)^2).
 \tag{19}
$$
Thus unconditionally $\liminf W_N/\log N\ge-1/(\pi^2c)$.

Under RH, (15) and (3) also give
$$
 \boxed{J_N\le C_c\frac{1+M_N^2}{\log N},\qquad N\ge3.}
 \tag{20}
$$
To see this, repeat the upper argument with the norm multiplier rather than the dissipation multiplier. The mass term is $k_{cL}m(L)^2\ll_c m(L)^2/L$, and the interior multiplier satisfies
$$
 \sup_\xi\frac{\xi^2e^{-2t\psi(\xi)}}{1/4+\xi^2}
 \le C(1+t)^{-2}.
$$
Plancherel and $\int_0^Lm^2\ll L+1$ yield (20), including the complete high-frequency part.

The oscillation proof [critical natural charge two sided unboundedness](critical-natural-charge-two-sided-unboundedness.md) proves that every real number is a subsequential limit of the natural integer $M_N$: classical two-sided unboundedness together with $M_{n+1}-M_n\to0$ suffices. In particular choose $N_j\to\infty$ with $M_{N_j}\to0$. Equation (20) gives $J_{N_j}\to0$. Since $\mathbf D_c(N)\uparrow\mathbf D_c(\infty)<\infty$ under RH, (18) implies
$$
 \liminf_{N\to\infty}\left(W_N+\frac12L_N\right)
       =\frac{\mathbf D_c(\infty)-1}{2},
 \qquad
 \boxed{\liminf_{N\to\infty}\frac{W_N}{\log N}
             =-\frac1{\pi^2c}\quad\text{under RH}.}
 \tag{21}
$$
The comparison is quantitative under RH. Equation (15) gives
$\int_R^\infty m(L)^2/L^2\,dL\ll R^{-1}$ and
$\int_0^L m(u)^2\,du\ll L+1$. Integrating (6) from $R$ to infinity, and using (12)–(13) on that tail rather than the whole half-line, proves
$$
 \mathbf D_c(\infty)-\mathbf D_c(N)=O_c((\log N)^{-1}).
 \tag{22}
$$
Indeed the real-to-integer difference has tail squared seminorm $O(e^{-R})$; Minkowski bounds the integer tail by $c(\sqrt{O_c(R^{-1})}+\sqrt{O(e^{-R})})^2$. Hence for every $N\ge3$, under RH,
$$
 W_N=\frac12J_N-\frac12L_N+
          \frac{\mathbf D_c(\infty)-1}{2}
          +O_c((\log N)^{-1}).
 \tag{23}
$$
The endpoint source square $J_N$ remains explicit in this complete signed-work formula.

There is a precise sparsity consequence. Under RH,
$$
 \sum_{n\ge3}\frac{M_n^2}{n(\log n)^2}<\infty.
 \tag{24}
$$
For $\log n\le v<\log(n+1)$, the exact natural charge satisfies
$|m(v)-M_n|\le n^{-1/2}$. Integrating
$M_n^2\le2m(v)^2+2/n$ on each such interval and using the comparability of $v$, $\log n$, and the interval length $1/n$, proves (24) from $\mathscr J(\infty)<\infty$. Every prime-power endpoint is retained by this argument.

For every fixed $\varepsilon>0$, (19), (20), and (23) now imply
$$
 \boxed{\displaystyle
 \sum_{\substack{n\ge3:\,
 |W_n/\log n+1/(\pi^2c)|>\varepsilon}}\frac1n<\infty
 \qquad\text{under RH}.}
 \tag{25}
$$
To check this claim, the deterministic error in
$W_n/\log n+1/(\pi^2c)=J_n/(2\log n)+o(1)$
is eventually smaller than $\varepsilon/2$. A remaining exceptional index therefore has $J_n>\varepsilon\log n$. Equation (20) forces $M_n^2\ge b_{c,\varepsilon}(\log n)^2$ for all sufficiently large such indices. Their reciprocal sum is bounded by a constant times (24), plus a finite initial sum. In particular the indices with $W_n\ge0$ have finite reciprocal sum under RH.

These are consequences for the actual accumulated Hilbert-space birth work, with its dissipation, seed and diagonal present. They are not inferred from the unweighted scalar-work liminf. The accumulated positive clock action is controlled here only through the RH input (15). No result here proves the unconditional signed-source bound needed to settle RH.
