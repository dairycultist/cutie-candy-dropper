extends StaticBody2D

const PEG_SCENE := preload("res://peg.tscn")

func _ready() -> void:
	
	const spacing := 75.0
	
	for y in range(-5, 2):
		
		if y % 2 == 0:

			for x in range(-2, 2):
				var peg := PEG_SCENE.instantiate()
				add_child(peg)
				peg.position = Vector2(x * spacing * 2 + spacing, y * spacing)
		
		else:
			
			for x in range(-1, 2):
				var peg := PEG_SCENE.instantiate()
				add_child(peg)
				peg.position = Vector2(x * spacing * 2, y * spacing)
