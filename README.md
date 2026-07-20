# Josephson Junctions
```math
	\begin{aligned}
	&x' = y\\
	&y' = \frac{1}{\beta}\left(\frac{I}{I_c} - y - sin(x)\right)\\
	\end{aligned}
```

# About
This project simulates a Josephson Junction, a nonlinear dynamical system, finding fixed points, drawing its phase portrait, analysing stability of the linearized system and lyapunov stability with an energy formulation (using washboard potential).

The comments in the code and notebook are in Portuguese, since this project was used as final project of a Dynamical Systems graduate course. A report and a presentation, also in Portuguese, were made by me (Frederico Pelogia) and Nikolas Lukin.

## How to run:
- `julia`
- `]` (to access pkg manager)
- `activate .` (activate julia environment)
- `[backspace]` (go back to julia REPL)
- `using Pluto`
- `Pluto.run()`
- At Pluto.jl interface, open the desired notebook (filenames with _nb ) e.g.: `josephson_nb_lyapunov.jl` e `josephson_nb.jl`