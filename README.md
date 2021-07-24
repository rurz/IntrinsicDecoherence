# Intrinsic Decoherence

**Support repository for the upcoming article on the energy distribution via instrinsic decoherence in the three-coupled harmonic oscillator.**

If you want to take an interactive look, launch the Binder server and search for the `notebooks/Instrinsic_Graphics.ipynb` notebook.

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/rurz/IntrinsicDecoherence/HEAD?urlpath=lab)

___

Contains the script `Funcs.jl` who have the full definitions of the expectation values evolution on time for each of the oscillator, i.e ⟨â⟩(t)

Needs to define the parameters ω, λ, g, γ and a list of sampled times _t_.

#### Example

The expectation value for the oscillator â₁ who has the initial condition |α⟩ for α = 4; ω = 4, λ = 0.5, g = 0.1, γ = 10 and _t_ ∈ {0, 50} gives

```
julia> using UnicodePlots

julia> tlist = range(0, stop = 50, length = 500)
0.0:0.10020040080160321:50.0

julia> exv = [exv_a₁(4, 0.5, 0.1, 10, 4, tlist[τ]) for τ in 1:length(tlist)];

julia> lineplot(tlist, exv)
      ┌─────────────────────────────────────────────────┐ 
   20 │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⢱⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⢸⠀⠀⠀⢀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⢸⠀⠀⠀⡎⡇⠀⠀⠀⡏⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⠘⡄⠀⠀⡇⢱⠀⠀⢸⠀⢣⠀⠀⠀⣤⠀⠀⠀⢀⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⠀⡇⠀⢸⠀⢸⠀⠀⡸⠀⢸⠀⠀⢸⠀⡇⠀⠀⡸⠈⡇⠀⠀⡴⠱⡄⠀⠀⢀⣀⠀⠀⢀⡴⢦⠀⠀⠀⠀⠀│
      │⠀⡇⠀⢸⠀⠘⡄⠀⡇⠀⠈⡆⠀⡎⠀⢸⠀⢀⠇⠀⢸⡀⢠⠃⠀⢳⠀⣰⠃⠈⢧⣀⠞⠀⠀⢳⣀⡴⠒⠲│
      │⠀⢇⠀⡜⠀⠀⡇⠀⡇⠀⠀⡇⢠⠃⠀⠀⣇⡸⠀⠀⠀⠣⠏⠀⠀⠀⠓⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⠀⢸⠀⡇⠀⠀⢇⢰⠁⠀⠀⠸⡼⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⠀⢸⠀⡇⠀⠀⠸⡜⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      │⠀⠘⣾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
    0 │⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
      └─────────────────────────────────────────────────┘
      0                                       50

```

who confirms that ⟨â₁⟩(0) = α² —this is, the initial condition.

___
Alejandro R. Urzúa (2021) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/rurz/IntrinsicDecoherence)
