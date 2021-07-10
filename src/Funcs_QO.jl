
using QuantumOptics

export ψ, ρ
####################################################################################################
"`fbasis(N::Integer)` gives the Fock basis of N modes"
function fbasis(N::Integer)
    return FockBasis(N)
end

"`dop(fbasis)` gives the destroy operator on a Fock basis of N modes"
function dop(fbasis)
    return destroy(fbasis)
end
####################################################################################################
const θ = π/4
const csθ = 1/√(2)
####################################################################################################
ωₚ(ω, λ) = ω + λ
ωₘ(ω, λ) = ω - λ

ωₐ(ωₚ, ω, g) = (1/2) * (ωₚ + ω - √(8 * g^2 + (ωₚ - ω)^2))
ω₂(ωₚ, ω, g) = (1/2) * (ωₚ + ω + √(8 * g^2 + (ωₚ - ω)^2))

csϕθ(ωₚ, ω, g) = 0.5 * √(1 + (ωₚ - ω)/√(8 * g^2 + (ωₚ - ω)^2))
ssϕθ(ωₚ, ω, g) = 0.5 * √(1 - (ωₚ - ω)/√(8 * g^2 + (ωₚ - ω)^2))

ϕ(ωₚ, ω, g) = (1/2) * atan((2 * √(2) * g)/(ωₚ - ω));
####################################################################################################
"`opt(op, pos, N)` gives the 3-tensor of the operator `op` ∈ {a, a†, n} on position `pos` ∈ {1, 2, 3} for N modes in each oscillator"
function opt(op, pos, N)
    if pos == 1
        return tensor(op, identityoperator(fbasis(N)), identityoperator(fbasis(N)))
    elseif pos == 2
        return tensor(identityoperator(fbasis(N)), op, identityoperator(fbasis(N)))
    elseif pos == 3
        tensor(identityoperator(fbasis(N)), identityoperator(fbasis(N)), op)
    end
end
####################################################################################################
arg12(N) = dense(dagger(opt(dop(fbasis(N)), 2, N)) * opt(dop(fbasis(N)), 3, N) - dagger(opt(dop(fbasis(N)), 3, N)) * opt(dop(fbasis(N)), 2, N))

R₁₂(N) = exp(θ * arg12(N))

arg2(N) = dense(dagger(opt(dop(fbasis(N)), 2, N)) * opt(dop(fbasis(N)), 1, N) - dagger(opt(dop(fbasis(N)), 1, N)) * opt(dop(fbasis(N)), 2, N))

R₂(ωₚ, ω, g, N) = exp(ϕ(ωₚ, ω, g) * arg2(N))
####################################################################################################
α(ωₚ, ω, g) = (1im) * ssϕθ(ωₚ, ω, g)
const α₁ = (1im) * cos(θ)
α₂(ωₚ, ω, g) = (1im) * csϕθ(ωₚ, ω, g)
####################################################################################################
"`ψ(ωₚ, ω, g, λ, k, γ, N)` is the eigenstate for the three-oscillators"
ψ(ωₚ, ω, g, λ, k, γ, N) = dagger(R₁₂(N)) * dagger(R₂(ωₚ, ω, g, N)) * tensor(coherentstate(fbasis(N), -α(ωₚ, ω, g) * exp(-1im * ωₐ(ωₚ, ω, g) * k/γ)), coherentstate(fbasis(N), α₁ * exp(-1im * ωₘ(ω, λ) * k/γ)), coherentstate(fbasis(N), α₂(ωₚ, ω, g) * exp(-1im * ω₂(ωₚ, ω, g) * k/γ)))

ρ(ωₚ, ω, g, λ, k, γ, N) = ψ(ωₚ, ω, g, λ, k, γ, N)  ⊗ dagger(ψ(ωₚ, ω, g, λ, k, γ, N) )
