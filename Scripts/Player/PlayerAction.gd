extends Node

@export var raycast:RayCast2D
@export var actionUI:ActionUI

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if raycast.is_colliding():
		actionUI.show_actions()
	else:
		actionUI.hide_actions()
