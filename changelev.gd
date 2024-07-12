extends Area2D
@onready var changelevel = $changelevel





func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	Loader.change_level("res://adventur of timtim/level_2.tscn")
