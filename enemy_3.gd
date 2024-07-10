extends CharacterBody2D

@onready var animator = $AnimatedSprite2D
var speed = 500
var direction
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var moveactive = true
@onready var enemyturn = $enemyturn
var health = 50
@onready var damagearea = $damagearea
var takedamage
@onready var takedamageover = $takedamageover
@onready var collision_shape_2d = $damagearea/CollisionShape2D
var dying
@onready var dyingt = $dyingt
@onready var que = $que
@onready var heathitemmark = $heathitemmark
@onready var manaitemmark = $manaitemmark
@onready var fragmentmark = $fragmentmark
var MANAITEM = preload("res://adventur of timtim/manaitem.tscn")
var FRAGMENTS = preload("res://adventur of timtim/fragments.tscn")
var healthitem = preload("res://adventur of timtim/healthitem.tscn")
@onready var explode = $explode



func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	move(delta)
	animations()
	die()
func move(delta):
	if moveactive:
		speed = 500
		if animator.flip_h:
			direction = -1
		else:
			direction = 1
		velocity.x = direction * speed * delta
	else:
		velocity.x = 0  
	move_and_slide()
func die():
	if health == 0:
		enemyturn.stop()
		moveactive = false
		takedamage = false
func animations():
	if moveactive:
		animator.play("walk")
	if takedamage:
		animator.play("gethit")
	if dying:
		animator.play("die")



func _on_enemyturn_timeout():
	
	if animator.flip_h == true:
		animator.flip_h = false
	else:
		animator.flip_h = true
	enemyturn.start()
	


func _on_damagearea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	speed = 0
	moveactive = false
	takedamage = true
	health -= 10
	takedamageover.start()
	collision_shape_2d.disabled = true
	if health == 0:
		moveactive = false
		takedamage = false
		dying = true
		dyingt.start()
		collision_shape_2d.disabled = true
func _on_takedamageover_timeout():
	collision_shape_2d.disabled = false
	takedamage = false
	moveactive = true
	


func _on_dyingt_timeout():
	dying = false
	healthitem = healthitem.instantiate()
	get_parent().add_child(healthitem)
	healthitem.global_position = heathitemmark.global_position

	FRAGMENTS = FRAGMENTS.instantiate()
	get_parent().add_child(FRAGMENTS)
	FRAGMENTS.global_position = fragmentmark.global_position 
	MANAITEM = MANAITEM.instantiate()
	get_parent().add_child(MANAITEM)
	MANAITEM.global_position = manaitemmark.global_position
	

	que.start()
	explode.emitting = true
func _on_que_timeout():
	queue_free()


func _on_specialarea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	speed = 0
	moveactive = false
	takedamage = true
	health -= 50
	takedamageover.start()
	collision_shape_2d.disabled = true
	if health == 0:
		moveactive = false
		takedamage = false
		dying = true
		dyingt.start()
		collision_shape_2d.disabled = true
