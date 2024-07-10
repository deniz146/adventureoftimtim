extends GPUParticles2D

@onready var collision_polygon = $TileMap/StaticBody2D/CollisionPolygon2D


# Emit a particle
func _emit_particle(position: Vector2, velocity: Vector2):
	# Customize particle emission here
	var particle = {}
	particle.position = position
	particle.velocity = velocity
	particle.size = Vector2(8, 8)  # Example size
	add_child(particle)

# Handle particle collisions
func _check_collision(particle):
	if collision_polygon and collision_polygon.polygon:
		var polygon = collision_polygon.polygon
		var point = particle.position

		# Simple point in polygon check
		if collision_polygon.point_in_polygon(point):
			# Reflect the velocity (simple bounce logic)
			var normal = collision_polygon.get_closest_point(point) - point
			normal = normal.normalized()
			particle.velocity = particle.velocity.bounce(normal)

func _process(delta):
	for particle in get_children():
		if particle.has_method("position"):
			_check_collision(particle)
			particle.position += particle.velocity * delta
