# A moment-method barrier for the finite prime comb

This note concerns a particular proposed estimate for the high-frequency tail
of a finite prime comb. It is a quantitative limitation of the estimate, not a
limitation of the actual prime phases or a claim about the Riemann hypothesis.

Let \(N\to\infty\), \(L=\log N\), and
\[
D_N(t)=\sum_{p\le N}\frac{\log p}{\sqrt p}\,p^{it},\qquad
D_N(t)^k=\sum_m b_k(m)m^{it},\qquad
S_k=\sum_m|b_k(m)|^2,\quad W_k=\sum_m m|b_k(m)|^2.
\tag{1}
\]
The [Montgomery–Vaughan mean-value inequality](https://personal.science.psu.edu/rcv4/personal/Publications/s2-8-1-73.pdf), Corollary 3, gives an absolute constant \(C>0\) such that
\[
\int_T^{2T}|D_N(t)|^{2k}dt\le T S_k+C W_k.
\tag{2}
\]
Suppose an exceptional-set argument uses (2), Markov's inequality, and only
\(|\widehat f(t)|^2\le2a\|f\|_2^2\) for \(f\) supported on an interval of
length \(2a\). Its resulting upper bound for the contribution above a
threshold \(\lambda\) has the factor
\[
U_k=a\lambda^{1-2k}(T S_k+C W_k).
\tag{3}
\]
The constants in the elementary uncertainty bound have no effect on the
asymptotics below.

**Theorem.** Fix \(0<\eta<1\), \(c>0\), and put
\(h=N^\eta\), \(T=e^h\), \(\lambda=ch\), \(a=L/2\). Then
\[
\boxed{\lim_{N\to\infty}\frac1h\log\inf_{k\ge1}U_k=1-\eta.}
\tag{4}
\]
In particular, optimizing every integer moment in this *specific* upper
bound cannot make the error small at \(\log T=N^\eta\). This remains true
when the exact weighted error \(W_k\), rather than the coarser \(N^kS_k\),
is retained.

**Proof.** Unique factorization and the multinomial theorem imply
\[
S_k\le k! V^k,
\qquad V=\sum_{p\le N}\frac{(\log p)^2}{p}
       =\left(\tfrac12+o(1)\right)L^2,
\qquad W_k\le N^k S_k.
\tag{5}
\]
The asymptotic for \(V\) follows from the prime number theorem by partial
summation. Set \(k_0=\lfloor h/L\rfloor\). Stirling's formula in (5) gives
\(\log S_{k_0}\le(\eta+o(1))h\). Since \(k_0L=h+o(h)\) and
\(2k_0\log\lambda=(2\eta+o(1))h\), both terms of (3) at \(k_0\)
have logarithm at most \((1-\eta+o(1))h\). This proves the upper bound
in (4).

For the reverse bound, there are \(\asymp N/L\) primes in \([N/2,N]\).
Taking products of \(k\) *distinct* such primes, and noting
\(k_0=o(N/L)\), yields an absolute \(c_1>0\) such that
\[
S_k\ge k!(c_1L)^k\qquad(1\le k\le k_0).
\tag{6}
\]
Indeed, each unordered selection appears with multiplicity \(k!\) in
\(D_N^k\). Applying \(\log k!\ge k\log k-k\) to the \(T S_k\)
term of (3), uniformly over this range, gives
\[
\log U_k\ge(1-\eta-o(1))h\qquad(1\le k\le k_0).
\tag{7}
\]
For clarity, writing \(x=kL/h\in(0,1]\), the lower bound divided by
\(h\) is \(1-\eta x+O((1+|x\log x|)/L)\), whose minimum is
\(1-\eta+o(1)\).

The same distinct-prime products, now weighted by their integer product,
give
\[
W_{k_0}\ge k_0!(c_2 N L)^{k_0},
\qquad W_{k_0}^{1/k_0}\ge c_3Nh
\tag{8}
\]
with positive absolute constants. If
\(E_N(z)=\sum_{p\le N}(\log p)z_p\) on the product torus of prime
phases, orthogonality gives \(W_k=\int|E_N(z)|^{2k}dz\). Monotonicity
of probability-space \(L^q\) norms therefore gives
\(W_k\ge(c_3Nh)^k\) for all \(k\ge k_0\). The \(C W_k\) term of
(3) then implies
\[
\log U_k\ge k\bigl(L-\log h+O(1)\bigr)+O(\log(a\lambda))
\ge(1-\eta-o(1))h\qquad(k\ge k_0).
\tag{9}
\]
Equations (7) and (9) prove (4). \(\square\)

The prime-square and higher-prime-power terms in the *unraised* Weil comb
have total weight \(O(L)\); the continuous surrogate on \([T,2T]\) has
size \(O(\sqrt N/T)\). These observations locate (4) in the usual
high-frequency setup, but are not used in its proof. At \(\eta=1/2\),
(4) leaves an error of size \(\exp((1/2+o(1))\log T)\) in this method.
The way past it would have to use cancellation among the off-diagonal
prime-product terms or a sharper relation between exceptional phase sets
and the Fourier mass of admissible tests. The theorem makes no assertion
that such a relation is impossible.

The inputs in (2), (5), and the prime number theorem are classical. A
targeted comparison found no exact published statement of (4); priority
remains provisional.
