extends Node
class_name PlayerAction

@export var raycast:RayCast2D
@export var actionUI:ActionUI
signal teamodechanged(teapotmode:String)
var teapotMode="Poison"
var current_interactable: Node = null

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if raycast.is_colliding():
		var collider:Node2D = raycast.get_collider()
		if collider and collider.is_in_group("interactable"):
			actionUI.show_actions()
			current_interactable = collider.get_parent().get_node("Interactable")
		else:
			actionUI.hide_actions()
			current_interactable = null
			
	else:
		actionUI.hide_actions()
		current_interactable = null
		

func _on_interact_button_pressed():
	if current_interactable and current_interactable.has_method("_on_interact"):
		current_interactable._on_interact(teapotMode)  # Call the object's interaction method


#TODO: add so that the swi
func switchteamode():
	if GameManagerThing.current_ap<=0:
		return
	if teapotMode=="Tea":
		teapotMode="Poison"
	else:
		teapotMode="Tea"
	teamodechanged.emit(teapotMode)
