extends Control

var rules = preload("res://rules.gd").new()
@onready var ai_controller = $AIController

var player_score = 0
var ai_score = 0
var ai_last_result = ""
var last_player_move = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_run_automated_tests()

func _run_automated_tests():
	print("\n=== 开始 AI 状态机自动化测试 ===\n")
	
	var test_pass = 0
	var test_total = 0
	
	test_total += 1
	print("测试1: A1 随机出拳后，状态变为 A2")
	print("期望: 初始状态 A, sub_round 1, 调用后状态 A, sub_round 2")
	var initial_state = ai_controller.ai_state
	var initial_sub_round = ai_controller.sub_round
	var ai_move = ai_controller.get_ai_move(-1, "")
	ai_controller.update_ai_state(0, ai_move, "win")
	var final_state = ai_controller.ai_state
	var final_sub_round = ai_controller.sub_round
	print("实际: 初始状态=", initial_state, " sub_round=", initial_sub_round, " | 出拳=", ai_move, " | 最终状态=", final_state, " sub_round=", final_sub_round)
	if final_state == "A" and final_sub_round == 2:
		print("✓ 测试1 通过")
		test_pass += 1
	else:
		print("✗ 测试1 失败")
	print()
	
	ai_controller.ai_state = "A"
	ai_controller.sub_round = 2
	ai_controller.stubborn_move = -1
	
	test_total += 1
	print("测试2: A2 克制玩家上一轮 - 玩家出0(攻击)")
	print("期望: AI出2(格挡)")
	ai_move = ai_controller.get_ai_move(0, "")
	print("实际: AI出", ai_move)
	if ai_move == 2:
		print("✓ 测试2 通过")
		test_pass += 1
	else:
		print("✗ 测试2 失败")
	print()
	
	test_total += 1
	print("测试3: A2 克制玩家上一轮 - 玩家出1(蓄力)")
	print("期望: AI出0(攻击)")
	ai_move = ai_controller.get_ai_move(1, "")
	print("实际: AI出", ai_move)
	if ai_move == 0:
		print("✓ 测试3 通过")
		test_pass += 1
	else:
		print("✗ 测试3 失败")
	print()
	
	test_total += 1
	print("测试4: A2 克制玩家上一轮 - 玩家出2(格挡)")
	print("期望: AI出1(蓄力)")
	ai_move = ai_controller.get_ai_move(2, "")
	print("实际: AI出", ai_move)
	if ai_move == 1:
		print("✓ 测试4 通过")
		test_pass += 1
	else:
		print("✗ 测试4 失败")
	print()
	
	ai_controller.ai_state = "A"
	ai_controller.sub_round = 2
	ai_controller.stubborn_move = -1
	
	test_total += 1
	print("测试5: A2 输了进 A3")
	print("期望: 状态 A, sub_round 3")
	ai_controller.update_ai_state(0, 1, "lose")
	print("实际: 状态=", ai_controller.ai_state, " sub_round=", ai_controller.sub_round)
	if ai_controller.ai_state == "A" and ai_controller.sub_round == 3:
		print("✓ 测试5 通过")
		test_pass += 1
	else:
		print("✗ 测试5 失败")
	print()
	
	test_total += 1
	print("测试6: A3 模仿玩家上一轮")
	print("期望: 玩家上一轮出1(蓄力), AI也出1(蓄力)")
	ai_move = ai_controller.get_ai_move(1, "")
	print("实际: AI出", ai_move)
	if ai_move == 1:
		print("✓ 测试6 通过")
		test_pass += 1
	else:
		print("✗ 测试6 失败")
	print()
	
	ai_controller.ai_state = "A"
	ai_controller.sub_round = 2
	ai_controller.stubborn_move = -1
	
	test_total += 1
	print("测试7: A2 赢了跳 B2, 固执手势继承")
	print("期望: 状态 B, sub_round 2, stubborn_move=1")
	ai_controller.update_ai_state(0, 1, "win")
	print("实际: 状态=", ai_controller.ai_state, " sub_round=", ai_controller.sub_round, " stubborn_move=", ai_controller.stubborn_move)
	if ai_controller.ai_state == "B" and ai_controller.sub_round == 2 and ai_controller.stubborn_move == 1:
		print("✓ 测试7 通过")
		test_pass += 1
	else:
		print("✗ 测试7 失败")
	print()
	
	ai_controller.ai_state = "A"
	ai_controller.sub_round = 2
	ai_controller.stubborn_move = -1
	
	test_total += 1
	print("测试8: A2 平局跳 B2, 固执手势继承")
	print("期望: 状态 B, sub_round 2, stubborn_move=1")
	ai_controller.update_ai_state(1, 1, "draw")
	print("实际: 状态=", ai_controller.ai_state, " sub_round=", ai_controller.sub_round, " stubborn_move=", ai_controller.stubborn_move)
	if ai_controller.ai_state == "B" and ai_controller.sub_round == 2 and ai_controller.stubborn_move == 1:
		print("✓ 测试8 通过")
		test_pass += 1
	else:
		print("✗ 测试8 失败")
	print()
	
	ai_controller.ai_state = "A"
	ai_controller.sub_round = 3
	ai_controller.stubborn_move = -1
	
	test_total += 1
	print("测试9: A3 输了进 B1, 固执手势随机生成")
	print("期望: 状态 B, sub_round 1, stubborn_move != -1")
	ai_controller.update_ai_state(0, 1, "lose")
	print("实际: 状态=", ai_controller.ai_state, " sub_round=", ai_controller.sub_round, " stubborn_move=", ai_controller.stubborn_move)
	if ai_controller.ai_state == "B" and ai_controller.sub_round == 1 and ai_controller.stubborn_move != -1:
		print("✓ 测试9 通过")
		test_pass += 1
	else:
		print("✗ 测试9 失败")
	print()
	
	ai_controller.ai_state = "A"
	ai_controller.sub_round = 3
	ai_controller.stubborn_move = -1
	
	test_total += 1
	print("测试10: A3 赢了进 B2, 固执手势继承")
	print("期望: 状态 B, sub_round 2, stubborn_move=1")
	ai_controller.update_ai_state(0, 1, "win")
	print("实际: 状态=", ai_controller.ai_state, " sub_round=", ai_controller.sub_round, " stubborn_move=", ai_controller.stubborn_move)
	if ai_controller.ai_state == "B" and ai_controller.sub_round == 2 and ai_controller.stubborn_move == 1:
		print("✓ 测试10 通过")
		test_pass += 1
	else:
		print("✗ 测试10 失败")
	print()
	
	ai_controller.ai_state = "B"
	ai_controller.sub_round = 2
	ai_controller.stubborn_move = 1
	
	test_total += 1
	print("测试11: B2 无条件进 B3")
	print("期望: 状态 B, sub_round 3")
	ai_controller.update_ai_state(0, 1, "win")
	print("实际: 状态=", ai_controller.ai_state, " sub_round=", ai_controller.sub_round)
	if ai_controller.ai_state == "B" and ai_controller.sub_round == 3:
		print("✓ 测试11 通过")
		test_pass += 1
	else:
		print("✗ 测试11 失败")
	print()
	
	ai_controller.ai_state = "B"
	ai_controller.sub_round = 3
	ai_controller.stubborn_move = 1
	
	test_total += 1
	print("测试12: B3 出被固执手势克制的拳(stubborn_move=1蓄力), 跳回 A2")
	print("期望: AI出0(攻击), 状态 A, sub_round 2")
	ai_move = ai_controller.get_ai_move(0, "")
	ai_controller.update_ai_state(0, ai_move, "win")
	print("实际: AI出", ai_move, " | 状态=", ai_controller.ai_state, " sub_round=", ai_controller.sub_round)
	if ai_move == 2 and ai_controller.ai_state == "A" and ai_controller.sub_round == 2:
		print("✓ 测试12 通过")
		test_pass += 1
	else:
		print("✗ 测试12 失败")
	print()
	
	print("=== 测试完成 ===")
	print("通过: ", test_pass, "/", test_total)

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


func _on_reset_pressed() -> void:
	pass # Replace with function body.
