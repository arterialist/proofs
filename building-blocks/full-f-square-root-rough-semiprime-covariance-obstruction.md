# Rough-semiprime covariance at the square-root divisor cutoff

2026-09-16. This proves an asymptotic obstruction on the actual Euler
source. A balanced rough-divisor sector cannot be charged separately to
an additive fixed-power error, even when the cutoff is exactly
\(D=\lfloor\sqrt X\rfloor\). The theorem does not bound the complete
signed energy from below and does not rule out its desired global upper
bound.

Fix a finite first-block clock \(s\), put \(p_s>0\), and retain the actual
full-prime-power factorial ground, with \(F(x)\to\kappa_F>0\). Write
\[
 w_Y(x)=\frac{p_s^2Y\log^2(x/Y)}{x^2F(x)}
             \mathbf1_{[Y,2Y)}(x),\qquad
 R_X(x,y)=\int_X^{2X}w_Y(x)w_Y(y)\,\frac{dY}{Y}.
\]
Let \(\langle f,g\rangle_X=\int_X^{2X}f(Y)g(Y)dY/Y\). The exact
cutoff coefficients are
\[
 a_D(n)=\sum_{\substack{d\mid n\\d\le D}}\mu(d)\log(n/d),
 \qquad t_D(n)=\Lambda(n)-a_D(n).
\]
Thus the full score is \(B=L_D+T_D\), where
\[
 L_D(Y)=\sum_n a_D(n)w_Y(n)-\int_Y^{2Y}w_Y(x)dx,
 \qquad T_D(Y)=\sum_n t_D(n)w_Y(n).
\]
All endpoints are literal, and all proper powers remain in \(\Lambda\)
and in \(F\).

## The whole rough high-divisor sector has logarithmic-sized energy

Let \(P^-(n)\) be the least prime factor of \(n\), and define
\[
 d\tau_R(n)=
 \sum_{\substack{X\le n<4X\\P^-(n)>D}}t_D(n)\delta_n,
 \qquad U_R(Y)=\int w_Y\,d\tau_R.
\]
For every sufficiently large \(X\), this is a nonpositive atomic measure.
Moreover,
\[
 \boxed{\quad
 U_R(Y)\le-\frac{c_s}{\log X}
       \quad(X\le Y\le21X/20),\qquad
 \|U_R\|_X^2\asymp_s\frac1{\log^2X}.
 \quad}                                                    \tag{1}
\]

To prove the sign, no nonunit divisor of a \(D\)-rough integer is admitted
to \(a_D\), so \(a_D(n)=\log n\). For sufficiently large \(X\), such an
integer below \(4X\) has at most two prime factors, counted with
multiplicity: three factors would give \(n>D^3>4X\). At a prime,
\(t_D=0\); at distinct-prime \(pq\), \(t_D=-\log(pq)\); and at
\(p^2\), \(t_D=-\log p\). This includes the rough proper-power sector
with its correct coefficient.

For the quantitative lower bound, choose actual primes in the disjoint
ranges
\[
 \frac{11}{10}\sqrt X\le p<\frac{23}{20}\sqrt X,
 \qquad
 \frac75\sqrt X\le q<\frac{29}{20}\sqrt X.
                                                               \tag{2}
\]
Both primes exceed \(D\). The products are distinct, since the two factor
ranges are disjoint, and lie in
\[
 \frac{77}{50}X\le pq<\frac{667}{400}X.
                                                               \tag{3}
\]
The prime number theorem gives
\[
 \#\{p\}\sim\frac1{10}\frac{\sqrt X}{\log X},\quad
 \#\{q\}\sim\frac1{10}\frac{\sqrt X}{\log X},\quad
 \sum_{p,q}\log(pq)\sim\frac1{100}\frac{X}{\log X}.
                                                               \tag{4}
\]
For \(X\le Y\le21X/20\), every product in (3) belongs strictly to the
observing window. Its ratio to \(Y\) lies between \(154/105\) and
\(667/400\). Positivity and convergence of the actual ground therefore
give \(w_Y(pq)\ge c_s/X\), uniformly. Equations (3)--(4) prove the
pointwise lower bound in (1). All remaining rough coefficients are
nonpositive, so they cannot cancel it.

