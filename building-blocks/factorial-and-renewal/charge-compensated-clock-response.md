# The original derivative response of charge-compensated successor memory

This written proof uses the [compensated memory kernel](../successor-and-division/charge-compensated-successor-memory.md) and the [uniform seed-translation bounds](../successor-and-division/successor-seed-maximal-translation.md). It gives the weighted kernel and scalar-dual arguments explicitly. The actual causal reference $a_0$ has a derivative atom at zero; the zero-endpoint reference has an $L^1$ derivative. Both lead to the stated distributional bound, with their different remainders retained. No analytic theorem here is formalized in Lean.

## 1. Operators and completed domains

Let g belong to the causal additive space E_c and let its physical representative be

$$
 f(u)=(\mathscr Wg)(u)=e^{u/2}g(e^u),\qquad u\ge0.
$$

The [anchoring inequality](../successor-and-division/charge-compensated-successor-memory.md), equation (18), is

$$
 \|e^{-u/2}f\|_2\le\|g\|_{\mathcal E}.
 \tag{1}
$$

All physical functions and distributions are extended by zero to negative u. Write

$$
 (Sf)(v)=j(v)f(\sigma(v)),\quad
 j(v)=\sqrt{\frac{e^v}{1+e^v}},\quad
 \sigma(v)=\log(1+e^v),\quad d(v)=\frac1{1+e^v},
$$

for v>=0. Set ell=log 2,

$$
 k(u)=\begin{cases}-1,&0\le u<\ell,\\
 (1-e^{-u})^{-1/2}-1,&u\ge\ell,
 \end{cases}\qquad
 \delta(f)=\frac12\int_0^\infty k(u)f(u)du,
$$

$$
 a_0(v)=e^{-v/2}\mathbf1_{v\ge0},\quad C=S-a_0\delta,
 \quad Kf=B*f,\quad H=\frac12-\partial_v,\quad A=HK.
$$

The letter delta without a subscript denotes the relative-charge functional; delta_0 below is a Dirac measure. The negative initial interval in k is part of the definition.

The weighted physical space X consists of f with e^{-u/2}f in L2. The functional delta is bounded on X because k(u)e^{u/2} belongs to L2. Also S is bounded on X: the change u=sigma(v) gives

$$
 \int_0^\infty e^{-v}|Sf(v)|^2dv
 =\int_\ell^\infty\frac{e^{-u}}{1-e^{-u}}|f(u)|^2du
 \le2\|e^{-u/2}f\|_2^2.
$$

Thus C is meaningful on X. The convolution operators K and A are also bounded on X, as shown next. Consequently the literal products CAf and ACf are defined as X-valued functions for every completed input in (1). Their improved global W^{-1,1} bound is a separate conclusion below; no assertion that K maps E_c to itself is needed.

## 2. The exact weighted kernels and the missing endpoint

The distributional derivative of the complete seed has locally finite variation. Its continuous part is B/2. Therefore the actual signed kernel alpha=HB consists exactly of the atoms

$$
 \alpha=-\sum_p p^{-3/2}\delta_{\log p}
 +\sum_p\sum_{k\ge2}(1-p^{-1})p^{-k/2}\delta_{k\log p}.
 \tag{2}
$$

There is no atom at zero. Each birth is negative in alpha, and every later power is positive. The two exact weighted masses are

$$
 J_{1/2}:=\int_0^\infty e^{-v/2}B(v)dv
 =\sum_p\frac{\log p}{p(p-1)}<\infty,
$$

$$
 M_{1/2}:=\int_0^\infty e^{-v/2}|\alpha|(dv)
 =2\sum_p p^{-2}<\infty.
 \tag{3}
$$

For the second identity, the weighted birth mass is p^{-2}; the sum of weighted later powers is also p^{-2}. Young's inequality after exponential weighting gives

$$
 \|Kf\|_X\le J_{1/2}\|f\|_X,
 \qquad \|Af\|_X=\|\alpha*f\|_X\le M_{1/2}\|f\|_X.
 \tag{4}
$$

These equations also prove the local distribution identity HKf=alpha*f for completed inputs.

Since B is locally BV, convolution with a locally L2 causal f gives Kf in H1_loc on the physical line. Both Kf and its distributional derivative are locally L2. The function Kf vanishes below ell; its continuous H1 representative consequently satisfies

$$
 (Kf)(\ell+)=0.
 \tag{5}
$$

This remains true though B itself has a jump at ell. The input is a locally L2 function, not an atom, so convolution does not retain a nonzero value at the first arrival.

For a locally H1 function h, differentiating the causal output Sh gives the endpoint term

$$
 [S,H]h=d\,SHh+\frac{h(\ell+)}{\sqrt2}\delta_0.
 \tag{6}
$$

