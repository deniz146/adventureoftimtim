extends CharacterBody2D

@onready var getingdamegecol = $getingdamege/getingdamegecol
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health = 100
var speed = 50
var dir: Vector2
@onready var timer = $Timer
@onready var animated_sprite_2d = $AnimatedSprite2D
var move
var is_bat_chase: bool
@onready var player = %player
@onready var ray_cast_2d = $RayCast2D
@onready var playerdetect = $playerdetect
@onready var collision_shape_2d = $playerdetect/CollisionShape2D
var attack
var getdamage
var dying
@onready var dyingt = $dyingt
@onready var label = $Label
@onready var damege_timer = $damegeTimer
@onready var ashes = $ashes
@onready var explode = $explode
@onready var que = $que
@onready var manamarker = $manamarker
@onready var fragmentmarker = $fragmentmarker

@onready var healthmarker = $healthmarker
var MANAITEM = preload("res://adventur of timtim/manaitem.tscn")
var FRAGMENTS = preload("res://adventur of timtim/fragments.tscn")
var healthitem = preload("res://adventur of timtim/healthitem.tscn")
func _ready():
	is_bat_chase = false
	ray_cast_2d.enabled = false
	move = true
	attack = false
func _process(delta):
	_move(delta)
	handle_animations()
	_attack(delta)
	hurt()
	#dead()
	if health < 0:
		health = 0
	label.text = str (health)
func _move(delta):
	if move:
		velocity.y += gravity * delta
		if is_bat_chase:
			speed = 5
			ray_cast_2d.target_position = to_local(player.position)
			velocity += ray_cast_2d.target_position * speed * delta
			move_and_slide()
		elif !is_bat_chase:
			speed = 50
			velocity += dir * speed * delta
			move_and_slide()
func _on_timer_timeout():
	timer.wait_time = choose([0.5, 1.0])
	if !is_bat_chase:
		if dir == Vector2.DOWN:
			dir = Vector2.UP
		if dir == Vector2.UP:
			dir = Vector2.DOWN
		
func _attack(delta):
	if attack:
		speed = 0.0001
		ray_cast_2d.target_position = to_local(player.position)
		velocity += ray_cast_2d.target_position * speed
		move_and_slide()
		

func choose(array):
	array.shuffle()
	return array.front()
func handle_animations():
	if move:
		animated_sprite_2d.play("fly")
		if dir.x == -1:
			animated_sprite_2d.flip_h = true
		if dir.x == 1:
			animated_sprite_2d.flip_h = false
	if attack:
		animated_sprite_2d.play("attack")
	if getdamage:
		animated_sprite_2d.play("hurt")
	if dying:
		animated_sprite_2d.play("death")
func hurt():
	if getdamage:
		getingdamegecol.disabled = true

func dead():
	if health == 0:
		dying = true
		move = false
		attack = false
		getdamage = false

func _on_playerdetect_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	is_bat_chase = true
	ray_cast_2d.enabled = true


func _on_playerdetect_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	is_bat_chase = false
	ray_cast_2d.enabled = false


func _on_attackarea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	move = false
	attack = true


func _on_attackarea_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	move = true
	attack = false



func _on_damege_timer_timeout():
	getingdamegecol.disabled = false
	getdamage = false
	if attack:
		attack = true
	if move:
		move = true
	



func _on_dyingt_timeout():
	healthitem = healthitem.instantiate()
	get_parent().add_child(healthitem)
	healthitem.global_position = healthmarker.global_position

	FRAGMENTS = FRAGMENTS.instantiate()
	get_parent().add_child(FRAGMENTS)
	FRAGMENTS.global_position = fragmentmarker.global_position

	MANAITEM = MANAITEM.instantiate()
	get_parent().add_child(MANAITEM)
	MANAITEM.global_position = manamarker.global_position


	explode.emitting = true
	ashes.emitting = false
	dying = false
	_process(false)
	animated_sprite_2d.play("dead")
	que.start()

	


func _on_getingdamege_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	health -= 10
	getdamage = true
	if attack:
		attack = false
	if move:
		move = false
	damege_timer.start()
	if health == 0:
		dyingt.start()
		ashes.emitting = true
		dying = true
		move = false
		attack = false
		getdamage = false


func _on_que_timeout():
	queue_free()
