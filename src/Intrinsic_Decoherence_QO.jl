### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 88170b64-be9f-11eb-201c-e7e7327ae185
using QuantumOptics

# ╔═╡ 524e5d7c-771f-4ad0-99b4-fef95d535993
begin
	using PyPlot
	using LaTeXStrings
	ion()
	rc("text", usetex = true)
end

# ╔═╡ 82ac0b60-b99f-4f21-a477-7ff4777c902e
md"
## Intrinsic decoherence in three-coupled harmonic oscillator

Alejandro R. Urzúa & Héctor M. Moya-Cessa\
Coordinación de Óptica
Instituto Nacional de Astrofísica, Óptica y Electrónica\
(2021)
"

# ╔═╡ 8f5c48fb-e53d-4c6e-8d68-e37c43c43f66
md"
$H = \omega a^{\dagger}a + \omega\left(a_1^{\dagger}a_1 + a_2^{\dagger}a_2\right) + \lambda \left(a_1^{\dagger}a_2 + a_2^{\dagger}a_1\right)
    + g\left[a\left(a_1^{\dagger}+a_2^{\dagger}\right)+a^{\dagger}(a_1+a_2)\right]$
"

# ╔═╡ d486a29c-7305-41ee-8a98-bcf632e9f7c5
md"
$\begin{eqnarray*}
    H_{2} &=& \frac{1}{2} a^{\dagger}a\left(\left[\omega_{+} + \omega\right] - \sqrt{8g^{2}+\left(\omega_{+} - \omega\right)^{2}}\right)\\
    &+& \frac{1}{2}a_{2}^{\dagger}a_{2}\left(\left[\omega_{+} + \omega\right] + \sqrt{8g^{2}+\left(\omega_{+} + \omega\right)^{2}}\right)\\
    &+& \omega_{-}a_{1}^{\dagger}a_{1}
\end{eqnarray*}$
"

# ╔═╡ 742a9a93-7e7d-4e4a-8988-6261b5a31f42
begin
	N = 1 # Number of modes in the Fock space. The same for the three systems
	fbasis = FockBasis(N) # Operational basis
end;

# ╔═╡ b0867cd1-fc55-41d3-b29a-d18af7af079b
begin
	a = destroy(fbasis)
	a1 = a
	a2 = a
end;

# ╔═╡ b15259bf-b10e-4dda-b581-c10be8735c51
const θ = π/4;

# ╔═╡ d5636ba9-e3a9-4f2c-a19a-1db333493015
begin
	ω = 0.7
	λ = 0.6
	ωₚ = ω + λ
	ωₘ = ω - λ
	g = 1
	
	ωₐ = (1/2) * (ωₚ + ω - √(8 * g^2 + (ωₚ - ω)^2))
	ω₂ = (1/2) * (ωₚ + ω + √(8 * g^2 + (ωₚ - ω)^2))
	
	csϕθ = 0.5 * √(1 + (ωₚ - ω)/√(8 * g^2 + (ωₚ - ω)^2))
	ssϕθ = 0.5 * √(1 - (ωₚ - ω)/√(8 * g^2 + (ωₚ - ω)^2))
	csθ = 1/√(2)
end;

# ╔═╡ 1ddd377d-95ac-42ed-a089-e401e03e5a0d
const ϕ = (1/2) * atan((2 * √(2))/(ωₚ - ω));

# ╔═╡ 850ef1fd-103e-4508-8806-4c9e7660e490
begin
	aT = tensor(a, identityoperator(fbasis), identityoperator(fbasis))
	a1T = tensor(identityoperator(fbasis), a1, identityoperator(fbasis))
	a2T = tensor(identityoperator(fbasis), identityoperator(fbasis), a2)
end;

# ╔═╡ 98e5a648-b43a-406b-85f2-06969eaf236c
begin
	nT = tensor(number(fbasis), identityoperator(fbasis), identityoperator(fbasis))
	n1T = tensor(identityoperator(fbasis), number(fbasis), identityoperator(fbasis))
	n2T = tensor(identityoperator(fbasis), identityoperator(fbasis), number(fbasis))
