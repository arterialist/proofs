# A gap in Suzuki's adjoint-domain argument

Suzuki, [*Weil's quadratic form via the screw function*, arXiv:2606.09096v1](https://arxiv.org/html/2606.09096v1#S6.SS2), Section 6.2, argues that the localized differentiation operator has deficiency indices $(1,1)$. The following points concern the displayed proof of Lemma 6.2 and hence its use in Theorem 1.5. They do not disprove either statement or bear on the odd Weil-form inequality.

Set $T_a=A_a-\lambda I>0$, with form space $\mathcal H(T_a)$ and norm $\|u\|_{T_a}^2=\langle T_a u,u\rangle_2$. Since $\lambda<\inf\sigma(A_a)$, the form norm controls the $L^2$ norm. It is the stronger norm. At [source lines 696-700](https://arxiv.org/html/2606.09096v1#S6.SS2), the proof says that a functional continuous for $\|\cdot\|_{T_a}$ is "in particular continuous with respect to the $L^2$-norm." This implication runs in the wrong direction. For a simple model with $\|u\|_T^2=\sum_{n\ge3}\log n\,|u_n|^2$, the functional

$$
 \ell(u)=\sum_{n\ge3}\frac{u_n}{\sqrt{n\log n}}
$$

is form-continuous because $\sum_{n\ge3}1/(n(\log n)^2)<\infty$, but is not $\ell^2$-continuous because $\sum_{n\ge3}1/(n\log n)=\infty$. Thus line 698 cannot establish that the adjoint functional has an $L^2$ representing vector.

Even if one supplied such an $L^2$ bound, [line 699](https://arxiv.org/html/2606.09096v1#S6.SS2) would at most give $(T_a v)'=(A_av)'-\lambda v'\in L^2$ distributionally. It would not separately give $v'\in L^2$ and $(A_av)'\in L^2$, as claimed there. A separate regularity argument would be needed.

At [lines 703-711](https://arxiv.org/html/2606.09096v1#S6.SS2), the proof writes $\langle u,g\rangle_{T_a}=\langle u,T_ag\rangle_2$ and then differentiates $T_av$ for arbitrary $v,g\in\mathcal H(T_a)$. For a general form-domain vector, $T_ag$ belongs canonically to the dual of the form space, but need not be an $L^2$ vector. The displayed $L^2$ pairing therefore requires an extension in a specified duality sense or extra operator-domain regularity. The subsequent identification of the adjoint kernel with solutions of $(T_av)'=\pm T_av$ cannot be inferred from the written steps alone.

The two norm/domain issues leave a gap in this proof of the deficiency-index count. A repair would have to formulate the adjoint equation in the form dual, establish the needed regularity there, and rule out additional solutions. None of this yields an unconditional sign for the pole-free odd form or bounds its rank-one return.
