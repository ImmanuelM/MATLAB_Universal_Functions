# MATLAB Universal Functions

A personal library of reusable MATLAB functions collected over years of work in
**time-series analysis, factor/latent-variable models, signal processing,
statistics, machine learning, and linear programming (simplex methods)**.

Author: **Immanuel Manohar** — Dr.M's Innovations LLC
Written by hand, without the use of AI code-generation tools.

> Most functions are self-documenting: run `help <functionname>` in MATLAB to
> see the usage header at the top of each file.

---

## Installation / usage

Clone the repository and add it to your MATLAB path:

```matlab
addpath(genpath('MATLAB_Universal_Functions'));
```

Then call any function directly, e.g. `acfval = acf(x, 20);`.

Using `genpath` is important: the third-party dependencies live in the
`third_party/` sub-folder, and functions such as `pacf` (needs `acf`),
`QR_algorithm*` / `rrqr2` (need `rrqr`), and `costFunctionReg` (needs `sigmoid`)
will only resolve once that sub-folder is on the path.

> **Note:** The rank-revealing QR routines (`QR_algorithm*`, `rrqr2`) depend on a
> compiled MEX gateway (`third_party/rrqrGate.mexa64`, Linux/x86-64). On other
> platforms this gateway must be recompiled from the original RRQR toolbox before
> those routines will run.

---

## Function reference

### Time-series analysis & correlation

| Function | Description |
|----------|-------------|
| `acf` | One-sided auto-correlation function up to `L` lags, with optional plot and white-noise error limits. *(third-party — see below)* |
| `pacf` | Partial auto-correlation function via Durbin's recursion, with optional plot. *(third-party — see below)* |
| `acvf_b` | **Biased** estimate of the auto-/cross-covariance matrix up to `M` lags. |
| `cvf_ub` | **Unbiased** estimate of the auto-/cross-covariance matrix up to `M` lags. |
| `MA_recursive` | Recursive estimation of moving-average (MA) coefficients, innovation variance, and cumulants from data. |
| `pred` | `h`-step-ahead prediction of a series from its AR coefficients. |
| `shift_mat` | Build a matrix of lagged (linear or circular) copies of a vector — handy for constructing regressor/Hankel matrices. |
| `Zero_crossing_counter` | Count the number of sign changes (zero crossings) in a sequence (e.g. an ACF). |

### Factor models, PCA / ICA & model-order selection

| Function | Description |
|----------|-------------|
| `PCA_SVD` | Principal component analysis via SVD; returns the factor-loading matrix and factors for the model `Y = U·Fe`. |
| `bai_ng2` | Number of factors in an approximate factor model using the Bai & Ng (2002) information criterion; returns model order, loadings, and factors. |
| `merc` | Model-order / factor estimation using the **eigenvalue-ratio** criterion. |
| `model_order1` | Q. Yao-style model-order detection from lagged covariance matrices (eigenvalue-ratio on the sum of `Ryy(l)·Ryy(l)'`). |
| `QR_algorithm2` | Factor-loading estimation from lagged covariances using rank-revealing QR (Hybrid-I via `rrqr`). |
| `QR_algorithm3` | As above, using the averaged/robust rank-revealing QR (`rrqr2`). |
| `QR_algorithm4` | As above, using the correlation-based RRQR (`rrqr_new`). |
| `ICA` | Independent Component Analysis by a deflation approach (kurtosis-based extraction). *(third-party — see below)* |
| `ICE` | Incremental Condition Estimation (Bischof) — updates a condition-number estimate as rows/columns are added to a triangular matrix. |

### Rank-revealing QR & matrix utilities

| Function | Description |
|----------|-------------|
| `rrqr2` | Averaged/robust rank-revealing QR built on top of `rrqr` (Hybrid-I), improving the stability of the estimated basis. |
| `rrqr_old` | Rank-revealing QR factorization (Golub-I / Stewart-II / Hybrid-I modes) after Chandrasekaran & Ipsen (1994). |
| `rrqr_old2` (`rrqr_new`) | Rank-revealing QR based on column-correlation pivoting. |
| `QR_GS` | QR decomposition via the Gram–Schmidt method. |
| `orthogonalize` | Remove the component of a matrix along a given (normalized) vector. |
| `ordering` | Match/re-order rows (with sign correction) of one vector time-series against a reference — resolves the permutation & sign ambiguity of factor/ICA solutions. |
| `Permute` | Build an `n×n` permutation matrix that swaps rows `i` and `j` of the identity. |
| `sort_mat` | Sort a value vector ascending/descending and reorder the columns of an associated matrix accordingly. |
| `sort_mat2` | Variant of `sort_mat` (ascending sort of an associated row vector). |
| `rrqr` | MATLAB gateway to the compiled `rrqrGate` MEX rank-revealing QR routine. *(third-party — see below)* |

### Signal processing & visualization