end;

# ╔═╡ 76071672-8d08-494f-9da2-2021bb8f3755
R₁₂ = exp(θ * dense(dagger(a1T) * a2T - dagger(a2T) * a1T));

# ╔═╡ 563233c2-0b47-4411-8bdb-7b6335f833b4
R₂ = exp(ϕ * dense(dagger(a2T) * aT - dagger(aT) * a2T));

# ╔═╡ 264f9486-cef9-49af-abae-f788643781f3
begin
	α = (1im) * ssϕθ
	α₁ = (1im) * cos(θ)	
	α₂ = (1im) * csϕθ
end;

# ╔═╡ 5a022e4d-2846-4e81-b3a3-1e7ed99d1c1d
md"
$\ket{\psi}_{k}=R_{12}^{\dagger}R_{2}^{\dagger}\ket{-e^{-\frac{ik}{\gamma}\omega'}\alpha\sin\phi\sin\theta}\ket{e^{-\frac{ik}{\gamma}\omega''}\alpha\cos\theta}_{1}\ket{e^{-\frac{ik}{\gamma}\omega_{-}}\alpha\cos\phi\sin\theta}_{2}$
"

# ╔═╡ 8da4523c-3de5-491d-9274-55a3cbd65350
ψ(k,γ) = dagger(R₁₂) * dagger(R₂) * tensor(coherentstate(fbasis, -α * exp(-1im * ωₐ * k/γ)), coherentstate(fbasis, α₁ * exp(-1im * ωₘ * k/γ)), coherentstate(fbasis, α₂ * exp(-1im * ω₂ * k/γ)))

# ╔═╡ dd315b29-b708-4514-bfcf-89d5853b0782
md"
$\rho_k=\ket{\psi_k}\bra{\psi_k}$
"

# ╔═╡ 718da6b2-f5b1-4854-a97b-20a7ca92e961
ρ(k, γ) = ψ(k, γ) ⊗ dagger(ψ(k, γ))

# ╔═╡ 3adecd15-f5fe-4ee3-bf23-a766b74fb30c
md"
$e^{\gamma St}\rho(0)=\sum_{k=0}^{\infty}\frac{(\gamma t)^k}{k!}\rho_k$
"

# ╔═╡ 314fced9-73c2-40ab-afa1-bceda18a7516
eρ(γ, t, trunc) = sum([(γ * t)^k/(factorial(big(k))) * ρ(k, γ) for k in 0:1:trunc])

# ╔═╡ 831b96c3-59fd-4070-bc82-d0fc41d29ad2
md"
${\rho}(t)=e^{-\gamma t}e^{\gamma St}\rho(0)$
"

# ╔═╡ b26fb8e5-263b-40c4-92b2-ecf64e8a17dd
ρt(γ, t, trunc) = exp(-γ * t) * eρ(γ, t, trunc)

# ╔═╡ 14cea64f-b1ec-4d93-86f0-e9175ff6869c
begin
	exn(γ, t, trunc) = expect(nT, ρt(γ, t, trunc))
	exn1(γ, t, trunc) = expect(n1T, ρt(γ, t, trunc))
	exn2(γ, t, trunc) = expect(n2T, ρt(γ, t, trunc))
end

# ╔═╡ f194ac20-a967-40e4-b762-0c252cbb2c22
begin
	t_list = range(0, stop = 10, step = 0.1)
	const terms = 50
end;

# ╔═╡ abd5e7e5-f6a6-4f86-aa79-a09487e3437f
begin
	vn = zeros(length(t_list))
	Threads.@threads for τ in 1:length(t_list)
		vn[τ] = abs2.(exn(1, t_list[τ], terms))
	end
end

# ╔═╡ 59f92a48-27c9-4b5d-a96a-0d5cba23adf6
begin
	vn1 = zeros(length(t_list))
	Threads.@threads for τ in 1:length(t_list)
		vn1[τ] = abs2.(exn1(1, t_list[τ], terms))
	end
end

# ╔═╡ 8a1c1799-1e7e-4dcc-b235-7c580a108f6a
begin
	vn2 = zeros(length(t_list))
	Threads.@threads for τ in 1:length(t_list)
		vn2[τ] = abs2.(exn2(1, t_list[τ], terms))
	end
end

# ╔═╡ df0af91a-2e11-4610-8b79-10fa47487323
begin
	fig, (ax1, ax2, ax3) = subplots(3,1, sharex = "col", figsize = (5,8))
	fig.suptitle(L"Mean value intensities for each oscillator on $\rho(t)$. $\gamma = 1$, $k = 500$ terms")
	ax1.plot(vn, "r")
		ax1.set_title(L"$\langle a^{\dagger}a\rangle$")
		#ax1.set_xticks(range(0, stop = 40, step = 10))
		ax1.set_xlabel(L"$t$ [s]")
	ax2.plot(vn1, "g")
		ax2.set_title(L"$\langle a^{\dagger}_{1}a_{1}\rangle$")
		#ax2.set_xticks(range(0, stop = 40, step = 10))
		ax2.set_xlabel(L"$t$ [s]")
	ax3.plot(vn2, "b")
		ax3.set_title(L"$\langle a^{\dagger}_{2}a_{2}\rangle$")
		#ax3.set_xticks(range(0, stop = 40, step = 10))
		ax3.set_xlabel(L"$t$ [s]")
	
	tight_layout(w_pad = 0.1)
	savefig("expects.png", dpi = 300, transparent = true)
end

# ╔═╡ Cell order:
# ╟─82ac0b60-b99f-4f21-a477-7ff4777c902e
# ╟─8f5c48fb-e53d-4c6e-8d68-e37c43c43f66
# ╟─d486a29c-7305-41ee-8a98-bcf632e9f7c5
# ╠═88170b64-be9f-11eb-201c-e7e7327ae185
# ╠═742a9a93-7e7d-4e4a-8988-6261b5a31f42
# ╠═b0867cd1-fc55-41d3-b29a-d18af7af079b
# ╠═b15259bf-b10e-4dda-b581-c10be8735c51
# ╠═d5636ba9-e3a9-4f2c-a19a-1db333493015
# ╠═1ddd377d-95ac-42ed-a089-e401e03e5a0d
# ╠═850ef1fd-103e-4508-8806-4c9e7660e490
# ╠═98e5a648-b43a-406b-85f2-06969eaf236c
# ╠═76071672-8d08-494f-9da2-2021bb8f3755
# ╠═563233c2-0b47-4411-8bdb-7b6335f833b4
# ╠═264f9486-cef9-49af-abae-f788643781f3
# ╟─5a022e4d-2846-4e81-b3a3-1e7ed99d1c1d
# ╠═8da4523c-3de5-491d-9274-55a3cbd65350
# ╟─dd315b29-b708-4514-bfcf-89d5853b0782
# ╠═718da6b2-f5b1-4854-a97b-20a7ca92e961
# ╟─3adecd15-f5fe-4ee3-bf23-a766b74fb30c
# ╠═314fced9-73c2-40ab-afa1-bceda18a7516
# ╟─831b96c3-59fd-4070-bc82-d0fc41d29ad2
# ╠═b26fb8e5-263b-40c4-92b2-ecf64e8a17dd
# ╠═14cea64f-b1ec-4d93-86f0-e9175ff6869c
# ╠═524e5d7c-771f-4ad0-99b4-fef95d535993
# ╠═f194ac20-a967-40e4-b762-0c252cbb2c22
# ╠═abd5e7e5-f6a6-4f86-aa79-a09487e3437f
# ╠═59f92a48-27c9-4b5d-a96a-0d5cba23adf6
# ╠═8a1c1799-1e7e-4dcc-b235-7c580a108f6a
# ╠═df0af91a-2e11-4610-8b79-10fa47487323
