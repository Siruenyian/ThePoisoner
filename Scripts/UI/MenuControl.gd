extends Node2D

const ENEMY_SCENE_PATH : String = "res://Scenes/Prototype.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_start_button_pressed() -> void:
	GameManagerThing.switch_scene_async(ENEMY_SCENE_PATH)


func _on_how_to_button_pressed() -> void:
	pass # Replace with function body.

func _on_exit_button_pressed() -> void:
	pass # Replace with function body.
