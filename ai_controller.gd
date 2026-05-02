extends Node

var ai_state = "A"
var sub_round = 1
var stubborn_move = -1
var last_player_move = -1

func get_winning_move(opponent_move: int) -> int:
	match opponent_move:
		0:
			return 2
		1:
			return 0
		2:
			return 1
	return -1



func get_ai_move(player_last_move: int, last_result: String) -> int:
	var ai_move: int
	
	if ai_state == "A" and sub_round == 1:
		ai_move = randi() % 3
	elif ai_state == "A" and sub_round == 2:
		print("DEBUG A2: player_last_move = ", player_last_move)
		ai_move = get_winning_move(player_last_move)
	elif ai_state == "A" and sub_round == 3:
		ai_move = player_last_move
	elif ai_state == "B" and sub_round == 1:
		if stubborn_move == -1:
			stubborn_move = randi() % 3
		ai_move = stubborn_move
	elif ai_state == "B" and sub_round == 2:
		ai_move = stubborn_move
	elif ai_state == "B" and sub_round == 3:
		ai_move = (stubborn_move + 1) % 3
	else:
		ai_move = randi() % 3
	
	return ai_move

func update_ai_state(player_move: int, ai_move: int, result: String):
	if ai_state == "A" and sub_round == 1:
		sub_round = 2
	elif ai_state == "A" and sub_round == 2:
		if result == "lose":
			sub_round = 3
		else:
			ai_state = "B"
			sub_round = 2
			stubborn_move = ai_move
	elif ai_state == "A" and sub_round == 3:
		if result == "lose":
			ai_state = "B"
			sub_round = 1
			stubborn_move = randi() % 3
		else:
			ai_state = "B"
			sub_round = 2
			stubborn_move = ai_move
	elif ai_state == "B" and sub_round == 1:
		if result == "lose":
			ai_state = "A"
			sub_round = 2
		else:
			sub_round = 2
	elif ai_state == "B" and sub_round == 2:
		sub_round = 3
	elif ai_state == "B" and sub_round == 3:
		ai_state = "A"
		sub_round = 2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