For the upper bound, any rough semiprime in \([X,4X)\) has both factors
in \((D,4X/D]\subset(\tfrac12\sqrt X,8\sqrt X]\) for large \(X\).
There are \(O(\sqrt X/\log X)\) possible primes, hence
\(O(X/\log^2X)\) products. Their total coefficient variation is
\(O(X/\log X)\). Rough squares contribute only \(O(\sqrt X)\) to that
variation and are retained. Since \(w_Y\ll_s X^{-1}\) throughout the
shell, \(|U_R(Y)|\ll_s1/\log X\). Integrating its square, and using the
positive logarithmic length of \([X,21X/20]\), proves (1).

## The density pairing and its exact signs

Define the positive density score
\[
 V(Y)=\int_Y^{2Y}w_Y(x)dx
 =p_s^2\int_1^2\frac{\log^2v}{v^2F(Yv)}dv.
\]
It converges uniformly on the shell to
\[
 v_s=\frac{p_s^2}{\kappa_F}
       \left(1-\log2-\frac{(\log2)^2}{2}\right)>0.
\]
Consequently the actual rough high source and the **positive** density
have the signed bilinear pairing
\[
 \boxed{\quad
 \iint R_X(n,x)\,d\tau_R(n)\,dx
 =\langle U_R,V\rangle_X
 \asymp_s-\frac1{\log X}.
 \quad}                                                     \tag{5}
\]
Here \(A\asymp-1/\log X\) means
\(-C_s/\log X\le A\le-c_s/\log X\).

The signs in the complete source are explicit. For the selected
distinct-prime products (2), let
\(d\alpha=\sum_{p,q}\log(pq)\delta_{pq}\), and
\(S(Y)=\int w_Yd\alpha>0\). Their low coefficient is \(+\alpha\)
and their high coefficient is \(-\alpha\). If
\(I_X=\langle S,V\rangle_X\asymp_s1/\log X\), their ordered
crosses with the actual negative density \(-dx\) are respectively
\[
 2\langle+\alpha,R_X(-dx)\rangle=-2I_X,
 \qquad
 2\langle-\alpha,R_X(-dx)\rangle=+2I_X.
                                                               \tag{6}
\]
They cancel exactly. Their low/high atomic sector energies likewise
give \(\|S\|^2-2\|S\|^2+\|S\|^2=0\), with
\(\|S\|^2\asymp_s1/\log^2X\). Discarding either density cross or
either matching divisor history loses a quantity larger than every
fixed negative power of \(X\).

The obstruction also reaches the far density cross. Set
\(K_H=\mathbf1_{|n-x|>H}R_X\), with \(1\le H\le X/4\).
Restrict the positive density variable to
\([23X/20,5X/4]\), while retaining products (3) and
\(Y\in[X,21X/20]\). Both arguments remain strictly inside the observing
window and
\(n-x\ge(77/50-5/4)X=29X/100>H\).
Both weights are bounded below by \(c_s/X\), so
\[
 \sum_{p,q}\log(pq)
   \int_{23X/20}^{5X/4}K_H(pq,x)dx
 \asymp_s\frac1{\log X}.                                  \tag{7}
\]
The low and high crosses with negative density again have the opposite
signs displayed in (6). Equation (7) is a far **density pairing**;
no assertion is made that the selected semiprime-semiprime pairs are
themselves far apart.

## Even optimal scalar density centering leaves a logarithmic energy

There is a concrete obstruction to repairing the rough block by assigning
it an optimally chosen multiple of the density. Put
\[
 C_0=\int_1^2\frac{\log^2z}{z^2}dz>0,\quad
 C_1=\int_1^2\frac{\log^3z}{z^2}dz,\quad L=\log2.
\]
The actual rough source has the uniform asymptotic profile
\[
 \boxed{\quad
 U_R(vX)=-\frac{2p_s^2}{\kappa_F\log X}
              (C_0\log v+C_1)+o_s(1/\log X),
 \qquad1\le v\le2.
 \quad}                                                     \tag{8}
\]

