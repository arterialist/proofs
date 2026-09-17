# Friable prime-admission flux in the finite affine Gram

This note differentiates the exact friable split of the nonuniform friable-boundary decomposition one prime at a time.
The result is an exact Buchstab energy-flux identity with both moving bulk
endpoints retained.  The flux has no pointwise or logarithmically averaged
negative sign.  A two-packet example in the actual finite-\(X\) Möbius
bulk makes the failure explicit.

## 1. Exact finite-\(X\) admission

Put

\[
 D_X=\lceil\sqrt X\rceil,
 \qquad T_X=\lceil X\log X\rceil,
 \qquad \mathcal B_X=\{d:D_X<d<T_X\}.
 \tag{1}
\]

The finite affine Gram is

\[
 \mathcal G_X(d,e)
 =\langle\Phi_{X,d},\Phi_{X,e}\rangle
 =\sum_{a,b\ge1}\kappa_{a+b-2}
   e^{-2\max(ad,be)/X},
 \tag{2}
\]

where every \(\kappa_{a+b-2}>0\).  For real \(y\ge1\), define

\[
 S_y=\sum_{\substack{d\in\mathcal B_X\\P^+(d)\le y}}
       \mu(d)\Phi_{X,d},
 \qquad
 R_y=F_X^{\rm bulk}-S_y.
 \tag{3}
\]

Equivalently, the unique-largest-prime formula is

\[
 R_y=-\sum_{\substack{p>y\\p<T_X}}
 \sum_{\substack{D_X/p<m<T_X/p\\P^+(m)<p}}
 \mu(m)\Phi_{X,pm}.
 \tag{4}
\]

If \(p\) is prime, let \(p^-\) denote a value immediately below \(p\),
and set

\[
 \mathcal M_p(X)=
 \left\{m:
 \frac{D_X}{p}<m<\frac{T_X}{p},\ 
 \mu(m)\ne0,\ P^+(m)<p
 \right\}.
 \tag{5}
\]

The exact admitted packet is

\[
 U_p=-\sum_{m\in\mathcal M_p(X)}\mu(m)\Phi_{X,pm}.
 \tag{6}
\]

Thus the vector-valued Buchstab recursion, including the strict moving
endpoints, is

\[
 \boxed{
 S_p=S_{p^-}+U_p,
 \qquad R_p=R_{p^-}-U_p.}
 \tag{7}
\]

No extension of either cofactor interval is made.  Since \(P^+(m)<p\),
the sign in (6) is exactly \(\mu(pm)=-\mu(m)\).

## 2. Exact energy flux

Let

\[
 E(y)=\|S_y\|^2.
 \tag{8}
\]

At the prime \(p\), (7) gives

\[
 \boxed{
 \Delta_pE:=E(p)-E(p^-)
 =\|U_p\|^2+2\langle S_{p^-},U_p\rangle.}
 \tag{9}
\]

In arithmetic coordinates this is

\[
\boxed{\begin{aligned}
 \Delta_pE={}&
 \sum_{m,n\in\mathcal M_p(X)}
 \mu(m)\mu(n)\mathcal G_X(pm,pn)\\
 &-2\!\sum_{\substack{d\in\mathcal B_X\\P^+(d)<p}}
 \sum_{m\in\mathcal M_p(X)}
 \mu(d)\mu(m)\mathcal G_X(d,pm).
\end{aligned}}
 \tag{10}
\]

Substitution of (2) retains every affine history:

\[
\begin{aligned}
 \Delta_pE={}&
 \sum_{a,b\ge1}\kappa_{a+b-2}
 \sum_{m,n\in\mathcal M_p(X)}
 \mu(m)\mu(n)e^{-2\max(apm,bpn)/X}\\
 &-2\sum_{a,b\ge1}\kappa_{a+b-2}
 \sum_{\substack{d\in\mathcal B_X\\P^+(d)<p}}
 \sum_{m\in\mathcal M_p(X)}
 \mu(d)\mu(m)e^{-2\max(ad,bpm)/X}.
\end{aligned}
 \tag{11}
\]

