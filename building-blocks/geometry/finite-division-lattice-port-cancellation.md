# Finite division cores and exact lattice-port cancellation

Written proof. The complete arithmetic histories and endpoint conventions are part of each statement. No Lean formalization or unconditional feedback-sign conclusion is asserted here.

This proof uses [the coherent lattice identity](actual-coherent-division-lattice-remainder.md) and [the Mellin-kernel proof](../zeta-and-zeros/actual-Abel-feedback-Mellin-kernel.md), together with [signed division-core boundary](../successor-and-division/signed-division-core-boundary.md). It retains the actual physical endpoint, every cofactor, the initial continuum cell, and the single full signed quadrature error. It does not investigate that error's sign.

Use distinct parameters
$$
0<\tau\le1,\quad r=e^{-\tau},\quad h=1-r,\quad
a_\tau=(1-r)/r=e^\tau-1.
\tag{1}
$$
Here $\tau$ is the geometric Abel parameter, not positive prime-process time. In particular $h\le\tau\le eh$. Write the continuous scaling kernel as $\mathsf k$, distinct from an integer cutoff $K$, and put
$$
U(u,n)=q^0(u,n)-n^{-1/2},\quad
s_\tau(n)=\tau\int_0^\infty e^{-\tau u}U(u,n)\,du
=\sqrt\tau\,\mathsf k(\tau n),
\quad L(z)=\sum_{a\ge1}\mu(a)\mathsf k(az).
\tag{2}
$$

## 1. The coherent source identity checks with its stated endpoint and error

For $n\ge2$, define
$$
p_\tau(n)=a_\tau\sum_{j\ge n}r^j b_j,\qquad
b_j=\frac{\arctan(j^{-1/2})}{\sqrt j},
$$
$$
\epsilon_\tau(n)=a_\tau\sum_{j\ge0}r^jU(j,n)
-\tau\int_0^\infty e^{-\tau u}U(u,n)\,du.
\tag{3}
$$
The exact physical return is $q_j(n)-q^0(j,n)=-b_j$ for $j\ge n$, while these masses agree for $j<n$. It proves
$$
\boxed{W_r(n)+p_\tau(n)=s_\tau(n)+\epsilon_\tau(n).}
\tag{4}
$$
The subtraction in $U$ occurs before quadrature, and $U(0,n)=0$. No separate divergent constant-source integral is taken.

The proved summed-variation estimate supplies the single full error
$$
\mathcal R(\tau)=\sum_{n\ge2}\Lambda(n)\epsilon_\tau(n),
\qquad |\mathcal R(\tau)|\le C_0\sqrt\tau.
\tag{5}
$$
All these sums are absolutely convergent for each fixed $\tau>0$. The other full readouts are
$$
C(\tau)=\sum_{n\ge2}\Lambda(n)p_\tau(n)
=a_\tau\sum_{j\ge2}r^jb_j\psi(j)>0,
$$
$$
\mathcal Q(\tau)=\sum_{n\ge2}\Lambda(n)s_\tau(n)
=\sqrt\tau\sum_{m\ge1}\log m\,L(\tau m).
\tag{6}
$$
Thus the coherent identity has exactly the stated signs:
$$
\boxed{E(r)+C(\tau)=\mathcal Q(\tau)+\mathcal R(\tau).}
\tag{7}
$$
At each finite $j$, the endpoint collapse uses
$\sum_{m\le j}\log m\,\mathcal M(\lfloor j/m\rfloor)=\psi(j)$.
It retains $\psi(1)=0$, the $j=2$ contribution, and all proper powers. Absolute interchange follows from $|\mathcal M(j/m)|\le j/m$, $b_j\le1/j$, and the geometric weight. Chebyshev bounds $C$; PNT is required only for its separately stated limit $C(\tau)\to1$.

The [proved absolute moment identities](../successor-and-division/successor-division-kernel-moments.md) are
$$
\int_0^\infty L(z)\,dz=0,\qquad
\int_0^\infty L(z)\log z\,dz=0.
\tag{8}
$$
They imply $\int_0^\infty\log x\,L(\tau x)\,dx=0$. The full cell $(0,1)$ is therefore required in the lattice identity even though the sample at $m=1$ is zero. That cell is distinct from $C(\tau)$. These checks confirm the preceding exact identity and convergence statements; they do not sign $\mathcal R$.

## 2. Finite cofactor boundaries and all physical ports

