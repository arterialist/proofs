# Integer-atomic positive-source version of the full-\(F\) chirp obstruction

RH Agent3, 2026-09-16. **Status:** written countermodel, not the actual von Mangoldt source and not Lean formalized. This converts a positive continuous-source chirp into an **integer-atomic, nonnegative** observing source. The conclusion is that integer discreteness and source positivity alone do not make the full-\(F\) dyadic score invert pointwise \(E\). The full-score clock factor is derived in the [fixed-positive-clock note](factorial-f-ground-fixed-positive-clock-measure-inverse.md).

Let \(a=3/10\), \(b=1/5\), and choose a large \(x_0=\exp(u_0)\) with \(e^{bu_0}=m\pi\). Define the increasing source \(\psi_c=0\) on \([1,2)\), with an atom of mass \(2\) at \(2\), \(\psi_c(x)=x\) on \([2,x_0]\), and \(\psi_c(x)=x+E_c(x)\) thereafter, where
\[
 r_c(u)=e^{-au}\sin(e^{bu}),\qquad
 E_c(x)=xF_c(x)r_c(\log x),\qquad
 F_c(e^u)=\kappa_c\exp\!\left(\int_u^\infty r_c(v)dv\right),
\quad F_c(x_0)=\log2.                                    \tag{1}
\]
On the tail \(\psi_c'=1+O(x^{-(a-b)})>0\); by taking \(x_0\) large, \(F_c>0\) everywhere. Its ground has \(F_c(1)=0\), \(F_c=\log x\) on \((1,2]\), \(F_c=\log2\) on \([2,x_0]\), and \(F_c'=-E_c/x^2\) almost everywhere.

Define the right-continuous step source, supported at **every possible integer** but with some optional zero weights,
\[
 \psi_d(x)=\psi_c(\lfloor x\rfloor)
 =\sum_{1\le n\le x}w_n,\qquad
 w_1=0,\quad w_n=\psi_c(n)-\psi_c(n-1)\ge0\ (n\ge2),       \tag{2}
\]
and \(E_d(x)=\psi_d(x)-x\). Specifically \(w_2=2\), the long middle block has \(w_n=1\), and on the tail \(w_n=1+E_c(n)-E_c(n-1)=1+O(n^{-1/10})>0\). A straddling interval at \(x_0\) also has nonnegative weight because \(\psi_c\) is globally increasing. These weights are generic; they are not \(\Lambda(n)\).

