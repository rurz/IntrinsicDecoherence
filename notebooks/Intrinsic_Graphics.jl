### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 0d84d5ac-dec0-11eb-2c4c-ed35c8f4dac3
# Loading necessary packages

begin
	using PyPlot
	using LaTeXStrings
	ion()
	rc("text", usetex = true)
end

# ╔═╡ 1ba667b6-3335-4371-bb8c-2fa51d78a34e
md"

# Intrinsic decoherence in three coupled harmonic oscillator
##### by Alejandro R. Urzúa and Héctor M. Moya-Cessa

"

# ╔═╡ 45b9d057-2612-419c-b741-7b8ac77f9602
# Defining the parameters

begin
	α = 4 # For the coherent state |α⟩₁
	ω = 4 
	λ = 0.5
	
	ωₘ = ω - λ
	ωₚ = ω + λ
	
	Ω(g) = (1/2) * (ω + ωₚ - √(8 * g^2 + (ωₚ - ω)^2))
	Ω₂(g) = (1/2) * (ω + ωₚ + √(8 * g^2 + (ωₚ - ω)^2))
	
	c2ϕ(g) = (ωₚ - ω)/√(8 * g^2 + (ωₚ - ω)^2)
	s2ϕ(g) = (2 * √2 * g)/√(8 * g^2 + (ωₚ - ω)^2)
	
	cc2ϕ(g) = (1/2) * (1 + c2ϕ(g))
	ss2ϕ(g) = (1/2) * (1 - c2ϕ(g))
end;

# ╔═╡ b437a8b1-397a-4ad5-b69a-2b275d961751
begin
	expΩΩ₂(g, γ, t) = 
		exp(big(
		γ * t * exp(
			(1im/γ) * (
				Ω(g) - Ω₂(g)
					)
				)
			))
	
	expωₘΩ₂(g, γ, t) = 
	exp(big(
		γ * t * exp(
			(1im/γ) * (
				ωₘ - Ω₂(g)
				)
			)
	))
	
	expωₘΩ(g, γ, t) = 
	exp(big(
		γ * t * exp(
			(1im/γ) * (
				ωₘ - Ω(g)
				)
			)
	))
end;

# ╔═╡ 2e719c4c-a60f-48a2-ad50-aff7546c2ca3
exv_a(g, γ, t) = 
abs2(α) * cc2ϕ(g) * ss2ϕ(g) * 
	(1 - (1/2) * exp(-γ * t) * (
		expΩΩ₂(g, γ, t) + conj(expΩΩ₂(g, γ, t))
	)
	
);

# ╔═╡ 5d63b13a-9920-45c8-8e1e-2f4409c1ba19
exv_a1(g, γ, t) = 
(1/4) * abs2(α) * (
	1 + cc2ϕ(g)^2 + ss2ϕ(g)^2 +
	exp(-γ * t) * (
		(expΩΩ₂(g, γ, t) + conj(expΩΩ₂(g, γ, t))) * cc2ϕ(g) * ss2ϕ(g) +
			(expωₘΩ₂(g, γ, t) + conj(expωₘΩ₂(g, γ, t))) * cc2ϕ(g) +
					(expωₘΩ(g, γ, t) + conj(expωₘΩ(g, γ, t))) * ss2ϕ(g)
		)
	)

# ╔═╡ 5f31e782-5638-492d-8b47-0b05b4422f02
exv_a2(g, γ, t) = 
(1/4) * abs2(α) * (
	1 + cc2ϕ(g)^2 + ss2ϕ(g)^2 +
	exp(-γ * t) * (
		(expΩΩ₂(g, γ, t) + conj(expΩΩ₂(g, γ, t))) * cc2ϕ(g) * ss2ϕ(g) -
			(expωₘΩ₂(g, γ, t) + conj(expωₘΩ₂(g, γ, t))) * cc2ϕ(g) -
					(expωₘΩ(g, γ, t) + conj(expωₘΩ(g, γ, t))) * ss2ϕ(g)
		)
	)

# ╔═╡ 91d5a6b4-72f4-4386-b326-c2b55dd89087
# γ = 10

begin
	t_list = range(0, stop = 70, length = 1000)
	
	texv1_a = [exv_a(0.1, 10, t_list[τ]) for τ in 1:length(t_list)]
	texv1_a1 = [exv_a1(0.1, 10, t_list[τ]) for τ in 1:length(t_list)]
	texv1_a2 = [exv_a2(0.1, 10, t_list[τ]) for τ in 1:length(t_list)]
	
	texv2_a = [exv_a(0.5, 10, t_list[τ]) for τ in 1:length(t_list)]
	texv2_a1 = [exv_a1(0.5, 10, t_list[τ]) for τ in 1:length(t_list)]
	texv2_a2 = [exv_a2(0.5, 10, t_list[τ]) for τ in 1:length(t_list)]
	
	texv3_a = [exv_a(1, 10, t_list[τ]) for τ in 1:length(t_list)]
	texv3_a1 = [exv_a1(1, 10, t_list[τ]) for τ in 1:length(t_list)]
	texv3_a2 = [exv_a2(1, 10, t_list[τ]) for τ in 1:length(t_list)]