| Function | Description |
|----------|-------------|
| `gabor_sca` | Compute and display a **scalogram** using Gabor wavelets over a range of scales/frequencies. |
| `plotfft` | Single-sided FFT magnitude and phase plots of a signal, given the sampling rate. |
| `plot_basis` | Tile a set of column vectors (e.g. learned dictionary/basis atoms) as a grid of images. |

### Statistics & distributions

| Function | Description |
|----------|-------------|
| `gengauss` | Draw samples from a **generalized Gaussian** distribution via accept–reject sampling. |
| `alp_beta` | Fit generalized-Gaussian shape (`beta`) and scale (`alpha`) parameters per row (e.g. per trading day) by maximum likelihood. |
| `histwc` | Weighted histogram counts over equal-width bins (loop version). *(third-party — see below)* |
| `histwcv` | Vectorized weighted histogram counts. *(third-party — see below)* |
| `quartile` | Quartiles, fences, and outliers of a data vector (box-plot statistics). *(third-party — see below)* |
| `aboxplot` | Advanced grouped box-plot for 3-D/cell data. *(third-party — see below)* |
| `colorgrad` | Generate a color-gradient colormap (blue/orange/green/red, up/down). *(third-party — see below)* |

### Machine learning

| Function | Description |
|----------|-------------|
| `sigmoid` | Logistic sigmoid of a scalar/vector/matrix. *(third-party — course template, see below)* |
| `costFunctionReg` | Cost and gradient for **regularized logistic regression**. *(third-party — course template, see below)* |

### Error / performance metrics

| Function | Description |
|----------|-------------|
| `rmse` | Root-mean-square error between two matrices. |
| `fe` | Mean per-column RMS "forecast error" between two matrices. |

### Synthetic data generation

| Function | Description |
|----------|-------------|
| `data_gen1` | Generate samples of the factor model `r = H·f + e` where each factor shares one common ARMA process (single innovation). |
| `data_gen2` | As above, but each factor is driven by its **own independent** ARMA innovation. |
| `data_gen3` | As above, factors driven by **separate ARMA filters sharing a common** innovation sequence. |

### Linear programming — `Simplex Codes_Immanuel_Manohar/`

A self-contained toolkit for solving linear programs, transportation, and
network-flow problems. Entry point: **`simplex(Type)`** (interactive) or
**`simplex(Type, 'file.mat')`** (from a saved problem).

| Function | Description |
|----------|-------------|
| `simplex` | Top-level driver: prompts for / loads a problem and dispatches to the chosen solver (standard LP, transportation, or network flow). |
| `simplex1` | Selects the LP solver (Two-phase, Revised, Dual, or Primal-Dual) for a standard linear program. |
| `simplex_iteration` | Core tableau-based simplex pivot iterations. |
| `Two_phase_simplex` | Two-phase simplex method (Phase I finds an initial BFS, Phase II optimizes). |
| `Revised_simplex` | Revised simplex method (maintains `B^-1` rather than the full tableau). |
| `revised_simplex_iteration` | Core iteration engine for the revised simplex method. |
| `Dual_simplex` | Dual simplex method — avoids Phase I for problems of the form `min c'x s.t. Ax ≤ b`. |
| `simplex_transportaion` | Transportation-problem solver; balances supply/demand (adds a dummy node when unbalanced) then solves. |
| `simplex_balancedtransportation` | Balanced transportation solver: North-West-corner initial BFS + MODI/u-v optimization. |
| `cycle` | Finds and updates the closed loop (stepping-stone cycle) for an entering basic variable in the transportation tableau. |

The folder also includes example problem files (`example_1.mat` … `Example_5.mat`)
and a written report (`Linear_programming_Report _Immanuel Manohar.pdf` / `.docx`).

---

## Third-party files

The following files were **not** written by Immanuel Manohar. They live in the
[`third_party/`](third_party/) folder, each carries an attribution/license
comment at the top of the file, and each remains governed by its own license
(not the repository license):

| File(s) | Original author | License |
|---------|-----------------|---------|
| `third_party/aboxplot.m`, `third_party/colorgrad.m`, `third_party/quartile.m` | Alex Bikfalvi | GNU GPL v3 |
| `third_party/histwc.m`, `third_party/histwcv.m` | Mehmet Süzen | BSD |
| `third_party/acf.m`, `third_party/pacf.m` | Arun K. Tangirala | as stated in file |
| `third_party/ICA.m` | Ruck Thawonmas (Kochi Univ. of Technology) | as stated in file |
| `third_party/sigmoid.m`, `third_party/costFunctionReg.m` | Coursera Machine Learning course template (completed by the author) | as stated in file |
| `third_party/rrqr.m` + `third_party/rrqrGate.mexa64` | RRQR MEX toolbox gateway | as stated in file |

All other files in this repository are the original work of the author.

---

## License

This project (excluding the third-party files listed above) is released under
an **attribution license**: you are free to use, modify, and distribute the
code provided that clear credit is given to the author, **Immanuel Manohar
(Dr.M's Innovations LLC)**. See [LICENSE](LICENSE) for the full terms.