Here is a proof using only PNT on fixed-ratio prime intervals. The
positive measures
\[
 \frac{\log X}{2\sqrt X}\sum_{p>D}\delta_{p/\sqrt X}
\]
converge weakly to Lebesgue measure on every fixed compact subinterval
of \([1,\infty)\). Form their product on
\(a,b\ge1,ab\le4\). Its boundary has limiting two-dimensional measure
zero, and the diagonal prime pairs have negligible mass. Distinct
unordered pairs contribute one half of the ordered product; their
weight \(\log(pq)/\log X\) tends uniformly to 1. Rough squares have
negligible mass at this normalization, although they remain in
\(\tau_R\). It follows that the positive measure
\[
 \nu_X=\frac{\log X}{X}
       \sum_{\substack{X\le n<4X\\P^-(n)>D}}
                  [-t_D(n)]\delta_{n/X}
\]
converges weakly on \([1,4]\) to \(2\log t\,dt\). Indeed the product
pushforward gives
\[
 2\int_{a,b\ge1,\ ab\le4}h(ab)\,da\,db
 =2\int_1^4h(t)\log t\,dt.
\]

Substitute \(n=Xt\), \(Y=Xv\) in the literal weight and use uniform
\(F(Xt)\to\kappa_F\). The remaining compact test family
\[
 \frac{v\log^2(t/v)}{t^2}\mathbf1_{[v,2v)}(t),\quad1\le v\le2,
\]
has uniformly bounded variation. Since the limiting measure has a
continuous distribution function, the distribution functions of
\(\nu_X\) converge uniformly. Stieltjes integration by parts therefore
makes the convergence uniform in \(v\), including the moving upper
cutoff. The limit integral is
\[
 -\frac{2p_s^2}{\kappa_F}
   \int_v^{2v}\frac{v\log^2(t/v)}{t^2}\log t\,dt
 =-\frac{2p_s^2}{\kappa_F}(C_0\log v+C_1),
\]
which proves (8).

Allow an arbitrary real scalar \(c_X\), chosen after seeing the complete
rough source and actual density. The optimal density-centering error is
\[
 \boxed{\quad
 \min_{c\in\mathbb R}\|U_R+cV\|_X^2
 \sim\frac{p_s^4C_0^2L^3}{3\kappa_F^2\log^2X}>0.
 \quad}                                                     \tag{9}
\]
To see this, use \(u=\log(Y/X)\in[0,L]\). By (8),
\((\log X)U_R\) converges uniformly to
\(-2p_s^2(C_0u+C_1)/\kappa_F\), while
\(V\to p_s^2C_0/\kappa_F\) uniformly. Orthogonal projection onto the
one-dimensional span of \(V\) is continuous under these limits. It
removes the constant part, leaving
\[
 \frac{4p_s^4C_0^2}{\kappa_F^2}
       \int_0^L(u-L/2)^2du
 =\frac{p_s^4C_0^2L^3}{3\kappa_F^2}.
\]
The optimal scalar itself satisfies
\(c_X\sim[L+2C_1/C_0]/\log X\), so this obstruction already applies
to a small positive density allocation, not just unrestricted signed
reweighting. Thus even optimally removing the rough sector's scalar
density component cannot leave an additive fixed-power error. Its
remaining logarithmic-scale variation must also be canceled by other
actual divisor histories.

## What an additive-error repair must retain

For every fixed \(\delta>0\) and fixed \(C\), the upper bound
\(\|U_R\|_X^2\le C X^{-\delta}\) fails for all sufficiently large
\(X\). The analogous absolute fixed-power payment of (5), (6), or (7)
also fails. This concerns the entire actual rough high sector, not a
perturbed source or merely a chosen unsigned majorant.

There is no resulting lower bound for \(\|T_D\|^2\) or \(\|B\|^2\).
Other high-divisor coefficients have both signs and can cancel the
rough sector, while its matching low histories cancel pointwise. A
modified global covariance argument must retain these cross terms.
Equations (1) and (9) refute both a separate-sector additive fixed-power
payment and its optimal scalar-density-centering repair. A varying
density profile or another collective signed estimate is not ruled out.
Neither result refutes nor proves a bound for the complete signed
covariance.
