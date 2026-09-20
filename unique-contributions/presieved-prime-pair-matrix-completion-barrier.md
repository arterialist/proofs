# Presieved prime pair matrix completion: scalar barrier and nonuniform repair

**Status:** rigorous analytic proof with exact rational certificates in Python, September 2026.
Note location:
- [building-blocks/goldbach/presieved-prime-pair-completion.md](../building-blocks/goldbach/presieved-prime-pair-completion.md)
Certificates:
- [certificates/presieved_prime_pair.py](../certificates/presieved_prime_pair.py)
- [certificates/presieved_prime_pair_sturm.py](../certificates/presieved_prime_pair_sturm.py)

Attribution: Arterialist RH research team, September 2026.
Literature context:
In sieve theory and the additive theory of primes (Goldbach, twin primes), sequences are classically pre-sieved by removing multiples of small primes before applying combinatorial or bilinear sieves. In operator-theoretic number theory, positive semidefinite completion is applied to bounding distinct-pair convolution energies $\sum_{j, k \in S} a_j a_k R_h(j-k) \ge c P_1^2 - \lambda_* P_2$.
A targeted comparison on 20 September 2026 covered presieved sieve kernels,
finite positive-semidefinite completion arguments, and the cited Goldbach and
twin-prime literature. It found no exact match for the finite cubic kernel,
primorial masked character obstruction, and certified nonuniform repair stated
below. This bounded comparison supports only the displayed finite result and
does not claim a universal matrix-completion theorem or absolute priority.

## Statement

Let $h = 2^k \ge 8$ be dyadic, $W$ a squarefree even primorial, and $S = \{j \bmod q : (j, W) = 1\}$ with $\rho = \phi(W)/W$.
Let $R_h(d) = \frac{h}{2}[r(d/h) - r(2d/h)]$ be the cubic distinct-pair convolution kernel with $R_h(0) = 0$, $I_h = \int R_h = h^2/64$, and let
\[
 \mathsf{B} = (R_h^{(q)}(j-k))_{j, k \in S} - \frac{I_h}{q} \mathbf{1}\mathbf{1}^*.
\]
Define the scalar completion charge $\lambda_* = \max(0, -\lambda_{\min}(\mathsf{B}))$ so that $\mathsf{B} + \lambda_* I \succeq 0$.

**Theorem 1 (Universal Scalar Completion Barrier).**
1. For every dyadic $h \ge 4W$ and every primorial $W \ge 30$:
   \[
    \boxed{\quad \lambda_* \ge \frac{\rho h^2}{8\pi^4} \quad}
   \]
   forced by the masked Fourier character $w_j = \mathbf{1}_{(j, W)=1} e^{i \frac{4\pi}{h} j}$.
2. Across all primorials $W \ge 6$ (regardless of size relative to $h$):
   \[
    \mathcal{Q}_{8, W} = -\frac{3}{32} \prod_{\substack{p \mid W \\ p \ge 5}} \frac{p-2}{p-1} < 0, \qquad
    \mathcal{Q}_{16, W} = -\frac{3}{16} \prod_{\substack{p \mid W \\ p \ge 5}} \frac{p-2}{p-1} < 0.
   \]
   The obstruction is strictly negative for all primorials, with an exact twin-prime product factor.

**Theorem 2 (Nonuniform Repair).**
At $(X, h, W, q) = (64, 16, 6, 96)$, placing nonuniform diagonal charges on zero-weight residues yields a certified distinct-pair lower bound exceeding $+16.90$, whereas the optimal scalar completion fails with bound below $-61.02$. Certified by exact rational Sturm sequences in [`presieved_prime_pair_sturm.py`](../certificates/presieved_prime_pair_sturm.py).

Full proof:
- [building-blocks/goldbach/presieved-prime-pair-completion.md](../building-blocks/goldbach/presieved-prime-pair-completion.md)
