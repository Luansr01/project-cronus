extends Node

enum Elems {Água, Grama, Fogo}

# linha é quem ataca e coluna quem recebe
const matriz_fraquezas = \
	[[1, 0.5, 2],
	[2, 1, 0.5],
	[0.5, 2, 1]]

func calc_efetividade(elem_ataque : Elems, elem_defesa : Elems) -> float:
	return matriz_fraquezas[elem_ataque][elem_defesa]
	
