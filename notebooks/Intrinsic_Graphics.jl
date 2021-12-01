### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ d82325be-ee76-11eb-255e-21790b024173
# Activate the shared project environment
begin
    import Pkg
    Pkg.activate(Base.current_project())
	
	using IntrinsicDecoherence
end

# ╔═╡ d78603ff-5546-47e8-8f11-3f37bbd78e3b
# Calling plotting suite
begin
	using PyPlot
	using LaTeXStrings
	ion()
	rc("text", usetex = true)
end

# ╔═╡ e5378250-e42e-47a3-85bf-2c214abca6e9
md"## Intrinsic decoherence dynamics in the three-coupled harmonic oscillators interaction"

# ╔═╡ a6d194a6-5336-4495-9555-bd1b084b4203
# Set the constant parameters
begin
	const α = 4
	const ω = 4
	const λ = 0.5
end;

# ╔═╡ a5f8d238-8f9e-48a8-9e8c-292e0a884bd0
# For γ = 10
begin
	t_list = range(0, stop = 70, length = 1000)
	
	texv1_a = [exv_a(ω, λ, 0.1, 10, α, t_list[τ]) for τ in 1:length(t_list)]
	texv1_a1 = [exv_a₁(ω, λ, 0.1, 10, α, t_list[τ]) for τ in 1:length(t_list)]
	texv1_a2 = [exv_a₂(ω, λ, 0.1, 10, α, t_list[τ]) for τ in 1:length(t_list)]
	
	texv2_a = [exv_a(ω, λ, 0.5, 10, α, t_list[τ]) for τ in 1:length(t_list)]
	texv2_a1 = [exv_a₁(ω, λ, 0.5, 10, α, t_list[τ]) for τ in 1:length(t_list)]
	texv2_a2 = [exv_a₂(ω, λ, 0.5, 10, α, t_list[τ]) for τ in 1:length(t_list)]
	
	texv3_a = [exv_a(ω, λ, 1, 10, α, t_list[τ]) for τ in 1:length(t_list)]
	texv3_a1 = [exv_a₁(ω, λ, 1, 10, α, t_list[τ]) for τ in 1:length(t_list)]
	texv3_a2 = [exv_a₂(ω, λ, 1, 10, α, t_list[τ]) for τ in 1:length(t_list)]
end;

