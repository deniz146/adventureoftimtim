extends Node2D
@onready var ray_cast = $RayCast2D
@onready var timer = $Timer
@export var ammo : PackedScene
var health = 100

@onready var player = preload("res://adventur of timtim/player.tscn")
var raycasttouch = 0
func _ready():
	player = get_parent().find_child("player")
	
func _physics_process(delta):
	_aim()
	_check_player_collision()
	
func _aim():
	if ray_cast.get_collider() == player:
		ray_cast.target_position = to_local(player.position)
		raycasttouch = 1

	
func _check_player_collision():
	if ray_cast.get_collider() == player and timer.is_stopped() and raycasttouch == 1:
		timer.start()
	elif ray_cast.get_collider() != player and not timer.is_stopped():
		timer.stop()
	


func _on_timer_timeout():
	_shoot()
	
func _shoot():
	var bullet = ammo.instantiate()
	bullet.position = position
	bullet.direction = (ray_cast.target_position).normalized()
	get_tree().current_scene.add_child(bullet)



func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("die")
	health -= 20
	if health == 0:
		area.get_parent().queue_free()
		queue_free()
