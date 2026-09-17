"""Exact finite curved-chain construction on the literal integer graph."""
import sympy as sp

x, u, v, w, eta = sp.symbols('x u v w eta', real=True)
z = sp.Symbol('z')
prime_symbols = {2: u, 3: v, 5: w}


def weight(d):
    return sp.prod(prime_symbols[p] ** e for p, e in sp.factorint(d).items())


def same(A, B):
    assert A.shape == B.shape
    assert all(sp.cancel(a - b) == 0 for a, b in zip(A, B))


def graph(N):
    edges = [('S', n) for n in range(1, N)]
    edges += [('D', d, n) for n in range(1, N + 1) for d in range(2, N // n + 1)]
    lookup = {e: j for j, e in enumerate(edges)}
    endpoints, weights = [], []
    for e in edges:
        if e[0] == 'S':
            endpoints.append((e[1], e[1] + 1))
            weights.append(x)
        else:
            _, d, n = e
            endpoints.append((d * n, n))
            weights.append(-weight(d))
    E = len(edges)
    B, J, T = sp.zeros(N, E), sp.zeros(E, N), sp.zeros(N)
    outdegree = [0] * N
    for j, ((a, b), wt) in enumerate(zip(endpoints, weights)):
        B[a - 1, j] = 1
        B[b - 1, j] = -wt
        J[j, a - 1] = 1
        T[a - 1, b - 1] += wt
        outdegree[a - 1] += 1
    V = sp.diag(*[1 - d for d in outdegree])
    A = sp.eye(N) - T.T
    same(A, V + B * J)

    def path(es):
        chain = sp.zeros(E, 1)
        wt = sp.Integer(1)
        for e in es:
            j = lookup[e]
            chain[j] += wt
            wt *= weights[j]
        a = endpoints[lookup[es[0]]][0]
        b = endpoints[lookup[es[-1]]][1]
        rhs = sp.zeros(N, 1)
        rhs[a - 1] += 1
        rhs[b - 1] -= wt
        same(B * chain, rhs)
        return chain

    labels, columns, defects = [], [], []
    for n in range(1, N + 1):
        for a in range(2, N // n + 1):
            for b in range(2, N // (a * n) + 1):
                labels.append(('T', a, b, n))
                columns.append(path([('D', a, b * n), ('D', b, n)]) - path([('D', a * b, n)]))
                defect = sp.zeros(N, 1)
                defect[n - 1] = -2 * weight(a * b)
                defects.append(defect)
    for m in range(2, N + 1):
        for n in range(1, N // m):
            labels.append(('F', m, n))
            P = [('D', m, n), ('S', n)]
            Q = [('S', j) for j in range(m * n, m * (n + 1))] + [('D', m, n + 1)]
            columns.append(path(P) - path(Q))
            defect = sp.zeros(N, 1)
            defect[n] = weight(m) * (x - x ** m)
            defects.append(defect)
    C = sp.Matrix.hstack(*columns)
    Omega = sp.Matrix.hstack(*defects)
    same(B * C, Omega)
    return edges, labels, B, C, Omega, J, V, A


def log_coeffs(D):
    # D has constant prime-marker coefficient 1 at every clock x.
    assert sp.expand(D).subs({u: 0, v: 0, w: 0}) == 1
    p = sp.Poly(sp.expand(D), u, v, w)
    c1 = p.coeff_monomial(u)
    c2 = p.coeff_monomial(v)
    return {
        'energy4': sp.expand(p.coeff_monomial(u ** 2) - c1 ** 2 / 2),
        'energy6': sp.expand(p.coeff_monomial(u * v) - c1 * c2),
        'energy2': c1,
        'energy3': c2,
    }


record = {'scope': 'Exact finite algebra. No RH or analytic zero inference.', 'cases': {}}
for N in (4, 6):
    edges, labels, B, C, Omega, J, V, A = graph(N)
    E, F = B.cols, C.cols
    D = sp.expand(A.det(method='domain-ge'))
    forcing = sp.expand(Omega * C.T * J)
    triangle_indices = [i for i, cell in enumerate(labels) if cell[0] == 'T']
    triangle_forcing = sp.zeros(N)
    for i in triangle_indices:
        _, a, b, n = labels[i]
        expected_row = sp.zeros(1, N)
        expected_row[0, b * n - 1] = -weight(a)
        same(C[:, i].T * J, expected_row)
        expected_force = sp.zeros(N)
        expected_force[n - 1, b * n - 1] = 2 * weight(a * a * b)
        same(Omega[:, i] * C[:, i].T * J, expected_force)
        triangle_forcing += expected_force
    same(forcing.subs(x, 1), triangle_forcing)
    Dtri = sp.expand((A + eta * triangle_forcing).det(method='domain-ge'))
    for exponents, coefficient in sp.Poly(Dtri - D, u, v, w).terms():
        if coefficient != 0:
            assert max(exponents) >= 2
    for k, value in log_coeffs(Dtri).items():
        assert sp.expand(value - log_coeffs(D)[k]) == 0
    Deta = sp.expand((A + eta * forcing).det(method='domain-ge'))
    Dnew = sp.expand(Deta.subs(eta, 1))

    # Counterterm identity, verified at the matrix level over the polynomial ring.
    Iedge, Iface = sp.eye(E), sp.eye(F)
    zeroVF, zeroFE = sp.zeros(N, F), sp.zeros(F, E)
    M = sp.BlockMatrix([[V, B, Omega], [-J, Iedge, C], [sp.zeros(F, N), C.T, Iface + C.T * C]]).as_explicit()
    L = sp.BlockMatrix([[sp.eye(N), -B, zeroVF], [sp.zeros(E, N), Iedge, sp.zeros(E, F)], [sp.zeros(F, N), -C.T, Iface]]).as_explicit()
    expected = sp.BlockMatrix([[A, sp.zeros(N, E), zeroVF], [-J, Iedge, C], [C.T * J, zeroFE, Iface]]).as_explicit()
    same(L * M, expected)
    Mzero = sp.MutableDenseMatrix(M)
    Mzero[:N, N + E:] = sp.zeros(N, F)
    expectedzero = sp.MutableDenseMatrix(expected)
    expectedzero[:N, N + E:] = -Omega
    same(L * Mzero, expectedzero)
    same(A + forcing, A + B * C * C.T * J)

    # Canonical curvature-absorbing extension is a chain complex and splits.
    Btilde = B.row_join(sp.eye(N))
    Ctilde = C.col_join(-Omega)
    same(Btilde * Ctilde, sp.zeros(N, F))
    U = sp.BlockMatrix([[Iedge, sp.zeros(E, N)], [B, sp.eye(N)]]).as_explicit()
    same(U * Ctilde, C.col_join(sp.zeros(N, F)))
    same(Btilde, sp.zeros(N, E).row_join(sp.eye(N)) * U)

    # Curved supersymmetry, exact rational samples retain Hermitian meaning.
    samples = []
    for clock, q2, q3, q5 in [(sp.Rational(1, 2), sp.Rational(1, 2), sp.Rational(1, 3), sp.Rational(1, 5)), (1, 1, 1, 1)]:
        sub = {x: clock, u: q2, v: q3, w: q5}
        b, c = B.subs(sub), C.subs(sub)
        om = Omega.subs(sub)
        Q = sp.BlockMatrix([[sp.zeros(N), b, sp.zeros(N, F)], [sp.zeros(E, N), sp.zeros(E), c], [sp.zeros(F, N), sp.zeros(F, E), sp.zeros(F)]]).as_explicit()
        defect = sp.zeros(N + E + F)
        defect[:N, N + E:] = om
        same(Q * Q, defect)
        R = b.col_join(c.T)
        even, odd = R * R.T, R.T * R
        # Sylvester identity for characteristic polynomials checks all masses.
        pe, po = even.charpoly(z).as_expr(), odd.charpoly(z).as_expr()
        chi = N + F - E
        assert sp.cancel(pe / po - z ** chi) == 0
        # Full bordered matrices are checked by independent exact determinants.
        assert sp.cancel(M.subs(sub).det() - D.subs(sub)) == 0
        assert sp.cancel(Mzero.subs(sub).det() - Dnew.subs(sub)) == 0
        samples.append({'x': str(clock), 'u': str(q2), 'v': str(q3), 'w': str(q5), 'rank_curvature': om.rank(), 'superdimension': chi, 'D': str(D.subs(sub)), 'uncompensated_D': str(Dnew.subs(sub))})

    # Exact distinguished-return identity, preserving vertex 1.
    Qdet = sp.expand(A[1:, 1:].det(method='domain-ge'))
    schur1 = sp.cancel(A[0, 0] - (A[:1, 1:] * A[1:, 1:].inv() * A[1:, :1])[0])
    assert sp.cancel(schur1 - D / Qdet) == 0
    coeffs = log_coeffs(D)
    newcoeffs = log_coeffs(Dnew)
    firsteta = sp.expand(sp.diff(Deta, eta).subs(eta, 0))
    assert sp.cancel(firsteta - D * sp.trace(A.inv() * forcing)) == 0

    record['cases'][str(N)] = {
        'edges': edges, 'faces': labels,
        'B': [[str(t) for t in row] for row in B.tolist()],
        'C': [[str(t) for t in row] for row in C.tolist()],
        'curvature': [[str(t) for t in row] for row in Omega.tolist()],
        'V_diagonal': [str(t) for t in V.diagonal()],
        'D': str(D), 'deleted_vertex1_D': str(Qdet),
        'uncompensated_D': str(Dnew), 'uncompensated_D_eta': str(Deta),
        'triangle_forcing': [[str(t) for t in row] for row in triangle_forcing.tolist()],
        'triangle_only_D_eta': str(Dtri),
        'log_coefficients_D': {k: str(t) for k, t in coeffs.items()},
        'log_coefficients_uncompensated': {k: str(t) for k, t in newcoeffs.items()},
        'first_coupling_derivative': str(firsteta), 'exact_samples': samples,
        'all_assertions': 'passed',
    }


expected_mixed = -x**3-x**4+x**5-x**9-x**11-x**12-x**17
assert sp.expand(sp.sympify(record['cases']['6']['log_coefficients_uncompensated']['energy6'], locals={'x': x})-expected_mixed)==0
assert expected_mixed.subs(x,1)==-5
print('All exact integer-curved-chain checks passed.')

