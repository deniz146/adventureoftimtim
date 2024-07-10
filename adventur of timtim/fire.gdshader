shader_type particles;

uniform vec2 collision_polygon_points[10]; // Adjust the size based on your polygon complexity
uniform mat3 collision_polygon_transform;

void process() {
    vec2 particle_pos = PARTICLE.position.xy;

    // Transform particle position to match the polygon's coordinate system
    vec2 transformed_particle_pos = (collision_polygon_transform * vec3(particle_pos, 1.0)).xy;

    // Check if particle is within the collision polygon (basic point-in-polygon test)
    bool collision_detected = false;
    int j = collision_polygon_points.length() - 1;
    for (int i = 0; i < collision_polygon_points.length(); i++) {
        if ((collision_polygon_points[i].y > transformed_particle_pos.y) != (collision_polygon_points[j].y > transformed_particle_pos.y) &&
            (transformed_particle_pos.x < (collision_polygon_points[j].x - collision_polygon_points[i].x) * (transformed_particle_pos.y - collision_polygon_points[i].y) /
            (collision_polygon_points[j].y - collision_polygon_points[i].y) + collision_polygon_points[i].x)) {
            collision_detected = !collision_detected;
        }
        j = i;
    }

    // Example: Reverse velocity on collision
    if (collision_detected) {
        VELOCITY = -VELOCITY;
    }
}
