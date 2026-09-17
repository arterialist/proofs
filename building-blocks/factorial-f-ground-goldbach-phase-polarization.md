# Phase cuts in the original factorial ground metric

RH Agent3, 2026-09-17. **Status:** unconditional written identity and asymptotic for the actual \(\Lambda\) source. It keeps every prime power, the original positive factorial ground, the moving unit-cell Goldbach cutoff, and both one-body centering terms. The phase square gives a positive uncentered pair cost, but its leading term cancels against the centered one-body row. The remaining term is a signed pairing with \(\psi(x)-x\); no RH bound follows.

## Exact pair square and centered polarization

Let \(X\) be a positive integer, \(F(x)>0\) the actual factorial ground, \(\kappa_F=1+\gamma\), and
\[
 w_F(x)=\frac1{x^2F(x)^2},\qquad
 \psi(x)=\sum_{n\le x}\Lambda(n),\qquad E(x)=\psi(x)-x.
\]
For any completely multiplicative \(\chi:\mathbb N\to\mathbb C\) with \(|\chi(n)|=1\), set
\[
 \psi_\chi(x)=\sum_{n\le x}\Lambda(n)\chi(n),\qquad
 \Delta_\chi(x)=\psi(x)-\psi_\chi(x),\qquad
 \mathscr E_X^\chi=\int_X^{2X}w_F(x)|\psi_\chi(x)-x|^2dx.
\tag{1}
\]
The original energy is \(\mathscr E_X=\mathscr E_X^1\). Proper powers carry the phase \(\chi(p^r)=\chi(p)^r\).

Use the actual max-threshold kernel from the [complete-clock pair identity](factorial-f-ground-complete-clock-weighted-flux-energy.md),
\[
 \mathcal K_{X,2X}(y)=\int_{\max(X,y)}^{2X}w_F(x)dx.
\]
The Hermitian phase pair row is
\[
 P_X^\chi=
 \sum_{m,n\le2X}\Lambda(m)\Lambda(n)
 \mathcal K_{X,2X}(\max(m,n))
 \operatorname{Re}\bigl(\chi(m)\overline{\chi(n)}\bigr)
 =\int_X^{2X}w_F(x)|\psi_\chi(x)|^2dx.
\]
Since \(|\chi(m)|=|\chi(n)|=1\), its difference from the untwisted row is the nonnegative square
\[
 \boxed{\displaystyle
 P_X-P_X^\chi
 =\frac12\sum_{m,n\le2X}\Lambda(m)\Lambda(n)
 \mathcal K_{X,2X}(\max(m,n))
 |\chi(m)-\chi(n)|^2\ge0.}
\tag{2}
\]
This max-threshold kernel is different from the cutoff \(m+n\le X\) in the [complete-history Goldbach phase law](goldbach-complex-prime-phase-square-transition.md). Its asymptotic coefficient must be computed separately.

The matching one-body row is
\[
 L_X^\chi=2\sum_{n\le2X}\Lambda(n)\operatorname{Re}\chi(n)
             \int_{\max(X,n)}^{2X}\frac{dx}{xF(x)^2}
          =2\int_X^{2X}xw_F(x)\operatorname{Re}\psi_\chi(x)\,dx.
\]
Because \(\mathscr E_X^\chi=P_X^\chi-L_X^\chi+\int_X^{2X}F(x)^{-2}dx\), direct polarization gives
\[
 \boxed{\displaystyle
 \mathscr E_X-\mathscr E_X^\chi
 =\int_X^{2X}w_F(x)
       \bigl(2E(x)\operatorname{Re}\Delta_\chi(x)
                         -|\Delta_\chi(x)|^2\bigr)\,dx.}
\tag{3}
\]
The positive phase cost (2) does not by itself bound the centered energy. The difference between the two nonnegative centered energies has the signed \(E\)-pairing in (3).

## The moving additive cutoff keeps the same cancellation

