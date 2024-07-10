extends AnimationPlayer


@onready var animation_player = $"."
@onready var player = %player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.health  == 0:
		animation_player.play("new_animation")