For integer $K\ge2$, keep the strict finite core
$$
c_K(n)=\sum_{\substack{m\mid n\\m<K}}\mu(n/m)\log m.
\tag{9}
$$
It equals $\Lambda(n)$ for $n<K$. For a sequence $v$ with the convergence below, write
$$
\mathcal P_K(v)=\sum_{2\le n<K}\Lambda(n)v(n),\qquad
\mathcal B_K(v)=\sum_{n\ge K}c_K(n)v(n).
$$
The exact finite inverse readout is
$$
\boxed{\sum_{m<K}\log m\sum_{a\ge1}\mu(a)v(am)
=\mathcal P_K(v)+\mathcal B_K(v).}
\tag{10}
$$
The initial $m=1$ term is present and zero. A divisor equal to $K$ is excluded, whereas a product equal to $K$ enters the boundary.

Set $B_{\rm act}=\mathcal B_K(W_r)$, $B_{\rm sc}=\mathcal B_K(s_\tau)$, $B_{\rm ep}=\mathcal B_K(p_\tau)$, and $B_{\rm qu}=\mathcal B_K(\epsilon_\tau)$. Equation (4), with the complete signed cofactor coefficient, gives
$$
\boxed{B_{\rm act}=B_{\rm sc}-B_{\rm ep}+B_{\rm qu}.}
\tag{11}
$$
In particular the actual boundary is not identified with the scaling boundary.

The endpoint boundary is exactly
$$
\boxed{B_{\rm ep}
=a_\tau\sum_{j\ge K}r^jb_j\sum_{K\le n\le j}c_K(n).}
\tag{12}
$$
Both endpoints $n=K$ and $n=j$ are included. With $\mathcal M(0)=0$, the finite endpoint collapse is
$$
D_K(j):=\sum_{m<K}\log m\,\mathcal M(\lfloor j/m\rfloor)
=\psi(\min(j,K-1))
+\mathbf1_{j\ge K}\sum_{K\le n\le j}c_K(n).
\tag{13}
$$
Consequently, for the actual inverse port $C_m$,
$$
\sum_{m<K}\log m\,C_m(\tau)
=\underbrace{a_\tau\sum_{j\ge2}r^jb_j\psi(\min(j,K-1))}_{\mathcal P_K(p_\tau)}
+B_{\rm ep}.
\tag{14}
$$
The first term continues through every $j\ge K$: old core births still return after the cutoff. Truncating those histories would lose a genuine endpoint contribution.

The elementary bound
$$
\sum_{K\le n\le j}|c_K(n)|
\le j\sum_{m<K}\frac{\log m}{m}\le2j\log^2K
$$
gives
$$
\boxed{|B_{\rm ep}|\le2r^{K-1}\log^2K,\qquad K\ge16.}
\tag{15}
$$
At $K=\lceil16h^{-1}\log(e/h)\rceil$, this is $O(h^{16}\log^2(e/h))$. This boundary port is small; the full $C(\tau)$ need not be.

For fixed $\tau,K$, these expressions converge absolutely. Indeed $W_r,s_\tau,\epsilon_\tau=O_\tau(n^{-3/2})$, $p_\tau(n)\le r^{n-1}/n$, and
$$
\sum_{n\ge K}|c_K(n)|n^{-3/2}
\le3K^{-1/2}\sum_{m<K}\frac{\log m}{m}<\infty.
\tag{16}
$$
These fixed-parameter facts do not give the sharp bound (5) by separately estimating inverse-core and inverse-exterior errors.

## 3. Exact finite cells and cancellation before estimation

Define the finite lattice defect, including its initial cell, and the continuous port by
$$
\begin{split}
\mathscr D_K(\tau)={}&\sqrt\tau\sum_{m=1}^{K-1}
\left[\log m\,L(\tau m)-\int_m^{m+1}\log x\,L(\tau x)\,dx\right]\\
&-\sqrt\tau\int_0^1\log x\,L(\tau x)\,dx,
\end{split}
$$
$$
J_K(\tau)=\sqrt\tau\int_0^K\log x\,L(\tau x)\,dx
=-\sqrt\tau\int_K^\infty\log x\,L(\tau x)\,dx.
\tag{17}
$$
The second equality uses the complete two moments (8). Finite summation through the last cell $(K-1,K)$ gives
$$
\boxed{\sqrt\tau\sum_{m<K}\log m\,L(\tau m)
=\mathscr D_K+J_K=\mathcal P_K(s_\tau)+B_{\rm sc}.}
\tag{18}
$$
The finite division-core form of (4) is therefore
$$
\mathcal P_K(W_r)+B_{\rm act}+\mathcal P_K(p_\tau)+B_{\rm ep}
=\mathscr D_K+J_K+\mathcal P_K(\epsilon_\tau)+B_{\rm qu}.
\tag{19}
$$
Subtract (11). The actual, endpoint, and quadrature boundaries cancel exactly:
$$
\boxed{\mathcal P_K(W_r)+\mathcal P_K(p_\tau)
=\mathscr D_K+J_K-B_{\rm sc}+\mathcal P_K(\epsilon_\tau).}
\tag{20}
$$
The complementary division exterior has the opposite cofactor boundaries. Thus adding the two parts also cancels them before any estimate.

