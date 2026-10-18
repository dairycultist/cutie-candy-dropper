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
	
	for particle in get_children():
		
		var velocity = particle_to_velocity.get(particle)
		
		particle.position += velocity * delta
		
		velocity = lerp(velocity, Vector2.ZERO, 5.0 * delta)
		velocity += (global_position - particle.global_position).normalized() * 3000.0 * delta
		
		particle_to_velocity.set(particle, velocity)

func create_candy_particles(at: Vector2, count: int):
	
	for particle in get_children():
		
		if particle_to_velocity.get(particle) == Vector2.ZERO:
			
			particle.global_position = at + Vector2(randfn(0.0, 20.0), randfn(0.0, 20.0))
			
			var direction = (particle.global_position - global_position).normalized()
			
			direction = Vector2(direction.y, -direction.x)
			
			particle_to_velocity.set(particle, direction * 1000.0)
			
			count -= 1
			
			if count == 0:
				return
