# Intrinsic Decoherence

**Support repository for the upcoming article on the interaction dynamics via instrinsic decoherence in the three-coupled harmonic oscillator.**

If you want to take an interactive look, launch the Binder server and search for the `notebooks/Instrinsic_Graphics.ipynb` notebook. Also, there's a comparison notebook solving the ordinary Schrödinger equation, where the solution of the problem is given using the package `QuantumOptics.jl`, showing how the dynamics is unaffected by the decoherence, go to `notebooks/Instrinsic_QO.ipynb` to play with it.

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/rurz/IntrinsicDecoherence/HEAD?urlpath=lab)

___

Contains the script `Funcs.jl` who have the full definitions of the expectation values evolution on time for each of the oscillator, i.e ⟨âⱼᵀâⱼ⟩(t)

Needs to define the parameters ω, λ, g, γ and a list of sampled times _t_.

#### Example

The expectation value for the oscillator â₁ who has the initial condition |α⟩ for α = 4; ω = 4, λ = 0.5, g = 0.1, γ = 10 and _t_ ∈ {0, 50} gives

```
julia> using IntrinsicDecoherence

julia> using UnicodePlots

julia> tlist = range(0, stop = 70, length = 1000)
0.0:0.10020040080160321:50.0

julia> exv = [exv_a₁(4, 0.5, 0.1, 10, 4, tlist[τ]) for τ in 1:length(tlist)];

julia> lineplot(tlist, exv)
      ┌─────────────────────────────────────────────────┐
   20 │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⢱⠀⠀⡀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⢸⠀⠀⣿⠀⠀⡸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⢸⠀⢰⠹⡀⠀⡇⢣⠀⠀⣤⠀⠀⢠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⢸⠀⢸⠀⡇⠀⡇⢸⠀⢸⠹⡄⠀⡇⢧⠀⢰⢳⡀⠀⣀⡀⠀⢠⢦⠀⠀⠀⠀⠀⣠⣄⠀⠀⠀⠀⠀⢀⣀⠀│
      │⢸⠀⢸⠀⡇⢠⠃⢸⠀⡸⠀⡇⢰⠃⢸⡀⡎⠀⣇⢰⠃⢱⣠⠏⠀⢧⣠⠖⠦⠴⠃⠈⠳⠤⠖⠤⠴⠋⠈⠓│
      │⠈⡇⡜⠀⢇⢸⠀⠀⡇⡇⠀⢳⡼⠀⠀⠷⠁⠀⠘⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⠀⡇⡇⠀⢸⢸⠀⠀⢧⠃⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⠀⡇⡇⠀⠸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⠀⢧⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
    0 │⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      └─────────────────────────────────────────────────┘
      0                                       70


```

who confirms that ⟨âᵀ₁â₁⟩(t)(0) = |α|² —this is, the initial condition |α⟩₁ for the oscillator in 1.

___
Alejandro R. Urzúa (2021)

Cite as: Urzúa, A. R. (2021). rurz/IntrinsicDecoherence: Alpha release (v0.1.0-alpha) [Computer software]. Zenodo. https://doi.org/10.5281/ZENODO.5131447

 [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/rurz/IntrinsicDecoherence)
