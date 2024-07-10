extends CharacterBody2D

@onready var progress_bar = $ProgressBar

@onready var ray_cast = $RayCast2D
@onready var enemyturn = $enemyturn
@export var ammo : PackedScene
var health = 100
@onready var timer = $Timer
@onready var animater = $AnimatedSprite2D
@onready var enemy_vanish = $"enemy vanish"
var turnenemy = true
@onready var player = preload("res://adventur of timtim/player.tscn")
var raycasttouch = 0
var clearshot = false
@export var  enemy_SPEED = 50
var player_position
var target_position
@onready var blood = $blood
var dead = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var marker = $Marker2D
@onready var enemy_seen = $"enemy seen"
@onready var seen = $seen
var enemymove
var burned


func _ready():
	player = get_parent().find_child("player")
	seen.hide()
	enemymove = true
	progress_bar.init_health(health)
	burned = false
	health = 100

func _physics_process(delta):
	#_aim()
	_check_player_collision()
	enemy_jump(delta)
	move_left(delta)
	move_right(delta)
	_burned()
	if burned:
		health -= 20 * delta

	
	progress_bar.health = health
	

	
func enemy_jump(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
func move_right(delta):
	if enemymove:
		if is_on_floor() and scale.x:
			velocity.x = -enemy_SPEED
			animater.play("enemy_run")

	
func move_left(delta):
	if enemymove:
		if is_on_floor() and -scale.x:
			velocity.x = enemy_SPEED
			animater.play("enemy_run")
		


	move_and_slide()


	
func _aim():
	if ray_cast.get_collider() == player and clearshot:
		ray_cast.target_position = to_local(player.position)
		raycasttouch = 1
		enemy_SPEED = 0

	
func _check_player_collision():
	if ray_cast.get_collider() == player and timer.is_stopped() and clearshot:
		timer.start()
	elif ray_cast.get_collider() != player and not timer.is_stopped():
		timer.stop()
	


func _on_timer_timeout():
	_shoot()

func _shoot():
	
	var bullet = ammo.instantiate()
	bullet.position = marker.position
	#bullet.direction = (marker.direction).normalized()
	get_parent().add_child(bullet)



func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var _particle = blood
	_particle.rotation = -global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
	if dead == true:
		_particle.emitting = false
	health -= 20
	if health == 0:
		set_physics_process(false)
		animater.play("enemy_death")
		enemy_vanish.start()
	
		progress_bar.queue_free()
func _burned():
	if health < 1:
		health = 0
		if health == 0:
			progress_bar.queue_free()
			set_physics_process(false)
			animater.play("enemy_death")
			enemy_vanish.start()
		
		

func _on_enemy_vanish_timeout():
	#area.get_parent().queue_free()
	#queue_free()
	set_physics_process(false)
	animater.play("dead")
	
	dead = true
	


func _on_enemy_turn_collision_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if turnenemy:
		scale.x = -scale.x
		enemy_SPEED = -enemy_SPEED
	
	




func _on_player_detection_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	enemymove = false

	enemy_seen.start()
	seen.show()
	#turnenemy = false

	#player_position = player.position
	#target_position = (player_position - position).normalized()
	
	#if position.distance_to(player_position) > 3:
		#velocity.x = target_position * enemy_SPEED
		#move_and_slide()


func _on_player_detection_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	clearshot = false
	enemymove = true
	
	#turnenemy = true


func _on_enemy_seen_timeout():
	clearshot = true
	seen.hide()


func _on_getting_burned_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	burned = true
	if health == 0:
		set_physics_process(false)
		animater.play("enemy_death")
		enemy_vanish.start()
	if health > 0:
		animater.play("burn")




func _on_getting_burned_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	burned = false
