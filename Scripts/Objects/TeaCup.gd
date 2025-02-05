extends Node2D

var fluidBar:ProgressBar
var poisonLevel:int
var teaLevel:int
var fluidlevel:int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fluidBar=get_parent().get_node("FluidBar")
	poisonLevel=0
	teaLevel=0
	fluidlevel=0
	#print(hitbox.name)

func _on_interact(teaType:String):
	print("this is interact from other ndoe ", teaType)
	if fluidlevel>=3:
		return
	if teaType=="Poison":
		poisonLevel+=1
		if poisonLevel>=2:
			GameManagerThing.end_game("WIN")
	else:
		teaLevel+=1
		if teaLevel>=2:
			print("This table is ok 😭")

	fluidlevel+=1
	fluidBar.value = float(fluidlevel) / 3 * 100 
	
func _process(delta: float) -> void:
	pass
