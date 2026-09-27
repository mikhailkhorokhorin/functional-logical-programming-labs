# Functional Lab 1. Root Finding and Taylor Series

## Task

`root_finding.fsx` solves equation 28

$$
x - 2 + \sin\frac{1}{x} = 0, \qquad x \in [1.2,\ 2]
$$

and two reference equations

$$
e^x + \ln x - 10x = 0, \qquad x \in [3,\ 4]
$$

$$
\cos x - e^{-x^2/2} + x - 1 = 0, \qquad x \in [0.5,\ 2]
$$

by dichotomy, Newton's method and simple iteration with precision $\varepsilon = 10^{-5}$.

`taylor_series.fsx` tabulates

$$
f(x) = -\ln\left|2\sin\frac{x}{2}\right| = \sum_{k=1}^{\infty} \frac{\cos kx}{k}
$$

on $\left[\frac{\pi}{5},\ \frac{6\pi}{5}\right]$ at 11 points with precision $\varepsilon = 0.01$ and prints the number of terms used. The dumb version computes every term directly. The smart version gets $\cos kx$ from the recurrence

$$
\cos (k+1)x = \cos kx \cos x - \sin kx \sin x, \qquad \sin (k+1)x = \sin kx \cos x + \cos kx \sin x
$$

## Build and run

```bash
make run LAB=functional/lab1
```

## Example

`root_finding.fsx`:

```text
Equation   | Dichotomy        | Newton           | Iterations
-------------------------------------------------------------
28         | 1.30767          | 1.30766          | 1.30767
1          | 3.52650          | 3.52650          | 3.52650
2          | 1.08944          | 1.08944          | 1.08944
x^2+1      | no sign change   | zero derivative  | diverged
```

`taylor_series.fsx`:

```text
       x |      Builtin | Smart Taylor |  Terms |  Dumb Taylor |  Terms
-----------------------------------------------------------------------
  0.6283 |     0.481212 |     0.485272 |    323 |     0.485272 |    323
  0.9425 |     0.096532 |     0.098779 |    220 |     0.098779 |    220
...
  3.4558 |    -0.680759 |    -0.685201 |    101 |    -0.685201 |    101
  3.7699 |    -0.642965 |    -0.638229 |    105 |    -0.638229 |    105
```

## Notes

Every method returns a `Result`: dichotomy checks the sign change on the interval, Newton's method guards against a zero derivative, and all iterative methods report non-convergence after 100 iterations. The row `x^2+1` solves $x^2 + 1 = 0$ on $[-1,\ 1]$, which has no real roots, and demonstrates these errors.

The series converges only conditionally, so a small term does not mean a small error. Summation stops after term $n$ once the Dirichlet tail bound drops below $\varepsilon$:

$$
\left|\sum_{k=n+1}^{\infty} \frac{\cos kx}{k}\right| \le \frac{1}{(n+1)\left|\sin\frac{x}{2}\right|} < \varepsilon
$$

which guarantees $\left|S_n - f(x)\right| < \varepsilon$.
