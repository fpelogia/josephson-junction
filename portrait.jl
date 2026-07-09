using CairoMakie, LinearAlgebra

function plota_retrato_de_fase(p)
    retrato_fase = (x, y) -> Point2f(f([x, y], p))
    fig = streamplot(retrato_fase, -2π..2π, -1.0..1.0)
    display(fig)
end

# Função que representa a derivada
function f(X, p)
    # estado
    x, y = X
    
    # parâmetros
    β, I, Ic = p

    return [
        y,
        (1/β)*((I/Ic)-y-sin(x))
    ]
end

# Seja x = ϕ e y = ϕ'

x₀ = 1e-3
y₀ = 1e-6

β = 5 # Parâmetro de McCumber (adimensional)
I = 1e-6 # Corrente de polarização 
Ic = 500e-6 # Corrente crítica

# Define system
u0 = [x₀, y₀]
p0 = [β, I, Ic]

plota_retrato_de_fase(p0)