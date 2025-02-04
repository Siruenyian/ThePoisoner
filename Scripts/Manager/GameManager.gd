extends Node2D
class_name GameManager

signal turn_ended
signal turn_started

@export var player: Node  # Assign the Player node in the Inspector

var current_turn = "Player"  # Track whose turn it is
@export var max_ap: int = 5
var current_ap: int  

@onready var ap_bar: ProgressBar = $"../CanvasLayer/APBar"
@onready var turn_label : Label =$"../CanvasLayer/TurnLabel"
signal ap_changed(new_ap: int)

func _ready():
	current_ap = max_ap  
	update_ap_bar()
	start_turn()

func start_turn():
	print("Turn Started! It's", current_turn, "turn")
	restore_ap()
	turn_label.text=current_turn
	turn_started.emit(current_turn)

func end_turn():
	print("Turn Ended!")
	turn_ended.emit()
	if current_turn == "Player":
		current_turn = "NPC"  # Enemy turn
	else:
		current_turn = "Player"
	start_turn()
	
func use_ap(amount: int):
	if current_ap >= amount:
		current_ap -= amount
		update_ap_bar()
		ap_changed.emit(current_ap)
		if current_ap <= 0:
			end_turn()  
		return true
	return false 

func restore_ap():
	current_ap = max_ap
	update_ap_bar()
	ap_changed.emit(current_ap)

func update_ap_bar():
	ap_bar.value = float(current_ap) / max_ap * 100 
