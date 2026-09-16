# Radius-two compact strip: rational continuous rate and Schur constant

Fix

\[
 U=25{,}820{,}006,
 \qquad d_0=10^{-546},
 \qquad M=10^{500},
 \qquad a=\frac12.
 \tag{1}
\]

This note supplies a completely explicit lower bound for the outward continuous-arrival rate on \(2<|u|\le U\).  It then converts any explicit upper bound for the negative compact-strip part into a rational \(\varepsilon\) and a coarse Schur constant.  No numerical optimization is attempted.

## 1. A rational lower bound for the theta ratio

For \(x\ge1\), positivity of the theta series and its first term give

\[
 \Phi(x)\ge
 2\pi e^{5x/2}(2\pi e^{2x}-3)e^{-\pi e^{2x}}.
 \tag{2}
\]

Let \(r=|u|\).  For \(2<r\le U\) and \(0\le t\le1/2\), evenness gives

\[
 \frac{\Phi(u+\operatorname{sgn}(u)t)}{b(u)}
 =\frac{\Phi(r+t)}{2\cosh(r/2)}.
 \tag{3}
\]

Use only the rational inequalities

\[
 3<\pi<4,
 \qquad 2<e<3.
 \tag{4}
\]

Since \(x=r+t\ge2\), the algebraic prefactor in (2) is larger than \(18\).  Also

\[
 \pi e^{2x}<4\,3^{2U+1}=:Y,
 \qquad
 e^{-\pi e^{2x}}>e^{-Y}>3^{-Y}.
 \tag{5}
\]

Because \(U\) is even,

\[
 b(u)=2\cosh(r/2)<2e^{r/2}\le2e^{U/2}
 <2\,3^{U/2}.
 \tag{6}
\]

Define the integers

\[
 Y:=4\,3^{51{,}640{,}013},
 \qquad
 H:=Y+12{,}910{,}003,
 \tag{7}
\]

and the positive rational

\[
 \boxed{c_*:=9\,3^{-H}=3^{2-H}.}
 \tag{8}
\]

Equations (2)--(7) prove

\[
 \boxed{
 \inf_{\substack{2<|u|\le U\\0\le t\le1/2}}
 \frac{\Phi(u+\operatorname{sgn}(u)t)}{b(u)}
 >c_*.}
 \tag{9}
\]

This avoids an unproved monotonicity assertion for \(\Phi/b\): every factor was bounded uniformly on the whole compact rectangle.

## 2. Paying a generic compact-strip deficit

Suppose an explicit rational \(L\ge0\) has been proved such that

\[
 (D-\alpha_2)w(u)\ge-L
 \qquad(2<|u|\le U).
 \tag{10}
\]

Set

\[
 \delta_*:=\frac{d_0}{8}=\frac1{8\cdot10^{546}}.
 \tag{11}
\]

For \(0<\varepsilon<1/2\), integrate only the outward continuous displacements \(t\in[\varepsilon,1/2]\).  Since

\[
 r(t)=\frac{e^{-t/2}}{1-e^{-2t}}
 \ge\frac{e^{-1/4}}{2t}>\frac1{4t},
 \tag{12}
\]

where \(e^{1/4}<2\), (9) gives the uniform rate

\[
 q_\varepsilon(u)>
 \frac{c_*}{4}\log\frac{1/2}{\varepsilon}
 \qquad(2<|u|\le U).
 \tag{13}
\]

Define the integer

\[
 \boxed{
 B_L:=1+\left\lceil
 \frac{4(L+\delta_*M)}{c_*}
 \right\rceil}
 \tag{14}
\]

and the rational truncation

\[
 \boxed{\varepsilon_L:=\frac1{2\,3^{B_L}}.}
 \tag{15}
\]

Since \(\log3>1\),

\[
 \frac{c_*}{4}\log\frac{1/2}{\varepsilon_L}
 =\frac{c_*B_L\log3}{4}
 >L+\delta_*M.
 \tag{16}
\]

The barrier satisfies \(w\ge1\), so \(K_{\varepsilon_L}w\ge q_{\varepsilon_L}\).  Since \(w\le M\), equations (10) and (16) yield

\[
 (A_{\varepsilon_L}-\alpha_2)w
 \ge\delta_*M\ge\delta_*w
 \qquad(2<|u|\le U).
 \tag{17}
\]

