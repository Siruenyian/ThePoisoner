extends Node

class_name APManager  

@export var max_ap: int = 5 
var current_ap: int  

@onready var ap_bar: ProgressBar = $"../CanvasLayer/APBar"

signal ap_changed(new_ap: int)  #

func _ready():
	current_ap = max_ap  
	update_ap_bar()

func use_ap(amount: int):
	if current_ap >= amount:
		current_ap -= amount
		update_ap_bar()
		ap_changed.emit(current_ap)  
		return true
	return false 

func restore_ap():
	current_ap = max_ap
	update_ap_bar()
	ap_changed.emit(current_ap)

func update_ap_bar():
	ap_bar.value = float(current_ap) / max_ap * 100 
