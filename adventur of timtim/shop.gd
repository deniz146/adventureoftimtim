extends Sprite2D


@onready var animation_player = $"../AnimationPlayer"


@onready var panel = $Panel


@onready var player = get_node("/game/player")
func _on_close_pressed():
	animation_player.play("transout")


func _on_special_1_pressed():
	if get_parent().fragment >= 3:
		get_parent().havespecial1 = true
		get_parent().fragment -= 3
	else:
		pass


func _on_special_2_pressed():
	if player.fragment >= 3:
		player.havespecial2 = true
		player.fragment -= 3
	else:
		pass


func _on_fire_pressed():
	print("ye")
	if player.fragment >= 2:
		player.havefire = true
		player.fragment -= 2
	else:
		pass


func _on_bow_pressed():
	if player.fragment >= 2:
		player.havebow = true
		player.fragment -= 2
	else:
		pass


func _on_arrow_pressed():

	if player.fragment >= 1:
		player.bullet_count += 1
		player.fragment -= 1
	else:
		pass
	
