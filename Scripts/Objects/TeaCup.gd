extends Node2D

var poisonBar:ProgressBar
var poisonLevel:int
@export var maxpoisonLevel:int= 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	poisonBar=get_parent().get_node("PoisonBar")
	poisonLevel=0
	#print(hitbox.name)

func _on_interact():
	print("this is interact from other ndoe")
	poisonLevel+=1
	poisonBar.value = float(poisonLevel) / maxpoisonLevel * 100 
	if poisonLevel>=maxpoisonLevel:
		GameManagerThing.end_game()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