There is also an exact weighted-Stokes form.  Define

\[
 A_{y,a}(v)=
 \sum_{\substack{d\in\mathcal B_X,\ P^+(d)\le y\\ad\le Xv}}
 \mu(d),
 \qquad
 Q_{p,a}(v)=
 -\sum_{\substack{m\in\mathcal M_p(X)\\apm\le Xv}}
 \mu(m).
 \tag{12}
\]

Using

\[
 e^{-2\max(A,B)/X}
 =2\int_{\max(A/X,B/X)}^\infty e^{-2v}dv,
 \tag{13}
\]

one obtains

\[
 E(y)=2\sum_{a,b\ge1}\kappa_{a+b-2}
 \int_0^\infty e^{-2v}A_{y,a}(v)A_{y,b}(v)dv,
 \tag{14}
\]

and

\[
\boxed{\begin{aligned}
 \Delta_pE=2\sum_{a,b\ge1}\kappa_{a+b-2}
 \int_0^\infty e^{-2v}\bigl(&A_{p^-,a}Q_{p,b}
 +Q_{p,a}A_{p^-,b}\\
 &+Q_{p,a}Q_{p,b}\bigr)(v)dv.
\end{aligned}}
 \tag{15}
\]

The ceilings inside (12), namely

\[
 m\le\frac{Xv}{ap},
 \qquad
 \frac{D_X}{p}<m<\frac{T_X}{p},
 \tag{16}
\]

are the moving Buchstab endpoints.  They prevent a translation-invariant
prime recursion.

## 3. Conservation across the full friable split

The three pieces of

\[
 \|F_X^{\rm bulk}\|^2
 =\|S_y\|^2+\|R_y\|^2+2\langle S_y,R_y\rangle
 \tag{17}
\]

have the prime jumps

\[
\begin{aligned}
 \Delta_p\|S\|^2
 &=2\langle S_{p^-},U_p\rangle+\|U_p\|^2,\\
 \Delta_p\|R\|^2
 &=-2\langle R_{p^-},U_p\rangle+\|U_p\|^2,\\
 \Delta_p\{2\langle S,R\rangle\}
 &=2\langle U_p,R_{p^-}\rangle
   -2\langle S_{p^-},U_p\rangle-2\|U_p\|^2.
\end{aligned}
 \tag{18}
\]

Their sum is identically zero.  This is the exact finite-\(X\)
energy-flux law.  Prime admission transfers energy among the friable
norm, the rough norm, and their signed cross; it does not dissipate the
complete energy.

## 4. Logarithmic differentiation and averaging

Use \(\tau=\log y\).  Since \(S_y\) is a step function, its distributional
derivative is the atomic measure

\[
 \partial_\tau S_{e^\tau}
 =\sum_{p<T_X}U_p\,\delta(\tau-\log p),
 \tag{19}
\]

and the energy flux is

\[
 \boxed{
 \partial_\tau E(e^\tau)
 =\sum_{p<T_X}\Delta_pE\,\delta(\tau-\log p).}
 \tag{20}
\]

Consequently an unweighted logarithmic integration is exactly

\[
 \int_{\log y_0}^{\log y_1}\partial_\tau E(e^\tau)d\tau
 =E(y_1)-E(y_0)
 =\sum_{y_0<p\le y_1}\Delta_pE.
 \tag{21}
\]

For a nonnegative test function \(\psi\), the weighted version is

\[
 \int\psi(\tau)\,dE(e^\tau)
 =\sum_{p<T_X}\psi(\log p)\Delta_pE.
 \tag{22}
\]

Neither expression has a negative sign.  In fact, if all nonempty packets
are integrated from the initial state \(S=0\), (21) is
\(\|F_X^{\rm bulk}\|^2\ge0\).  A decreasing positive weight cannot repair
the sign: discrete summation by parts expresses its weighted flux as a
nonnegative combination of the intermediate energies plus the final
energy.

