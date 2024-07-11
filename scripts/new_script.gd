extends CPUParticles2D
func _ready():
	set_process(true)
	
func _process(delta):
	while get_child_count() > 0:
		var child = get_child(0)
		remove_child(child)
		child.queue_free()
		
	for i in range(get_particle_count()):
		var particle_pos = particles.get_position(i)
		var shape = CollisionObject2D.new()
		var circle_shape = CollisionObject2D.new()
		circle_shape.radius = 5
		shape.shape = circle_shape
		shape.position = particle_pos
		add_child(shape)
