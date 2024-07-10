shader_type particles;

uniform float collision_radius = 0.1;  // Radius for collision detection
uniform vec3 collision_center = vec3(0.0);  // Center point for collision detection

void fragment() {
    // Compute particle position in world space
    vec3 particle_position = position;

    // Check collision against a sphere defined by collision_center and collision_radius
    float distance_to_center = distance(particle_position, collision_center);

    if (distance_to_center < collision_radius) {
        // Handle collision response here
        // Example: Bounce the particle off the collision sphere
        vec3 collision_normal = normalize(particle_position - collision_center);
        position = normalize(position - collision_normal * 2.0 * collision_radius);
    }
}
