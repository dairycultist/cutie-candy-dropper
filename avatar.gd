extends Node2D

const CANDY_PARTICLE_PREFAB = preload("res://candy_particle.tscn")

var particle_to_velocity: Dictionary[Sprite2D, Vector2]
var particles: Array[Sprite2D]

var score = 0:
	set(value):
		$Label.text = str("Score: ", value)
		score = value

func _ready() -> void:
	
	for i in range(100):
		var particle = CANDY_PARTICLE_PREFAB.instantiate()
		add_child(particle)
		particles.append(particle)
		particle.position = Vector2.ZERO
		particle_to_velocity.set(particle, Vector2.ZERO)

func _process(delta: float) -> void:
	
	$Sprite.position.x = sin(Time.get_ticks_msec() / 200.0) * 10.0
	$Sprite.rotation = cos(Time.get_ticks_msec() / 200.0) * 0.1
	$Sprite.scale = lerp($Sprite.scale, Vector2.ONE, 10.0 * delta)
	
	for particle in particles:
		
		var velocity = particle_to_velocity.get(particle)
		
		if velocity != Vector2.ZERO:
		
			particle.position += velocity * delta
			
			if particle.position.length() > 64.0:
				velocity = lerp(velocity, Vector2.ZERO, 5.0 * delta)
				velocity += (global_position - particle.global_position).normalized() * 3000.0 * delta
			else:
				velocity = Vector2.ZERO
				particle.position = Vector2.ZERO
				$Sprite.scale *= 1.0 + randf() * 0.03
				score += 1
			
		particle_to_velocity.set(particle, velocity)

@warning_ignore("shadowed_variable_base_class")
func create_candy_particles(at: Vector2, count: int, modulate: Color):
	
	for particle in particles:
		
		if particle_to_velocity.get(particle) == Vector2.ZERO:
			
			particle.global_position = at
			particle.modulate = modulate
			
			var direction = (particle.global_position - global_position).normalized()
			
			direction = Vector2(direction.y, -direction.x) + Vector2(randfn(0.0, 0.2), randfn(0.0, 0.2))
			
			particle_to_velocity.set(particle, direction * 1200.0)
			
			count -= 1
			
			if count == 0:
				return
