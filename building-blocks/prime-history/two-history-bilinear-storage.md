# Two actual histories: bilinear storage and boundary flux

This is a written mathematical proof, not a Lean formalization. The [successor cutoff](../successor-and-division/actual-successor-frequency-cutoff.md) and [semilocal normalization](../weil-and-spectral/semilocal-weighted-scattering.md) fix the actual input and operator conventions.

This construction transports two copies of the actual input in opposite directions. It preserves the Fourier square, rather than replacing it by a positive spectral density. Its output is an exact finite-boundary conservation law. No sign or RH-scale bound for the resulting storage is assumed.

The conventions agree with [the dyadic finite-band flux](../prime-distribution/prime-innovation-finite-band-flux.md). The signed scalar-phase transport in [the signed phase transport](../weil-and-spectral/signed-scattering-phase-transport.md) is compatible with the cancellation below, but no estimate from that note is needed for this identity.

## 1. The actual input and opposite transports

Let $a(v)=e^{-v/2}(\psi(e^v)-e^v)$ for $v\ge0$, extended by zero for $v<0$. Take the continuous finite cutoff $f=f_t=\chi_ta$, with $t\ge1$, where $\chi_t=1$ through $t$, decreases linearly to zero at $t+1$, and is zero thereafter. All prime powers in $\psi$, the initial value $a(0)=-1$, the density, and the terminal taper remain in $f$.

Put $L=\log2$, $r=2^{-1/2}$,
$$
T_\pm F(v)=F(v\pm L),\quad D=I-rT_-,\quad A=I-rT_+,
\quad U=AD^{-1}.
$$
Both inverses exist on $L^2(\mathbb R)$ as norm-convergent geometric series. Define
$$
z=D^{-1}f,\qquad w=A^{-1}f,\qquad
p=Az=Uf,\qquad q=Dw=U^{-1}f.
\tag{1}
$$
With $\widehat F(\xi)=\int F(v)e^{-i\xi v}\,dv$,
$$
\widehat p(\xi)=\frac{1-re^{i\xi L}}{1-re^{-i\xi L}}\widehat f(\xi),
\qquad
\widehat q(\xi)=\frac{1-re^{-i\xi L}}{1-re^{i\xi L}}\widehat f(\xi).
$$
Consequently
$$
\widehat p\,\widehat q=\widehat f^{\,2},\qquad p*q=f*f.
\tag{2}
$$
These are bilinear products, without conjugation. For $0\le s\le t$, the last convolution is exactly the causal actual convolution $a*a(s)$.

## 2. A local discrete conservation law

For fixed $s$, define the bilinear current
$$
\begin{split}
\mathcal J_s(v)={}&r\{z(v+L)w(s-v)+z(v)w(s-v-L)\}\\
&-r^2\{z(v+L)w(s-v-L)+z(v)w(s-v)\}.
\end{split}
\tag{3}
$$
Direct expansion of $(Dz)(v)(Aw)(s-v)-(Az)(v)(Dw)(s-v)$ gives
$$
\boxed{f(v)f(s-v)-p(v)q(s-v)
=\mathcal J_s(v)-\mathcal J_s(v-L).}
\tag{4}
$$
Thus every finite interval $[\alpha,\beta]$ has the exact storage/flux law
$$
\int_\alpha^\beta[f(v)f(s-v)-p(v)q(s-v)]\,dv
=\int_{\beta-L}^{\beta}\mathcal J_s(v)\,dv
-\int_{\alpha-L}^{\alpha}\mathcal J_s(v)\,dv.
\tag{5}
$$
There is no discarded terminal term. All products on finite strips are integrable by Cauchy--Schwarz. For this compact actual input the geometric series also give ordinary locally bounded representatives, so expansion (4) can be read pointwise apart from irrelevant jump values.

## 3. The two exterior histories collapse to two finite strips

For $s\ge0$, let
$$
\mathcal I_f(s)=\int_0^s p(v)q(s-v)\,dv.
$$
The causal resolvent $z$ vanishes for negative arguments. On $0<u<L$,
$$
p(-u)=-r f(L-u)=e^{-u/2}=:\eta(-u).
\tag{6}
$$
This is the retained actual seed, since $a(v)=-e^{v/2}$ before the first prime arrival. It has squared norm
$\int_0^L e^{-u}du=1/2$, agreeing with the one-history normalization.

The full inverse history satisfies
$$
q(v)=-r f(v-L)+(1-r^2)\sum_{j\ge0}r^jf(v+jL).
\tag{7}
$$
In particular
$$
q(-u-jL)=r^jq(-u),\qquad 0<u<L, j\ge0.
\tag{8}
$$
Its infinite left tail is therefore determined by its one-strip value $q(-u)$, but that strip is not a free seed. It depends on the entire finite actual input.

Equation (5) on $[0,s]$, or equivalently splitting the whole convolution in (2) at $0,s$, gives
$$
\boxed{
(f*f)(s)=\mathcal I_f(s)
+\int_0^L\left[e^{-u/2}q(s+u)+q(-u)z(s+u)\right]du.
}
\tag{9}
$$
Here is the exact collapse of the potentially infinite right exterior integral. Using (8),
$$
\begin{split}
\int_s^\infty p(v)q(s-v)\,dv
&=\int_0^Lq(-u)\sum_{j\ge0}r^jp(s+u+jL)\,du\\
&=\int_0^Lq(-u)(A^{-1}p)(s+u)\,du\\
&=\int_0^Lq(-u)z(s+u)\,du.
\end{split}
$$
Absolute integrability follows from $p,q\in L^2$; alternatively the series is norm-convergent and can be paired on a finite strip. The left exterior is supported only on $(-L,0)$, where (6) gives its term in (9).

