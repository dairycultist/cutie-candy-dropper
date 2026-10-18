extends StaticBody2D

const PEG_SCENE := preload("res://peg.tscn")

const SPACING := 75.0

func _ready() -> void:
	
	for y in range(-5, 2):
		
		if y % 2 == 0:

			for x in range(-2, 2):
				var peg := PEG_SCENE.instantiate()
				add_child(peg)
				peg.position = Vector2(x * SPACING * 2 + SPACING, y * SPACING)
		
		else:
			
			for x in range(-1, 2):
				var peg := PEG_SCENE.instantiate()
				add_child(peg)
				peg.position = Vector2(x * SPACING * 2, y * SPACING)