More precisely, for consecutive admissions \(p_1<\cdots<p_N\), put
\(E_j=E(p_j)\), \(E_0=0\).  If
\(w_1\ge\cdots\ge w_N\ge0\), then

\[
 \sum_{j=1}^Nw_j(E_j-E_{j-1})
 =w_NE_N+\sum_{j=1}^{N-1}(w_j-w_{j+1})E_j\ge0.
 \tag{23}
\]

Thus the most natural logarithmic smoothing has the opposite sign from a
contractive admission principle.

## 5. Exact actual-packet counterexample

Take \(X=4\).  Then

\[
 D_X=2,
 \qquad T_X=6,
 \qquad \mathcal B_X=\{3,4,5\}.
 \tag{24}
\]

The only nonzero Möbius coefficients in the bulk are
\(\mu(3)=\mu(5)=-1\).  The moving endpoint sets in (5) are exactly

\[
 \mathcal M_3(4)=\{1\},
 \qquad \mathcal M_5(4)=\{1\},
 \tag{25}
\]

so the actual packets are

\[
 U_3=-\Phi_{4,3},
 \qquad U_5=-\Phi_{4,5}.
 \tag{26}
\]

At the first admission,

\[
 \Delta_3E=\mathcal G_4(3,3)>0.
 \tag{27}
\]

At the second admission, even the cross-only flux has the wrong sign:

\[
 2\langle S_{3},U_5\rangle
 =2\mathcal G_4(3,5)>0,
 \tag{28}
\]

and hence

\[
 \boxed{
 \Delta_5E=\mathcal G_4(5,5)+2\mathcal G_4(3,5)>0.}
 \tag{29}
\]

The inequalities are strict because every term in (2) is positive; in
particular the literal \(a=b=1\) term is
\(\kappa_0e^{-2\max(d,e)/4}>0\).  This is not a generic two-vector PSD
example.  It uses the exact Möbius signs, exact largest-prime packets,
strict moving endpoints, every clock coefficient, and the original
finite-\(X\) affine kernel.  Choosing \(\psi\ge0\) supported near \(\log5\) in
(22) gives a strictly positive logarithically averaged cross and total
flux.

## 6. The only averaged inequality sufficient for implication (40)

Although averaged monotonicity is false, integrating (9) over every prime
does give the exact criterion

\[
\boxed{
 \mathfrak A_X^{\rm bulk}
 =\sum_{p<T_X}
 \left(\|U_p\|^2+2\langle S_{p^-},U_p\rangle\right).}
 \tag{30}
\]

Therefore the precise signed logarithmic-flux inequality sufficient for
implication (40) is

\[
\boxed{
 \sum_{p<T_X}2\langle S_{p^-},U_p\rangle
 \le-\sum_{p<T_X}\|U_p\|^2
 +O_\varepsilon(X^{1+\varepsilon}).}
 \tag{31}
\]

Equivalently, one may partition the logarithmic prime axis into intervals
\(I_j\) and prove

\[
 \sum_j\left[
 \sum_{\log p\in I_j}
 \left(\|U_p\|^2+2\langle S_{p^-},U_p\rangle\right)
 \right]_+
 \ll_\varepsilon X^{1+\varepsilon},
 \tag{32}
\]

where \([x]_+=\max(x,0)\).  This shellwise condition implies (30) at
the target scale, but it is a new
signed affine Möbius correlation, not a consequence of Buchstab counting
or energy positivity.

The logarithmic averaging therefore supplies an exact flux formulation,
but no monotonicity gain.  Proving (31), or the stronger shellwise form
(32), is precisely the remaining cancellation needed for
\(\mathfrak A_X^{\rm bulk}\ll_\varepsilon X^{1+\varepsilon}\) and hence
for implication (40).  No RH premise or conclusion is used.
