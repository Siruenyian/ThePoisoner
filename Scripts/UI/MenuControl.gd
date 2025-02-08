extends Node2D

const tutscenePath : String = "res://Scenes/Tutorial.tscn"
const mainscenePath : String = "res://Scenes/Prototype.tscn"
@onready var howtoScreen:Control=$"../CanvasLayer/Control"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	howtoScreen.hide()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_start_button_pressed() -> void:
	if GameManagerThing.istutPlayed:
		GameManagerThing.switch_scene_async(mainscenePath)
		GameManagerThing.start_game(1)
	else:
		#GameManagerThing.istutPlayed=true
		GameManagerThing.switch_scene_async(tutscenePath)
		GameManagerThing.start_tut()
		

func _on_tut_button_pressed() -> void:
	GameManagerThing.switch_scene_async(tutscenePath)
	GameManagerThing.start_tut()
	

func _on_how_to_button_pressed() -> void:
	howtoScreen.show()

func _on_exit_button_pressed() -> void:
	get_tree().quit()
	#OS.shell_open("https://example.com")


func _on_howtoscreen_gui_input(event: InputEvent) -> void:
	print(event)
	if event is InputEventMouseButton and event.pressed:
		howtoScreen.hide()
	
