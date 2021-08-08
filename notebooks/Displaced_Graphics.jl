### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 48be9ff8-f712-11eb-2c5f-5bcd200ee565
begin
    import Pkg
    Pkg.activate(Base.current_project())
	
	using IntrinsicDecoherence
end

# ╔═╡ c57eeb5f-f310-44ed-be9c-6692f46424c5
begin
	using PyPlot
	using LaTeXStrings
	ion()
	rc("text", usetex = true)
end

# ╔═╡ e8c55ba3-262e-459a-a101-fc7f4461fb90
begin
	const α = 4
	const ω = 4
end;

# ╔═╡ fb33fbf6-73e2-4e8f-891e-19b7fb8db5dd
t1 = range(0, stop = 10, length = 500);

# ╔═╡ aa43212b-f5f9-4fad-909d-5081ede80e21
begin
	tann1 = [ann_a(α, 0.1, ω, 3, t1[τ]) for τ in 1:length(t1)];
	tann2 = [ann_a(α, 0.5, ω, 3, t1[τ]) for τ in 1:length(t1)];
	tann3 = [ann_a(α, 1, ω, 3, t1[τ]) for τ in 1:length(t1)];
end

# ╔═╡ 84e0e33b-d58f-4b85-a770-cec5da2d59d1
begin
	figreim1 = figure(figsize = (10, 6))
	axreim1 = gca()
	
	axreim1.plot(t1, real(tann2), "b", lw = 3, label = L"\mathrm{Re}\{\langle\hat{a}\rangle\}")
	axreim1.plot(t1, imag(tann2), "g", lw = 3, label = L"\mathrm{Im}\{\langle\hat{a}\rangle\}")
	
	axreim1.legend(fontsize = 18)
	axreim1.set_ylabel(L"\textrm{Amplitude}", fontsize = 20)
	axreim1.set_xlabel(L"t\; [s]", fontsize = 18)
	setp(axreim1.get_xticklabels(), fontsize = 18)
	setp(axreim1.get_yticklabels(), fontsize = 18)
	axreim1.set_title(L"Expectation value of $\langle\hat{a}\rangle$", fontsize = 18)
	
	tight_layout()
	
	#savefig("aex.pdf", dpi = 600)
end

# ╔═╡ 98a14d54-30c0-4526-b791-8991d86c8ceb
begin
	tnum1 = [num_a(α, 0.1, ω, 10, t1[τ]) for τ in 1:length(t1)];
	tnum2 = [num_a(α, 0.5, ω, 10, t1[τ]) for τ in 1:length(t1)];
	tnum3 = [num_a(α, 1, ω, 10, t1[τ]) for τ in 1:length(t1)];
end

# ╔═╡ 526a3122-2c23-4939-a4d6-b89e4bfb8c92
begin
	fignum = figure(figsize = (10, 6))
	axnum = gca()
	
	axnum.plot(t1, real(tnum1), "r", lw = 3, label = L"\lambda = 0.1")
	axnum.plot(t1, real(tnum2), "g", lw = 3, label = L"\lambda = 0.5")
	axnum.plot(t1, real(tnum3), "b", lw = 3, label = L"\lambda = 1")
	
	axnum.set_ylim([16, 19.5])
	
	axnum.legend(fontsize = 18)
	axnum.set_ylabel(L"\textrm{Number of Photons}", fontsize = 20)
	axnum.set_xlabel(L"t\; [s]", fontsize = 18)
	setp(axnum.get_xticklabels(), fontsize = 18)
	setp(axnum.get_yticklabels(), fontsize = 18)
	axnum.set_title(L"Expectation value of $\langle\hat{a}^{\dagger}\hat{a}\rangle$", fontsize = 20)
	
	tight_layout()
	
	#savefig("nex.pdf", dpi = 600)
end

# ╔═╡ Cell order:
# ╠═48be9ff8-f712-11eb-2c5f-5bcd200ee565
# ╠═c57eeb5f-f310-44ed-be9c-6692f46424c5
# ╠═e8c55ba3-262e-459a-a101-fc7f4461fb90
# ╠═fb33fbf6-73e2-4e8f-891e-19b7fb8db5dd
# ╠═aa43212b-f5f9-4fad-909d-5081ede80e21
# ╠═84e0e33b-d58f-4b85-a770-cec5da2d59d1
# ╠═98a14d54-30c0-4526-b791-8991d86c8ceb
# ╠═526a3122-2c23-4939-a4d6-b89e4bfb8c92
