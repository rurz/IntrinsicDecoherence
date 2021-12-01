### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 9fd2d94c-4e6c-11ec-040b-31d105963e37
# Activate the shared project environment
begin
    import Pkg
    Pkg.activate(Base.current_project())
	
	using IntrinsicDecoherence
end

# ╔═╡ f1827968-cc5f-4f76-8846-69cd02e21bd3
# Calling plotting suite
begin
	using PyPlot
	using LaTeXStrings
	ioff()
	rc("text", usetex = true)
end

# ╔═╡ 677404c2-d0df-4e00-9cc2-dfb0976fe9b1
md"
# Intrinsic decoherence dynamics in the three-coupled harmonic oscillators interaction

Authors: **_Alejandro R. Urzúa & Héctor M. Moya Cessa_**

Instituto Nacional de Astrofísica, Óptica y Electrónica

([arurz@inaoep.mx](mailto:arurz@inaoep.mx), [hmmc@inaoep.mx](mailto:hmmc@inaoep.mx))

Developer: AR. Urzúa (2021)

 [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
"

# ╔═╡ 6562f5c9-6b21-47a2-a85e-dfbc6435c32a
md"
## Initial problem

The principal idea is to solve the mean value evolution

$$\begin{equation}
	\braket{\hat{A}}  = e^{-\gamma t}\sum_{k=0}^{\infty}\frac{ (\gamma t)^k}{k!} \left\langle \psi_{k} | \hat{A} | \psi_{k}\right\rangle,
\end{equation}$$

giving that the $k$-th element of the wavefunction $\psi$ is given by

$$\begin{equation}
    \rho_{k}=\ket{\psi_{k}}\bra{\psi_k}, \qquad \ket{\psi_{k}}=e^{-\mathrm{i} k\frac{\hat{H}}{\gamma}}\ket{\psi(0)},
\end{equation}$$

with the Hamiltonian of the system defined as

$$\newcommand{\op}[1]{\hat{#1}}\begin{equation}
\begin{aligned}
    \op{H} = \omega\left(\op{a}_{1}^{\dagger}\op{a}_{1} + \op{a}_{2}^{\dagger}\op{a}_{2} + \op{a}_{3}^{\dagger}\op{a}_{3}\right) + \lambda\left(\op{a}_{1}^{\dagger}\op{a}_{2} + \op{a}_{2}^{\dagger}\op{a}_{1}\right)
    + g\left[\op{a}_{3}\left(\op{a}_{1}^{\dagger}+\op{a}_{2}^{\dagger}\right)+\op{a}_{3}^{\dagger}(\op{a}_{1}+\op{a}_{2})\right].
\end{aligned}
\end{equation}$$
"

# ╔═╡ 09a75736-ae84-4889-8e58-b1a8e16d8231
md"
## Solution

The solution we find for the $k$-th element of the wavefunction $\psi$ is given by

$$\newcommand{\op}[1]{\hat{#1}}\newcommand{\mi}{\mathrm{i}}\begin{align*}
    \ket{\psi_{k}} &= \op{R}_{12}^{\dagger}\op{R}_{2}^{\dagger}\,e^{-\mi k\frac{\op{H}_{2}}{\gamma}}\ket{\alpha\cos\theta}_{1}\ket{\alpha\cos\phi\sin\theta}_{2}\ket{-\alpha\sin\phi\sin\theta}_{3}\\
    &= \op{R}_{12}^{\dagger}\op{R}_{2}^{\dagger}\ket{e^{-\frac{\mi k}{\gamma}\Omega_{2}}\alpha\cos\theta}_{1}\ket{e^{-\frac{\mi k}{\gamma}\omega_{-}}\alpha\cos\phi\sin\theta}_{2}\ket{-e^{-\frac{\mi k}{\gamma}\Omega}\alpha\sin\phi\sin\theta}_{3},
\end{align*}$$

with $\gamma$ the decay parameter, $\theta = \pi/4$, and 
$$\begin{equation*}
    2\phi = \arctan\left(\frac{2\sqrt{2}g}{\omega_{+}-\omega}\right),
\end{equation*}$$ where g is the coupling strength, and $\omega_{\pm} = \omega \pm \lambda$.
"

# ╔═╡ fa63f69e-d586-485c-89c0-1556addb738d
# Set the constant parameters
begin
	const α = 4
	const ω = 4
	const λ = 0.5
end;

# ╔═╡ 6a7d48b3-beff-453c-99d3-7d4b9184565a
md"

## Case 1. $\gamma = 10$

"

# ╔═╡ d845eb59-ace3-4280-b5ab-de280ec11787
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

# ╔═╡ 568f94f7-716e-4322-9d3c-265a2b82a4a5
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
	
	axins = axs3.inset_axes([0.7, 0.6, 0.25, 0.25])
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
	#axs1.legend(fontsize = 13)
	axs1.annotate(L"\langle \hat{a}_{3}^{\dagger}\hat{a}_{3} \rangle", xy=(12, 12), xytext=(20, 15), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	axs1.annotate(L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle", xy=(21, 10.6), xytext=(29, 13), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	axs1.annotate(L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle", xy=(27.1, 1.6), xytext=(33, 4), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	
	axs2.set_ylabel(L"\textrm{Number of photons}", fontsize = 20)
	setp(axs2.get_xticklabels(), fontsize = 18)
	setp(axs2.get_yticklabels(), fontsize = 18)
	#axs2.legend(fontsize = 13)
	axs2.annotate(L"\langle \hat{a}_{3}^{\dagger}\hat{a}_{3} \rangle", xy=(8.5, 11.5), xytext=(20, 15), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	axs2.annotate(L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle", xy=(23, 3.8), xytext=(27, 6.5), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	axs2.annotate(L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle", xy=(21, 3.2), xytext=(25, 0), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=-0.2",
                                  "fc"=>"w")
	)
	
	axs3.set_xlabel(L"t\; [s]", fontsize = 18)
	axs3.set_ylabel(L"\textrm{Number of photons}", fontsize = 20)
	setp(axs3.get_xticklabels(), fontsize = 18)
	setp(axs3.get_yticklabels(), fontsize = 18)
	#axs3.legend(fontsize = 13)
	axs3.annotate(L"\langle \hat{a}_{3}^{\dagger}\hat{a}_{3} \rangle", xy=(8.7, 9.15), xytext=(15, 12), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	axs3.annotate(L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle", xy=(22.8, 7.8), xytext=(29, 10.5), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	axs3.annotate(L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle", xy=(21, 3.92), xytext=(27, 0.5), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=-0.2",
                                  "fc"=>"w")
	)
	
	tight_layout()

	#savefig("γ10_sp.pdf", dpi = 300)
	#savefig("γ10_sp.png", dpi = 300)
end

# ╔═╡ dfd3f4be-2fae-4a48-8e78-c40d7252b711
figs

# ╔═╡ 7f491f8e-a79e-4e6e-ae2d-5d67af390512
md"
## Case 2. $\gamma = 100$
"

# ╔═╡ 49f28ae0-b7ed-4570-aa2b-80cbeeeccb81
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

# ╔═╡ 6bfbc529-17b9-4e4e-bcdb-c7e3c72cec04
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
	#axS1.legend(fontsize = 13)
	axS1.annotate(L"\langle \hat{a}_{3}^{\dagger}\hat{a}_{3} \rangle", xy=(0.55, 14.5), xytext=(1.6, 15), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	axS1.annotate(L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle", xy=(3.55, 13.5), xytext=(4.5, 14), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	axS1.annotate(L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle", xy=(3, 1), xytext=(3, 5), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	
	
	axS2.set_ylabel(L"\textrm{Number of photons}", fontsize = 20)
	setp(axS2.get_xticklabels(), fontsize = 18)
	setp(axS2.get_yticklabels(), fontsize = 18)
	#axS2.legend(fontsize = 13)
	axS2.annotate(L"\langle \hat{a}_{3}^{\dagger}\hat{a}_{3} \rangle", xy=(0.4, 14.5), xytext=(1.6, 15), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	axS2.annotate(L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle", xy=(2.06, 7), xytext=(2.06, 10), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	axS2.annotate(L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle", xy=(3.2, 3.13), xytext=(4, 5), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	
	axS3.set_xlabel(L"t\; [s]", fontsize = 18)
	axS3.set_ylabel(L"\textrm{Number of photons}", fontsize = 20)
	setp(axS3.get_xticklabels(), fontsize = 18)
	setp(axS3.get_yticklabels(), fontsize = 18)
	#axS3.legend(fontsize = 13)
	axS3.annotate(L"\langle \hat{a}_{3}^{\dagger}\hat{a}_{3} \rangle", xy=(0.3, 14.2), xytext=(1.6, 15), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	axS3.annotate(L"\langle \hat{a}_{2}^{\dagger}\hat{a}_{2} \rangle", xy=(4.6, 13.5), xytext=(6, 14), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=0.2",
                                  "fc"=>"w")
	)
	axS3.annotate(L"\langle \hat{a}_{1}^{\dagger}\hat{a}_{1} \rangle", xy=(3.9, 3.14), xytext=(4, 7), size= 12,
		bbox=Dict("boxstyle"=>"round4", "fc"=>"w"),
            arrowprops=Dict("arrowstyle"=>"-|>",
                        "connectionstyle"=>"arc3,rad=-0.2",
                                  "fc"=>"w")
	)
	
	tight_layout()
	
	#savefig("γ100_sp.pdf", dpi = 300)
	#savefig("γ100_sp.png", dpi = 300)
end

# ╔═╡ 7d3ad796-1855-44e1-9505-9543587df7f8
figS

# ╔═╡ Cell order:
# ╟─677404c2-d0df-4e00-9cc2-dfb0976fe9b1
# ╟─9fd2d94c-4e6c-11ec-040b-31d105963e37
# ╟─f1827968-cc5f-4f76-8846-69cd02e21bd3
# ╟─6562f5c9-6b21-47a2-a85e-dfbc6435c32a
# ╟─09a75736-ae84-4889-8e58-b1a8e16d8231
# ╟─fa63f69e-d586-485c-89c0-1556addb738d
# ╟─6a7d48b3-beff-453c-99d3-7d4b9184565a
# ╟─d845eb59-ace3-4280-b5ab-de280ec11787
# ╟─568f94f7-716e-4322-9d3c-265a2b82a4a5
# ╟─dfd3f4be-2fae-4a48-8e78-c40d7252b711
# ╟─7f491f8e-a79e-4e6e-ae2d-5d67af390512
# ╟─49f28ae0-b7ed-4570-aa2b-80cbeeeccb81
# ╟─6bfbc529-17b9-4e4e-bcdb-c7e3c72cec04
# ╟─7d3ad796-1855-44e1-9505-9543587df7f8
