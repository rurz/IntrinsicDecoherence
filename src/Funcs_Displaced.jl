"
This script contains the functions to evaluate the expectation values ⟨Â⟩ for the displaced oscillator

The parameters to be given are: ω, λ, g, γ, α, and a list of sampled times t, plus r and θ for the squeezed states

"

export ann_a, num_a, quad_a, quads_a, nums_a

"`quad_a(α, λ, ω, γ, t)` evaluate the position quadrature operator average for the coherent state. α ∈ Complex"
quad_a(α, λ, ω, γ, t) = (α + (λ/ω)) * exp(-γ * t * (1 - exp(1im * ω/γ))) + (conj(α) + (λ/ω)) * exp(-γ * t * (1 - exp(-1im * ω/γ))) - 2 * (λ/ω)

"`num_a(α, λ, ω, γ, t)` evaluate the number operator average for the coherent state. α ∈ Complex"
num_a(α, λ, ω, γ, t) = abs2(α) + (λ/ω) * (α + conj(α)) + 2 * (λ/ω)^2 - (λ/ω) * ((α + (λ/ω)) * exp(-γ * t * (1 - exp(1im * ω/γ))) + (conj(α) + (λ/ω)) * exp(-γ * t * (1 - exp(-1im * ω/γ))))

# Squeezed coefficients
μ(r) = cosh(r)
ν(r, θ) = exp(1im * θ) * sinh(r)

"`quads_a(α, r, θ, λ, ω, γ, t)` evaluate the position quadrature operator average for the squeezed state. α ∈ Complex"
quads_a(α, r, θ, λ, ω, γ, t) = (μ(r) * conj(α) + conj(ν(r, θ)) * α + (λ/ω)) * exp(-γ * t * (1 - exp(1im * ω/γ))) + (μ(r) * α + ν(r, θ) * conj(α) + (λ/ω)) * exp(-γ * t * (1 - exp(-1im * ω/γ))) - 2 * (λ/ω)

# Number operator squeezed coefficients
ncf1(r, θ, α) = (μ(r)^2 + abs2(ν(r, θ))) * abs2(α)
ncf2(r, θ, α) = μ(r) * (ν(r, θ) * conj(α)^2 + conj(ν(r, θ)) * α^2)
ncf3(r, θ, α) = (μ(r) - conj(ν(r, θ))) * α + (μ(r) - ν(r, θ)) * conj(α)
ncf4(r, θ, α) = μ(r) * conj(α) - conj(ν(r, θ)) * α
ncf5(r, θ, α) = μ(r) * α - ν(r, θ) * conj(α)

"`nums_a(α, r, θ, λ, ω, γ, t)` evaluate the number operator average for the squeezed state. α ∈ Complex"
nums_a(α, r, θ, λ, ω, γ, t) = (ncf1(r, θ, α) - ncf2(r, θ, α) + (λ/ω) * ncf3(r, θ, α) + 2 * (λ/ω)^2 + abs2(ν(r, θ))) - (λ/ω) * ((ncf4(r, θ, α) + (λ/ω)) * exp(-γ * t * (1 - exp(1im * ω/γ))) + (ncf5(r, θ, α) + (λ/ω)) * exp(-γ * t * (1 - exp(-1im * ω/γ))))
