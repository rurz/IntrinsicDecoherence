### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 6d001f68-067c-419e-89d9-32bc1ab88bad
using Pkg

# ╔═╡ 99a0f9b0-6b90-4065-80c0-94900a65cd17
Pkg.activate(".")

# ╔═╡ 33c05de5-414a-4284-943e-541eb91a8b4a
using IntrinsicDecoherence

# ╔═╡ 0b698cec-442c-4658-823e-ec607f453a53
using Plots

# ╔═╡ 68c306e1-c37b-4860-808e-dca1e644f1ae
cd("..")

# ╔═╡ 1e04af3d-3c08-4a69-b9a4-cf685e110521
tlist = range(0, stop = 100, length = 1000);

# ╔═╡ edd1a047-90f7-49bd-ac92-0c367a629565
plotly()

# ╔═╡ fd2e3bf4-20be-449d-91c2-0d080e359765
γ = @bind γ html"<input type=range min=0 max=100 step=10 value=0>"

# ╔═╡ 46ad7bbd-d854-470f-99af-acf5ad0b8495
λ = @bind λ html"<input type=range min=0 max=1 step=0.1 value=0>"

# ╔═╡ fef57323-aed6-4ec5-9ff2-9dc83c819d50
g = @bind g html"<input type=range min=0 max=1 step=0.1 value=0>"

# ╔═╡ 033f8e62-dcd3-47b2-ba00-9bd4c5b8ef1f
Ta = [real(exv_a(4, λ, g, γ, 4, tlist[τ])) for τ in 1:length(tlist)];

# ╔═╡ d52bf409-9ca8-47d0-a243-2d9fa1bea03d
Ta₁ = [real(exv_a₁(4, λ, g, γ, 4, tlist[τ])) for τ in 1:length(tlist)];

# ╔═╡ 7604bc70-2a8e-40fa-bd1f-ae565590cf97
Ta₂ = [real(exv_a₂(4, λ, g, γ, 4, tlist[τ])) for τ in 1:length(tlist)];

# ╔═╡ c3c04f4b-d91a-4e8c-8d9d-7cb7e6713702
plot(tlist, [Ta, Ta₁, Ta₂], linewidth = 4, title = "γ = $γ, λ = $λ, g = $g", label = ["⟨aᵀa⟩" "⟨a₁ᵀa₁⟩" "⟨a₂ᵀa₂⟩"])

# ╔═╡ Cell order:
# ╠═68c306e1-c37b-4860-808e-dca1e644f1ae
# ╠═6d001f68-067c-419e-89d9-32bc1ab88bad
# ╠═99a0f9b0-6b90-4065-80c0-94900a65cd17
# ╠═33c05de5-414a-4284-943e-541eb91a8b4a
# ╠═1e04af3d-3c08-4a69-b9a4-cf685e110521
# ╠═033f8e62-dcd3-47b2-ba00-9bd4c5b8ef1f
# ╠═d52bf409-9ca8-47d0-a243-2d9fa1bea03d
# ╠═7604bc70-2a8e-40fa-bd1f-ae565590cf97
# ╠═0b698cec-442c-4658-823e-ec607f453a53
# ╟─edd1a047-90f7-49bd-ac92-0c367a629565
# ╟─fd2e3bf4-20be-449d-91c2-0d080e359765
# ╟─46ad7bbd-d854-470f-99af-acf5ad0b8495
# ╟─fef57323-aed6-4ec5-9ff2-9dc83c819d50
# ╠═c3c04f4b-d91a-4e8c-8d9d-7cb7e6713702
