extends Node2D

@export var candy_scenes: Array[PackedScene]

class CandyInfo extends Resource:
	var scene: PackedScene
	var texture: CompressedTexture2D
	var modulate: Color

var candy_infos: Array[CandyInfo]

var candy_queue: Array[CandyInfo]

func _ready() -> void:
	
	# extract candy infos
	for scene in candy_scenes:
		var candy_info := CandyInfo.new()
		
		candy_info.scene = scene
		
		var temp := scene.instantiate()
		candy_info.texture = temp.texture
		temp.queue_free()
		
		candy_infos.append(candy_info)
	
	# create a candy queue
	for i in range(20):
		var base_candy_info = candy_infos.pick_random()
		var candy_info := CandyInfo.new()
		candy_info.scene = base_candy_info.scene
		candy_info.texture = base_candy_info.texture
		candy_info.modulate = Color.from_ok_hsl(randf(), 1.0, 0.7)
		candy_queue.append(candy_info)

func _process(_delta: float) -> void:
	
	for candy in $Candies.get_children():
		
		var candy_position = candy.get_node("Bone-0").global_position
		
		if candy_position.y > $Candies.global_position.y:
			$Avatar.create_candy_particles(candy_position, 20)
			candy.queue_free()
	
	if candy_queue.size() > 0:
		
		if candy_queue.size() > 1:
			$NextSprite.texture = candy_queue[1].texture
			$NextSprite.modulate = candy_queue[1].modulate
	
		$PreviewSprite.texture = candy_queue[0].texture
		$PreviewSprite.modulate = candy_queue[0].modulate
		$PreviewSprite.global_position.x = get_global_mouse_position().x
		
		if Input.is_action_just_released("drop"):
			
			var candy_info = candy_queue.pop_front()
			var candy = candy_info.scene.instantiate()
			$Candies.add_child(candy)
			candy.global_position = $PreviewSprite.global_position - candy_info.texture.get_size() / 2.0
			candy.color = candy_info.modulate
