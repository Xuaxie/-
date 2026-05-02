extends Control

var rules = preload("res://rules.gd").new()
@onready var ai_controller = $AIController

var player_score = 0
var ai_score = 0
var ai_last_result = ""
var last_player_move = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# 玩家按下“攻击”按钮
func _on_attack_pressed():
	_play_round(0) # 0代表攻击
	

# 玩家按下“防御”按钮
func _on_defence_pressed():
	_play_round(2) # 2代表格挡

# 玩家按下“蓄力”按钮
func _on_charge_pressed():
	_play_round(1) # 1代表蓄力

# 主流程：每回合都做这三件事
func _play_round(player_move: int):
	print("AI状态: ", ai_controller.ai_state, " | 子轮次: ", ai_controller.sub_round)
	var ai_move = ai_controller.get_ai_move(last_player_move, ai_last_result)
	var result = rules.determine_winner(player_move, ai_move)

	# 翻译动作
	var move_names = ["攻击", "蓄力", "格挡"]
	var player_move_name = move_names[player_move]
	var ai_move_name = move_names[ai_move]

	# 胜负文字
	var result_text = ""
	match result:
		1:
			result_text = "玩家获胜！"
			player_score += 1
			ai_last_result = "lose"
		-1:
			result_text = "AI获胜！"
			ai_score += 1
			ai_last_result = "win"
		0:
			result_text = "平局！"
			ai_last_result = "draw"
		# 将更新比分和拼接显示完全分开
	$Label_score.text = "玩家出了：" + player_move_name + \
						"\nAI出了：" + ai_move_name + \
						"\n结果：" + result_text + \
						"\n当前比分：玩家 " + str(player_score) + " : " + str(ai_score) + " AI"
	ai_controller.update_ai_state(player_move, ai_move, ai_last_result)
	last_player_move = player_move

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
