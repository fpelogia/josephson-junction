# Josephson Junction
```math
	\begin{aligned}
	&x' = y\\
	&y' = \frac{1}{\beta}\left(\frac{I}{I_c} - y - sin(x)\right)\\
	\end{aligned}
```
<img width="700" height="385" alt="gif_josephson" src="https://github.com/user-attachments/assets/6bb9ad9b-fa0c-4037-97ac-d77d74b63a27" />
<img width="1306" height="665" alt="image" src="https://github.com/user-attachments/assets/441a6111-83a9-4dd9-a243-adb7611b6b15" />

# About
This project simulates a Josephson Junction, a nonlinear dynamical system, finding fixed points, drawing its phase portrait, analysing stability of the linearized system and lyapunov stability with an energy formulation (using washboard potential). The ODE System was derived from the adimensional formulation of a RCSJ equivalent circuit, with the McCumber Parameter $\beta$. The project was inspired by an example on Strogatz's iconic book on nonlinear dynamics [1].  

The comments in the code and notebook are in Portuguese, since this project was used as final project of a Dynamical Systems graduate course. A report and a presentation, also in Portuguese, were made by me (Frederico Pelogia) and Nikolas Lukin.

## How to run:
- `julia`
- `]` (to access pkg manager)
- `activate .` (activate julia environment)
- `[backspace]` (go back to julia REPL)
- `using Pluto`
- `Pluto.run()`
- At Pluto.jl interface, open the desired notebook (filenames with _nb ) e.g.: `josephson_nb_lyapunov.jl` e `josephson_nb.jl`

# References
[1] _Strogatz, Steven H. Nonlinear Dynamics and Chaos: With Applications to Physics, Biology, Chemistry, and Engineering. 2nd ed., CRC Press, 2015._
