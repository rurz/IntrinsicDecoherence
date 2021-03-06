### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 6fc66216-fa46-11eb-27bc-8fcb9143502c
begin
    import Pkg
    Pkg.activate(Base.current_project())
	
	using IntrinsicDecoherence
end

# ╔═╡ 46d9d011-ad41-49fb-aea0-8a55e93d97b5
begin
	using PyPlot
	using LaTeXStrings
	ion()
	rc("text", usetex = true)
end

# ╔═╡ 198df15f-890d-44f6-bb13-d9cde21c0e8a
begin
	const α = 4
	const r = 0.3
	const ω = 4
end;

# ╔═╡ be4e4005-6372-4d95-8c40-d9eb7d6a91f4
tlist = range(0, stop = 7, length = 500);

# ╔═╡ 1af1ee37-55e5-4f9f-b7bc-896a52ffdc8f
begin
	ctrs = [quads_a(α, 0, 0, 0.7, ω, 10, tlist[τ]) for τ in 1:length(tlist)];
	tsq1 = [quads_a(α, r, 0.7, 0.7, ω, 10, tlist[τ]) for τ in 1:length(tlist)];
	tsq2 = [quads_a(α, r, 1.4, 0.7, ω, 10, tlist[τ]) for τ in 1:length(tlist)];
	tsq3 = [quads_a(α, r, 2.1, 0.7, ω, 10, tlist[τ]) for τ in 1:length(tlist)];
end;

# ╔═╡ 0ce11282-0612-4236-91ea-8fd0a17b1fc6
begin
	figreim1 = figure(figsize = (10, 6))
	axreim1 = gca()
	
	#axreim1.plot(tlist, real(ctrs), "y--", lw = 2, alpha = 0.5)
	axreim1.plot(tlist, real(tsq1), "r", lw = 3, label = L"\theta = 0.7")
	axreim1.plot(tlist, real(tsq2), "g", lw = 3, label = L"\theta = 1.4")
	axreim1.plot(tlist, real(tsq3), "b", lw = 3, label = L"\theta = 2.1")
	
	#axreim1.set_ylim([-9, 9])
	
	#axreim1.text(1,4, L"r = 0.3", fontsize = 20)
	
	axreim1.legend(fontsize = 18)
	axreim1.set_ylabel(L"\textrm{Amplitude}", fontsize = 20)
	axreim1.set_xlabel(L"t\; [s]", fontsize = 18)
	setp(axreim1.get_xticklabels(), fontsize = 18)
	setp(axreim1.get_yticklabels(), fontsize = 18)
	axreim1.set_title(L"Expectation value of $\langle\hat{a}^{\dagger}+\hat{a}\rangle$", fontsize = 18)
	
	tight_layout()
	
	savefig("quads.pdf", dpi = 600)
end

# ╔═╡ e0492707-23ea-44bf-8530-4fe0df014f76
begin
	ctrS = [nums_a(α, 0, 0, 0.7, ω, 10, tlist[τ]) for τ in 1:length(tlist)];
	tSq1 = [nums_a(α, r, 0.7, 0.7, ω, 10, tlist[τ]) for τ in 1:length(tlist)];
	tSq2 = [nums_a(α, r, 1.4, 0.7, ω, 10, tlist[τ]) for τ in 1:length(tlist)];
	tSq3 = [nums_a(α, r, 2.1, 0.7, ω, 10, tlist[τ]) for τ in 1:length(tlist)];
end;

# ╔═╡ 0c1b4982-ad06-44d2-89b7-e4fab429521b
begin
	figreim2 = figure(figsize = (10, 6))
	axreim2 = gca()
	
	axreim2.plot(tlist, real(ctrS), "y--", lw = 2, alpha = 0.5)
	axreim2.plot(tlist, real(tSq1), "r", lw = 3, label = L"\theta = 0.7")
	axreim2.plot(tlist, real(tSq2), "g", lw = 3, label = L"\theta = 1.4")
	axreim2.plot(tlist, real(tSq3), "b", lw = 3, label = L"\theta = 2.1")
	
	#axreim1.set_ylim([-9, 9])
	
	#axreim2.text(5, 17.2, L"r = \theta = 0", fontsize = 16)
	axreim2.annotate(L"r = \theta = 0", xy=(5, 17.5), xytext=(5.5, 16), arrowprops = Dict("arrowstyle"=>"->"), fontsize = 14)
	
	axreim2.legend(fontsize = 18, loc = 1)
	axreim2.set_ylabel(L"\textrm{Number of Photons}", fontsize = 20)
	axreim2.set_xlabel(L"t\; [s]", fontsize = 18)
	setp(axreim2.get_xticklabels(), fontsize = 18)
	setp(axreim2.get_yticklabels(), fontsize = 18)
	axreim2.set_title(L"Expectation value of $\langle\hat{a}^{\dagger}\hat{a}\rangle$", fontsize = 18)
	
	tight_layout()
	
	savefig("nums.pdf", dpi = 600)
end

# ╔═╡ Cell order:
# ╠═6fc66216-fa46-11eb-27bc-8fcb9143502c
# ╠═46d9d011-ad41-49fb-aea0-8a55e93d97b5
# ╠═198df15f-890d-44f6-bb13-d9cde21c0e8a
# ╠═be4e4005-6372-4d95-8c40-d9eb7d6a91f4
# ╠═1af1ee37-55e5-4f9f-b7bc-896a52ffdc8f
# ╠═0ce11282-0612-4236-91ea-8fd0a17b1fc6
# ╠═e0492707-23ea-44bf-8530-4fe0df014f76
# ╠═0c1b4982-ad06-44d2-89b7-e4fab429521b
