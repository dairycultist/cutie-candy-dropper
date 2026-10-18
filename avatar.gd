extends Sprite2D

const CANDY_PARTICLE_PREFAB = preload("res://candy_particle.tscn")

var particle_to_velocity: Dictionary[Sprite2D, Vector2]

func _ready() -> void:
	
	for i in range(100):
		var particle = CANDY_PARTICLE_PREFAB.instantiate()
		add_child(particle)
		particle.position = Vector2.ZERO
		particle_to_velocity.set(particle, Vector2.ZERO)

func _process(delta: float) -> void:
	
	scale = lerp(scale, Vector2.ONE, 10.0 * delta)
	
	for particle in get_children():
		
		var velocity = particle_to_velocity.get(particle)
		
		if velocity != Vector2.ZERO:
		
			particle.position += velocity * delta
			
			if particle.position.length() > 64.0:
				velocity = lerp(velocity, Vector2.ZERO, 5.0 * delta)
				velocity += (global_position - particle.global_position).normalized() * 3000.0 * delta
			else:
				velocity = Vector2.ZERO
				particle.position = Vector2.ZERO
				scale *= 1.0 + randf() * 0.03
			
		particle_to_velocity.set(particle, velocity)

func create_candy_particles(at: Vector2, count: int, modulate: Color):
	
	for particle in get_children():
		
		if particle_to_velocity.get(particle) == Vector2.ZERO:
			
			particle.global_position = at
			particle.modulate = modulate
			
			var direction = (particle.global_position - global_position).normalized()
			
			direction = Vector2(direction.y, -direction.x) + Vector2(randfn(0.0, 0.2), randfn(0.0, 0.2))
			
			particle_to_velocity.set(particle, direction * 1000.0)
			
			count -= 1
			
			if count == 0:
				return
