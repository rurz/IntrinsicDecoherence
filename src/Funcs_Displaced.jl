export ann_a, num_a, quad_a, quads_a

ann_a(α, λ, ω, γ, t) = (α + (λ/ω)) * exp(-γ * t * exp(-1im * ω/γ)) - (λ/ω)

quad_a(α, λ, ω, γ, t) = (α + (λ/ω)) * exp(-γ * t * (1 - exp(1im * ω/γ))) + (conj(α) + (λ/ω)) * exp(-γ * t * (1 - exp(-1im * ω/γ))) - 2 * (λ/ω)

num_a(α, λ, ω, γ, t) = abs2(α) + (λ/ω) * (α + conj(α)) + 2 * (λ/ω)^2 - (λ/ω) * ((α + (λ/ω)) * exp(-γ * t * (1 - exp(1im * ω/γ))) + (conj(α) + (λ/ω)) * exp(-γ * t * (1 - exp(-1im * ω/γ))))

μ(r) = cosh(r)
ν(r) = sinh(r)

quads_a(α, r, λ, ω, γ, t) = (μ(r) * conj(α) + ν(r) * α + (λ/ω)) * exp(-γ * t * (1 - exp(1im * ω/γ))) + (μ(r) * α + ν(r) * conj(α) + (λ/ω)) * exp(-γ * t * (1 - exp(-1im * ω/γ))) - 2 * (λ/ω)
