extends StaticBody2D

func _ready() -> void:
	$Area2D.body_entered.connect(func(body: Node2D):
		
		if body is RigidBody2D:
			$Sprite.scale = Vector2(2.0, 2.0)
			body.apply_central_impulse((body.global_position - global_position).normalized() * 18.0)
	)

func _process(delta: float) -> void:
	
	$Sprite.scale = lerp($Sprite.scale, Vector2.ONE, 10.0 * delta)
