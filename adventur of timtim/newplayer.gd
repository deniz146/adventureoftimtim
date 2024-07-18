extends CharacterBody2D
@onready var animator = $AnimatedSprite2D


const speed = 300.0

var jump_power = 10
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 10
var main_sm: LimboHSM
var dir
func _ready():
	initate_state_machine()
func _physics_process(delta):
	print(main_sm.get_active_state())
	dir = Input.get_action_strength("right") - Input.get_action_strength("left") 
	if dir:
		velocity.x = dir * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	velocity.y += 10
	move_and_slide()
func _unhandled_Input():
	if Input.is_action_just_released("jump"):
		main_sm.dispatch(&"to_jump")
func initate_state_machine():
	main_sm = LimboHSM.new()
	add_child(main_sm)
	var idle_state = LimboState.new().named("idle").call_on_enter(idle_start).call_on_update(idle_update)
	var walk_state = LimboState.new().named("walk").call_on_enter(walk_start).call_on_update(walk_update)
	var jump_state = LimboState.new().named("jump").call_on_enter(jump_start).call_on_update(jump_update)
	var punch_state = LimboState.new().named("punch").call_on_enter(punch_start).call_on_update(punch_update)
	
	
	main_sm.add_child(idle_state)
	main_sm.add_child(walk_state)
	main_sm.add_child(jump_state)
	main_sm.add_child(punch_state)
	
	main_sm.initial_state = idle_state
	
	main_sm.add_transition(idle_state, walk_state, &"to_walk")
	main_sm.add_transition(idle_state, jump_state, &"to_jump")
	main_sm.add_transition(idle_state, punch_state, &"to_punch")
	main_sm.add_transition(main_sm.ANYSTATE, idle_state, &"state_ended")
	main_sm.initialize(self)
	main_sm.set_active(true)
	
	
	
func idle_start():
	pass
func idle_update(delta: float):
	if velocity.x != 0:
		main_sm.dispatch(&"to_walk")
	
	
	
func walk_start():
	animator.play("walk")
func walk_update(delta: float):
	if velocity.x == 0:
		main_sm.dispatch(&"state_ended")
	
	
	
func jump_start():
	animator.play("jump_start")
	velocity.y = jump_power
func jump_update(delta: float):
	if is_on_floor():
		main_sm.dispatch(&"state_ended")
	
	
	
func punch_start():
	pass
func punch_update(delta: float):
	pass
	
	
	