The already certified outer estimate is stronger than \(\delta_*w\) for \(|u|>U\), so (17) completes the global barrier once a value of \(L\) is supplied.

## 3. An explicit coarse Schur bound

The public pointwise estimate is

\[
 C_\varepsilon^2\le\frac14\sup_u
 \int_{\substack{v\in O_2\\|u-v|\ge\varepsilon}}
 r(|u-v|)^2\frac{\Phi(v)}{b(v)}\,dv.
 \tag{18}
\]

The kernel \(r\) decreases.  Moreover, since \(d\nu=b\Phi\,dv\), \(b\ge2\), and \(\nu\) is a probability,

\[
 \int_{O_2}\frac{\Phi(v)}{b(v)}\,dv
 =\int_{O_2}\frac1{b(v)^2}\,d\nu(v)
 \le\frac14.
 \tag{19}
\]

Thus

\[
 C_\varepsilon\le\frac{r(\varepsilon)}4.
 \tag{20}
\]

For \(0<\varepsilon\le1/2\), the elementary inequality \(e^{2\varepsilon}\ge1+2\varepsilon\) gives

\[
 1-e^{-2\varepsilon}
 \ge\frac{2\varepsilon}{1+2\varepsilon}
 \ge\varepsilon,
 \qquad
 r(\varepsilon)\le\frac1\varepsilon.
 \tag{21}
\]

Substituting (15) therefore yields the explicit bound

\[
 \boxed{C_{\varepsilon_L}\le\frac1{4\varepsilon_L}
 =\frac{3^{B_L}}2.}
 \tag{22}
\]

Finally, the resolvent step may be recorded entirely in terms of \(L\):

\[
 \boxed{
 \|\psi_2\|_\infty
 \le\frac{MC_{\varepsilon_L}}{\delta_*}
 \le4\cdot10^{1046}\,3^{B_L}.}
 \tag{23}
\]

## 4. Substitution of the proved strip bound

The companion compact-strip estimate proves

\[
 (D-(1/2-d_0))w(u)\ge-10^{503}
 \qquad\text{for a.e. }2<|u|\le U.
 \tag{24}
\]

Since \(\alpha_2<1/2-d_0\) and \(w\ge0\), (24) implies (10) with

\[
 L=10^{503}.
\]

Instead of carrying the ceiling in (14), define the explicit integer

\[
 \boxed{
 B_*:=5\cdot10^{503}\,3^{H-2},
 \qquad
 H=4\,3^{51{,}640{,}013}+12{,}910{,}003.}
 \tag{25}
\]

Because

\[
 \delta_*M=\frac1{8\cdot10^{46}}
\]

and \(c_*^{-1}=3^{H-2}\), one has

\[
 B_*>
 \frac{4(10^{503}+1/(8\cdot10^{46}))}{c_*}.
 \tag{26}
\]

Thus the following are fully explicit rational constants:

\[
 \boxed{
 \varepsilon_*:=\frac1{2\,3^{B_*}},
 \qquad
 C_{\varepsilon_*}\le\frac{3^{B_*}}2,
 \qquad
 P_\infty:=\|\psi_2\|_\infty
 \le4\cdot10^{1046}\,3^{B_*}.}
 \tag{27}
\]

Indeed, \(\log3>1\) and (25) give directly

\[
 \frac{c_*}{4}\log\frac{1/2}{\varepsilon_*}
 =\frac54\,10^{503}\log3
 >10^{503}+\frac1{8\cdot10^{46}}
 =L+\delta_*M.
 \tag{28}
\]

Therefore, on the compact strip,

\[
 (A_{\varepsilon_*}-\alpha_2)w
 =(D-\alpha_2)w+K_{\varepsilon_*}w
 \ge-L+q_{\varepsilon_*}
 >\delta_*M\ge\delta_*w.
 \tag{29}
\]

For \(|u|\ge U\), the effective prime-return estimate proves

\[
 (D-\alpha_2)w(u)\ge\frac{dM}{4}
 >\frac{d_0M}{4}=2\delta_*M.
 \tag{30}
\]

There \(w=M\) and \(K_{\varepsilon_*}w\ge0\), so (30) is stronger than

\[
 (A_{\varepsilon_*}-\alpha_2)w\ge\delta_*w.
\]

Together with (29), this verifies the barrier inequality almost everywhere on all of \(O_2\).  Equations (25)--(27) are the final explicit radius-two constants obtained by this deliberately coarse route.