Define the exact integer-atomic ground by
\[
 F_d(x)=\log x-\sum_{n\le x}\frac{w_n}{n}+\frac{\psi_d(x)}x,
 \qquad x\ge1.                                             \tag{3}
\]
At each integer \(n\), its two atomic jumps cancel: \(-w_n/n+w_n/n=0\), so \(F_d\) is continuous. On each open integer interval,
\[
 F_d'(x)=\frac1x-\frac{\psi_d(x)}{x^2}
          =-\frac{E_d(x)}{x^2}.                            \tag{4}
\]
Equations (3)--(4), \(F_d(1)=0\), and the same facts for \(F_c\) show
\[
 F_d(x)-F_c(x)=-\int_1^x\frac{D(t)}{t^2}dt,
 \qquad D(t)=\psi_d(t)-\psi_c(t).                           \tag{5}
\]
Because \(\psi_c\) is increasing, \(D\le0\). Its derivative is bounded on the tail (indeed \(\psi_c'=1+O(x^{-1/10})\)), and it has only the common atom at \(2\); hence \(|D(x)|\le C\) globally. In particular \(F_d\ge F_c>0\) for \(x>1\), and the finite limit \(\kappa_d=\lim_{x\to\infty}F_d(x)\) satisfies \(\kappa_d\ge\kappa_c>0\). With \(d_\infty=\kappa_d-\kappa_c\), the exact quadrature tail is
\[
 F_d(x)=F_c(x)+d_\infty+O(x^{-1}),\qquad
 E_d(x)=E_c(x)+O(1).                                       \tag{6}
\]
Integration by parts after \(y=e^{bv}\) gives \(\int_u^\infty r_c(v)\,dv=O(e^{-(a+b)u})\), hence \(F_c(x)=\kappa_c+O(x^{-(a+b)})=\kappa_c+O(x^{-1/2})\). Thus \(F_d(x)=\kappa_d+O(x^{-1/2})\). Put \(c=\kappa_c/\kappa_d\in(0,1]\) and \(r_d(u)=E_d(e^u)/(e^uF_d(e^u))\). Exact algebra, with no replacement of \(F_d\) inside the score, gives
\[
 r_d(u)=\frac{F_c(e^u)}{F_d(e^u)}r_c(u)
             +\frac{D(e^u)}{e^uF_d(e^u)}
       =c\,r_c(u)+O(e^{-(2a+b)u})+O(e^{-u})
       =c\,r_c(u)+O(e^{-0.8u}).                            \tag{7}
\]
Here \(F_c/F_d=c+O(e^{-(a+b)u})\). In particular \(r_d^2=c^2r_c^2+O(e^{-1.1u})\). Every bound is uniform on the future tail \(u+t\), \(t\ge0\).

For \(H_0(t)=t^2e^{-t}\), \(K_0(t)=2t(t-1)e^{-t}\), \(L=\log2\), define the **actual integer-atomic score of this model** by the Stieltjes difference
\[
 \mathcal G_{Y,0}^{(d)}=\int_{[Y,\infty)}
    \frac{H_0(\log(x/Y))}{xF_d(x)}\,dE_d(x),\qquad
 J_0^{(d)}(u)=\mathcal G_{e^u,0}^{(d)}-\mathcal G_{2e^u,0}^{(d)}.  \tag{8}
\]
The source is locally finite, \(F_d\) is continuous, and \(H_0(0)=0\), so Stieltjes integration by parts, including atoms, gives the **exact** original-ground formula
\[
 J_0^{(d)}=T_{K_0}\Delta r_d-T_{H_0}\Delta(r_d^2).     \tag{9}
\]
At \(x=2Y\in\mathbb N\), the old-base term in (8) contains \(w_{2Y}H_0(\log2)/(2YF_d(2Y))\); the new-base term is zero at that atom. This is the same right-endpoint convention as the actual prime-power formula. The density \(-dx\) in \(dE_d=d\psi_d-dx\) is also retained.

Since \(H_0,K_0\in L^1\) and (7) is uniform on future shifts,
\[
 T_{K_0}\Delta r_d=c\,T_{K_0}\Delta r_c+O(e^{-0.8u}),\qquad
 T_{H_0}\Delta(r_d^2)=c^2T_{H_0}\Delta(r_c^2)+O(e^{-1.1u}). \tag{10}
\]
\(T_{K_0}r_c\) has the form \(e^{-au}\operatorname{Im}\int_1^\infty B_K(y)e^{ie^{bu}y}dy\), where \(B_K(y)=K_0(b^{-1}\log y)y^{-a/b}/(by)\). Here \(B_K(1)=0\), \(B_K''\in L^1\), and two integrations by parts yield \(O(e^{-(a+2b)u})\), also after shifting \(u\) by \(L\). For \(r_c^2\), use \(\sin^2z=(1-\cos2z)/2\): \(\int_0^\infty H_0(t)e^{-2at}dt=2/(1+2a)^3\), while the oscillating part has three integrations by parts because its transformed amplitude and first derivative vanish at \(y=1\). This proves the two displayed estimates, including their lower endpoint contributions.
Thus \(T_{K_0}\Delta r_c=O(e^{-0.7u})\) and
\(T_{H_0}\Delta(r_c^2)=[(1-2^{-0.6})/1.6^3]e^{-0.6u}+O(e^{-1.2u})\). Therefore
\[
 \boxed{J_0^{(d)}(u)
  =-c^2\frac{1-2^{-0.6}}{1.6^3}e^{-0.6u}+O(e^{-0.7u}).}   \tag{11}
\]
This is stronger than an RH-scale \(O_\epsilon(e^{-(1/2-\epsilon)u})\) score estimate. Yet at \(x_k=(\pi/2+2\pi k)^5\), (6) gives
\[
 E_d(x_k)=\kappa_c x_k^{0.7}(1+o(1))+O(1),             \tag{12}
\]
so \(E_d(x)=O_\epsilon(x^{1/2+\epsilon})\) fails for \(\epsilon<0.2\). The same fixed-small-positive-clock factor \(J_s^{(d)}=T_{\mu_s}J_0^{(d)}\) transfers (11), because the finite signed causal clock measure is independent of the observing source.

The obstruction is deliberately limited. The integer weights in (2) carry a smooth chirped density of size \(1+O(n^{-1/10})\); they do not have actual prime-power support or von Mangoldt weights. The theorem rules out a pointwise nonlinear inverse based only on positivity, integer atomicity, \(F'=-E/x^2\), and the original score kernel. Any inverse for the actual \(\Lambda\) source must exploit its additional arithmetic structure.
