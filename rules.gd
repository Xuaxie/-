extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# rules.gd
# 判定规则：攻击克蓄力、蓄力克格挡、格挡克攻击

func determine_winner(player: int, ai: int) -> int:
	if player == ai:
		return 0  # 平局
	if (player == 0 and ai == 1) or (player == 1 and ai == 2) or (player == 2 and ai == 0):
		return 1  # 玩家赢
	return -1     # AI赢

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
