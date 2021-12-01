### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 44b34e3e-f591-11eb-33c7-0d192fda6f83
begin
    import Pkg
    Pkg.activate(Base.current_project())
	
	using QuantumOptics
end

# ╔═╡ 07955d5f-1272-4074-a531-5bc868722a7d
begin
	using PyPlot
	ion()
end

# ╔═╡ 9f0d6f82-87cf-405f-9c79-233b2c39ea2e
begin 
	const dim = 5

	fbasis = FockBasis(dim)
end

# ╔═╡ f34df059-eb22-4db5-a96b-3396695ec432
begin
	a = destroy(fbasis)
	n = number(fbasis)
end;

# ╔═╡ 37e774dc-ebca-4716-a44e-92bad8c91b7f
coh(α) = coherentstate(fbasis, α)

# ╔═╡ 1dd7ab9a-cc7d-4f2b-a4ce-9ee51a205fc0
dagger(coh(1))*dagger(a)*coh(1)

# ╔═╡ d0991d20-43b3-49b0-b579-6879815bc12b
sqee(ξ) = sparse(exp((1/2) * (conj(ξ) * dense(a)^2 - ξ * dense(dagger(a))^2)))

# ╔═╡ 02163fd0-99b0-492d-b03b-238890284567
diss(α) = sparse(exp(α * dense(dagger(a)) - conj(α) * dense(a)))

# ╔═╡ e86d36fe-28ff-49f3-bd7a-20fef0390695
acoh(ω, λ, γ, α, t) = (α + (λ/ω)) * exp(-γ * t * exp(- 1im * ω / γ)) - (λ/ω)

# ╔═╡ d3c34519-101e-4c6c-ba05-97684fde57b7
tlist = range(0, stop = 5, length = 500)

# ╔═╡ 3e84e3d9-c822-4451-bd8b-96c31e6e9ef6
tacoh = [acoh(4, 1, 5, 4, tlist[τ]) for τ in 1:length(tlist)]

# ╔═╡ 875caefb-fd1a-4c21-8749-03e5c2d8dcaf
begin
	plot(tlist, real.(tacoh))
	plot(tlist, imag.(tacoh))
end

# ╔═╡ Cell order:
# ╠═44b34e3e-f591-11eb-33c7-0d192fda6f83
# ╠═9f0d6f82-87cf-405f-9c79-233b2c39ea2e
# ╠═f34df059-eb22-4db5-a96b-3396695ec432
# ╠═37e774dc-ebca-4716-a44e-92bad8c91b7f
# ╠═1dd7ab9a-cc7d-4f2b-a4ce-9ee51a205fc0
# ╠═d0991d20-43b3-49b0-b579-6879815bc12b
# ╠═02163fd0-99b0-492d-b03b-238890284567
# ╠═e86d36fe-28ff-49f3-bd7a-20fef0390695
# ╠═07955d5f-1272-4074-a531-5bc868722a7d
# ╠═d3c34519-101e-4c6c-ba05-97684fde57b7
# ╠═3e84e3d9-c822-4451-bd8b-96c31e6e9ef6
# ╠═875caefb-fd1a-4c21-8749-03e5c2d8dcaf
