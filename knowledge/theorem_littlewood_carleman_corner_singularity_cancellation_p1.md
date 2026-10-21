# Littlewood-Carleman Corner Singularity Cancellation Identity

Type: theorem
Confidence: high
Source: Aggregator Nodes L01_N10, L01_N11 (Level 1)
Relevant to: Littlewood-Carleman and Green's theorem contour integrations, boundary energy deficits, and regularized slab integrals near critical zeros

## Statement
Let $\sigma_2 > 1$ and consider the rectangular domain $\mathcal{R}_T = [1/2, \sigma_2] \times [-T, T]$ in the complex $s$-plane. Let $\Phi(s) = (s - 1/2)\frac{\xi'}{\xi}(s)$, where $\xi(s)$ is the completed Riemann xi function. 

Let $\mathcal{D}_{\text{offline}}(T) = \sum_{\rho \in \mathrm{RightOfflineSupport}, |\gamma| < T} (\beta - 1/2)$ denote the total horizontal displacement of all off-line zeros of $\zeta(s)$ with ordinate $|\gamma| < T$ and real part $\beta > 1/2$, counted with multiplicity.

Then, under the signed Littlewood-Carleman contour integral around $\partial \mathcal{R}_T$, the displacement satisfies the exact contour identity:
$$\mathcal{D}_{\text{offline}}(T) = I_{\text{left}}(T) + I_{\text{right}}(T) - I_{\text{horiz}}(T),$$
where:
$$I_{\text{left}}(T) = \frac{1}{2\pi}\int_{-T}^T \log|\Xi(t)|\, dt - \frac{T}{\pi}\log|\Xi(T)|,$$
$$I_{\text{horiz}}(T) = \frac{1}{\pi} \operatorname{Im} \int_{1/2}^{\sigma_2} \left(\sigma - \frac{1}{2} + iT\right) \frac{\xi'}{\xi}(\sigma + iT)\, d\sigma.$$

Furthermore, let $\gamma_n$ be an ordinate of a critical-line zero $\rho_n = 1/2 + i\gamma_n$ with multiplicity $m_n \ge 1$. As the truncation height $T \to \gamma_n$, the Laurent singularity of $\xi'/\xi(s)$ at $\rho_n$ produces a singular contribution in the horizontal integral:
$$I_{\text{horiz}}(T) = -\frac{\gamma_n m_n}{\pi} \log\left(\frac{1}{|T - \gamma_n|}\right) - \frac{\gamma_n m_n}{\pi} \log\left(\sigma_2 - \frac{1}{2}\right) + O(1).$$
Under the correct contour orientation with negative sign $-I_{\text{horiz}}(T)$, this singularity precisely and identically cancels the $+ \frac{\gamma_n m_n}{\pi} \log(1/|T - \gamma_n|)$ logarithmic singularity arising from the vertical boundary integral $I_{\text{left}}(T)$, ensuring that the total boundary contour deficit is continuous across all critical-line zero ordinates $T = \gamma_n$, with well-defined finite limit:
$$\lim_{T \to \gamma_n} \left(I_{\text{left}}(T) - I_{\text{horiz}}(T)\right) = -\frac{\gamma_n m_n}{\pi} \log\left(\sigma_2 - \frac{1}{2}\right) + \mathcal{R}_{\text{reg}}(\gamma_n).$$

## Proof
1. **Residue Theorem on Slab**: Apply Cauchy's residue theorem to $\Phi(s) = (s - 1/2)\xi'(s)/\xi(s)$ on $\partial \mathcal{R}_T$. For any zero $\rho = \beta + i\gamma \in \mathcal{R}_T$, the residue of $\xi'/\xi$ is $m_\rho$, so $\operatorname{Res}_{s=\rho} \Phi(s) = m_\rho (\rho - 1/2) = m_\rho (\beta - 1/2 + i\gamma)$.
2. Taking real parts and summing over conjugate pairs $\rho, \bar{\rho}$, the imaginary terms $i\gamma$ cancel, leaving exactly:
   $$\frac{1}{2\pi} \operatorname{Re} \oint_{\partial \mathcal{R}_T} \Phi(s)\, ds = \sum_{\rho \in \mathcal{R}_T} m_\rho \left(\beta - \frac{1}{2}\right) = \mathcal{D}_{\text{offline}}(T).$$
   (Critical-line zeros have $\beta = 1/2$, so their displacement $\beta - 1/2 = 0$ contributes zero to $\mathcal{D}_{\text{offline}}$).
3. **Contour Decomposition**: The boundary consists of:
   - Left vertical segment: $\sigma = 1/2$, where $s - 1/2 = it$, yielding $I_{\text{left}}(T)$ after integrating by parts $\log|\xi(1/2+it)|$.
   - Right vertical segment: $\sigma = \sigma_2$, yielding $I_{\text{right}}(T)$, which is $O(1)$ by rapid Euler product convergence.
   - Top and bottom horizontal segments: oriented from right to left at $+iT$ and left to right at $-iT$. Symmetrizing yields $-I_{\text{horiz}}(T)$.
4. **Singularity Analysis at $T \to \gamma_n$**: Near $\rho_n = 1/2 + i\gamma_n$, expand:
   $$\frac{\xi'}{\xi}(\sigma + iT) = \frac{m_n}{\sigma - 1/2 + i(T - \gamma_n)} + g(\sigma, T),$$
   where $g$ is holomorphic and bounded in a neighborhood of $\rho_n$.
5. Compute the singular part of the horizontal integral:
   $$\int_{1/2}^{\sigma_2} \left(\sigma - \frac{1}{2} + iT\right) \frac{m_n}{\sigma - 1/2 + i(T - \gamma_n)}\, d\sigma.$$
   Let $u = \sigma - 1/2$ and $\delta = T - \gamma_n$. The integral becomes:
   $$m_n \int_0^{\sigma_2 - 1/2} \frac{u + i\gamma_n + i\delta}{u + i\delta}\, du = m_n (\sigma_2 - 1/2) + i m_n \gamma_n \int_0^{\sigma_2 - 1/2} \frac{du}{u + i\delta}.$$
   Taking the imaginary part:
   $$\operatorname{Im}\left(i m_n \gamma_n \int_0^{\sigma_2 - 1/2} \frac{u - i\delta}{u^2 + \delta^2}\, du\right) = m_n \gamma_n \int_0^{\sigma_2 - 1/2} \frac{u}{u^2 + \delta^2}\, du = \frac{m_n \gamma_n}{2} \log\left(\frac{(\sigma_2 - 1/2)^2 + \delta^2}{\delta^2}\right).$$
   As $\delta = T - \gamma_n \to 0$, this diverges as:
   $$\frac{1}{\pi} \cdot \frac{m_n \gamma_n}{2} \log\left(\frac{(\sigma_2 - 1/2)^2}{\delta^2}\right) = \frac{m_n \gamma_n}{\pi} \log(\sigma_2 - 1/2) - \frac{m_n \gamma_n}{\pi} \log|\delta|.$$
6. Since this enters with a negative sign $-I_{\text{horiz}}(T)$, its singular contribution is $+ \frac{m_n \gamma_n}{\pi} \log|T - \gamma_n|$.
7. Simultaneously, $I_{\text{left}}(T)$ contains $-\frac{T}{\pi}\log|\Xi(T)|$. Since $\Xi(T) \sim C (T - \gamma_n)^{m_n}$, $-\frac{T}{\pi}\log|\Xi(T)| \sim -\frac{\gamma_n m_n}{\pi}\log|T - \gamma_n|$.
8. Summing $I_{\text{left}}(T) - I_{\text{horiz}}(T)$, the two terms cancel identically:
   $$-\frac{\gamma_n m_n}{\pi}\log|T - \gamma_n| + \frac{\gamma_n m_n}{\pi}\log|T - \gamma_n| = 0.$$

## Hypotheses / Conditions
- Slab height $T$ not coinciding with any off-line zero ordinate ($\gamma \ne \gamma_{\text{offline}}$).
- Correct counterclockwise contour orientation with $-I_{\text{horiz}}$ (sign inversion produces $2I_{\text{horiz}}$ and blows up to $\infty$).
- Absolute convergence of $\xi(s)$ Euler product on $\operatorname{Re}(s) = \sigma_2 > 1$.

## How It Applies
This identity resolves a common false failure mode in contour-energy methods: researchers observing the divergence of horizontal integrals as $T \to \gamma_n$ mistakenly conclude that Littlewood-Carleman methods cannot be evaluated near critical zeros. The theorem demonstrates that the corner divergence is a gauge artifact of separating horizontal and vertical boundaries, which cancels when boundaries are properly combined.

## Caveats
- While the identity is exact, using it to prove $\mathcal{D}_{\text{offline}} = 0$ is a tautology: the identity is an exact representation of $\mathcal{D}_{\text{offline}}$, not an independent upper bound.
- Evaluating the left boundary integral $I_{\text{left}}(T) = \frac{1}{2\pi}\int_{-T}^T \log|\zeta(1/2+it)| dt + \dots$ unconditionally incurs an $O(\log T)$ error from Selberg's argument function $S_1(T) = \int_0^T S(t) dt$. Because $O(\log T) \gg \beta - 1/2 \le 1/2$, unconditional contour evaluation cannot detect individual off-line zeros.