The two strip values in (9) keep the terminal cutoff even when $s+u>t$. Replacing them by an untruncated history would be a further operation, not part of this identity.

## 4. The inverse strip is an actual division response

Substituting the actual $f_t$ into (7) yields, for $0<u<L$,
$$
\boxed{
q(-u)=(1-r^2)e^{-u/2}
\sum_{j\ge1}\chi_t(jL-u)
\left[\frac{\psi(2^je^{-u})}{2^je^{-u}}-1\right].
}
\tag{10}
$$
At each cutoff this is a finite sum, including every prime-power arrival encountered by the dyadic history. Thus (9) isolates two specified boundary responses: the fixed first-prime seed and the actual finite dyadic relative-error history. It does not turn the second response into a positive quantity or into the one-history flux $1/2$.

## 5. Finite-frequency storage retains the commutator

Write $\mathcal B_s(F,G)=\int_{\mathbb R}F(v)G(s-v)\,dv$, and let $P$ be multiplication by $1_{[0,\infty)}$. Let $Q$ be an even real bounded Fourier multiplier $q_0(\xi)$ of compact support. It commutes with $U,U^{-1}$, and
$$
\mathcal B_s(Qp,Qq)=\mathcal B_s(Qf,Qf)
=\frac1{2\pi}\int q_0(\xi)^2\widehat f(\xi)^2e^{i\xi s}\,d\xi.
\tag{11}
$$
One may take the sharp orthogonal low-pass projection; for a smooth flat-top multiplier $m$, choose $m=q_0^2$. Define the negative-time inverse response $\kappa=(I-P)q$, and keep $\eta=(I-P)p$ from (6). Then
$$
(I-P)Qp=Q\eta-[P,Q]p,
\qquad (I-P)Qq=Q\kappa-[P,Q]q.
$$
For $s\ge0$, two negative-time functions have zero convolution at $s$. Hence the exact finite-band storage law is
$$
\begin{split}
\mathcal B_s(Qf,Qf)={}&\int_0^s(Qp)(v)(Qq)(s-v)\,dv\\
&+\mathcal B_s(Q\eta-[P,Q]p,Qq)\\
&+\mathcal B_s(Qp,Q\kappa-[P,Q]q).
\end{split}
\tag{12}
$$
The commutators cannot be removed: low-pass filtering does not preserve the causal support used in (9). Formula (12) keeps the complex square and both leakage terms instead of replacing them by a Hermitian norm.

## 6. Finite products and the remaining comparison

The local identity (4)--(5) works for two different inputs: take $Dz=F$, $Aw=G$, and replace $f(v)f(s-v)$ by $F(v)G(s-v)$. It therefore telescopes over any finite collection of prime factors, using $L_p=\log p$, $r_p=p^{-1/2}$, transporting the two histories by $U_p$ and $U_p^{-1}$ at each step. The Fourier product remains $\widehat f^2$ at every stage; every local resolvent retains its complete geometric prime-power series.

After the first factor the histories need not be causal. Accordingly the subsequent boundary currents must be retained as the actual currents in (5), rather than assigned the first factor's fixed seed or its positive one-history norm. The exact construction reduces the comparison to signed finite-strip interactions. Bounding their contribution to the harmonic/filter readout remains a separate arithmetic obligation; no positivity or RH-scale estimate is asserted here.

## 7. The complete arithmetic W consumer

Keep the same actual cutoff f_t at every intermediate time 0<=s<=t,
and define the complete strip response from (9) by

$$
\mathcal C_f(s)=\int_0^L
\left[e^{-u/2}q(s+u)+q(-u)z(s+u)\right]du.
$$

For a function b on the causal half-line, write the actual combined
harmonic and causal-filter readout as

$$
\mathcal T_t b=\sum_{d\le e^t}\frac{b(t-\log d)}d
-\int_0^t e^{-3(t-s)/2}
\sum_{d\le e^s}\frac{b(s-\log d)}d\,ds.
$$

The [exact arithmetic reflection formula](../analytic-methods/harmonic-convolution.md) and (9) give

$$
\boxed{
e^{-3t/2}W(e^t)
=\mathcal T_t\mathcal I_f+\mathcal T_t\mathcal C_f
-e^{-3t/2}S_{\rm crit}(e^t).
}
\tag{13}
$$

The same-prime subtraction is literal:

$$
S_{\rm crit}(x)=\sum_{d\le x}\sqrt d
\sum_{p^j\le x/d}(x/d-p^j)(j-1)(\log p)^2.
$$

Thus (13) contains all ordered pairs, proper powers, baseline, new
critical scales and the initial filter contribution. It supplies the
specific consumer for a future estimate on bilinear storage or its
boundary current. No sign of either contribution is assumed.

There is an exact initial compensation worth making explicit. Since
f is causal, (f*f)(0)=0 and I_f(0)=0, so C_f(0)=0. Directly, z(u)=f(u)
=-exp(u/2) for 0<u<L, and

$$
\int_0^L e^{-u/2}q(u)\,du
=(1-r^2)\int_0^\infty\chi_t(v)
\left[\frac{\psi(e^v)}{e^v}-1\right]dv,
$$
$$
\int_0^L q(-u)z(u)\,du
=-(1-r^2)\int_0^\infty\chi_t(v)
\left[\frac{\psi(e^v)}{e^v}-1\right]dv.
\tag{14}
$$

These two finite-cutoff terms cancel exactly. The positive one-history
seed norm 1/2 therefore cannot be substituted for this bilinear initial
response. Equations (13)--(14) retain the mechanism that a signed
two-history estimate must use.
