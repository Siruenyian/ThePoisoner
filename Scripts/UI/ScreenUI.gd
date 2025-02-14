extends Control

#This thing is for any UI
# Called when the node enters the scene tree for the first time.
@onready var loseScreen:Control=$LoseScreen
@onready var winScreen:Control=$WinScreen
@onready var drawScreen:Control=$DrawScreen

var stateArray=[]
func _ready():
	stateArray=[]
	loseScreen.visible = false
	winScreen.visible = false
	drawScreen.visible = false
	
	GameManagerThing.game_ended.connect(show_game_over)


func show_game_over(condition:String):
	stateArray.append(condition)
	var gameState=""
	gameState=condition
	print("statearray nows",stateArray)
	if stateArray.size()>1:
		if (stateArray[0]==stateArray[1]):
			gameState="DRAW"
	match gameState:
		"LOSE":
			loseScreen.visible = true
			get_tree().paused = true
		"WIN":
			winScreen.visible = true
			get_tree().paused = true
		"DRAW":
			drawScreen.visible = true
			get_tree().paused = true
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