Adding the prime-power exterior of (4) to (20) gives a useful finite-cutoff identity for the full readout:
$$
\boxed{E(r)+C(\tau)
=\mathscr D_K(\tau)+\Gamma_K(\tau)+\mathcal R(\tau),}
\tag{21}
$$
$$
\boxed{\Gamma_K(\tau)=J_K(\tau)-B_{\rm sc}
+\sqrt\tau\sum_{n\ge K}\Lambda(n)\mathsf k(\tau n).}
\tag{22}
$$
This retains the single full error $\mathcal R$ from (5). It does not bound $B_{\rm qu}$ and its cancelling exterior separately.

The factorial endpoint is likewise retained. The finite actual division core appearing in (19) equals
$$
\sum_{m<K}[\varphi_r(m)-\varphi_r(m+1)]\log(m!)
+\varphi_r(K)\log((K-1)!).
\tag{23}
$$
Thus (19)--(22) join the actual factorial core, signed cofactor boundary, lattice cells, and every physical endpoint without altering a cutoff.

Most importantly, the whole expression (22) is itself an exact quadrature remainder:
$$
\boxed{\Gamma_K(\tau)
=\sqrt\tau\left[
\sum_{m\ge K}\log m\,L(\tau m)
-\int_K^\infty\log x\,L(\tau x)\,dx\right].}
\tag{24}
$$
Indeed the exterior of (10) for $s_\tau$ is
$\sqrt\tau\sum_{m\ge K}\log m\,L(\tau m)
=\sqrt\tau\sum_{n\ge K}\Lambda(n)\mathsf k(\tau n)-B_{\rm sc}$.
Combine this with (17). This cancels the large continuous and cofactor ports exactly, before even a leading asymptotic is estimated.

## 4. Eventual monotonicity of the actual inverse kernel

The full-kernel derivative and its exponential-split asymptotic are already proved in RH Proof's [the kernel-scaling proof](../successor-and-division/successor-feedback-kernel-scaling.md), Section 1, equations (1)--(3). Its $\Phi(z,u)$ is exactly the present $q^0(u,z)$, so its kernel $K$ equals $\mathsf k$ without a normalization factor. That identity of kernels does not identify the parameters $h$ and $\tau$. The following argument records the cusp justification and a coarse explicit threshold, then consumes the derivative in the full inverse kernel. The new finite-core consequence is (24), (32), and (36), rather than the derivative formula itself.

For fixed $u$, the continuous birth mass has
$$
\partial_z q^0(u,z)
=-\frac{\mathbf1_{u<z}}{2z\sqrt{z-u}}.
$$
The two branches agree at $u=z$; there is no boundary atom. The displayed singularity is locally jointly integrable. Applying this identity first in integrated form on compact $z$-intervals and then Fubini shows that the integrated derivative is continuous. Hence, pointwise for $z>0$,
$$
\boxed{\mathsf k'(z)=\frac1{2z^{3/2}}
\left[1-\int_0^z e^{-u}(1-u/z)^{-1/2}\,du\right].}
\tag{25}
$$

Split the integral at $z/2$. On its first part,
$(1-u/z)^{-1/2}=1+u/(2z)+O(u^2/z^2)$, uniformly. The remaining cusp tail is at most $\sqrt2\,z e^{-z/2}$. The omitted exponential tails of the first two Taylor terms are also exponentially small. Therefore
$$
\mathsf k'(z)=-\frac1{4z^{5/2}}+O(z^{-7/2}),\qquad z\ge1.
\tag{26}
$$
One may keep explicit coarse constants: the Taylor remainder contributes at most $5/z^2$ to the bracket integral, and all exponential remainders contribute at most $2(1+z)e^{-z/2}$. The maxima of $z^2e^{-z/2}$ and $z^3e^{-z/2}$, with $e>2$, give
$$
\left|\int_0^z e^{-u}(1-u/z)^{-1/2}du-1-\frac1{2z}\right|
\le80z^{-2}.
$$
Consequently
$$
\left|\mathsf k'(z)+\frac1{4z^{5/2}}\right|\le40z^{-7/2}.
\tag{27}
$$
The elementary bound $|q^0(u,z)-z^{-1/2}|\le Cu z^{-3/2}$ proves $\mathsf k(z)\to0$ at infinity. Integrating (27) from infinity gives
$$
\left|\mathsf k(z)-\frac1{6z^{3/2}}\right|\le16z^{-5/2}.
\tag{28}
$$