For each integer \(N\), let
\[
 a_N=\int_N^{N+1}w_F(x)dx,\qquad
 b_N=\int_{N+1/2}^{N+1}w_F(x)dx.
\]
Define \(T_N^\chi\) by replacing the factor \(1\) on every ordered pair in the [moving additive-total surrogate](factorial-f-ground-complete-clock-weighted-flux-energy.md#the-gap-correction-is-macroscopic-for-the-actual-prime-source) with
\(\operatorname{Re}(\chi(m)\overline{\chi(n)})\). Define
\(P_N^\chi=a_N|\psi_\chi(N)|^2\) and
\(D_N^\chi=T_N^\chi-P_N^\chi\).
Old pairs have the full cell weight; the only extra pairs contain the new index \(N+1\). Exact counting gives
\[
 \boxed{\displaystyle
 D_N^\chi=2\Lambda(N+1)\operatorname{Re}\!\left[
  \chi(N+1)\overline{
       a_N\sum_{m\le N-1}\Lambda(m)\chi(m)
                 +b_N\Lambda(N)\chi(N)}\right].}
\tag{4}
\]
The term with \(m=N\) has the half-cell weight \(b_N\); the pair
\((N+1,N+1)\) still has zero weight. In particular \(D_N^1\) is the positive correction in the source identity, while \(D_N^\chi\) can have either sign. Nevertheless
\[
\begin{aligned}
 D_N^1-D_N^\chi
 =2\Lambda(N+1)\bigg[&
 a_N\sum_{m\le N-1}\Lambda(m)
   \{1-\operatorname{Re}(\chi(N+1)\overline{\chi(m)})\}\\
 &+b_N\Lambda(N)
   \{1-\operatorname{Re}(\chi(N+1)\overline{\chi(N)})\}\bigg],
\end{aligned}
\tag{5}
\]
so \(0\le D_N^1-D_N^\chi\le2D_N^1\).

Twist the one-body center in the [exact centered additive consumer](factorial-f-ground-complete-clock-weighted-flux-energy.md#the-gap-correction-is-macroscopic-for-the-actual-prime-source) as well:
\[
 \mathcal U_X^\chi=
 \sum_{N=X}^{2X-1}T_N^\chi
 -2\sum_{n\le2X}\Lambda(n)\operatorname{Re}\chi(n)
                  \int_{\max(X,n)}^{2X}\frac{dx}{xF(x)^2}
 +\int_X^{2X}\frac{dx}{F(x)^2}.
\]
Partitioning the integral into unit cells proves the exact identity
\[
 \boxed{\quad
 \mathcal U_X^\chi
 =\mathscr E_X^\chi+\sum_{N=X}^{2X-1}D_N^\chi,\qquad
 \mathcal U_X-\mathcal U_X^\chi
 =\int_X^{2X}w_F(2E\operatorname{Re}\Delta_\chi-|\Delta_\chi|^2)dx
     +\sum_{N=X}^{2X-1}(D_N^1-D_N^\chi).
 \quad}
\tag{6}
\]
The first equation does not assert \(\mathcal U_X^\chi\ge0\): its successor correction is signed.

## A complete-history phase profile at the square-root scale

Fix \(c>0\) and \(\theta\in\mathbb R\). For this \(X\), set
\(\chi_X(p)=e^{i\theta}\) on primes \(p\le c\sqrt X\), and
\(\chi_X(p)=1\) on all other primes, extending completely multiplicatively.
Let \(\vartheta(y)=\sum_{p\le y}\log p\). Uniformly for \(1\le y\le2\), the PNT and the complete proper-power bound give
\[
 \frac{\Delta_{\chi_X}(yX)}{\sqrt X}
 \longrightarrow
 d_{c,\theta}(y)
 :=c(1-e^{i\theta})
     +\min(c,\sqrt y)(1-e^{2i\theta}).
\tag{7}
\]
The first term comes from all affected prime bases. The second is the square row \(p^2\le yX\). Powers \(p^r\) with \(r\ge3\) contribute
\(O(X^{1/3}\log X)=o(\sqrt X)\), uniformly on the dyadic interval.

The moving-cell correction in (6) is smaller than its general bounded ceiling:
\[
 \boxed{\displaystyle
 0\le\sum_{N=X}^{2X-1}(D_N^1-D_N^{\chi_X})
 =O_{c,\theta}(X^{-1/2}).}
\tag{8}
\]
To see this, the total \(\Lambda\)-weight of modified old indices \(n\le2X\) is \(O_c(\sqrt X)\) by the same prime-power count as (7). The total weight of modified *new* indices in \((X,2X]\) is also \(O_c(\sqrt X)\): their first powers lie below \(X\), leaving only squares and higher powers. On cells with \(\chi_X(N+1)=1\), (5) costs at most \(C\Lambda(N+1)\sqrt X/N^2\), whose sum is \(O(X^{-1/2})\) by \(\psi(2X)=O(X)\). On the other cells use \(D_N^1-D_N^{\chi_X}\le2D_N^1\ll\Lambda(N+1)/N\) and sum only over the \(O_c(\sqrt X)\) modified new weight. This retains adjacent proper powers in \(b_N\).

Finally \(F(x)\to\kappa_F\) and \(\psi(x)/x\to1\) uniformly on \([X,2X]\). Substitution of (7) into (2) and the one-body row gives matching leading terms:
\[
\begin{aligned}
 \frac{P_X-P_X^{\chi_X}}{\sqrt X}
 &\longrightarrow
 \frac{2}{\kappa_F^2}\int_1^2
               \frac{\operatorname{Re}d_{c,\theta}(y)}y\,dy,\\
 \frac{L_X-L_X^{\chi_X}}{\sqrt X}
 &\longrightarrow
 \frac{2}{\kappa_F^2}\int_1^2
               \frac{\operatorname{Re}d_{c,\theta}(y)}y\,dy,\\
 \int_X^{2X}w_F(x)|\Delta_{\chi_X}(x)|^2dx
 &\longrightarrow
 \frac1{\kappa_F^2}\int_1^2
               \frac{|d_{c,\theta}(y)|^2}{y^2}\,dy.
\end{aligned}
\tag{9}
\]
The common leading coefficient contains
\[
 \operatorname{Re}d_{c,\theta}(y)
 =c(1-\cos\theta)+\min(c,\sqrt y)(1-\cos2\theta).
\]
Its square-row integral differs from the \(g(c)\) coefficient of the [additive-total cut](goldbach-complex-prime-phase-square-transition.md): the F-ground row is max-threshold weighted and the cut moves with ordinary succession.

Equations (3), (6), (8), and (9) answer the coupling question. The positive phase square has a deterministic order-\(\sqrt X\) value in the original metric, and the one-body center has exactly the same leading value. What remains is the signed \(E\)-correlation and a vanishing successor correction. Positivity of the twisted energy merely restates the Hilbert-space square
\(\|E-\Delta_{\chi_X}\|_{L^2(w_F)}^2\ge0\); it supplies no unconditional upper bound for the original centered energy, no Goldbach existence theorem, and no RH estimate.
