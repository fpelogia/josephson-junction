using GLMakie, LinearAlgebra, DynamicalSystems,IntervalRootFinding, IntervalArithmetic
using DynamicalSystems:jacobian

# Funções auxiliares ===============
function plota_retrato_de_fase(density=1)
    retrato_fase = (x, y) -> Point2f(f([x, y], p))
    fig = streamplot(retrato_fase, (-2π,2π), (-3.0,3.0), colormap=[:black, :darkred, :red], density=density)

	# Plota pontos fixos
    fp_x = [point[1] for point in pts_equilibrio]
	fp_y = [point[2] for point in pts_equilibrio]
	
	colors = [est ? "green" : "red" for est in estabilidade]
	scatter!(fp_x, fp_y, color=colors, markersize = 15, marker = :circle)
    return fig
end

# =================================

# Função que representa a derivada
function f(X, p)
    # estado
    x, y = X
    
    # parâmetros
    β, I, Ic = p

    return [
        y,
        (1/β)*((I/Ic) -y -sin(x))
    ]
end

# Seja x = ϕ e y = ϕ'
x₀ = 1e-3
y₀ = 1e-6

β = 5 # Parâmetro de McCumber (adimensional)
I = 1e-6 # Corrente de polarização 
Ic = 500e-6 # Corrente crítica

# Define sistema
u0 = [x₀, y₀]
p = [β, I, Ic]

sys = (u,p,t) -> SVector{2}(f(u,p))

# Define Sistema de EDOs
sys_model = CoupledODEs(sys, u0, p)

total_time = 30

# Calcula trajetória
Y, t = trajectory(sys_model, total_time, Δt = 0.01)

# ====== Calculando pontos de equilíbrio =======
box = [interval(-π, π), interval(-2,2)]
pts_equilibrio, eigs, estabilidade = fixedpoints(sys_model, box)

println("Pontos de equilíbrio encontrados:")
for (i, p) in enumerate(pts_equilibrio)
    println("Ponto $i: $p | Estável? $(estabilidade[i])")
end

begin
	for (i, X) in enumerate(pts_equilibrio)
		println("================= Pt Equilíbrio $i ==================")
		#J_X = jacobian(sys_model)
		#println("Jacobiana (calculada) em $X :")
		#display(J_X(X,p))
	
		println("Jacobiana (analítica) em $X :")
		jac = [
			0 1;
			-cos(X[1])/β -1/β
		]
		display(jac)
		
		# Para analisar a estabilidade manualmente, calculamos os autovalores (eigenvalues)
		λ = eigvals(jac)
		println("\nAutovalores em $X: $λ")
		println("\n\n")
	end
end

# ==== Gráfico com retrato de fase do sistema ====

fig_rf = plota_retrato_de_fase()
wait(display(fig_rf))

# ==== Gráfico com as trajetórias do sistema =====
# Plot
fig = Figure(size=(700,300))
ax = Axis(fig[1, 1]; xlabel = "tempo (t)", ylabel = "variável")
ax2 = Axis(fig[1, 3]; xlabel = "x", ylabel = "y")

lines!(ax, t, columns(Y)[1], label="ϕ", color=:blue)
lines!(ax, t, columns(Y)[2], label="ϕ'", color=:red)

# Plot
lines!(ax2, columns(Y)[1], columns(Y)[2])
    
fig[1,2] = Legend(fig, ax)
wait(display(fig))

# ======== Energia e Lyapunov ======

# cria malha
x = -2pi:0.1:2pi

y = -3.0:0.1:3.0

# Energia total do sistema
E(x, y) = 0.5 * y^2 - cos(x) - I/Ic * x


# Avaliando a função na malha
E_superf = [E(xi, yi) for xi in x, yi in y]

# Construção da figura
fig_lyap = Figure(size = (800, 600))
ax_lyap = Axis3(fig_lyap[1, 1], 
    title = "Superfície de Energia e Curvas de Nível (I/Ic = $(I/Ic))",
    xlabel = "ϕ", 
    ylabel = "ϕ'", 
    zlabel = "Energia E(x,y)"
)

# Superfície 3D da Enegia
surface!(ax_lyap, x, y, E_superf, colormap = :viridis, transparency = true, alpha = 0.6)

# Projeção das curvas de nível na base (ajustando a transformação em Z)
min_E = minimum(E_superf)
contour!(ax_lyap, x, y, E_superf, levels = 20, colormap = :viridis, linewidth=2)
#transformation = (:xy, min_E - 1.0))
# Plota pontos fixos
fp_x = [point[1] for point in pts_equilibrio]
fp_y = [point[2] for point in pts_equilibrio]
colors = [est ? "green" : "red" for est in estabilidade]
scatter!(fp_x, fp_y, color=colors, markersize = 15, marker = :circle)

wait(display(fig_lyap))


# Plota retrato de fase com as curvas de nível no fundo
fig_rf = plota_retrato_de_fase(1)
contour!(fig_rf.axis, x, y, E_superf, levels = 10, colormap = [:green], linewidth=1.5)
wait(display(fig_rf))