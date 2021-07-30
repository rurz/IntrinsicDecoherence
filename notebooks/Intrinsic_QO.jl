### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 7818dfb7-1574-4989-826d-824f8b1397d3
begin
    import Pkg
    Pkg.activate(Base.current_project())
	
	using QuantumOptics
end

# ╔═╡ de09dfbf-d4ae-400e-b1ae-d140c02d5857
begin
	using PyPlot
	ion()
end

# ╔═╡ b960f032-f0d2-11eb-018b-09493fde5a0e
md"## Intrinsic decoherence dynamics in the three-coupled harmonic oscillators interaction"

# ╔═╡ e989ff96-be84-4a14-8688-1a488aba28db
begin 
	const dim = 30

	fbasis = FockBasis(dim)
end

# ╔═╡ 34d5d453-f526-4353-bff9-1212b1649804
begin
	a = destroy(fbasis)
	n = number(fbasis)
end

# ╔═╡ 3b135ff8-38a2-43ab-b5bc-21bf3ba58d2d
function aT(pos)
	if pos == 1
		return tensor(a, identityoperator(fbasis), identityoperator(fbasis))
	elseif pos == 2
		return tensor(identityoperator(fbasis), a, identityoperator(fbasis))
	elseif pos == 3
		return tensor(identityoperator(fbasis), identityoperator(fbasis), a)
	end
end

# ╔═╡ 6e4d9b8a-c987-4d23-a80e-dfbddedcb3e2
function nT(pos)
	if pos == 1
		return tensor(n, identityoperator(fbasis), identityoperator(fbasis))
	elseif pos == 2
		return tensor(identityoperator(fbasis), n, identityoperator(fbasis))
	elseif pos == 3
		return tensor(identityoperator(fbasis), identityoperator(fbasis), n)
	end
end

# ╔═╡ bd5de8ee-7b51-46e3-98c1-95acb088ab6b
Hfree(ω) = ω * (nT(1) + nT(2) + nT(3))

# ╔═╡ 0a4f0325-d2c1-4cb5-8eef-a66eee7e2473
Hl(λ) = λ * (dagger(aT(1)) * aT(2) + dagger(aT(2)) * aT(1))

# ╔═╡ 379f0235-dc11-4a2f-a182-95782b4b5c17
Hg(g) = g * (aT(3) * (dagger(aT(1)) + dagger(aT(2))) + dagger(aT(3)) * (aT(1) + aT(2)))

# ╔═╡ 32dc8f18-b5c4-42d1-a86c-658f2f1270a1
H(ω, λ, g) = Hfree(ω) + Hl(λ) + Hg(g)

# ╔═╡ cd4e925f-52c1-4a2c-93c1-48fc4d48aa16
ψ₀(α) = tensor(coherentstate(fbasis, α), fockstate(fbasis, 0), fockstate(fbasis, 0))

# ╔═╡ fd1236b5-2b44-4a85-bb3b-787ad2bc3dab
tlist = [0:0.1:50;]

# ╔═╡ f01cf97c-a18d-448e-ac57-c923cea6dc73
tout, ψₜ = timeevolution.schroedinger(tlist, ψ₀(4), H(4, 0.5, 0.1))

# ╔═╡ 5d81d922-a86e-4937-a7e8-7caba47a0bdb
begin
	expn1 = expect(nT(1), ψₜ)
	expn2 = expect(nT(2), ψₜ)
	expn3 = expect(nT(3), ψₜ)
end

# ╔═╡ 63519656-c468-467e-a37c-3eadc730425a
begin
	plot(tout, expn1)
	plot(tout, expn2)
	plot(tout, expn3)
end

# ╔═╡ Cell order:
# ╟─b960f032-f0d2-11eb-018b-09493fde5a0e
# ╠═7818dfb7-1574-4989-826d-824f8b1397d3
# ╠═e989ff96-be84-4a14-8688-1a488aba28db
# ╠═34d5d453-f526-4353-bff9-1212b1649804
# ╠═3b135ff8-38a2-43ab-b5bc-21bf3ba58d2d
# ╠═6e4d9b8a-c987-4d23-a80e-dfbddedcb3e2
# ╠═bd5de8ee-7b51-46e3-98c1-95acb088ab6b
# ╠═0a4f0325-d2c1-4cb5-8eef-a66eee7e2473
# ╠═379f0235-dc11-4a2f-a182-95782b4b5c17
# ╠═32dc8f18-b5c4-42d1-a86c-658f2f1270a1
# ╠═cd4e925f-52c1-4a2c-93c1-48fc4d48aa16
# ╠═fd1236b5-2b44-4a85-bb3b-787ad2bc3dab
# ╠═f01cf97c-a18d-448e-ac57-c923cea6dc73
# ╠═5d81d922-a86e-4937-a7e8-7caba47a0bdb
# ╠═de09dfbf-d4ae-400e-b1ae-d140c02d5857
# ╠═63519656-c468-467e-a37c-3eadc730425a