end;

# ╔═╡ d98d4cea-e6cc-4e22-8f66-ad1ba8910ae0
# γ = 100

begin
	t_lisT = range(0, stop = 7, length = 1000)
	
	texV1_a = [exv_a(0.1, 100, t_lisT[τ]) for τ in 1:length(t_lisT)]
	texV1_a1 = [exv_a1(0.1, 100, t_lisT[τ]) for τ in 1:length(t_lisT)]
	texV1_a2 = [exv_a2(0.1, 100, t_lisT[τ]) for τ in 1:length(t_lisT)]
	
	texV2_a = [exv_a(0.5, 100, t_lisT[τ]) for τ in 1:length(t_lisT)]
	texV2_a1 = [exv_a1(0.5, 100, t_lisT[τ]) for τ in 1:length(t_lisT)]
	texV2_a2 = [exv_a2(0.5, 100, t_lisT[τ]) for τ in 1:length(t_lisT)]
	
	texV3_a = [exv_a(1, 100, t_lisT[τ]) for τ in 1:length(t_lisT)]
	texV3_a1 = [exv_a1(1, 100, t_lisT[τ]) for τ in 1:length(t_lisT)]
	texV3_a2 = [exv_a2(1, 100, t_lisT[τ]) for τ in 1:length(t_lisT)]
end;

