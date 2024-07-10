extends Node2D
@onready var animator = $AnimationPlayer
var openchest 
var havelabel = true
var chestopened = true
@onready var label = $Label
var special2 = preload("res://adventur of timtim/special_2.tscn")
@onready var marker_2d = $Marker2D
@onready var timer = $Timer

func _process(delta):
	if openchest and Input.is_action_just_pressed("save") and chestopened:
		animator.play("special2chest")
		havelabel = false
		label.queue_free()
		chestopened = false
		timer.start()

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if havelabel:
		label.show()
	animator.play("press f")
	
	openchest = true



func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if havelabel:
		label.hide()
	openchest = false

func _on_timer_timeout():
	special2 = special2.instantiate()
	get_parent().add_child(special2)
	special2.global_position = marker_2d.global_position
