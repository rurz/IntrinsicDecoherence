### A Pluto.jl notebook ###
# v0.15.1

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

# ╔═╡ ae5783e0-84c9-432a-8034-3999b55e9f4e
@bind λ html"<input type='range' min=0.1 max=1 step=0.1 value=0.1>"

# ╔═╡ bc231fdf-d7c5-42eb-9b78-565334729de2
λ

# ╔═╡ Cell order:
# ╠═ae5783e0-84c9-432a-8034-3999b55e9f4e
# ╠═bc231fdf-d7c5-42eb-9b78-565334729de2
