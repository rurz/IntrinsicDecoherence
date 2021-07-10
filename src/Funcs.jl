"
This script contains the functions to evaluate the expectation values ⟨Â⟩ for the three oscillators

The parameters to be given are: ω, λ, g, γ, α, and a list of sampled times t

"

export exv_a, exv_a₁, exv_a₂

## Definitions of the parameters and function parameters

ωₘ(ω, λ) = ω - λ
ωₚ(ω, λ) = ω + λ

Ω(ω, λ, g) = (1/2) * (ω + ωₚ(ω, λ) - √(8 * g^2 + (ωₚ(ω, λ) - ω)^2))
Ω₂(ω, λ, g) = (1/2) * (ω + ωₚ(ω, λ) + √(8 * g^2 + (ωₚ(ω, λ) - ω)^2))

c2ϕ(ω, λ, g) = (ωₚ(ω, λ) - ω)/√(8 * g^2 + (ωₚ(ω, λ) - ω)^2)
s2ϕ(ω, λ, g) = (2 * √2 * g)/√(8 * g^2 + (ωₚ(ω, λ) - ω)^2)

cc2ϕ(ω, λ, g) = (1/2) * (1 + c2ϕ(ω, λ, g))
ss2ϕ(ω, λ, g) = (1/2) * (1 - c2ϕ(ω, λ, g))

##
## Definition of the exponentials

expΩΩ₂(ω, λ, g, γ, t) = exp(big(γ * t * exp((1im/γ) * (Ω(ω, λ, g) - Ω₂(ω, λ, g)))))

expωₘΩ₂(ω, λ, g, γ, t) = exp(big(γ * t * exp((1im/γ) * (ωₘ(ω, λ) - Ω₂(ω, λ, g)))))

expωₘΩ(ω,λ, g, γ, t) = exp(big(γ * t * exp((1im/γ) * (ωₘ(ω, λ) - Ω(ω, λ, g)))))

##
## Definition of the functions who gives the expectation values

"`exv_a(ω, λ, g, γ, α, t)` gives the expectation value over time of the oscillator ⟨â⟩(t). The function will be waiting for the parameters {ω, λ, g, γ, α} and a list of sampled times."
exv_a(ω, λ, g, γ, α, t) = abs2(α) * cc2ϕ(ω, λ, g) * ss2ϕ(ω, λ, g) * (1 - (1/2) * exp(-γ * t) * (expΩΩ₂(ω, λ, g, γ, t) + conj(expΩΩ₂(ω, λ, g, γ, t))))

"`exv_a₁(ω, λ, g, γ, α, t)` gives the expectation value over time of the oscillator ⟨â₁⟩(t). The function will be waiting for the parameters {ω, λ, g, γ, α} and a list of sampled times."
exv_a₁(ω, λ, g, γ, α, t) = (1/4) * abs2(α) * (1 + cc2ϕ(ω, λ, g)^2 + ss2ϕ(ω, λ, g)^2 + exp(-γ * t) * ((expΩΩ₂(ω, λ, g, γ, t) + conj(expΩΩ₂(ω, λ, g, γ, t))) * cc2ϕ(ω, λ, g) * ss2ϕ(ω, λ, g) + (expωₘΩ₂(ω, λ, g, γ, t) + conj(expωₘΩ₂(ω, λ, g, γ, t))) * cc2ϕ(ω, λ, g) + (expωₘΩ(ω, λ, g, γ, t) + conj(expωₘΩ(ω, λ, g, γ, t))) * ss2ϕ(ω, λ, g)))

"`exv_a₂(ω, λ, g, γ, α, t)` gives the expectation value over time of the oscillator ⟨â₂⟩(t). The function will be waiting for the parameters {ω, λ, g, γ, α} and a list of sampled times."
exv_a₂(ω, λ, g, γ, α, t) = (1/4) * abs2(α) * (1 + cc2ϕ(ω, λ, g)^2 + ss2ϕ(ω, λ, g)^2 + exp(-γ * t) * ((expΩΩ₂(ω, λ, g, γ, t) + conj(expΩΩ₂(ω, λ, g, γ, t))) * cc2ϕ(ω, λ, g) * ss2ϕ(ω, λ, g) - (expωₘΩ₂(ω, λ, g, γ, t) + conj(expωₘΩ₂(ω, λ, g, γ, t))) * cc2ϕ(ω, λ, g) - (expωₘΩ(ω, λ, g, γ, t) + conj(expωₘΩ(ω, λ, g, γ, t))) * ss2ϕ(ω, λ, g)))

##

"WARNING: There's overflows issues for when the exponentials goes to very large numbers, their evaluations returns numbers below the machine precision."
