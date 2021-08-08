### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ ac89ffd2-f717-11eb-3fb2-d77d7f818725
begin
    import Pkg
    Pkg.activate(Base.current_project())
	
	using QuantumOptics
end

# ╔═╡ 65dd2c78-3317-4fc4-867b-ae5a1043f3f3
begin
	using PyPlot
	ion()
end

# ╔═╡ ccd42b7b-0c0c-4bb8-b3f0-fa424bbf127c
begin 
	const dim = 30

	fbasis = FockBasis(dim)
end

# ╔═╡ e0fbeeb5-02ef-4c4f-a8cf-bb8143af4660
begin
	a = destroy(fbasis)
	n = number(fbasis)
end;

# ╔═╡ 97e730c1-c09e-44dd-8074-283b993394f0
H(ω, λ) = ω * dagger(a) * a + λ * (a + dagger(a))

# ╔═╡ 05531381-00fa-424e-87cd-fab529b72d3d
tlist = [0:0.05:10;];

# ╔═╡ 1bed70a4-27d2-4a7b-bd49-ab565ea128c0
ψ₀(α) = coherentstate(fbasis, α);

# ╔═╡ b7cb690e-3e0e-4855-97af-5015ac354fa2
tout, ψₜ = timeevolution.schroedinger(tlist, ψ₀(4), H(4, 0.1));

# ╔═╡ cc571d2a-3abe-4c07-a64d-9799b5aef844
begin
	ev1 = expect(n, ψₜ)
	ev2 = expect(a, ψₜ)
end;

# ╔═╡ 45e61eba-9dbe-4322-8924-155058f90a02
begin
	plot(tout, ev1)
	plot(tout, ev2)
end

# ╔═╡ Cell order:
# ╠═ac89ffd2-f717-11eb-3fb2-d77d7f818725
# ╠═65dd2c78-3317-4fc4-867b-ae5a1043f3f3
# ╠═ccd42b7b-0c0c-4bb8-b3f0-fa424bbf127c
# ╠═e0fbeeb5-02ef-4c4f-a8cf-bb8143af4660
# ╠═97e730c1-c09e-44dd-8074-283b993394f0
# ╠═05531381-00fa-424e-87cd-fab529b72d3d
# ╠═1bed70a4-27d2-4a7b-bd49-ab565ea128c0
# ╠═b7cb690e-3e0e-4855-97af-5015ac354fa2
# ╠═cc571d2a-3abe-4c07-a64d-9799b5aef844
# ╠═45e61eba-9dbe-4322-8924-155058f90a02
