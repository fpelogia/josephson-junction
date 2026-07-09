# Junções de Josephson
```math
	\begin{aligned}
	&x' = y\\
	&y' = \frac{1}{\beta}\left(\frac{I}{I_c} - y - sin(x)\right)\\
	\end{aligned}
```

## Como rodar:
- `julia`
- `]` (Para entrar no pkg manager)
- `activate .` (Pra ativar o ambiente com as dependências)
- `[backspace]` (pra retornar ao REPL do julia)
- `using Pluto`
- `Pluto.run()`
- Já na interface do Pluto, abra o notebook desejado (arquivos que coloquei _nb no nome) ex: `josephson_nb_lyapunov.jl` e `josephson_nb.jl`