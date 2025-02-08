extends Control

#This thing is for any UI
# Called when the node enters the scene tree for the first time.
@onready var loseScreen:Control=$LoseScreen
@onready var winScreen:Control=$WinScreen
var game_over_shown = false 

func _ready():
	loseScreen.visible = false
	winScreen.visible = false
	game_over_shown = false 
	GameManagerThing.game_ended.connect(show_game_over)


func show_game_over(condition:String):
	if game_over_shown:
		return
	game_over_shown = true 
	match condition:
		"LOSE":
			loseScreen.visible = true
			get_tree().paused = true
		"WIN":
			winScreen.visible = true
			get_tree().paused = true

	
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
