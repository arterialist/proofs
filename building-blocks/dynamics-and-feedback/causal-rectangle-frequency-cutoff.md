# An exact causal rectangle decomposition and a cube-root frequency cutoff

Use the actual $a(s)=e^{-s/2}(\psi(e^s)-e^s)$, causally extended, and fix $t\ge1$. This is a written alternative to the support split in the [successor theorem](../successor-and-division/actual-successor-frequency-cutoff.md). Put $L=1+t$, $J=\lceil t\rceil$, and $R=\lfloor t\rfloor+2$. Let $\theta$ be the $C^1$ monotone step equal to zero below zero, equal to $3r^2-2r^3$ for $0\le r\le1$, and equal to one above one. Thus $0\le\theta\le1$ and $|\theta'|\le3/2$.

On the nonnegative half-line define
$$
\beta_0(s)=1-\theta(s),\qquad
\beta_j(s)=\theta(s-j+1)-\theta(s-j)\quad(1\le j\le J),
\qquad f_j=\beta_ja.
$$
All $f_j$ are extended by zero to negative times. Telescoping gives
$$
\sum_{j=0}^J\beta_j(s)=1-\theta(s-J)=1\qquad(0\le s\le t).
\tag{1}
$$
Each $f_j$ is supported on $[\max(0,j-1),j+1]$. The cutoffs vanish continuously at their positive support endpoints, so they introduce no boundary atoms. Only $f_0'$ contains the initial atom $-\delta_0$. Every prime-power atom has its literal coefficient $\beta_j(\log n)\Lambda(n)/\sqrt n$.

Keep the finite set of **ordered** pairs
$$
\mathcal P_t=\{(j,k):0\le j,k\le J,\ j+k\le R\}.
$$
For an omitted pair, $j+k>t+2$, so its lower support sum exceeds $t$. Consequently
$$
\boxed{g(s)=(a*a)(s)=\sum_{(j,k)\in\mathcal P_t}(f_j*f_k)(s)
\quad\text{for every }0\le s\le t.}
\tag{2}
$$
This is simultaneous in $s$, as required by harmonic sampling and the final causal filter. There are $O(L^2)$ pairs. Every retained upper support sum is at most $j+k+2\le t+4$. No discontinuous cutoff in the sum variable $u+v$ was introduced.

## Localized successor estimates

Assume only the elementary Chebyshev bound $\psi(y)\le By$, with $B\ge1$. The distributional decomposition is
$$
f_j'=\sum_n c_{j,n}\delta_{\log n}+w_j(s)ds,
\quad
w_j=\beta_j'a-\beta_j(a/2+e^{s/2}).
$$
Set $Q_j=\sum|c_{j,n}|^2$, $R_j=\sum n|c_{j,n}|^2$, and $V_j=\|w_j\|_2^2$. The support has logarithmic length at most two. Partial summation and $\Lambda(n)^2\le(\log n)\Lambda(n)$ give
$$
Q_j\le\mathbf1_{j=0}+3B(j+1),\qquad
R_j\le\mathbf1_{j=0}+B(j+1)e^{j+1},\qquad
V_j\ll_B e^{j+1}.
\tag{3}
$$
For example, on $A<n\le B_0$, $A=e^{j-1}$, $B_0=e^{j+1}$, partial summation bounds $\sum\Lambda(n)/n$ by $B(1+\log(B_0/A))=3B$. Support endpoint coefficients vanish. The $j=0$ estimate follows from the same upper bound starting at one, together with its explicit initial atom.

The integer-location translation argument in [the successor theorem](../successor-and-division/actual-successor-frequency-cutoff.md) applies to each $f_j$, including its clustered jumps. Hence, for $\Omega\ge2$,
$$
E_j=\frac1{2\pi}\int_{|\xi|>\Omega}|\widehat f_j(\xi)|^2d\xi
\ll_B(j+1)\left(\Omega^{-1}+e^{j+1}\Omega^{-2}\right).
\tag{4}
$$

## Signed finite-band readout and its error

Define the signed product sum
$$
\mathcal B_t(\xi)=\sum_{(j,k)\in\mathcal P_t}\widehat f_j(\xi)\widehat f_k(\xi).
$$
It is integrable by finite-sum Cauchy–Schwarz. Equation (2) and Fourier inversion are exact on the entire causal interval. No product is replaced by an absolute square. The uniform error after restricting to $|\xi|\le\Omega$ is at most
$$
\sum_{(j,k)\in\mathcal P_t}\sqrt{E_jE_k}.
\tag{5}
$$
From (4), its three contributions are bounded by
$$
\frac1\Omega\sum_{j+k\le R}\sqrt{(j+1)(k+1)},
$$
$$
\frac1{\Omega^{3/2}}\sum_{j+k\le R}\sqrt{(j+1)(k+1)}
\left(e^{(j+1)/2}+e^{(k+1)/2}\right),
$$
$$
\frac1{\Omega^2}\sum_{j+k\le R}\sqrt{(j+1)(k+1)}e^{(j+k+2)/2}.
$$
Extending the nonnegative bounds to the full indicated triangle is harmless. The first sum is $O(L^3)$. For the second, put $h=R-j$; the inner $k$-sum is at most $(h+1)^{3/2}$, while $\sqrt{j+1}\le\sqrt{R+1}$. The convergent sum $\sum_{h\ge0}(h+1)^{3/2}e^{-h/2}$ therefore gives $O(L^{1/2}e^{t/2})$. For the third, group by $r=j+k$: its inner sum is $O((r+1)^2)$, and a geometric sum gives $O(L^2e^{t/2})$. Thus
$$
\sum_{\mathcal P_t}\sqrt{E_jE_k}
\ll_B\frac{L^3}{\Omega}
+\frac{L^{1/2}e^{t/2}}{\Omega^{3/2}}
+\frac{L^2e^{t/2}}{\Omega^2}.
\tag{6}
$$

The harmonic weights total at most $1+t=L$, and the full filter $I-k*$, $k(s)=e^{-3s/2}$, costs at most $5/3$ on the uniform norm. The same exact multiplier from the successor note can therefore be used with $\mathcal B_t$, including its endpoint term:
$$
\mathcal M_t(\xi)=\frac{1/2+i\xi}{3/2+i\xi}e^{i\xi t}
\sum_{d\le e^t}d^{-1-i\xi}
+\frac{e^{-3t/2}}{3/2+i\xi}\sum_{d\le e^t}\sqrt d.
$$
The resulting normalized full-readout error is
$$
\boxed{\ll_B\frac{L^4}{\Omega}
+\frac{L^{3/2}e^{t/2}}{\Omega^{3/2}}
+\frac{L^3e^{t/2}}{\Omega^2}.}
\tag{7}
$$
In particular $\Omega=e^{t/3}L$ gives a uniform $O_B(1)$ error, and $\Omega=e^{t/3}L^{7/3}$ gives $O_B(L^{-2})$. The literal same-prime cost is subtracted exactly as in the successor note and is not approximated by this operation.

At the proposed smaller cutoff $\Omega=e^{t/4}\operatorname{poly}(t)$, the middle bound in (7) contains $e^{t/8}$. Thus these pairwise $L^2$ estimates alone do not establish a quarter-power cutoff. This is a limitation of the estimate, not a counterexample to that cutoff: exact integer-product locations and a smooth Fourier kernel supply additional information beyond (5).
