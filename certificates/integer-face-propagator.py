"""Fixed mass-one face propagator: exact arithmetic, no metric fitting."""
import sympy as sp

x, u, v, w, t = sp.symbols('x u v w t')
markers = {2: u, 3: v, 5: w}
zero = {u: 0, v: 0, w: 0}


def q(d):
    return sp.prod(markers[p] ** a for p, a in sp.factorint(d).items())


def same(A, B):
    assert A.shape == B.shape
    assert all(sp.cancel(a - b) == 0 for a, b in zip(A, B))


def build(N):
    # Original directed edges, one for every allowed successor and strict division.
    edges = [('S', n) for n in range(1, N)]
    edges += [('D', d, n) for n in range(1, N + 1) for d in range(2, N // n + 1)]
    index = {edge: i for i, edge in enumerate(edges)}
    E = len(edges)
    weights, endpoints = [], []
    B, J, A = sp.zeros(N, E), sp.zeros(E, N), sp.eye(N)
    for i, edge in enumerate(edges):
        if edge[0] == 'S':
            a, b, weight = edge[1], edge[1] + 1, x
        else:
            _, d, n = edge
            a, b, weight = d * n, n, -q(d)
        weights.append(weight)
        endpoints.append((a, b))
        B[a - 1, i] = 1
        B[b - 1, i] -= weight
        J[i, a - 1] = 1
        A[b - 1, a - 1] -= weight

    def chain(path):
        ans, pref = sp.zeros(E, 1), sp.Integer(1)
        for edge in path:
            i = index[edge]
            ans[i] += pref
            pref *= weights[i]
        tail = endpoints[index[path[0]]][0]
        head = endpoints[index[path[-1]]][1]
        rhs = sp.zeros(N, 1)
        rhs[tail - 1] = 1
        rhs[head - 1] -= pref
        same(B * ans, rhs)
        return ans

    cells, columns, omega = [], [], []
    for n in range(1, N + 1):
        for a in range(2, N // n + 1):
            for b in range(2, N // (a * n) + 1):
                cells.append(('T', a, b, n))
                columns.append(chain([('D', a, b * n), ('D', b, n)]) - chain([('D', a * b, n)]))
                col = sp.zeros(N, 1)
                col[n - 1] = -2 * q(a * b)
                omega.append(col)
    for m in range(2, N + 1):
        for n in range(1, N // m):
            cells.append(('F', m, n))
            columns.append(chain([('D', m, n), ('S', n)]) - chain([('S', k) for k in range(m * n, m * (n + 1))] + [('D', m, n + 1)]))
            col = sp.zeros(N, 1)
            col[n] = q(m) * (x - x ** m)
            omega.append(col)
    C, Omega = sp.Matrix.hstack(*columns), sp.Matrix.hstack(*omega)
    same(B * C, Omega)
    return edges, cells, B, C, Omega, J, A


def matrix_strings(M):
    return [[str(t) for t in row] for row in M.tolist()]


def coefficient(poly, monomial):
    return sp.Poly(sp.expand(poly), u, v, w).coeff_monomial(monomial)


record = {'scope': 'Fixed x=1, fixed face mass 1; exact symbolic coefficients and rational operator checks.', 'cases': {}}
for N in (4, 6):
    edges, cells, Bx, Cx, Ox, J, Ax = build(N)
    B, C, Omega, A = [M.subs(x, 1) for M in (Bx, Cx, Ox, Ax)]
    C0, A0 = C.subs(zero), A.subs(zero)
    G0 = sp.eye(C.cols) + C0.T * C0
    H0 = G0.inv()
    A0inv = A0.inv()
    # At x=1 every affine curvature is zero and Omega starts in degree 2.
    scaled = {u: t * u, v: t * v, w: t * w}
    O2 = Omega.subs(scaled).applyfunc(lambda a: sp.expand(a).coeff(t, 2))
    same(Omega, O2)
    A1 = A.subs(scaled).applyfunc(lambda a: sp.expand(a).coeff(t, 1))
    A2 = A.subs(scaled).applyfunc(lambda a: sp.expand(a).coeff(t, 2))
    forcing2 = sp.expand(O2 * H0 * C0.T * J)
    log1 = sp.expand(sp.trace(A0inv * A1))
    oldlog2 = sp.expand(sp.trace(A0inv * A2) - sp.trace((A0inv * A1) ** 2) / 2)
    shift2 = sp.expand(sp.trace(A0inv * forcing2))
    newlog2 = sp.expand(oldlog2 + shift2)
    D = sp.expand(A.det(method='domain-ge'))
    same(Omega[1:, :], sp.zeros(N - 1, C.cols))
    Qroot = sp.expand(A[1:, 1:].det(method='domain-ge'))
    root_q1 = sum(coefficient(Qroot, marker) * marker for marker in markers.values())
    root_q2 = Qroot.subs(scaled).expand().coeff(t, 2) - root_q1 ** 2 / 2
    relative_old = sp.expand(log1 + oldlog2 - root_q1 - root_q2)
    relative_new = sp.expand(log1 + newlog2 - root_q1 - root_q2)
    assert coefficient(D, 1) == 1
    assert coefficient(oldlog2, u ** 2) == coefficient(D, u ** 2) - coefficient(D, u) ** 2 / 2
    assert coefficient(oldlog2, u * v) == coefficient(D, u * v) - coefficient(D, u) * coefficient(D, v)

    # Isolate every face-to-face contribution to the leading correction.
    cross = []
    for i, left in enumerate(cells):
        for j, right in enumerate(cells):
            value = sp.expand(sp.trace(A0inv * O2[:, i] * H0[i, j] * C0[:, j].T * J))
            if value != 0:
                cross.append({'curvature_face': left, 'receiving_face': right, 'log_shift': str(value)})
    assert sp.expand(sum(sp.sympify(row['log_shift']) for row in cross) - shift2) == 0

    # Independent exact rational full-matrix identities and positivity checks.
    samples = []
    for q2, q3, q5 in [(sp.Rational(1, 2), sp.Rational(1, 3), sp.Rational(1, 5)), (1, 1, 1)]:
        sub = {u: q2, v: q3, w: q5}
        b, c, om, a = [M.subs(sub) for M in (B, C, Omega, A)]
        G = sp.eye(C.cols) + c.T * c
        H = G.inv()
        Kedge = sp.eye(C.rows) + c * c.T
        P = c * H * c.T
        same(P, sp.eye(C.rows) - Kedge.inv())
        effective = a + om * H * c.T * J
        V = a - b * J
        same(effective, V + b * (2 * sp.eye(C.rows) - Kedge.inv()) * J)
        bordered = sp.BlockMatrix([[a, -om], [c.T * J, G]]).as_explicit()
        assert sp.cancel(bordered.det() / G.det() - effective.det()) == 0
        assert all(G[:k, :k].det() > 0 for k in range(1, G.rows + 1))
        samples.append({'u': str(q2), 'v': str(q3), 'w': str(q5), 'face_determinant': str(G.det()), 'effective_determinant': str(effective.det()), 'original_determinant': str(a.det())})

    # At N4 derive the whole rational function, independently of the degree expansion.
    rational = None
    if N == 4:
        G = sp.eye(C.cols) + C.T * C
        h = G.inv()
        effective = A + Omega * h * C.T * J
        rational = sp.cancel(effective.det(method='domain-ge'))
        independent_log = sp.log(rational)
        assert sp.cancel(sp.diff(independent_log, u).subs(zero) - coefficient(log1, u)) == 0
        assert sp.cancel(sp.diff(independent_log, u, 2).subs(zero) / 2 - coefficient(newlog2, u ** 2)) == 0
        assert sp.cancel(sp.diff(independent_log, u, v).subs(zero) - coefficient(newlog2, u * v)) == 0
        numerator, denominator = sp.fraction(rational)
        assert sp.gcd(sp.Poly(numerator, u, v), sp.Poly(denominator, u, v)).total_degree() == 0
        expected_denominator = u ** 4 + 7 * u ** 2 - 2 * u + 14
        expected_correction = 4 * u ** 2 * (u ** 3 + u ** 2 + 4 * u + 1)
        assert sp.cancel(rational - D - expected_correction / expected_denominator) == 0
        assert sp.gcd(expected_correction, expected_denominator) == 1
        assert sp.discriminant(expected_denominator, u) == 61504
        delta = effective - A
        expected_row = 2 * u ** 2 / expected_denominator * sp.Matrix([[u * (1 + u), u * (5 + u ** 2), 1 + u, 1 + u]])
        expected_delta = sp.zeros(N)
        expected_delta[0, :] = expected_row
        same(delta, expected_delta)
        symmetric_part = (delta + delta.T) / 2
        minor13 = symmetric_part.extract([0, 2], [0, 2]).det()
        assert sp.cancel(minor13 + u ** 4 * (1 + u) ** 2 / expected_denominator ** 2) == 0

    record['cases'][str(N)] = {
        'edges': edges, 'cells': cells, 'C0': matrix_strings(C0), 'G0': matrix_strings(G0), 'H0': matrix_strings(H0),
        'Omega2': matrix_strings(O2), 'C0_transpose_J': matrix_strings(C0.T * J),
        'forcing_degree2': matrix_strings(forcing2), 'cross_face_contributions': cross,
        'log_degree1': str(log1), 'original_log_degree2': str(oldlog2), 'log_shift_degree2': str(shift2), 'effective_log_degree2': str(newlog2),
        'face_gram_constant_determinant': str(G0.det()),
        'C0_transpose_J_ones': [str(a) for a in C0.T * J * sp.ones(N, 1)],
        'H0_C0_transpose_J_ones': [str(a) for a in H0 * C0.T * J * sp.ones(N, 1)],
        'coefficient_table': {str(r): {'original': str(coefficient(log1 + oldlog2, q(r))), 'effective': str(coefficient(log1 + newlog2, q(r))), 'Euler_log': str({2: 1, 3: 1, 4: sp.Rational(1, 2), 6: 0}[r])} for r in (2, 3, 4, 6)},
        'root_cofactor': str(Qroot),
        'root_relative_coefficient_table': {str(r): {'original': str(coefficient(relative_old, q(r))), 'effective': str(coefficient(relative_new, q(r))), 'Euler_log': str({2: 1, 3: 1, 4: sp.Rational(1, 2), 6: 0}[r])} for r in (2, 3, 4, 6)},
        'full_N4_rational_determinant': str(rational) if rational is not None else None,
        'exact_samples': samples, 'all_assertions': 'passed',
    }


assert sp.expand(sp.sympify(record['cases']['6']['log_shift_degree2'])-(sp.Rational(54,1967)*u**2+sp.Rational(680,1967)*u*v))==0
assert sp.sympify(record['cases']['6']['root_relative_coefficient_table']['6']['effective'])==-sp.Rational(5221,1967)
print('All exact integer-face-propagator checks passed.')

