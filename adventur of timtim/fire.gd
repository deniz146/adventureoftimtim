extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta


	move_and_slide()


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	queue_free()
