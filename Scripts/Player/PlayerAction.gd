extends Node
class_name PlayerAction

@export var raycast:RayCast2D
@export var actionUI:ActionUI
signal teamodechanged(teapotmode:String)
var teapotMode="Poison"
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider and collider.is_in_group("interactable"):
			actionUI.show_actions()
		else:
			actionUI.hide_actions()
	else:
		actionUI.hide_actions()

func attempt_interaction(target):
	if target and target.is_in_group("interactable"):
		target.interact()

func switchteamode():
	if teapotMode=="Tea":
		teapotMode="Poison"
	else:
		teapotMode="Tea"
	teamodechanged.emit(teapotMode)
