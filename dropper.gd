extends Node2D

@export var candy_scenes: Array[PackedScene]

class CandyInfo:
	var scene: PackedScene
	var texture: CompressedTexture2D

var candy_infos: Array[CandyInfo]

var candy_queue: Array[CandyInfo]

func _ready() -> void:
	
	# extract candy infos
	for scene in candy_scenes:
		var candy_info := CandyInfo.new()
		
		candy_info.scene = scene
		
		var temp := scene.instantiate()
		candy_info.texture = temp.get_node("Sprite").texture
		temp.queue_free()
		
		candy_infos.append(candy_info)
	
	# create a candy queue
	for i in range(20):
		candy_queue.append(candy_infos.pick_random())

func _process(_delta: float) -> void:
	
	if candy_queue.size() > 0:
		
		if candy_queue.size() > 1:
			$NextSprite.texture = candy_queue[1].texture
	
		$PreviewSprite.texture = candy_queue[0].texture
		$PreviewSprite.global_position.x = get_global_mouse_position().x
		
		if Input.is_action_just_released("drop"):
			
			var candy = candy_queue.pop_front().scene.instantiate()
			add_child(candy)
			candy.position = $PreviewSprite.position
