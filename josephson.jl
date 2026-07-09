using DynamicalSystems
using CairoMakie

# System Parameter
a = 0

# x' = y
# y' = (1/β)*((I/Ic)-y-sin(x))
function sn_sys(u, p, t)
    # state
    x, y = u

    # parameters
    β, I, Ic = p
    
    du = [
        y,
        (1/β)*((I/Ic)-y-sin(x))
    ]
    return SVector(du...)
end

# Plot
fig = Figure(size=(1000,500))
ax = Axis(fig[1, 1]; xlabel = "time", ylabel = "variable")
ax2 = Axis(fig[1, 3]; xlabel = "x", ylabel = "y")


x₀ = 1.5
y₀ = 1e-6

β = 1
I = 1e-6
Ic = 500e-6

# Define system
u0 = [x₀, y₀]
p0 = [β, I, Ic]
sn_sys_model = CoupledODEs(sn_sys, u0, p0)
println(sn_sys_model)

# Calculate trajectory
total_time = 50
Y, t = trajectory(sn_sys_model, total_time, Δt = 0.01)

lines!(ax, t, columns(Y)[1], label="ϕ", color=:blue)
lines!(ax, t, columns(Y)[2], label="ϕ'", color=:red)

# Plot
lines!(ax2, columns(Y)[1], columns(Y)[2])
    
fig[1,2] = Legend(fig, ax)
supertitle = Label(fig[0, :], "josephson", fontsize = 24)

display(fig)