The differentiated Möbius series is locally uniformly absolutely convergent on $z>0$: its large-index terms satisfy
$a|\mathsf k'(az)|\ll_z a^{-3/2}$.
It follows that the actual full inverse kernel is $C^1$, and
$$
L(z)=\frac1{6\zeta(3/2)z^{3/2}}+O(z^{-5/2}),\qquad
L'(z)=-\frac1{4\zeta(3/2)z^{5/2}}+O(z^{-7/2}).
\tag{29}
$$
All Möbius coefficients remain. Only the absolutely convergent Euler product at $3/2$ is used for the leading terms.

There is an absolute $z_0$ such that
$$
\boxed{L(z)>0,\qquad zL'(z)\le-L(z)\quad(z\ge z_0).}
\tag{30}
$$
For example $z_0=10000$ is a conservative explicit choice: since $\zeta(3/2)<3$, $\zeta(5/2)<2$, equations (27)--(28) imply
$$
L(z)\ge z^{-3/2}(1/18-32/z),\qquad
L(z)+zL'(z)\le z^{-3/2}(-1/36+112/z).
$$
Both required strict signs hold for $z\ge10000$. No assertion that the optimal threshold is this large is intended.

## 5. A positive, vanishing exterior error

If $K\ge3$ and $\tau K\ge z_0$, then
$$
f_\tau(x)=\log x\,L(\tau x)
$$
is positive and decreasing on $[K,\infty)$. In fact, with $z=\tau x$,
$$
f_\tau'(x)=\frac{L(z)+\log x\,zL'(z)}x
\le\frac{L(z)(1-\log x)}x<0.
\tag{31}
$$
It is integrable and tends to zero. The exact left-endpoint cell comparisons give
$$
0\le\sum_{m\ge K}\left[f_\tau(m)-\int_m^{m+1}f_\tau(x)dx\right]
\le\sum_{m\ge K}[f_\tau(m)-f_\tau(m+1)]=f_\tau(K).
$$
Together with (24) and (29), this proves
$$
\boxed{0\le\Gamma_K(\tau)
\le\sqrt\tau\,\log K\,L(\tau K)
\le C\frac{\log K}{\tau K^{3/2}},
\quad K\ge3,\quad\tau K\ge z_0.}
\tag{32}
$$

At the same actual moving core
$$
K=\left\lceil16h^{-1}\log(e/h)\right\rceil,\qquad h=1-e^{-\tau},
\tag{33}
$$
put $H=h^{-1}$, $\ell=\log(eH)$. Then
$$
16H\ell\le K\le17H\ell,\qquad
16\ell\le\tau K\le17e\ell,\qquad \log K\le2\ell+1.
\tag{34}
$$
Thus the hypothesis $\tau K\ge z_0$ holds for all sufficiently small $h$, with no claim that it holds throughout $0<\tau\le1$. Formula (32) gives
$$
\boxed{0\le\Gamma_K(\tau)
\le C\frac{\sqrt h}{\sqrt{\log(e/h)}}\longrightarrow0
\quad(h\downarrow0).}
\tag{35}
$$
The explicit $z_0$ above supplies a conservative sufficient threshold if one is required.

The final finite-core consumer is therefore the exact formula
$$
\boxed{E(e^{-\tau})+C(\tau)
=\mathscr D_K(\tau)+\mathcal R(\tau)+\Gamma_K(\tau),}
$$
$$
\boxed{|\mathcal R(\tau)|\le C_0\sqrt\tau,\qquad
0\le\Gamma_K(\tau)\le C\sqrt{h/\log(e/h)}
\quad\hbox{for all sufficiently small }h.}
\tag{36}
$$
The full physical return $C$, the initial cell, and every signed source history remain. The exterior term is now proved positive and vanishing because the complete cofactor cancellation identifies it as actual quadrature, not because its separate large ports were bounded by triangle inequalities. The finite lattice core and the full signed $\mathcal R$ have not been signed. No source-sign criterion or RH implication is reproved here.