Indeed sigma'=j^2=1-d and j'=jd/2 give the interior expression. The derivative of the causal output adds the atom (Sh)(0+)=h(ell+)/sqrt2. Applied to h=Kf, equation (5) removes that particular atom, so

$$
 [S,H]Kf=d\,SAf.
$$

The latter is genuinely in L1. Changing variables to u=sigma(v) gives the useful bound

$$
 \|d\,SAf\|_1
 \le\left(\int_\ell^\infty\frac{e^{-u}}{1-e^{-u}}du\right)^{1/2}\|Af\|_X
 =\sqrt{\log2}\,\|Af\|_X.
 \tag{7}
$$

## 3. Exact relative-charge duals

Fubini for the weighted kernels and integration by parts on the smooth branch of $k$ give the absolutely convergent formulas

$$
 k_f:=\delta(Kf)=\int_0^\infty d_K(u)f(u)du,\quad
 d_K(u)=\frac12\int_\ell^\infty k(u+w)B(w)dw,
$$

$$
 a_f:=\delta(Af)=\int_0^\infty d_A(u)f(u)du,\quad
 d_A(u)=\frac12\int B(w)[k'(u+w)+k(u+w)/2]dw,
 \qquad u>0.
 \tag{8}
$$

The derivative in the second formula is only on the smooth branch u+w>ell. The isolated endpoint u=0 uses its right limit and has no effect on locally L2 inputs. Thus no jump of k is silently integrated through a prime atom.

Writing c_n=binomial(2n,n)/4^n, these columns are exactly

$$
 d_K(u)=\frac12\sum_{n\ge1}c_ne^{-nu}\widehat B(n),\qquad
 d_A(u)=\frac12\sum_{n\ge1}(1/2-n)c_ne^{-nu}\widehat B(n).
 \tag{9}
$$

The Laplace transform is $\widehat B(n)=\int_0^\infty e^{-nw}B(w)\,dw$, distinct from a Fourier transform here. Both series retain every prime power. To obtain (9), expand $(1-z)^{-1/2}-1=\sum_{n\ge1}c_nz^n$ on $0\le z\le1/2$ in (8), and use Tonelli or the absolutely summable differentiated majorant. The minimum delay gives $\widehat B(n)\le e^{-(n-1)\ell}\widehat B(1)$. Thus the series converge with every fixed $u$-derivative uniformly on $u\ge0$. In particular d_K>0, d_A<0, and both are O(e^{-u}). Equation (1) proves bounded scalar compositions on E_c. These are scalar weak integration-by-parts formulas; they do not posit an integrable derivative of B.

## 4. The original a0 commutator is measure-valued at the remainder

Let $T=[C,K]$ on physical representatives; the [kernel theorem](../successor-and-division/charge-compensated-successor-memory.md) proves $\|Tf\|_1\le C\|g\|_{\mathcal E}$ for the additive input $g$. The exact causal derivative is

$$
 \partial_v a_0=\delta_0-a_0/2,
 \qquad \boxed{Ha_0=a_0-\delta_0.}
 \tag{10}
$$

In particular Ha0 is not the ordinary interior derivative alone. Expanding [C,H]K and using (6) gives

$$
 \boxed{[C,H]Kf=d\,SAf+(a_0-\delta_0)k_f-a_0a_f.}
 \tag{11}
$$

This is a bounded finite-measure-valued map on E_c. It is not in general L1: for any nonzero nonnegative compact smooth input, d_K>0 implies k_f>0, so (11) has the nonzero atom -k_f delta_0. The other displayed terms are L1 and cannot cancel that atom inside this remainder.

The product commutator is

$$
 \boxed{[C,A]f=H(Tf)+d\,SAf+(a_0-\delta_0)k_f-a_0a_f.}
 \tag{12}
$$

For every compact smooth test phi on the full real line its exact pairing is

$$
 \begin{aligned}
 \langle[C,A]f,\varphi\rangle
 ={}&\int Tf(v)[\varphi(v)/2+\varphi'(v)]dv
 +\int d(v)SAf(v)\varphi(v)dv\\
 &+k_f\left[\int a_0(v)\varphi(v)dv-\varphi(0)\right]
 -a_f\int a_0(v)\varphi(v)dv.
 \end{aligned}
 \tag{13}
$$

This is the original-response pairing with its atom and derivative, not a formula for the anticausal response.

For an explicit W^{-1,1} representation, define

$$
 F_0=Tf/2+d\,SAf+(a_0/2)k_f-a_0a_f,
 \qquad F_1=Tf+a_0k_f.
$$

Both belong to L1 with norms bounded by C||g||_E. Since delta_0=partial a0+a0/2, equation (12) is exactly

$$
 [C,A]f=F_0-\partial_vF_1.
 \tag{14}
$$

Using the standard representation norm for W^{-1,1}, (14) proves

$$
 \boxed{[C,A]\mathscr W:\mathcal E_c\longrightarrow W^{-1,1}(\mathbb R)
 \quad\text{bounded}.}
$$

In particular its pairing is bounded by C||g||_E(||phi||_infinity+||phi'||_infinity). On the smooth core this is ordinary distributional operator algebra. For completed inputs, weighted boundedness of A,K,C and the proved L1 extension of T permit passage to the same identity. No globally integrable derivative of T is assumed. On the core its endpoint derivative cancels the atom in (11) in the complete commutator, but that fact does not justify deleting the atom from the decomposition.

## 5. A zero-endpoint seed repairs the remainder, not the whole derivative

Define

$$
 \rho(v)=\frac v2e^{-v/2}\mathbf1_{v\ge0},\qquad C_\rho=S-\rho\delta.
$$

This has the same total seed integral 2, but rho(0+)=0. Its exact derivative is

$$
 \boxed{H\rho=\frac{v-1}{2}e^{-v/2}\mathbf1_{v\ge0}\in L^1,}
$$

with no atom. Put eta=rho-a0. Its integral is zero and its first absolute moment is finite. Therefore

$$
 K\eta=\int_0^\infty\eta(w)(\tau_wB-B)dw\quad\text{in }L^1,
$$

by the proved logarithmic large-shift L1 bound. This signed integral retains the zero-mass cancellation before integrating B, which itself is not in L1. The exact memory commutator is

$$
 T_\rho=[C_\rho,K]
 =T+(a_0-\rho)\delta K+K(\rho-a_0)\delta,
 \tag{15}
$$

so T_rho:E_c to L1 is bounded. Its differentiated remainder is now

$$
 \boxed{[C_\rho,H]Kf=d\,SAf+(H\rho)k_f-\rho a_f\in L^1.}
 \tag{16}
$$

Thus [C_rho,A]f=H(T_rho f)+[C_rho,H]Kf has the corresponding W^{-1,1} bound and exact test pairing, with the second term represented by the L1 density (16). This is a genuine L1 repair of the remainder. It is not a proof that the complete differentiated commutator belongs to L1.

A general smooth zero-endpoint seed formula must therefore be specialized differently from the actual original a0 formula: (10) is mandatory for a0, while (16) applies to rho.

## 6. Joint prime and source limits

Let K_P=B_P*, alpha_P=HB_P, A_P=HK_P, and T_P=[C,K_P]. Exact weighted tail masses from (3) give

$$
 \int e^{-v/2}(B-B_P)(v)dv
 =\sum_{p>P}\frac{\log p}{p(p-1)}=O(P^{-1}),
$$

$$
 \int e^{-v/2}|\alpha-\alpha_P|(dv)
 =2\sum_{p>P}p^{-2}=O(P^{-1}).
 \tag{17}
$$

The first estimate follows from Chebyshev partial summation; the second already follows by comparison with all integers. Every proper power is included in the exact equalities. Equations (4), (7), and the bounded weighted charge imply that the remainder in (11), and the L1 remainder in (16), converge in their respective measure and L1 norms at rate O(P^{-1}) on the entire E_c unit ball. This rate follows directly from the displayed exact weighted masses.

The [memory theorem](../successor-and-division/charge-compensated-successor-memory.md) gives

$$
 \|T-T_P\|_{\mathcal E_c\to L^1}\le C\varepsilon_P,
 \qquad \varepsilon_P=\frac{\log(2+\log\log P)}{\sqrt{\log P}}
$$

for sufficiently large P. For (15), the extra term (K-K_P)eta is O(1/log P) in L1 by the uniform tail-shift theorem and the finite first absolute moment of eta. Therefore T_rho has the same overall O(epsilon_P) cutoff rate. Combining these facts with (12)-(16) proves

$$
 \boxed{\|[C,A]-[C,A_P]\|_{\mathcal E_c\to W^{-1,1}}
 +\|[C_\rho,A]-[C_\rho,A_P]\|_{\mathcal E_c\to W^{-1,1}}
 \le C(\varepsilon_P+P^{-1}).}
 \tag{18}
$$

Here every operator includes the physical-coordinate map from E_c as in (1).

If g_N tends to g in E_c and the norms of g_N are bounded, then, for either C or C_rho,

$$
 \|[C,A_P]\mathscr Wg_N-[C,A]\mathscr Wg\|_{W^{-1,1}}
 \le C(\varepsilon_P+P^{-1})\sup_N\|g_N\|_E
 +C\|g_N-g\|_E.
$$

Thus the [proved actual natural source cutoffs](../dynamics-and-feedback/natural-arrival-cutoff-completion.md) and prime cutoffs converge jointly, with no restriction on their relative speeds. Pairing against every fixed bounded C1 test follows from this estimate. It does not differentiate an L1 limit without a distributional bound, and it does not claim a sign or complete the anticausal/full Weil readout.
