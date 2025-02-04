extends Node2D

signal turn_ended
signal turn_started(current_turn)
signal ap_changed(new_ap: int)

var current_turn = "Player"
var max_ap: int = 1
var current_ap: int  

func _ready():
	current_ap = max_ap  
	start_turn()

func start_turn():
	print("Turn Started! It's", current_turn, "turn")
	restore_ap()
	turn_started.emit(current_turn)
	
func end_turn():
	print("Turn Ended!")
	turn_ended.emit()
	if current_turn == "Player":
		current_turn = "NPC"  
	else:
		current_turn = "Player"
		
	await get_tree().create_timer(5).timeout
	start_turn()
	
func use_ap(amount: int):
	if current_ap >= amount:
		current_ap -= amount
		ap_changed.emit(current_ap)
		if current_ap <= 0:
			end_turn()  
		return true
	return false 

func restore_ap():
	current_ap = max_ap
	ap_changed.emit(current_ap)

func end_game():
	return