# ╔═╡ a31563ba-6c02-4092-bad0-765f820f7a38
begin
	figs, (axs1, axs2, axs3) = subplots(3,1, figsize = (6,10), sharex = true)
	
	axs1.plot(t_list, real(texv1_a1), "r", lw = 3, label = L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle")
	axs1.plot(t_list, real(texv1_a2), "b", lw = 3, label = L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle")
	axs1.plot(t_list, real(texv1_a), "g", lw = 3, label = L"\langle \hat{a}_{3}^{\dagger}\hat{a}_{3} \rangle")
	
	axs2.plot(t_list, real(texv2_a1), "r", lw = 3, label = L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle")
	axs2.plot(t_list, real(texv2_a2), "b", ms = 4, lw = 3, label = L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle")
	axs2.plot(t_list, real(texv2_a), "g", linestyle = (0, (5, 5)), lw = 3, label = L"\langle \hat{a}_{3}^{\dagger}\hat{a}_{3} \rangle")
	
	axs3.plot(t_list, real(texv3_a1), "r", lw = 3, label = L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle")
	axs3.plot(t_list, real(texv3_a2), "b", lw = 3, label = L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle")
	axs3.plot(t_list, real(texv3_a), "g", lw = 3, label = L"\langle \hat{a}_{3}^{\dagger}\hat{a}_{3} \rangle")
	
	axs1.text(69, 0, L"(a)", fontsize=16)
	axs2.text(69, 0, L"(b)", fontsize=16)
	axs3.text(69, 0, L"(c)", fontsize=16)
	
	axs1.set_yticks([0, 4, 8, 12, 16])
	axs2.set_yticks([0, 4, 8, 12, 16])
	axs3.set_yticks([0, 4, 8, 12, 16])
	
	axins = axs3.inset_axes([0.4, 0.6, 0.25, 0.25])
	axins.plot(t_list, real(texv3_a1), "r")
	axins.plot(t_list, real(texv3_a2), "b")
	axins.plot(t_list, real(texv3_a), "g")
	axins.set_xlim([0,8])
	axins.set_title(L"Close view $0 \leq t \leq 8$", fontsize = 12)
	setp(axins.get_xticklabels(), fontsize = 12)
	setp(axins.get_yticklabels(), fontsize = 12)
	axins.set_yticks([0,8,16])
	axins.set_xticks([0,4,8])
	
	axs1.set_ylabel(L"\textrm{Number of photons}", fontsize = 20)
	setp(axs1.get_xticklabels(), fontsize = 18)
	setp(axs1.get_yticklabels(), fontsize = 18)
	axs1.legend(fontsize = 13)
	
	axs2.set_ylabel(L"\textrm{Number of photons}", fontsize = 20)
	setp(axs2.get_xticklabels(), fontsize = 18)
	setp(axs2.get_yticklabels(), fontsize = 18)
	axs2.legend(fontsize = 13)
	
	axs3.set_xlabel(L"t\; [s]", fontsize = 18)
	axs3.set_ylabel(L"\textrm{Number of photons}", fontsize = 20)
	setp(axs3.get_xticklabels(), fontsize = 18)
	setp(axs3.get_yticklabels(), fontsize = 18)
	axs3.legend(fontsize = 13)
	
	tight_layout()
	
	savefig("γ10_sp.pdf", dpi = 300)
	savefig("γ10_sp.png", dpi = 300)
end

# ╔═╡ e5d45e47-c94a-41f6-80fb-6874e3b84fbf
# For γ = 100
begin
	t_lisT = range(0, stop = 7, length = 500)
	
	texV1_a = [exv_a(ω, λ, 0.1, 100, α, t_lisT[τ]) for τ in 1:length(t_lisT)]
	texV1_a1 = [exv_a₁(ω, λ, 0.1, 100, α, t_lisT[τ]) for τ in 1:length(t_lisT)]
	texV1_a2 = [exv_a₂(ω, λ, 0.1, 100, α, t_lisT[τ]) for τ in 1:length(t_lisT)]
	
	texV2_a = [exv_a(ω, λ, 0.5, 100, α, t_lisT[τ]) for τ in 1:length(t_lisT)]
	texV2_a1 = [exv_a₁(ω, λ, 0.5, 100, α, t_lisT[τ]) for τ in 1:length(t_lisT)]
	texV2_a2 = [exv_a₂(ω, λ, 0.5, 100, α, t_lisT[τ]) for τ in 1:length(t_lisT)]
	
	texV3_a = [exv_a(ω, λ, 1, 100, α, t_lisT[τ]) for τ in 1:length(t_lisT)]
	texV3_a1 = [exv_a₁(ω, λ, 1, 100, α, t_lisT[τ]) for τ in 1:length(t_lisT)]
	texV3_a2 = [exv_a₂(ω, λ, 1, 100, α, t_lisT[τ]) for τ in 1:length(t_lisT)]
end;

# ╔═╡ 07961c9f-34fd-401b-b7a9-f4ab25e6c94b
begin
	figS, (axS1, axS2, axS3) = subplots(3,1, figsize = (6,10), sharex = true)
	
	axS1.plot(t_lisT, real(texV1_a1), "r", lw = 3, label = L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle")
	axS1.plot(t_lisT, real(texV1_a2), "b", lw = 3, label = L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle")
	axS1.plot(t_lisT, real(texV1_a), "g", lw = 3, label = L"\langle \hat{a}_{3}^{\dagger}\hat{a}_{3} \rangle")
	
	axS2.plot(t_lisT, real(texV2_a1), "r", lw = 3, label = L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle")
	axS2.plot(t_lisT, real(texV2_a2), "b", ms = 3, lw = 3, label = L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle")
	axS2.plot(t_lisT, real(texV2_a), "g", linestyle = (0, (5, 5)), lw = 3, label = L"\langle \hat{a}_{3}^{\dagger}\hat{a}_{3} \rangle")
	
	axS3.plot(t_lisT, real(texV3_a1), "r", lw = 3, label = L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle")
	axS3.plot(t_lisT, real(texV3_a2), "b", lw = 3, label = L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle")
	axS3.plot(t_lisT, real(texV3_a), "g", lw = 3, label = L"\langle \hat{a}_{3}^{\dagger}\hat{a}_{3} \rangle")
	
	axS1.text(6.9, 0, L"(a)", fontsize=16)
	axS2.text(6.9, 0, L"(b)", fontsize=16)
	axS3.text(6.9, 0, L"(c)", fontsize=16)
	
	axS1.set_yticks([0, 4, 8, 12, 16])
	axS2.set_yticks([0, 4, 8, 12, 16])
	axS3.set_yticks([0, 4, 8, 12, 16])
	
	axS1.set_ylabel(L"\textrm{Number of photons}", fontsize = 20)
	setp(axS1.get_xticklabels(), fontsize = 18)
	setp(axS1.get_yticklabels(), fontsize = 18)
	axS1.legend(fontsize = 13)
	
	axS2.set_ylabel(L"\textrm{Number of photons}", fontsize = 20)
	setp(axS2.get_xticklabels(), fontsize = 18)
	setp(axS2.get_yticklabels(), fontsize = 18)
	axS2.legend(fontsize = 13)
	
	axS3.set_xlabel(L"t\; [s]", fontsize = 18)
	axS3.set_ylabel(L"\textrm{Number of photons}", fontsize = 20)
	setp(axS3.get_xticklabels(), fontsize = 18)
	setp(axS3.get_yticklabels(), fontsize = 18)
	axS3.legend(fontsize = 13)
	
	tight_layout()
	
	savefig("γ100_sp.pdf", dpi = 300)
	savefig("γ100_sp.png", dpi = 300)
end

# ╔═╡ Cell order:
# ╟─e5378250-e42e-47a3-85bf-2c214abca6e9
# ╠═d82325be-ee76-11eb-255e-21790b024173
# ╠═d78603ff-5546-47e8-8f11-3f37bbd78e3b
# ╠═a6d194a6-5336-4495-9555-bd1b084b4203
# ╠═a5f8d238-8f9e-48a8-9e8c-292e0a884bd0
# ╠═a31563ba-6c02-4092-bad0-765f820f7a38
# ╠═e5d45e47-c94a-41f6-80fb-6874e3b84fbf
# ╠═07961c9f-34fd-401b-b7a9-f4ab25e6c94b