# ╔═╡ e78dafc3-eb16-48f2-86b1-b323f7b97f2d
begin
	figs, (axs1, axs2, axs3) = subplots(3,1, figsize = (6,10), sharex = true)
	
	axs1.plot(t_list, real(texv1_a), "r", lw = 3, label = L"\langle \hat{a}^{\dagger}\hat{a} \rangle")
	axs1.plot(t_list, real(texv1_a1), "g", lw = 3, label = L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle")
	axs1.plot(t_list, real(texv1_a2), "b", lw = 3, label = L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle")
	
	axs2.plot(t_list, real(texv2_a), "ro", lw = 3, label = L"\langle \hat{a}^{\dagger}\hat{a} \rangle")
	axs2.plot(t_list, real(texv2_a1), "g", lw = 3, label = L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle")
	axs2.plot(t_list, real(texv2_a2), "b", ms = 4, lw = 3, label = L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle")
	
	axs3.plot(t_list, real(texv3_a), "r", lw = 3, label = L"\langle \hat{a}^{\dagger}\hat{a} \rangle")
	axs3.plot(t_list, real(texv3_a1), "g", lw = 3, label = L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle")
	axs3.plot(t_list, real(texv3_a2), "b", lw = 3, label = L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle")
	
	axs1.text(70, 0, L"(a)", fontsize=13)
	axs2.text(70, 0, L"(b)", fontsize=13)
	axs3.text(70, 0, L"(c)", fontsize=13)
	
	axins = axs3.inset_axes([0.4, 0.6, 0.25, 0.25])
	axins.plot(t_list, real(texv3_a), "r")
	axins.plot(t_list, real(texv3_a1), "g")
	axins.plot(t_list, real(texv3_a2), "b")
	axins.set_xlim([0,5])
	axins.set_title(L"Close view $0 \leq t \leq 5$", fontsize = 11)
	
	axs1.set_ylabel(L"\textrm{Number of photons}", fontsize = 16)
	setp(axs1.get_xticklabels(), fontsize = 14)
	setp(axs1.get_yticklabels(), fontsize = 14)
	axs1.legend(fontsize = 12)
	
	axs2.set_ylabel(L"\textrm{Number of photons}", fontsize = 16)
	setp(axs2.get_xticklabels(), fontsize = 14)
	setp(axs2.get_yticklabels(), fontsize = 14)
	axs2.legend(fontsize = 12)
	
	axs3.set_xlabel(L"t\; [s]", fontsize = 14)
	axs3.set_ylabel(L"\textrm{Number of photons}", fontsize = 16)
	setp(axs3.get_xticklabels(), fontsize = 14)
	setp(axs3.get_yticklabels(), fontsize = 14)
	axs3.legend(fontsize = 12)
	
	tight_layout()
	
	#savefig("γ10_sp.pdf", dpi = 300)
end

# ╔═╡ 999fd3ea-c248-48f2-8a4b-15dd564710db
begin
	figS, (axS1, axS2, axS3) = subplots(3,1, figsize = (6,10), sharex = true)
	
	axS1.plot(t_lisT, real(texV1_a), "r", lw = 3, label = L"\langle \hat{a}^{\dagger}\hat{a} \rangle")
	axS1.plot(t_lisT, real(texV1_a1), "g", lw = 3, label = L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle")
	axS1.plot(t_lisT, real(texV1_a2), "b", lw = 3, label = L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle")
	
	axS2.plot(t_lisT, real(texV2_a), "ro", lw = 3, label = L"\langle \hat{a}^{\dagger}\hat{a} \rangle")
	axS2.plot(t_lisT, real(texV2_a1), "g", lw = 3, label = L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle")
	axS2.plot(t_lisT, real(texV2_a2), "b", ms = 4, lw = 3, label = L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle")
	
	axS3.plot(t_lisT, real(texV3_a), "r", lw = 3, label = L"\langle \hat{a}^{\dagger}\hat{a} \rangle")
	axS3.plot(t_lisT, real(texV3_a1), "g", lw = 3, label = L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle")
	axS3.plot(t_lisT, real(texV3_a2), "b", lw = 3, label = L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle")
	
	axS1.text(7, 0, L"(a)", fontsize=13)
	axS2.text(7, 0, L"(b)", fontsize=13)
	axS3.text(7, 0, L"(c)", fontsize=13)
	
	#axinS = axS3.inset_axes([0.4, 0.6, 0.25, 0.25])
	#axinS.plot(t_list, texV3_a, "r")
	#axinS.plot(t_list, texV3_a1, "g")
	#axinS.plot(t_list, texV3_a2, "b")
	#axinS.set_xlim([0,5])
	#axinS.set_title(L"Close view $0 \leq t \leq 5$", fontsize = 11)
	
	axS1.set_ylabel(L"\textrm{Number of photons}", fontsize = 16)
	setp(axS1.get_xticklabels(), fontsize = 14)
	setp(axS1.get_yticklabels(), fontsize = 14)
	axS1.legend(fontsize = 12)
	
	axS2.set_ylabel(L"\textrm{Number of photons}", fontsize = 16)
	setp(axS2.get_xticklabels(), fontsize = 14)
	setp(axS2.get_yticklabels(), fontsize = 14)
	axS2.legend(fontsize = 12)
	
	axS3.set_xlabel(L"t\; [s]", fontsize = 14)
	axS3.set_ylabel(L"\textrm{Number of photons}", fontsize = 16)
	setp(axS3.get_xticklabels(), fontsize = 14)
	setp(axS3.get_yticklabels(), fontsize = 14)
	axS3.legend(fontsize = 12)
	
	tight_layout()
	
	savefig("γ100_sp.png", dpi = 300)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
PyPlot = "d330b81b-6aea-500a-939a-2ce795aea3ee"

[compat]
LaTeXStrings = "~1.2.1"
PyPlot = "~2.9.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[Conda]]
deps = ["JSON", "VersionParsing"]
git-tree-sha1 = "299304989a5e6473d985212c28928899c74e9421"
uuid = "8f4d0f93-b110-5947-807f-2305c1781a2d"
version = "1.5.2"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "81690084b6198a2e1da36fcfda16eeca9f9f24e4"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.1"

[[LaTeXStrings]]
git-tree-sha1 = "c7f1c695e06c01b95a67f0cd1d34994f3e7db104"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.2.1"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "6a8a2a625ab0dea913aba95c11370589e0239ff0"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.6"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "c8abc88faa3f7a3950832ac5d6e690881590d6dc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "1.1.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[PyCall]]
deps = ["Conda", "Dates", "Libdl", "LinearAlgebra", "MacroTools", "Serialization", "VersionParsing"]
git-tree-sha1 = "169bb8ea6b1b143c5cf57df6d34d022a7b60c6db"
uuid = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
version = "1.92.3"

[[PyPlot]]
deps = ["Colors", "LaTeXStrings", "PyCall", "Sockets", "Test", "VersionParsing"]
git-tree-sha1 = "67dde2482fe1a72ef62ed93f8c239f947638e5a2"
uuid = "d330b81b-6aea-500a-939a-2ce795aea3ee"
version = "2.9.0"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "5f6c21241f0f655da3952fd60aa18477cf96c220"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.1.0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[VersionParsing]]
git-tree-sha1 = "80229be1f670524750d905f8fc8148e5a8c4537f"
uuid = "81def892-9a0e-5fdd-b105-ffc91e053289"
version = "1.2.0"
"""

# ╔═╡ Cell order:
# ╟─1ba667b6-3335-4371-bb8c-2fa51d78a34e
# ╠═0d84d5ac-dec0-11eb-2c4c-ed35c8f4dac3
# ╠═45b9d057-2612-419c-b741-7b8ac77f9602
# ╠═b437a8b1-397a-4ad5-b69a-2b275d961751
# ╠═2e719c4c-a60f-48a2-ad50-aff7546c2ca3
# ╠═5d63b13a-9920-45c8-8e1e-2f4409c1ba19
# ╠═5f31e782-5638-492d-8b47-0b05b4422f02
# ╠═91d5a6b4-72f4-4386-b326-c2b55dd89087
# ╠═d98d4cea-e6cc-4e22-8f66-ad1ba8910ae0
# ╠═e78dafc3-eb16-48f2-86b1-b323f7b97f2d
# ╠═999fd3ea-c248-48f2-8a4b-15dd564710db
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
